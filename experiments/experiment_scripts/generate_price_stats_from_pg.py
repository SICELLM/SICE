#!/usr/bin/env python3
"""
Generate PRICE statistics (.pkl) from PostgreSQL.

Supports: TPC-H, TPC-DS, IMDB, Stats.

Creates 5 files per database in canon/statistics/{db}/:
  - abbrev_col_type.pkl  — table alias mapping + column type classification
  - size.pkl             — row counts per table
  - histogram40.pkl      — 40-bin equi-width histograms for numeric columns
  - summary40.pkl        — value frequency lists for discrete columns
  - fanout40.pkl         — join fanout distributions per join-column pair
With the Canon flags, also:
  - null_fraction.pkl          — NULL fraction per column (--price_n_filter)
  - nonequi_fanout_op40.pkl    — operator-conditioned fanouts of every join other
                                 than a plain cross-table equi-join (--price_n_fanout)
  - same-row comparisons x op y + v (--price_n_pairwise) add the derived column
    x - y, from its per-value distribution, to the histogram/summary/type files.

Usage:
    python generate_price_stats_from_pg.py --db tpch
    python generate_price_stats_from_pg.py --db tpcds
    python generate_price_stats_from_pg.py --db imdb
    python generate_price_stats_from_pg.py --db stats
    python generate_price_stats_from_pg.py --db all
"""

import os
from pathlib import Path
import sys
import re
import pickle
import argparse
import hashlib
from collections import defaultdict

import json
import numpy as np
import psycopg2

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))  # experiments/ for sice_lib

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
BIN_SIZE = 40

PRICE_STATS_BASE = os.environ.get("PRICE_STATS_BASE") or str(Path(__file__).resolve().parents[1] / "canon" / "statistics")
QUERIES_DIR = None  # set from --queries_dir in main()
DEEPDB_BASE = os.environ.get("SICE_DEEPDB_BASE") or str(Path(__file__).resolve().parents[1] / "deepdb_augmented")  # optional, not shipped

# TPC-H: table name -> PRICE alias
TPCH_ABBREV = {
    "customer": "tpch_c",
    "orders": "tpch_o",
    "lineitem": "tpch_l",
    "part": "tpch_p",
    "partsupp": "tpch_ps",
    "supplier": "tpch_s",
    "nation": "tpch_n",
    "region": "tpch_r",
}

# TPC-DS: table name -> PRICE alias
TPCDS_ABBREV = {
    "store_sales": "tpcds_ss",
    "store_returns": "tpcds_sr",
    "catalog_sales": "tpcds_cs",
    "catalog_returns": "tpcds_cr",
    "web_sales": "tpcds_ws",
    "web_returns": "tpcds_wr",
    "customer": "tpcds_cu",
    "customer_address": "tpcds_ca",
    "customer_demographics": "tpcds_cd",
    "household_demographics": "tpcds_hd",
    "date_dim": "tpcds_dd",
    "time_dim": "tpcds_td",
    "item": "tpcds_i",
    "store": "tpcds_s",
    "warehouse": "tpcds_w",
    "web_site": "tpcds_wsi",
    "web_page": "tpcds_wp",
    "catalog_page": "tpcds_cp",
    "promotion": "tpcds_pr",
    "call_center": "tpcds_cc",
    "income_band": "tpcds_ib",
    "reason": "tpcds_re",
    "ship_mode": "tpcds_sm",
    "inventory": "tpcds_inv",
    "dbgen_version": "tpcds_dv",
}

# IMDB and Stats: import from cross_workload_price_config
from sice_lib import IMDB_ABBREV, STATS_ABBREV, CROSS_WORKLOAD_ABBREV
import sqlglot
from canon.features_tool import column_comparison, diff_column, MIRROR_OP

# Bao's Stack dataset (StackExchange; rmarcus.info/stack), restored as PostgreSQL database `stack` (2026-09-28).
STACK_ABBREV = {
    "site": "so_s", "tag": "so_t", "question": "so_q", "answer": "so_a", "tag_question": "so_tq",
    "so_user": "so_u", "account": "so_acc", "badge": "so_b", "post_link": "so_pl", "comment": "so_c",
}

# Database name mapping: --db arg -> (pg_db_name, abbrev_dict, stats_output_name)
DB_CONFIG = {
    "stack": ("stack", STACK_ABBREV, "stack"),
    "tpch": ("tpch", TPCH_ABBREV, "tpch"),
    "tpcds": ("tpcds", TPCDS_ABBREV, "tpcds"),
    "imdb": ("imdb", IMDB_ABBREV, "imdb"),
    "stats": ("stats", STATS_ABBREV, "stats"),
}
# Database-update experiment (2026-09-24): the staged IMDB copies share IMDB's schema/abbrev and
# query files; their statistics are written to their own directories. SICE_STATS_DROP_TABLES
# (comma-separated) removes tables absent from a stage's schema before any table is queried.
for _k in ("imdb_upd", "imdb_upd1", "imdb_upd2", "imdb_upd3", "imdb_upd4", "imdb_upd5", "imdb_updh3", "imdb_updg3", "imdb_updq", "imdb_updq1", "imdb_updq2", "imdb_updq3"):   # imdb_updh3: hot-insert pilot (2026-10-13)
    DB_CONFIG[_k] = (_k, IMDB_ABBREV, _k)
for _k in ("stats_upd", "stats_upd1", "stats_upd2", "stats_upd3", "stats_upd4", "stats_upd5", "stats_updq", "stats_updq3"):
    DB_CONFIG[_k] = (_k, STATS_ABBREV, _k)

# Add all cross-workload databases from config
# Map db_name -> (pg_db_name, abbrev_dict, stats_output_name)
# pg_db_name matches the PostgreSQL database name (same as db_name for most)
# Skip tpc_h since it's the same database as tpch (already in DB_CONFIG)
_SKIP_CW_DBS = {"tpc_h"}
for _cw_db_name, _cw_abbrev in CROSS_WORKLOAD_ABBREV.items():
    if _cw_db_name not in DB_CONFIG and _cw_db_name not in _SKIP_CW_DBS:
        pg_name = _cw_db_name
        DB_CONFIG[_cw_db_name] = (pg_name, _cw_abbrev, _cw_db_name)

# Databases that discover joins/filters from deepdb_augmented JSON
# (no SQL query files available, and column names are not unique across tables)
JSON_DISCOVERY_DBS = {
    "imdb", "accidents", "airline", "baseball", "basketball",
    "carcinogenesis", "consumer", "credit", "employee", "fhnk",
    "financial", "geneea", "genome", "hepatitis", "movielens",
    "seznam", "ssb", "tournament", "walmart",
}

# Databases with ambiguous column names that need alias-aware SQL parsing
ALIAS_AWARE_DBS = {"stats", "stack"}   # stack: id/site_id/creation_date exist in several tables


# ---------------------------------------------------------------------------
# PostgreSQL helpers
# ---------------------------------------------------------------------------
def qi(identifier):
    """Quote a PostgreSQL identifier (table or column name) to handle
    mixed case, spaces, and special characters."""
    return f'"{identifier}"'


def get_connection(db_name):
    return psycopg2.connect(dbname=db_name, user="root", host="/var/run/postgresql")


def query_one(conn, sql):
    cur = conn.cursor()
    cur.execute(sql)
    row = cur.fetchone()
    cur.close()
    return row


def query_all(conn, sql):
    cur = conn.cursor()
    cur.execute(sql)
    rows = cur.fetchall()
    cur.close()
    return rows


def execute_stmt(conn, sql):
    """Execute a statement that returns no rows (CREATE TEMP TABLE / DROP)."""
    cur = conn.cursor()
    cur.execute(sql)
    cur.close()


# ---------------------------------------------------------------------------
# Per-value collection mode (--per_value / SICE_STATS_PER_VALUE=1)
#
# Instead of scanning a base table once per statistic, every column that any
# statistic needs is aggregated ONCE at value level,
#     CREATE TEMP TABLE pv_<table>_<col> AS
#         SELECT <col> AS val, count(*) AS cnt FROM <table> GROUP BY <col>
# (the NULL group is kept), and every statistic of that column -- n_distinct
# (engine adapters), null fraction, min/max, the 40-bin histogram, summary40,
# the string encoding, fanouts and orphan fractions -- is derived from the
# session-temporary object with the SAME expressions, edges, eps and ordering
# as the reference path (which stays untouched).  Table sizes come from
# SUM(cnt) of one of the table's pv objects.  Nothing persistent is created: TEMP objects vanish with the
# session and are dropped explicitly after the last stage that uses them.
# ---------------------------------------------------------------------------
PER_VALUE_ENV = os.environ.get("SICE_STATS_PER_VALUE", "") == "1"
PER_VALUE = False        # set per run by generate_stats_for_db()
PV_REGISTRY = {}         # (table, col) -> temp object name
_PV_ROWS = {}            # table -> total rows (SUM(cnt) over one pv object)
PV_VAL, PV_CNT = "val", "cnt"


def pv_name(table, col):
    """Session-temporary object name for (table, col): pv_<table>_<col>,
    lower-cased, non [a-z0-9_] characters -> '_', unique, <= 63 bytes."""
    t = re.sub(r"[^0-9a-z_]", "_", str(table).lower())
    c = re.sub(r"[^0-9a-z_]", "_", str(col).lower())
    name = f"pv_{t}_{c}"
    if len(name) > 63:
        name = name[:54] + "_" + hashlib.md5(name.encode()).hexdigest()[:8]
    taken = set(PV_REGISTRY.values())
    base, k = name, 1
    while name in taken:
        k += 1
        name = f"{base[:60]}_{k}"
    return name


def materialize_per_value(conn, columns):
    """ONE value-level aggregation per (table, column), kept as a TEMP object.
    PostgreSQL / DuckDB run the CREATE TEMP TABLE natively; the Spark adapter
    turns it into a persisted DataFrame registered as a temporary view."""
    global PER_VALUE
    PER_VALUE = True
    PV_REGISTRY.clear()
    _PV_ROWS.clear()
    cols = sorted(columns)
    print(f"  [per_value] materialising {len(cols)} value-level aggregations ...")
    for table, col in cols:
        name = pv_name(table, col)
        execute_stmt(conn, f"""
            CREATE TEMP TABLE {qi(name)} AS
            SELECT {qi(col)} AS {qi(PV_VAL)}, count(*) AS {qi(PV_CNT)}
            FROM {qi(table)}
            GROUP BY {qi(col)}
        """)
        PV_REGISTRY[(table, col)] = name
        if getattr(conn, "system", "postgres") == "postgres" and os.environ.get("SICE_PV_ANALYZE", "1") == "1":
            execute_stmt(conn, f"ANALYZE {qi(name)}")   # planner statistics for the fanout joins on the pv tables (temp tables are never auto-analysed)
        print(f"    {name} <- {table}.{col}")
    # PostgreSQL: make the TEMP tables survive a later conn.rollback()
    # (the pairwise stages roll back on a failed statement).
    conn.commit()


def drop_per_value(conn):
    """Drop the session-temporary objects (they would vanish with the session
    anyway) and leave per-value mode."""
    global PER_VALUE
    for (table, col), name in sorted(PV_REGISTRY.items()):
        execute_stmt(conn, f"DROP TABLE IF EXISTS {qi(name)}")
    conn.commit()
    PV_REGISTRY.clear()
    _PV_ROWS.clear()
    PER_VALUE = False


def _pv(table, col):
    """Temp object name for (table, col); None when per-value mode is off.
    In per-value mode a column without a pv object is a bug (the base table
    must never be scanned again), so it raises instead of falling back."""
    name = PV_REGISTRY.get((table, col))
    if name is None and PER_VALUE:
        raise RuntimeError(f"per_value: no value-level aggregation for {table}.{col}")
    return name


def _pv_table_rows(conn, table):
    """Total row count of `table` (NULL group included) from one of its pv
    objects: SUM(cnt).  Cached per table."""
    if table not in _PV_ROWS:
        name = next(n for (t, _c), n in sorted(PV_REGISTRY.items()) if t == table)
        row = query_one(conn, f"SELECT COALESCE(SUM({qi(PV_CNT)}), 0)::bigint FROM {qi(name)}")
        _PV_ROWS[table] = int(row[0])
    return _PV_ROWS[table]


# ---------------------------------------------------------------------------
# Column-to-table mapping (built from information_schema)
# ---------------------------------------------------------------------------
def build_col_to_table(conn):
    """Build a mapping from column_name -> table_name using information_schema.
    Only works when column names are unique across tables (true for TPC-H/DS).
    """
    rows = query_all(conn, """
        SELECT column_name, table_name
        FROM information_schema.columns
        WHERE table_schema = 'public'
    """)
    col_to_table = {}
    ambiguous = set()
    for col, table in rows:
        if col in col_to_table and col_to_table[col] != table:
            ambiguous.add(col)
        col_to_table[col] = table
    if ambiguous:
        print(f"  WARNING: Ambiguous columns (in multiple tables): {ambiguous}")
    return col_to_table


def build_table_columns(conn):
    """Build mapping: table_name -> {col_name: data_type}"""
    rows = query_all(conn, """
        SELECT table_name, column_name, data_type
        FROM information_schema.columns
        WHERE table_schema = 'public'
        ORDER BY table_name, ordinal_position
    """)
    table_cols = defaultdict(dict)
    for table, col, dtype in rows:
        table_cols[table][col] = dtype
    return dict(table_cols)


# ---------------------------------------------------------------------------
# SQL Query Parsing
# ---------------------------------------------------------------------------
def extract_queries_from_files(db_name):
    """Read all query .sql files and extract SQL strings (without EXPLAIN prefix)."""
    queries_path = os.path.join(QUERIES_DIR, db_name)
    if not os.path.isdir(queries_path):
        print(f"  ERROR: queries directory not found: {queries_path}")
        return []

    all_queries = []
    for fname in sorted(os.listdir(queries_path)):
        if not fname.endswith(".sql"):
            continue
        fpath = os.path.join(queries_path, fname)
        with open(fpath, "r", encoding="utf-8", errors="replace") as f:
            content = f.read()

        lines = content.split("\n")
        i = 0
        while i < len(lines):
            line = lines[i].strip()
            if line.upper().startswith("EXPLAIN"):
                # Collect the full query (may span multiple lines until ';')
                sql_lines = []
                i += 1
                while i < len(lines):
                    sql_lines.append(lines[i])
                    if ";" in lines[i]:
                        break
                    i += 1
                sql = " ".join(sql_lines).strip()
                if sql.endswith(";"):
                    sql = sql[:-1].strip()
                if sql:
                    all_queries.append(sql)
                i += 1
            else:
                i += 1

    # Deduplicate by normalizing whitespace
    seen = set()
    unique = []
    for q in all_queries:
        normalized = re.sub(r"\s+", " ", q.lower().strip())
        if normalized not in seen:
            seen.add(normalized)
            unique.append(q)

    return unique


def _strip_alias_prefix(col_ref):
    """Strip table/alias prefix from column reference: 'alias.col' -> 'col'"""
    if "." in col_ref:
        return col_ref.split(".")[-1]
    return col_ref


def discover_all_column_refs(queries, col_to_table):
    """Use sqlglot AST to find ALL column references in queries.

    The regex-based parse_joins_and_filters only inspects the FIRST WHERE
    clause and only handles AND-conjoined `col op literal` patterns. It misses:
      - columns inside OR groups (e.g. `(a = 1 or b = 2)`)
      - columns in JOIN ON clauses
      - columns referenced only in SELECT aggregates (e.g. `sum(x)`)
      - columns in WHERE clauses of subqueries (non-first WHERE)

    This walker traverses the full AST for every query and collects every
    column whose unqualified name is in col_to_table. The resulting set
    augments filter_cols so the corresponding histograms get generated.
    """
    try:
        import sqlglot
        import sqlglot.expressions as sx
    except ImportError:
        return set()
    found = set()
    for sql in queries:
        try:
            ast = sqlglot.parse_one(sql)
        except Exception:
            continue
        for col in ast.find_all(sx.Column):
            name = col.name.lower() if col.name else None
            if name and name in col_to_table:
                found.add((col_to_table[name], name))
    return found


def parse_joins_and_filters(queries, col_to_table):
    """Parse SQL queries to find join column pairs and filter columns.

    Returns:
        joins: set of ((table1, col1), (table2, col2)) tuples
        filter_cols: set of (table, col) tuples
    """
    joins = set()
    filter_cols = set()

    for sql in queries:
        # Find WHERE clause
        where_match = re.search(
            r"\bwhere\b(.+?)(?:\bgroup\s+by\b|\border\s+by\b|\blimit\b|\bhaving\b|$)",
            sql,
            re.IGNORECASE | re.DOTALL,
        )
        if not where_match:
            continue

        where_clause = where_match.group(1)

        # Split by AND
        predicates = re.split(r"\band\b", where_clause, flags=re.IGNORECASE)

        for pred in predicates:
            pred = pred.strip()
            # Clean up parens
            pred = pred.lstrip("(").rstrip(")").strip()

            # --- Equi-join: X = Y where both are column references ---
            # The regex `[\w.]+\s*=\s*[\w.]+` also matches `col=N` (literals are
            # word-chars too), so verify BOTH sides are columns before claiming
            # an equi-join. Otherwise `i_manager_id=1` would fall here, fail
            # the both-cols check, and be silently dropped via the unconditional
            # `continue` that used to follow — bypassing the filter branch.
            eq_match = re.match(r"^([\w.]+)\s*=\s*([\w.]+)\s*$", pred)
            if eq_match:
                left = eq_match.group(1).strip()
                right = eq_match.group(2).strip()
                left_col = _strip_alias_prefix(left).lower()
                right_col = _strip_alias_prefix(right).lower()

                left_in = left_col in col_to_table
                right_in = right_col in col_to_table

                if left_in and right_in:
                    t1 = col_to_table[left_col]
                    t2 = col_to_table[right_col]
                    if t1 != t2:
                        pair = tuple(sorted([(t1, left_col), (t2, right_col)]))
                        joins.add(pair)
                continue
                # [REVERTED] The fix that fell through to filter branch when
                # col=literal is removed for this bisection. Restoring the
                # always-continue behavior so we get the prior stats column set.

            # --- Filter: col op literal ---
            filter_match = re.match(
                r"^([\w.]+)\s*([<>!=]+)\s*(.+)$", pred
            )
            if filter_match:
                col_ref = filter_match.group(1).strip()
                col_name = _strip_alias_prefix(col_ref).lower()
                if col_name in col_to_table:
                    filter_cols.add((col_to_table[col_name], col_name))
                continue

            # --- BETWEEN ---
            between_match = re.match(
                r"^([\w.]+)\s+between\b", pred, re.IGNORECASE
            )
            if between_match:
                col_ref = between_match.group(1).strip()
                col_name = _strip_alias_prefix(col_ref).lower()
                if col_name in col_to_table:
                    filter_cols.add((col_to_table[col_name], col_name))
                continue

            # --- IN (...) ---
            in_match = re.match(
                r"^([\w.]+)\s+in\s*\(", pred, re.IGNORECASE
            )
            if in_match:
                col_ref = in_match.group(1).strip()
                col_name = _strip_alias_prefix(col_ref).lower()
                if col_name in col_to_table:
                    filter_cols.add((col_to_table[col_name], col_name))
                continue

    return joins, filter_cols


def parse_joins_and_filters_with_aliases(queries):
    """Parse SQL queries with explicit table aliases (e.g. stats CEB queries).

    Handles queries like:
        SELECT * FROM badges as b, users as u WHERE b.UserId = u.Id AND u.UpVotes >= 0

    Returns:
        joins: set of ((table1, col1), (table2, col2)) tuples
        filter_cols: set of (table, col) tuples
    """
    joins = set()
    filter_cols = set()

    for sql in queries:
        # Parse FROM clause to build alias -> table mapping
        from_match = re.search(
            r"\bfrom\b(.+?)\bwhere\b",
            sql, re.IGNORECASE | re.DOTALL,
        )
        if not from_match:
            continue

        alias_map = {}  # alias -> table_name
        from_clause = from_match.group(1).strip()
        for part in from_clause.split(","):
            part = part.strip()
            # "table as alias" or "table alias" or just "table"
            m = re.match(r"(\w+)\s+(?:as\s+)?(\w+)", part, re.IGNORECASE)
            if m:
                alias_map[m.group(2).lower()] = m.group(1).lower()
            else:
                tname = part.strip().lower()
                if tname:
                    alias_map[tname] = tname

        # Parse WHERE clause
        where_match = re.search(
            r"\bwhere\b(.+?)(?:\bgroup\s+by\b|\border\s+by\b|\blimit\b|\bhaving\b|$)",
            sql, re.IGNORECASE | re.DOTALL,
        )
        if not where_match:
            continue

        where_clause = where_match.group(1)
        predicates = re.split(r"\band\b", where_clause, flags=re.IGNORECASE)

        def _resolve(ref):
            """Resolve alias.col to (table, col)."""
            ref = ref.strip().lower()
            if "." in ref:
                alias, col = ref.split(".", 1)
                table = alias_map.get(alias)
                if table:
                    return (table, col)
            return None

        for pred in predicates:
            pred = pred.strip().lstrip("(").rstrip(")").strip()
            # Remove ::type casts for matching
            pred_clean = re.sub(r"::\w+", "", pred)

            # Equi-join: alias1.col1 = alias2.col2 (both sides must have a dot)
            eq_match = re.match(r"^(\w+\.\w+)\s*=\s*(\w+\.\w+)\s*$", pred_clean.strip())
            if eq_match:
                left = _resolve(eq_match.group(1))
                right = _resolve(eq_match.group(2))
                if left and right and left[0] != right[0]:
                    pair = tuple(sorted([left, right]))
                    joins.add(pair)
                elif left:
                    filter_cols.add(left)
                continue

            # Filter: alias.col op literal
            filter_match = re.match(
                r"^([\w.]+)\s*([<>!=]+)", pred_clean.strip()
            )
            if filter_match:
                resolved = _resolve(filter_match.group(1))
                if resolved:
                    filter_cols.add(resolved)
                continue

            # BETWEEN
            between_match = re.match(
                r"^([\w.]+)\s+between\b", pred_clean.strip(), re.IGNORECASE
            )
            if between_match:
                resolved = _resolve(between_match.group(1))
                if resolved:
                    filter_cols.add(resolved)
                continue

            # IN
            in_match = re.match(
                r"^([\w.]+)\s+in\s*\(", pred_clean.strip(), re.IGNORECASE
            )
            if in_match:
                resolved = _resolve(in_match.group(1))
                if resolved:
                    filter_cols.add(resolved)

    return joins, filter_cols


# ---------------------------------------------------------------------------
# Column Classification (continuous vs discrete)
# ---------------------------------------------------------------------------
DATE_TYPES = {"date", "timestamp without time zone", "timestamp with time zone"}
TIME_TYPES = {"time without time zone", "time with time zone", "interval"}
STRING_TYPES = {"character varying", "character", "text", "char", "varchar"}


def classify_columns(conn, tables_and_cols, table_col_dtypes):
    """Classify columns as continuous ('ctn') or discrete ('dsct').

    - String types -> discrete
    - Date types -> continuous (epoch seconds)
    - Numeric with high cardinality -> continuous
    - Numeric with low cardinality -> discrete
    """
    col_classes = {}

    for table, col in tables_and_cols:
        dtype = table_col_dtypes.get(table, {}).get(col, "")

        if dtype in STRING_TYPES or dtype in TIME_TYPES:
            col_classes[(table, col)] = "dsct"
            continue

        if dtype in DATE_TYPES:
            col_classes[(table, col)] = "ctn"
            continue

        # Numeric type - check cardinality from pg_stats
        row = query_one(conn, f"""
            SELECT n_distinct
            FROM pg_stats
            WHERE schemaname = 'public'
              AND tablename = '{table}'
              AND attname = '{col}'
        """)

        if row is None or row[0] is None:
            col_classes[(table, col)] = "ctn"
            continue

        n_distinct = float(row[0])
        if n_distinct < 0:
            # Negative = fraction of rows, e.g. -1 means all unique
            if abs(n_distinct) > 0.01:
                col_classes[(table, col)] = "ctn"
            else:
                col_classes[(table, col)] = "dsct"
        else:
            if n_distinct > 50:
                col_classes[(table, col)] = "ctn"
            else:
                col_classes[(table, col)] = "dsct"

    return col_classes


# ---------------------------------------------------------------------------
# SQL expression for casting columns to float (handles dates)
# ---------------------------------------------------------------------------
def _col_expr(table, col, dtype):
    """SQL expression to cast a column to float8, handling dates -> epoch."""
    qcol = qi(col)
    if dtype in DATE_TYPES:
        return f"EXTRACT(EPOCH FROM {qcol})::float8"
    return f"{qcol}::float8"


# ---------------------------------------------------------------------------
# Generate size.pkl
# ---------------------------------------------------------------------------
def generate_size(conn, abbrev):
    """Generate size.pkl: {alias: {'size': N, 'num_cols': C, 'num_rows': N}}"""
    print("  Generating size.pkl ...")
    size_data = {}

    for table_name, alias in abbrev.items():
        if PER_VALUE and any(t == table_name for t, _c in PV_REGISTRY):
            num_rows = _pv_table_rows(conn, table_name)      # SUM(cnt) of a pv object
        else:
            row = query_one(conn, f"SELECT count(*) FROM {qi(table_name)}")
            num_rows = row[0]

        row = query_one(conn, f"""
            SELECT count(*)
            FROM information_schema.columns
            WHERE table_schema = 'public' AND table_name = '{table_name}'
        """)
        num_cols = row[0]

        size_data[alias] = {
            "size": num_rows,
            "num_cols": num_cols,
            "num_rows": num_rows,
        }
        print(f"    {alias}: {num_rows:,} rows, {num_cols} cols")

    return size_data


# ---------------------------------------------------------------------------
# Generate null_fraction.pkl
# ---------------------------------------------------------------------------
def generate_null_fractions(conn, abbrev, columns):
    """Compute null_fraction = COUNT(NULL)/COUNT(*) per (table, column).

    Args:
        conn: psycopg2 connection.
        abbrev: dict[table_name -> price_alias].
        columns: iterable of (table, column) pairs.

    Returns:
        dict[(table, column)] -> float in [0, 1].
    """
    out = {}
    cur = conn.cursor()
    for table, col in sorted(columns):
        if table not in abbrev:
            continue
        try:
            pv = _pv(table, col)
            if pv:
                # cnt of the NULL group / sum(cnt)
                cur.execute(
                    f'SELECT COALESCE(SUM(CASE WHEN "{PV_VAL}" IS NULL THEN "{PV_CNT}" ELSE 0 END)::float '
                    f'       / NULLIF(SUM("{PV_CNT}"), 0)::float, 0.0) FROM "{pv}"'
                )
            else:
                cur.execute(
                    f'SELECT COALESCE(SUM(CASE WHEN "{col}" IS NULL THEN 1 ELSE 0 END)::float '
                    f'       / NULLIF(COUNT(*), 0)::float, 0.0) FROM "{table}"'
                )
            (frac,) = cur.fetchone()
            out[(table, col)] = float(frac) if frac is not None else 0.0
        except Exception as e:
            print(f"    WARN null_fraction({table}.{col}): {e}")
            out[(table, col)] = 0.0
    cur.close()
    return out


# ---------------------------------------------------------------------------
# Generate histogram40.pkl
# ---------------------------------------------------------------------------
def generate_histograms(conn, abbrev, col_types, table_col_dtypes, bin_size=BIN_SIZE):
    """Generate histogram40.pkl for ALL tracked columns (continuous + discrete).

    PRICE's Sql2Feature.get_column_histograms() expects every filter/join
    column to have a histogram entry, regardless of continuous/discrete type.
    For string-type discrete columns we encode values as integer indices
    (by frequency order) and histogram those.
    """
    print("  Generating histogram40.pkl ...")
    histogram_data = {}

    # Initialize all tables with empty dicts
    for alias in abbrev.values():
        histogram_data[alias] = {}

    for (table, col), cls in col_types.items():
        alias = abbrev[table]
        dtype = table_col_dtypes.get(table, {}).get(col, "")

        if dtype in STRING_TYPES or dtype in TIME_TYPES:
            # String/time column: encode as integer indices by frequency rank
            _generate_histogram_for_string_col(
                conn, table, col, alias, histogram_data, bin_size)
        else:
            # Numeric/date column: normal histogram
            _generate_histogram_for_col(
                conn, table, col, alias, histogram_data,
                table_col_dtypes, bin_size)

    return histogram_data


def _generate_histogram_for_col(conn, table, col, alias, histogram_data,
                                 table_col_dtypes, bin_size=BIN_SIZE):
    """Generate a single histogram entry and store it in histogram_data."""
    dtype = table_col_dtypes.get(table, {}).get(col, "")
    expr = _col_expr(table, col, dtype)

    qtable = qi(table)
    qcol = qi(col)
    pv = _pv(table, col)
    if pv:
        # Per-value mode: same expressions over the value-level aggregation
        # (val, cnt); counts are SUM(cnt), the table scan is never repeated.
        expr = _col_expr(table, PV_VAL, dtype)
        qtable = qi(pv)
        qcol = qi(PV_VAL)
        cnt_expr = f"SUM({qi(PV_CNT)})::bigint"
    else:
        cnt_expr = "count(*)"
    row = query_one(conn, f"""
        SELECT min({expr}), max({expr}), {cnt_expr}
        FROM {qtable}
        WHERE {qcol} IS NOT NULL
    """)
    if row is None or row[0] is None:
        histogram_data[alias][col] = {
            "hist": np.zeros(bin_size),
            "bin_edges": np.zeros(bin_size + 1),
            "len": 0,
            "min_value": 0,
            "max_value": 0,
        }
        return

    min_val, max_val, total_count = float(row[0]), float(row[1]), int(row[2])

    # Total rows including NULLs (for 'len' field, matching PRICE convention)
    if pv:
        len_column = _pv_table_rows(conn, table)
    else:
        len_column = query_one(conn, f"SELECT count(*) FROM {qtable}")[0]

    if min_val == max_val:
        bin_edges = np.linspace(min_val, min_val + 1.0, bin_size + 1)
        hist = np.zeros(bin_size, dtype=float)
        hist[0] = float(total_count)
    else:
        bin_edges = np.linspace(min_val, max_val, bin_size + 1)
        eps = (max_val - min_val) * 1e-10 + 1e-10
        rows = query_all(conn, f"""
            SELECT width_bucket({expr}, {min_val}, {max_val + eps}, {bin_size}) AS bucket,
                   {cnt_expr} AS cnt
            FROM {qtable}
            WHERE {qcol} IS NOT NULL
            GROUP BY bucket
            ORDER BY bucket
        """)

        hist = np.zeros(bin_size, dtype=float)
        for bucket, cnt in rows:
            if bucket is None:
                continue
            if 1 <= bucket <= bin_size:
                hist[bucket - 1] = float(cnt)
            elif bucket == 0:
                hist[0] += float(cnt)
            elif bucket == bin_size + 1:
                hist[bin_size - 1] += float(cnt)

    histogram_data[alias][col] = {
        "hist": hist,
        "bin_edges": bin_edges,
        "len": len_column,
        "min_value": min_val,
        "max_value": max_val,
    }
    print(f"    {alias}.{col}: min={min_val:.2f}, max={max_val:.2f}, "
          f"count={total_count:,}, bins_nonzero={int(np.count_nonzero(hist))}")


def _generate_histogram_for_string_col(conn, table, col, alias, histogram_data,
                                        bin_size=BIN_SIZE):
    """Generate histogram for a string column by encoding values as integers.

    Values are ranked by frequency (most frequent = 0) and a standard
    equi-width histogram is built over these integer indices.
    """
    qtable = qi(table)
    qcol = qi(col)
    pv = _pv(table, col)
    if pv:
        # Per-value mode: the (val, cnt) rows of the temp object, same ordering.
        rows = query_all(conn, f"""
            SELECT {qi(PV_VAL)}, {qi(PV_CNT)} AS cnt
            FROM {qi(pv)}
            WHERE {qi(PV_VAL)} IS NOT NULL
            ORDER BY cnt DESC
        """)
    else:
        rows = query_all(conn, f"""
            SELECT {qcol}, count(*) AS cnt
            FROM {qtable}
            WHERE {qcol} IS NOT NULL
            GROUP BY {qcol}
            ORDER BY cnt DESC
        """)
    if not rows:
        if pv:
            len_column = _pv_table_rows(conn, table)
        else:
            len_column = query_one(conn, f"SELECT count(*) FROM {qtable}")[0]
        histogram_data[alias][col] = {
            "hist": np.zeros(bin_size),
            "bin_edges": np.zeros(bin_size + 1),
            "len": len_column,
            "min_value": 0,
            "max_value": 0,
        }
        return

    # Map string values to integer indices (0 = most frequent)
    value_to_idx = {}
    for idx, (val, _cnt) in enumerate(rows):
        value_to_idx[val] = idx

    total_count = sum(cnt for _, cnt in rows)
    if pv:
        len_column = _pv_table_rows(conn, table)
    else:
        len_column = query_one(conn, f"SELECT count(*) FROM {qtable}")[0]
    n_distinct = len(rows)

    min_val = 0.0
    max_val = float(n_distinct - 1) if n_distinct > 1 else 1.0

    if n_distinct == 1:
        bin_edges = np.linspace(0.0, 1.0, bin_size + 1)
        hist = np.zeros(bin_size, dtype=float)
        hist[0] = float(total_count)
    else:
        bin_edges = np.linspace(min_val, max_val, bin_size + 1)
        hist = np.zeros(bin_size, dtype=float)
        bin_width = (max_val - min_val) / bin_size
        for val, cnt in rows:
            idx = value_to_idx[val]
            bucket = min(int((idx - min_val) / bin_width), bin_size - 1)
            hist[bucket] += float(cnt)

    histogram_data[alias][col] = {
        "hist": hist,
        "bin_edges": bin_edges,
        "len": len_column,
        "min_value": min_val,
        "max_value": max_val,
    }
    print(f"    {alias}.{col} (string): n_distinct={n_distinct}, "
          f"count={total_count:,}, bins_nonzero={int(np.count_nonzero(hist))}")


# ---------------------------------------------------------------------------
# Generate summary40.pkl
# ---------------------------------------------------------------------------
def generate_summaries(conn, abbrev, col_types, bin_size=BIN_SIZE):
    """Generate summary40.pkl for all discrete columns."""
    print("  Generating summary40.pkl ...")
    summary_data = {}

    for alias in abbrev.values():
        summary_data[alias] = {}

    table_dsct_cols = defaultdict(list)
    for (table, col), cls in col_types.items():
        if cls == "dsct":
            table_dsct_cols[table].append(col)

    for table, cols in table_dsct_cols.items():
        alias = abbrev[table]
        for col in cols:
            pv = _pv(table, col)
            if pv:
                rows = query_all(conn, f"""
                    SELECT {qi(PV_VAL)}, {qi(PV_CNT)} AS cnt
                    FROM {qi(pv)}
                    WHERE {qi(PV_VAL)} IS NOT NULL
                    ORDER BY cnt DESC
                """)
            else:
                rows = query_all(conn, f"""
                    SELECT {qi(col)}, count(*) AS cnt
                    FROM {qi(table)}
                    WHERE {qi(col)} IS NOT NULL
                    GROUP BY {qi(col)}
                    ORDER BY cnt DESC
                """)

            keys = []
            values = []
            for val, cnt in rows:
                if isinstance(val, (int, float)):
                    keys.append(val)
                else:
                    keys.append(str(val).strip())
                values.append(int(cnt))

            summary_data[alias][col] = {
                "keys": keys,
                "values": values,
            }
            print(f"    {alias}.{col}: {len(keys)} distinct values, total={sum(values):,}")

    return summary_data


# ---------------------------------------------------------------------------
# Generate fanout40.pkl
# ---------------------------------------------------------------------------
def generate_fanouts(conn, abbrev, joins, col_types, histogram_data,
                     table_col_dtypes, bin_size=BIN_SIZE):
    """Generate fanout40.pkl for all join column pairs."""
    print("  Generating fanout40.pkl ...")
    fanout_data = {}

    # Join columns need histograms for binning. Generate supplementary histograms
    # for any numeric join column that is missing from histogram_data (e.g. classified dsct).
    join_cols_needing_hist = set()
    for (t1, c1), (t2, c2) in joins:
        a1 = abbrev.get(t1)
        a2 = abbrev.get(t2)
        if a1 and c1 not in histogram_data.get(a1, {}):
            join_cols_needing_hist.add((t1, c1))
        if a2 and c2 not in histogram_data.get(a2, {}):
            join_cols_needing_hist.add((t2, c2))

    if join_cols_needing_hist:
        print(f"    Generating supplementary histograms for {len(join_cols_needing_hist)} join columns ...")
        for table, col in sorted(join_cols_needing_hist):
            # Skip string columns — can't make numeric histograms
            dtype = table_col_dtypes.get(table, {}).get(col, "")
            if dtype in STRING_TYPES or dtype in TIME_TYPES:
                print(f"      Skipping string/time column {table}.{col}")
                continue
            alias = abbrev[table]
            if alias not in histogram_data:
                histogram_data[alias] = {}
            _generate_histogram_for_col(conn, table, col, alias, histogram_data,
                                        table_col_dtypes, bin_size)

    # Compute fanouts for each join pair
    for (t1, c1), (t2, c2) in sorted(joins):
        a1 = abbrev.get(t1)
        a2 = abbrev.get(t2)
        if not a1 or not a2:
            continue

        left_key = f"{a1}.{c1}"
        right_key = f"{a2}.{c2}"
        print(f"    Computing fanout: {left_key} <-> {right_key}")

        if c1 not in histogram_data.get(a1, {}):
            print(f"      WARNING: No histogram for {a1}.{c1}, skipping")
            continue
        if c2 not in histogram_data.get(a2, {}):
            print(f"      WARNING: No histogram for {a2}.{c2}, skipping")
            continue

        left_fanout = _compute_fanout_direction(
            conn, t1, c1, t2, c2,
            histogram_data[a1][c1]["bin_edges"],
            table_col_dtypes, bin_size
        )

        right_fanout = _compute_fanout_direction(
            conn, t2, c2, t1, c1,
            histogram_data[a2][c2]["bin_edges"],
            table_col_dtypes, bin_size
        )

        fanout_data[(left_key, right_key)] = [left_fanout, right_fanout]
        fanout_data[(right_key, left_key)] = [right_fanout, left_fanout]

    return fanout_data


# ---------------------------------------------------------------------------
# Column-to-column comparisons: same-row filters and operator-conditioned joins
# ---------------------------------------------------------------------------
def discover_column_comparisons(queries, table_col_dtypes):
    """Find every comparison `x op y + v` between two base-table columns.

    A comparison between two columns of the same table instance (same SQL
    alias, or both unqualified) is a same-row filter on x - y; one between two
    instances is a join. Plain equi-joins between different tables are left to
    the existing equi-join discovery (fanout40.pkl).

    Returns:
        same_row: set of (table, col_x, col_y)
        joins_op: set of ((table_L, col_L), op, (table_R, col_R), v)
    """
    same_row, joins_op = set(), set()
    # Queries generated from one template differ only in their literals: parse
    # each shape once. String literals and numbers not preceded by +/- (an
    # offset such as `d_date + 5` is part of the comparison) are normalised.
    shapes = {}
    for sql in queries:
        key = re.sub(r"'(?:[^']|'')*'", "''", sql.lower())
        key = re.sub(r"(?<![+\-\s])(\s*)\b\d+(?:\.\d+)?\b", r"\1?", key)
        key = re.sub(r"\s+", " ", key)
        shapes.setdefault(key, sql)
    for key, sql in shapes.items():
        if not _may_compare_columns(key):
            continue
        try:
            ast = sqlglot.parse_one(sql, read="postgres")
        except Exception:
            continue
        aliases = {}
        for tbl in ast.find_all(sqlglot.exp.Table):
            if tbl.name in table_col_dtypes:
                aliases[(tbl.alias or tbl.name)] = tbl.name
        in_query = set(aliases.values())

        def _resolve(col):
            if col.table:
                t = aliases.get(col.table)
            else:
                owners = [t for t in in_query if col.name in table_col_dtypes[t]]
                t = owners[0] if len(owners) == 1 else None
            return t if t and col.name in table_col_dtypes.get(t, {}) else None

        for node in ast.find_all(sqlglot.exp.Predicate):
            parts = column_comparison(node)
            if parts is None:
                continue
            x, op, y, v = parts
            tx, ty = _resolve(x), _resolve(y)
            if tx is None or ty is None:
                continue
            if tx == ty and (x.table or "") == (y.table or ""):
                same_row.add((tx, x.name, y.name))
            elif not (op == "=" and v == 0 and tx != ty):
                joins_op.add(((tx, x.name), op, (ty, y.name), v))
    return same_row, joins_op


_COL_CMP_RE = re.compile(
    r"\b([a-z_]\w*(?:\.[a-z_]\w*)?)\s*(<>|!=|<=|>=|=|<|>)\s*([a-z_]\w*(?:\.[a-z_]\w*)?)\b(\s*[+\-]\s*\d)?")
_SQL_WORDS = {"and", "or", "not", "null", "true", "false", "is", "in", "between", "like", "select",
              "case", "when", "then", "else", "end", "date", "interval", "timestamp"}


def _may_compare_columns(sql):
    """Cheap text pre-filter for discover_column_comparisons (lower-cased SQL):
    False only when every column-vs-column comparison is a plain equality
    between differently qualified columns and no table appears twice, i.e.
    the query holds nothing but ordinary cross-table equi-joins."""
    hits = [m for m in _COL_CMP_RE.finditer(sql)
            if m.group(1) not in _SQL_WORDS and m.group(3) not in _SQL_WORDS]
    if not hits:
        return False
    tables = re.findall(r"(?:\bfrom\s+|\bjoin\s+|,\s*)([a-z_]\w*)(?=\s+(?:as\s+)?[a-z_]\w*\s*(?:,|\bwhere\b|\bjoin\b|\bon\b|$)|\s*(?:,|\bwhere\b|$))", sql)
    if len(tables) != len(set(tables)):
        return True
    for m in hits:
        a, op, b, offset = m.groups()
        qa = a.split(".")[0] if "." in a else ""
        qb = b.split(".")[0] if "." in b else ""
        if op != "=" or offset or qa == qb:
            return True
    return False


def _diff_expr(table_col_dtypes, table, col_x, col_y):
    """SQL for x - y in the units of the queries' offsets (days for dates),
    or None when the difference is undefined (strings)."""
    dx = table_col_dtypes.get(table, {}).get(col_x, "")
    dy = table_col_dtypes.get(table, {}).get(col_y, "")
    if dx in STRING_TYPES or dy in STRING_TYPES or dx in TIME_TYPES or dy in TIME_TYPES:
        return None
    if dx in DATE_TYPES and dy in DATE_TYPES:
        # Same epoch expressions as _col_expr (portable across PostgreSQL,
        # DuckDB and Spark), converted to days for dates.
        days = " / 86400.0" if (dx == "date" and dy == "date") else ""
        return (f"((EXTRACT(EPOCH FROM {qi(col_x)})::float8 - "
                f"EXTRACT(EPOCH FROM {qi(col_y)})::float8){days})")
    if dx in DATE_TYPES or dy in DATE_TYPES:
        return None
    return f"({qi(col_x)}::float8 - {qi(col_y)}::float8)"


def materialize_diff_distributions(conn, same_row, table_col_dtypes):
    """Per-value distribution of x - y for every same-row pair:
        CREATE TEMP TABLE ... AS SELECT x - y AS val, count(*) AS cnt FROM t GROUP BY 1
    registered like a per-value column under diff_column(x, y), so the
    histogram, summary, null-fraction and classification code treats it as an
    ordinary numeric column. Returns {(table, diff_col): 'ctn' | 'dsct'}."""
    col_types = {}
    for table, cx, cy in sorted(same_row):
        expr = _diff_expr(table_col_dtypes, table, cx, cy)
        if expr is None:
            print(f"    WARNING: no difference distribution for {table}.{cx} - {cy} (non-numeric)")
            continue
        dcol = diff_column(cx, cy)
        name = pv_name(table, dcol)
        execute_stmt(conn, f"""
            CREATE TEMP TABLE {qi(name)} AS
            SELECT {expr} AS {qi(PV_VAL)}, count(*) AS {qi(PV_CNT)}
            FROM {qi(table)}
            GROUP BY 1
        """)
        PV_REGISTRY[(table, dcol)] = name
        table_col_dtypes.setdefault(table, {})[dcol] = "double precision"
        n_distinct = query_one(conn, f"SELECT count(*) FROM {qi(name)} WHERE {qi(PV_VAL)} IS NOT NULL")[0]
        col_types[(table, dcol)] = "ctn" if n_distinct > 50 else "dsct"
        print(f"    {name} <- {table}.{cx} - {table}.{cy} ({n_distinct} distinct)")
    conn.commit()
    return col_types


def _value_distribution(conn, table, col, table_col_dtypes):
    """Non-NULL per-value distribution of a column: (values, counts).
    Numeric/date columns: float values (dates as epoch seconds), sorted.
    String columns: raw values ordered by count descending (the order of the
    string histogram encoding)."""
    dtype = table_col_dtypes.get(table, {}).get(col, "")
    is_string = dtype in STRING_TYPES or dtype in TIME_TYPES
    pv = _pv(table, col)
    src, ccol = (qi(pv), qi(PV_VAL)) if pv else (qi(table), qi(col))
    cnt = f"SUM({qi(PV_CNT)})" if pv else "count(*)"
    if is_string:
        rows = query_all(conn, f"""
            SELECT {ccol}, {cnt} AS cnt FROM {src} WHERE {ccol} IS NOT NULL
            GROUP BY 1 ORDER BY cnt DESC""")
        return [r[0] for r in rows], np.array([float(r[1]) for r in rows])
    expr = _col_expr(table, PV_VAL if pv else col, dtype)
    rows = query_all(conn, f"""
        SELECT {expr} AS v, {cnt} FROM {src} WHERE {ccol} IS NOT NULL
        GROUP BY 1 ORDER BY 1""")
    return (np.array([float(r[0]) for r in rows]),
            np.array([float(r[1]) for r in rows]))


def _count_matching(values, counts, rel, t):
    """For each threshold t[i]: the number of rows whose value w satisfies
    `w rel t[i]` (values sorted ascending)."""
    cum = np.concatenate([[0.0], np.cumsum(counts)])
    total = cum[-1]
    lt = cum[np.searchsorted(values, t, side="left")]
    le = cum[np.searchsorted(values, t, side="right")]
    return {"<": lt, "<=": le, ">": total - le, ">=": total - lt,
            "=": le - lt, "!=": total - (le - lt)}[rel]


def _bin_average(values, counts, matches, hist_entry, is_string, bin_size=BIN_SIZE):
    """Per-bin average of `matches` over the rows of each histogram bin of the
    left column (the binning of histogram40.pkl), and the orphan fraction."""
    n = len(values)
    if is_string:
        hi = float(n - 1) if n > 1 else 1.0
        width = hi / bin_size if n > 1 else 1.0
        idx = np.minimum((np.arange(n) / width).astype(int), bin_size - 1) if n > 1 \
            else np.zeros(n, dtype=int)
    else:
        lo, hi = float(hist_entry["bin_edges"][0]), float(hist_entry["bin_edges"][-1])
        if hi == lo:
            idx = np.zeros(n, dtype=int)
        else:
            eps = (hi - lo) * 1e-10 + 1e-10
            idx = np.clip(np.floor((values - lo) / (hi + eps - lo) * bin_size).astype(int),
                          0, bin_size - 1)
    rows = np.bincount(idx, weights=counts, minlength=bin_size)
    hits = np.bincount(idx, weights=counts * matches, minlength=bin_size)
    fanout = np.divide(hits, rows, out=np.zeros(bin_size), where=rows > 0)
    total = counts.sum()
    orphan = float(counts[matches == 0].sum() / total) if total > 0 else 0.0
    return [float(f) for f in fanout], orphan


def generate_nonequi_fanouts(conn, abbrev, joins_op, histogram_data, table_col_dtypes,
                             bin_size=BIN_SIZE):
    """nonequi_fanout_op40.pkl: operator-conditioned fanouts of the joins in
    joins_op. For `L.x op R.y + v` and each left value a,
        f_LR(a) = |{b in R : a op b + v}|,
    averaged over the rows of each histogram bin of L.x (as fanout40.pkl does
    for equality); f_RL symmetrically, |{a in L : a op b + v}| per bin of R.y.
    Computed exactly from the two per-value distributions. Keyed
    (L, op, R, v) and, mirrored, (R, MIRROR_OP[op], L, -v)."""
    print("  Generating nonequi_fanout_op40.pkl ...")
    out = {}
    dist_cache = {}

    def _dist(t, c):
        if (t, c) not in dist_cache:
            dist_cache[(t, c)] = _value_distribution(conn, t, c, table_col_dtypes)
        return dist_cache[(t, c)]

    for (tL, cL), op, (tR, cR), v in sorted(joins_op, key=str):
        aL, aR = abbrev.get(tL), abbrev.get(tR)
        if not aL or not aR:
            continue
        hL = histogram_data.get(aL, {}).get(cL)
        hR = histogram_data.get(aR, {}).get(cR)
        if hL is None or hR is None:
            print(f"    WARNING: no histogram for {aL}.{cL} or {aR}.{cR}, skipping")
            continue
        dL = table_col_dtypes.get(tL, {}).get(cL, "")
        dR = table_col_dtypes.get(tR, {}).get(cR, "")
        sL = dL in STRING_TYPES or dL in TIME_TYPES
        sR = dR in STRING_TYPES or dR in TIME_TYPES
        if sL or sR:
            if op not in ("=", "!=") or v != 0 or sL != sR:
                print(f"    WARNING: {aL}.{cL} {op} {aR}.{cR} + {v:g}: unsupported on strings, skipping")
                continue
        elif v != 0 and (dL in DATE_TYPES) != (dR in DATE_TYPES):
            print(f"    WARNING: {aL}.{cL} {op} {aR}.{cR} + {v:g}: mixed date/number offset, skipping")
            continue
        kL, kR = f"{aL}.{cL}", f"{aR}.{cR}"
        if op == "=" and v == 0:
            # Plain equality (e.g. between two instances of one table): the same
            # in-database computation as fanout40.pkl and orphan_fraction.
            f_lr = _compute_fanout_direction(conn, tL, cL, tR, cR, hL["bin_edges"],
                                             table_col_dtypes, bin_size)
            f_rl = _compute_fanout_direction(conn, tR, cR, tL, cL, hR["bin_edges"],
                                             table_col_dtypes, bin_size)
            o_lr, o_rl = generate_orphan_fractions(conn, abbrev, {((tL, cL), (tR, cR))}).get(
                (kL, kR), (0.0, 0.0))
            out[(kL, op, kR, v)] = {"fanout": (f_lr, f_rl), "orphan": (o_lr, o_rl)}
            out[(kR, op, kL, 0.0)] = {"fanout": (f_rl, f_lr), "orphan": (o_rl, o_lr)}
            print(f"    {kL} = {kR}: mean fanout {np.mean(f_lr):.1f} / {np.mean(f_rl):.1f}, "
                  f"orphan {o_lr:.3f} / {o_rl:.3f}")
            continue
        # Offsets in the queries are in days for dates; the values are epoch seconds.
        v_units = v * 86400.0 if dL == "date" else v

        valsL, cntL = _dist(tL, cL)
        valsR, cntR = _dist(tR, cR)
        if sL:
            # Strings: equality by value; != is the complement.
            r_eq = {k: c for k, c in zip(valsR, cntR)}
            l_eq = {k: c for k, c in zip(valsL, cntL)}
            mLR = np.array([r_eq.get(k, 0.0) for k in valsL])
            mRL = np.array([l_eq.get(k, 0.0) for k in valsR])
            if op == "!=":
                mLR, mRL = cntR.sum() - mLR, cntL.sum() - mRL
        else:
            # a op b + v  <=>  b MIRROR_OP[op] a - v
            mLR = _count_matching(valsR, cntR, MIRROR_OP[op], valsL - v_units)
            mRL = _count_matching(valsL, cntL, op, valsR + v_units)
        f_lr, o_lr = _bin_average(valsL, cntL, mLR, hL, sL, bin_size)
        f_rl, o_rl = _bin_average(valsR, cntR, mRL, hR, sR, bin_size)
        out[(kL, op, kR, v)] = {"fanout": (f_lr, f_rl), "orphan": (o_lr, o_rl)}
        out[(kR, MIRROR_OP[op], kL, -v + 0.0)] = {"fanout": (f_rl, f_lr), "orphan": (o_rl, o_lr)}
        print(f"    {kL} {op} {kR} + {v:g}: mean fanout {np.mean(f_lr):.1f} / {np.mean(f_rl):.1f}, "
              f"orphan {o_lr:.3f} / {o_rl:.3f}")
    return out


def generate_orphan_fractions(conn, abbrev, joins):
    """Compute orphan_fraction per direction for each join pair.

    For ((tL, cL), (tR, cR)):
      orphan_LR = fraction of L rows whose key has zero matches in R
      orphan_RL = fraction of R rows whose key has zero matches in L

    Returns dict[(price_alias_L.cL, price_alias_R.cR)] -> (orphan_LR, orphan_RL).
    """
    out = {}
    cur = conn.cursor()
    for (tL, cL), (tR, cR) in sorted(joins):
        if tL not in abbrev or tR not in abbrev:
            continue
        try:
            pvL, pvR = _pv(tL, cL), _pv(tR, cR)
            if pvL and pvR:
                # Per-value mode: the value-level counts are the pv rows.
                lc_sql = (f'SELECT "{PV_VAL}" AS k, "{PV_CNT}" AS lcnt '
                          f'FROM "{pvL}" WHERE "{PV_VAL}" IS NOT NULL')
                rc_sql = (f'SELECT "{PV_VAL}" AS k, "{PV_CNT}" AS rcnt '
                          f'FROM "{pvR}" WHERE "{PV_VAL}" IS NOT NULL')
            else:
                lc_sql = (f'SELECT "{cL}" AS k, COUNT(*) AS lcnt '
                          f'FROM "{tL}" WHERE "{cL}" IS NOT NULL GROUP BY 1')
                rc_sql = (f'SELECT "{cR}" AS k, COUNT(*) AS rcnt '
                          f'FROM "{tR}" WHERE "{cR}" IS NOT NULL GROUP BY 1')
            cur.execute(f"""
                WITH lc AS (
                    {lc_sql}
                ),
                rc AS (
                    {rc_sql}
                ),
                m AS (
                    SELECT COALESCE(lc.k, rc.k) AS k,
                           COALESCE(lc.lcnt, 0) AS lcnt,
                           COALESCE(rc.rcnt, 0) AS rcnt
                    FROM lc FULL OUTER JOIN rc USING (k)
                )
                SELECT
                  COALESCE(SUM(CASE WHEN rcnt = 0 THEN lcnt ELSE 0 END)::float
                           / NULLIF(SUM(lcnt), 0)::float, 0.0) AS orphan_lr,
                  COALESCE(SUM(CASE WHEN lcnt = 0 THEN rcnt ELSE 0 END)::float
                           / NULLIF(SUM(rcnt), 0)::float, 0.0) AS orphan_rl
                FROM m
            """)
            o_lr, o_rl = cur.fetchone()
            key = (f"{abbrev[tL]}.{cL}", f"{abbrev[tR]}.{cR}")
            out[key] = (float(o_lr or 0.0), float(o_rl or 0.0))
        except Exception as e:
            print(f"    WARN orphan_fraction({tL}.{cL} \u2194 {tR}.{cR}): {e}")
    cur.close()
    return out


def _compute_fanout_direction(conn, left_table, left_col, right_table, right_col,
                               bin_edges, table_col_dtypes, bin_size=BIN_SIZE):
    """Compute per-bin average fanout from left to right.

    For bin i of left_col's histogram:
        avg_fanout[i] = sum(lc(v) * rc(v)) / sum(lc(v))
    where lc(v) = count of left rows with value v in bin i,
          rc(v) = count of right rows with same value v.
    """
    left_dtype = table_col_dtypes.get(left_table, {}).get(left_col, "")

    if left_dtype in STRING_TYPES or left_dtype in TIME_TYPES:
        return _compute_fanout_direction_string(
            conn, left_table, left_col, right_table, right_col,
            bin_edges, bin_size)

    right_dtype = table_col_dtypes.get(right_table, {}).get(right_col, "")
    left_expr = _col_expr(left_table, left_col, left_dtype)
    right_expr_inner = _col_expr(right_table, right_col, right_dtype)
    ql_table = qi(left_table)
    qr_table = qi(right_table)
    ql_col = qi(left_col)
    qr_col = qi(right_col)
    pvL, pvR = _pv(left_table, left_col), _pv(right_table, right_col)
    if pvL and pvR:
        # Per-value mode: identical statement shape over the pv objects; the
        # value-level counts are SUM(cnt) per (cast) value so that values which
        # collide after the float8 cast are merged exactly as in the reference.
        left_expr = _col_expr(left_table, PV_VAL, left_dtype)
        right_expr_inner = _col_expr(right_table, PV_VAL, right_dtype)
        ql_table, qr_table = qi(pvL), qi(pvR)
        ql_col = qr_col = qi(PV_VAL)
        l_cnt = r_cnt = f"SUM({qi(PV_CNT)})::bigint"
    else:
        l_cnt = r_cnt = "count(*)"

    min_val = float(bin_edges[0])
    max_val = float(bin_edges[-1])

    if min_val == max_val:
        left_count = query_one(conn, f"""
            SELECT COALESCE({l_cnt}, 0) FROM {ql_table} WHERE {ql_col} IS NOT NULL
        """)[0]
        right_count = query_one(conn, f"""
            SELECT COALESCE({r_cnt}, 0) FROM {qr_table}
            WHERE {qr_col} IS NOT NULL AND {right_expr_inner} = {min_val}
        """)[0]
        fanout = [0.0] * bin_size
        if left_count > 0:
            fanout[0] = float(right_count)
        return fanout

    eps = (max_val - min_val) * 1e-10 + 1e-10

    sql = f"""
        WITH left_counts AS (
            SELECT {left_expr} AS val, {l_cnt} AS lcnt
            FROM {ql_table}
            WHERE {ql_col} IS NOT NULL
            GROUP BY {left_expr}
        ),
        right_counts AS (
            SELECT {right_expr_inner} AS val, {r_cnt} AS rcnt
            FROM {qr_table}
            WHERE {qr_col} IS NOT NULL
            GROUP BY {right_expr_inner}
        ),
        merged AS (
            SELECT lc.val, lc.lcnt, COALESCE(rc.rcnt, 0) AS rcnt
            FROM left_counts lc
            LEFT JOIN right_counts rc ON lc.val = rc.val
        )
        SELECT
            width_bucket(val, {min_val}, {max_val + eps}, {bin_size}) AS bucket,
            CASE WHEN SUM(lcnt) = 0 THEN 0
                 ELSE SUM(lcnt::float8 * rcnt) / SUM(lcnt)
            END AS avg_fanout
        FROM merged
        GROUP BY bucket
        ORDER BY bucket
    """

    rows = query_all(conn, sql)
    fanout = [0.0] * bin_size
    for bucket, avg_fo in rows:
        if bucket is None:
            continue
        idx = bucket - 1
        if 0 <= idx < bin_size:
            fanout[idx] = float(avg_fo) if avg_fo else 0.0
        elif bucket == 0:
            fanout[0] += float(avg_fo) if avg_fo else 0.0
        elif bucket == bin_size + 1:
            fanout[bin_size - 1] += float(avg_fo) if avg_fo else 0.0

    return fanout


def _compute_fanout_direction_string(conn, left_table, left_col, right_table, right_col,
                                      bin_edges, bin_size=BIN_SIZE):
    """Compute per-bin fanout for string-type join columns.

    Encodes string values as integer indices (by frequency on the left side),
    then maps to histogram bins matching the string histogram encoding.
    """
    # Get left value counts, ordered by frequency (matches string histogram encoding)
    ql_col = qi(left_col)
    qr_col = qi(right_col)
    pvL, pvR = _pv(left_table, left_col), _pv(right_table, right_col)
    if pvL and pvR:
        # Per-value mode: the (val, cnt) rows of the temp objects, same ordering.
        left_rows = query_all(conn, f"""
            SELECT {qi(PV_VAL)}, {qi(PV_CNT)} AS cnt
            FROM {qi(pvL)} WHERE {qi(PV_VAL)} IS NOT NULL
            ORDER BY cnt DESC
        """)
    else:
        left_rows = query_all(conn, f"""
            SELECT {ql_col}, count(*) AS cnt
            FROM {qi(left_table)} WHERE {ql_col} IS NOT NULL
            GROUP BY {ql_col} ORDER BY cnt DESC
        """)
    if not left_rows:
        return [0.0] * bin_size

    # Get right value counts
    if pvL and pvR:
        right_rows = query_all(conn, f"""
            SELECT {qi(PV_VAL)}, {qi(PV_CNT)} AS cnt
            FROM {qi(pvR)} WHERE {qi(PV_VAL)} IS NOT NULL
        """)
    else:
        right_rows = query_all(conn, f"""
            SELECT {qr_col}, count(*) AS cnt
            FROM {qi(right_table)} WHERE {qr_col} IS NOT NULL
            GROUP BY {qr_col}
        """)
    right_counts = {val: cnt for val, cnt in right_rows}

    # Map values to integer indices (frequency order)
    n_distinct = len(left_rows)
    min_val = 0.0
    max_val = float(n_distinct - 1) if n_distinct > 1 else 1.0
    bin_width = (max_val - min_val) / bin_size if max_val > min_val else 1.0

    # Accumulate per-bin: sum(lcnt * rcnt) and sum(lcnt)
    bin_lc_sum = [0.0] * bin_size
    bin_lc_rc_sum = [0.0] * bin_size

    for idx, (val, lcnt) in enumerate(left_rows):
        rcnt = right_counts.get(val, 0)
        bucket = min(int((idx - min_val) / bin_width), bin_size - 1) if max_val > min_val else 0
        bin_lc_sum[bucket] += float(lcnt)
        bin_lc_rc_sum[bucket] += float(lcnt) * float(rcnt)

    fanout = [0.0] * bin_size
    for i in range(bin_size):
        if bin_lc_sum[i] > 0:
            fanout[i] = bin_lc_rc_sum[i] / bin_lc_sum[i]

    return fanout


# ---------------------------------------------------------------------------
# JSON-based discovery of joins and filter columns (for imdb, stats)
# ---------------------------------------------------------------------------
def discover_joins_and_filters_from_json(db_name, abbrev):
    """Discover join pairs and filter columns from deepdb_augmented JSON plans.

    For databases without SQL query files (imdb, stats), we scan the plan trees
    to find which columns are used in joins and filters.

    Returns:
        joins: set of ((table1, col1), (table2, col2)) tuples
        filter_cols: set of (table, col) tuples
    """
    reverse_abbrev = {v: k for k, v in abbrev.items()}
    db_dir = os.path.join(DEEPDB_BASE, db_name)
    if not os.path.isdir(db_dir):
        print(f"  ERROR: deepdb_augmented directory not found: {db_dir}")
        return set(), set()

    json_paths = []
    for f in sorted(os.listdir(db_dir)):
        # index_ workload files are included, as in the generator that produced
        # the shipped imdb statistics (s2 queries filter on columns no other file uses).
        if f.endswith(".json"):
            json_paths.append(os.path.join(db_dir, f))

    joins = set()
    filter_cols = set()

    for json_path in json_paths:
        print(f"    Scanning {os.path.basename(json_path)} ...")
        with open(json_path) as f:
            data = json.load(f)

        table_stats = data["database_stats"]["table_stats"]
        column_stats = data["database_stats"]["column_stats"]
        plans = data["parsed_plans"]

        # Discover joins from join_conds
        for plan in plans:
            for jc in plan.get("join_conds", []):
                parts = re.split(r"\s+AND\s+", jc)
                for part in parts:
                    m = re.match(
                        r'"([^"]+)"\.?"([^"]+)"\s*=\s*"([^"]+)"\.?"([^"]+)"',
                        part.strip()
                    )
                    if m:
                        t1, c1, t2, c2 = m.group(1), m.group(2), m.group(3), m.group(4)
                        t1_l, c1_l = t1.lower(), c1.lower()
                        t2_l, c2_l = t2.lower(), c2.lower()
                        if t1_l in abbrev and t2_l in abbrev and t1_l != t2_l:
                            pair = tuple(sorted([(t1_l, c1_l), (t2_l, c2_l)]))
                            joins.add(pair)

        # Discover filter columns from scan nodes
        def _scan_filters(node):
            pp = node.get("plan_parameters", {})
            table_idx = pp.get("table")
            if table_idx is not None and pp.get("filter_columns") is not None:
                _extract_filter_cols(pp["filter_columns"], column_stats)
            for child in node.get("children", []):
                _scan_filters(child)

        def _extract_filter_cols(fc, col_stats):
            if fc is None:
                return
            op = fc.get("operator")
            col_idx = fc.get("column")
            if op in ("AND", "OR") and fc.get("children"):
                for child in fc["children"]:
                    _extract_filter_cols(child, col_stats)
                return
            if col_idx is not None and col_idx < len(col_stats):
                cs = col_stats[col_idx]
                tname = cs["tablename"].lower()
                cname = cs["attname"].lower()
                if tname in abbrev:
                    filter_cols.add((tname, cname))

        for plan in plans:
            _scan_filters(plan)

    return joins, filter_cols


# ---------------------------------------------------------------------------
# Build col_type dict for abbrev_col_type.pkl
# ---------------------------------------------------------------------------
def build_col_type_dict(abbrev, col_types):
    """Build col_type: {alias: {'ctn': [col_names], 'dsct': [col_names]}}"""
    col_type_dict = {}
    for alias in abbrev.values():
        col_type_dict[alias] = {"ctn": [], "dsct": []}

    for (table, col), cls in col_types.items():
        alias = abbrev.get(table)
        if alias is None:
            continue
        col_type_dict[alias][cls].append(col)

    return col_type_dict


# ---------------------------------------------------------------------------
# Resolve column name case
# ---------------------------------------------------------------------------
def resolve_column_case(joins, filter_cols, table_col_dtypes):
    """Map lowercased (table, col) names from JSON discovery to actual PG names.

    JSON discovery lowercases all names, but PostgreSQL may have mixed-case
    column names (e.g., 'yearMax', 'tmID'). This function resolves lowercased
    names to their actual case using the information_schema metadata.
    """
    # Build lowercase -> actual name mapping per table
    # Also build lowercase table name -> actual table name
    table_case_map = {}  # lowercase -> actual
    col_case_map = {}  # (table_lower, col_lower) -> (actual_table, actual_col)
    for table, cols in table_col_dtypes.items():
        table_case_map[table.lower()] = table
        for col in cols:
            col_case_map[(table.lower(), col.lower())] = (table, col)

    def _resolve(table, col):
        key = (table.lower(), col.lower())
        if key in col_case_map:
            return col_case_map[key]
        # Try resolving just the table
        actual_table = table_case_map.get(table.lower(), table)
        return (actual_table, col)

    # Resolve joins
    new_joins = set()
    for (t1, c1), (t2, c2) in joins:
        r1 = _resolve(t1, c1)
        r2 = _resolve(t2, c2)
        new_joins.add(tuple(sorted([r1, r2])))

    # Resolve filter cols
    new_filters = set()
    for t, c in filter_cols:
        new_filters.add(_resolve(t, c))

    return new_joins, new_filters


# ---------------------------------------------------------------------------
# Main generation
# ---------------------------------------------------------------------------
def generate_stats_for_db(db_name, price_n_filter=False, price_n_fanout=False,
                          price_n_pairwise=False, per_value=False):
    """Generate all 5 PRICE statistics files for the given database.

    per_value (or SICE_STATS_PER_VALUE=1): collect every per-column statistic
    from ONE value-level aggregation per column (see materialize_per_value);
    the produced files are identical to the default mode."""
    per_value = bool(per_value) or PER_VALUE_ENV
    print(f"\n{'='*60}")
    print(f"Generating PRICE statistics for: {db_name}"
          f"{'  [per_value mode]' if per_value else ''}")
    print(f"{'='*60}")

    if db_name not in DB_CONFIG:
        raise ValueError(f"Unknown database: {db_name}. Valid: {list(DB_CONFIG.keys())}")

    pg_db, abbrev, output_name = DB_CONFIG[db_name]
    _drop = {t.strip() for t in os.environ.get("SICE_STATS_DROP_TABLES", "").split(",") if t.strip()}
    if _drop:
        abbrev = {t: a for t, a in abbrev.items() if t not in _drop}
        print(f"    SICE_STATS_DROP_TABLES: excluding {sorted(_drop)} -> {len(abbrev)} tables")
    # imdb_upd* (database-update stages) reuse imdb's deepdb plans for column
    # discovery: IMDB column names are not unique across tables, so the generic
    # regex path mis-maps them and drops most filter columns.
    _json_src = "imdb" if db_name.startswith("imdb_upd") else db_name
    use_json_discovery = _json_src in JSON_DISCOVERY_DBS
    # stats_upd* (database-update stages) use the alias-aware SQL discovery of stats.
    use_alias_aware = db_name in ALIAS_AWARE_DBS or db_name.startswith("stats_upd")

    print(f"\n[1] Connecting to PostgreSQL database '{pg_db}' ...")
    conn = get_connection(pg_db)

    print(f"\n[2] Building column metadata ...")
    table_col_dtypes = build_table_columns(conn)
    if use_json_discovery:
        print(f"    Using JSON-based discovery for joins/filters (no SQL files)")
    elif use_alias_aware:
        print(f"    Using alias-aware SQL parsing (ambiguous column names)")
    else:
        col_to_table = build_col_to_table(conn)
        print(f"    {len(col_to_table)} columns across {len(table_col_dtypes)} tables")

    if use_json_discovery:
        print(f"\n[3] Discovering joins/filters from deepdb_augmented/{_json_src}/ ...")
        joins, filter_cols = discover_joins_and_filters_from_json(_json_src, abbrev)
        # Resolve lowercased names from JSON to actual PostgreSQL column names
        joins, filter_cols = resolve_column_case(joins, filter_cols, table_col_dtypes)
        # Also resolve the abbrev dict keys to match actual PG table names
        table_case_map = {t.lower(): t for t in table_col_dtypes}
        resolved_abbrev = {}
        for t, alias in abbrev.items():
            actual_t = table_case_map.get(t.lower(), t)
            resolved_abbrev[actual_t] = alias
        abbrev = resolved_abbrev
    elif use_alias_aware:
        print(f"\n[3] Parsing queries (alias-aware) from {QUERIES_DIR}/{db_name}/ ...")
        queries = extract_queries_from_files(db_name)
        print(f"    Found {len(queries)} unique queries")
        joins, filter_cols = parse_joins_and_filters_with_aliases(queries)
    else:
        print(f"\n[3] Parsing queries from {QUERIES_DIR}/{db_name}/ ...")
        queries = extract_queries_from_files(db_name)
        print(f"    Found {len(queries)} unique queries")
        joins, filter_cols = parse_joins_and_filters(queries, col_to_table)
        # [REVERTED] sqlglot AST augmentation is disabled for this bisection
        # so we re-derive the column set the regex-only discovery produced.

    print(f"    Found {len(joins)} unique join pairs")
    print(f"    Found {len(filter_cols)} unique filter columns")

    # Optional: also track every histogram column of a reference statistics set
    # (e.g. the shipped imdb set, whose JOB-full string predicates are not
    # discoverable from the deepdb plans). Columns absent from this database or
    # from dropped tables are filtered out below like any other column.
    _ref_dir = os.environ.get("SICE_STATS_REF_DIR")
    if _ref_dir:
        with open(os.path.join(_ref_dir, "histogram40.pkl"), "rb") as _f:
            _ref_hist = pickle.load(_f)
        _alias_to_table = {a: t for t, a in abbrev.items()}
        _ref_cols = {(_alias_to_table[a], c) for a, cols in _ref_hist.items()
                     if a in _alias_to_table for c in cols}
        _n_before = len(filter_cols)
        filter_cols = set(filter_cols) | _ref_cols
        print(f"    SICE_STATS_REF_DIR: +{len(filter_cols) - _n_before} columns from {_ref_dir}")

    for (t1, c1), (t2, c2) in sorted(joins):
        print(f"      JOIN: {t1}.{c1} = {t2}.{c2}")

    # Comparisons between two columns: same-row filters on x - y (statistics:
    # the per-value distribution of x - y) and joins other than plain cross-table
    # equi-joins (statistics: operator-conditioned fanouts).
    same_row, joins_op = set(), set()
    if (price_n_pairwise or price_n_fanout) and QUERIES_DIR \
            and os.path.isdir(os.path.join(QUERIES_DIR, db_name)):
        same_row, joins_op = discover_column_comparisons(
            extract_queries_from_files(db_name), table_col_dtypes)
        same_row = {p for p in same_row if p[0] in abbrev} if price_n_pairwise else set()
        joins_op = ({j for j in joins_op if j[0][0] in abbrev and j[2][0] in abbrev}
                    if price_n_fanout else set())
        for t, cx, cy in sorted(same_row):
            print(f"      SAME-ROW: {t}.{cx} - {t}.{cy}")
        for (t1, c1), op, (t2, c2), v in sorted(joins_op, key=str):
            print(f"      JOIN: {t1}.{c1} {op} {t2}.{c2} + {v:g}")

    # Collect all columns needing stats
    all_cols = set()
    for (t1, c1), (t2, c2) in joins:
        all_cols.add((t1, c1))
        all_cols.add((t2, c2))
    for (t1, c1), _op, (t2, c2), _v in joins_op:
        all_cols.add((t1, c1))
        all_cols.add((t2, c2))
    for tc in filter_cols:
        all_cols.add(tc)
    # Filter to only columns that exist in PG and have an alias mapping
    valid_cols = set()
    for t, c in all_cols:
        if t not in abbrev:
            continue
        if t not in table_col_dtypes or c not in table_col_dtypes[t]:
            print(f"    WARNING: column {t}.{c} not found in PG, skipping")
            continue
        valid_cols.add((t, c))
    all_cols = valid_cols
    # Also filter joins/filter_cols to only valid columns
    joins = {((t1, c1), (t2, c2)) for (t1, c1), (t2, c2) in joins
             if (t1, c1) in all_cols and (t2, c2) in all_cols}
    filter_cols = {(t, c) for t, c in filter_cols if (t, c) in all_cols}
    print(f"    Total columns to track: {len(all_cols)}")

    if per_value:
        # Every column any statistic needs (histogram/summary/null-fraction
        # columns and both sides of every join pair) == all_cols.
        print(f"\n[3b] Per-value mode: one value-level aggregation per column ...")
        materialize_per_value(conn, all_cols)

    diff_types = {}
    if same_row:
        if not per_value:
            PV_REGISTRY.clear()
            _PV_ROWS.clear()
        print(f"\n[3c] Per-value distributions of x - y for same-row comparisons ...")
        diff_types = materialize_diff_distributions(conn, same_row, table_col_dtypes)

    print(f"\n[4] Classifying columns ...")
    col_types = classify_columns(conn, all_cols, table_col_dtypes)
    col_types.update(diff_types)
    all_cols |= set(diff_types)
    ctn_count = sum(1 for v in col_types.values() if v == "ctn")
    dsct_count = sum(1 for v in col_types.values() if v == "dsct")
    print(f"    Continuous: {ctn_count}, Discrete: {dsct_count}")
    for (table, col), cls in sorted(col_types.items()):
        print(f"      {abbrev[table]}.{col}: {cls}")

    print(f"\n[5] Generating statistics ...")
    size_data = generate_size(conn, abbrev)

    print()
    histogram_data = generate_histograms(conn, abbrev, col_types, table_col_dtypes)

    print()
    summary_data = generate_summaries(conn, abbrev, col_types)

    null_fraction_data = {}
    if price_n_filter:
        print()
        print(f"    Computing null_fraction (rule b) ...")
        null_fraction_data = generate_null_fractions(conn, abbrev, all_cols)

    print()
    fanout_data = generate_fanouts(
        conn, abbrev, joins, col_types, histogram_data, table_col_dtypes
    )

    orphan_fraction_data = {}
    if price_n_fanout:
        print()
        print(f"    Computing orphan_fraction (rule g) ...")
        orphan_fraction_data = generate_orphan_fractions(conn, abbrev, joins)
        # Embed orphan info inside fanout_data so existing loaders see it on read.
        fanout_data["__orphan__"] = orphan_fraction_data

    nonequi_fanout_data = {}
    if joins_op:
        print()
        nonequi_fanout_data = generate_nonequi_fanouts(
            conn, abbrev, joins_op, histogram_data, table_col_dtypes)

    if per_value or diff_types:
        # Last stage that uses the value-level objects.
        drop_per_value(conn)

    col_type_dict = build_col_type_dict(abbrev, col_types)

    # Save all files
    output_dir = os.path.join(PRICE_STATS_BASE, output_name)
    os.makedirs(output_dir, exist_ok=True)

    print(f"\n[6] Saving files to {output_dir}/ ...")
    files = {
        "abbrev_col_type.pkl": {"abbrev": abbrev, "col_type": col_type_dict},
        "size.pkl": size_data,
        "histogram40.pkl": histogram_data,
        "summary40.pkl": summary_data,
        "fanout40.pkl": fanout_data,
    }
    if price_n_filter:
        files["null_fraction.pkl"] = null_fraction_data
    if price_n_fanout:
        files["nonequi_fanout_op40.pkl"] = nonequi_fanout_data
    for fname, data in files.items():
        fpath = os.path.join(output_dir, fname)
        with open(fpath, "wb") as f:
            pickle.dump(data, f)
        print(f"    Saved {fname}")

    conn.close()

    print(f"\n{'='*60}")
    print(f"DONE: {db_name}")
    print(f"  Tables: {len(abbrev)}")
    n_fanout_entries = sum(1 for k in fanout_data if isinstance(k, tuple))
    print(f"  Join pairs: {len(joins)} ({n_fanout_entries} fanout entries)")
    n_hist = sum(len(v) for v in histogram_data.values())
    n_summ = sum(len(v) for v in summary_data.values())
    print(f"  Histogram columns: {n_hist}")
    print(f"  Summary columns: {n_summ}")
    print(f"{'='*60}\n")


def main():
    parser = argparse.ArgumentParser(
        description="Generate PRICE statistics from PostgreSQL"
    )
    valid_dbs = sorted(DB_CONFIG.keys())
    parser.add_argument(
        "--db", type=str, required=True,
        help=f"Database to generate stats for, or 'all'. Valid: {valid_dbs}",
    )
    parser.add_argument("--price_n_parsing", action="store_true", default=False,
                        help="(No new stats — kept for symmetry with the train.py flag.)")
    parser.add_argument("--price_n_filter", action="store_true", default=False,
                        help="Compute null_fraction.pkl (rule b).")
    parser.add_argument("--price_n_fanout", action="store_true", default=False,
                        help="Extend fanout40.pkl with orphan_fraction (rule g) and compute "
                             "nonequi_fanout_op40.pkl, the operator-conditioned fanouts of every "
                             "join other than a plain cross-table equi-join.")
    parser.add_argument("--price_n_pairwise", action="store_true", default=False,
                        help="Compute the per-value distribution of x - y for every same-row "
                             "comparison x op y + v, stored as an ordinary column.")
    parser.add_argument("--price_n", action="store_true", default=False,
                        help="Shorthand: enable all four PRICE_N flags above.")
    parser.add_argument("--queries_dir", type=str, required=True,
                        help="Directory of per-query .sql files, one subdirectory per database "
                             "(e.g. <dir>/tpch/1.sql ...). Only needed to REGENERATE statistics "
                             "from a live PostgreSQL instance; the repository already ships "
                             "pre-generated statistics for all four workloads under canon/statistics/.")
    parser.add_argument("--per_value", action="store_true", default=PER_VALUE_ENV,
                        help="Collect every per-column statistic from ONE value-level "
                             "aggregation per column (TEMP tables); same output files. "
                             "Also enabled by SICE_STATS_PER_VALUE=1.")
    parser.add_argument("--dry_run", action="store_true", default=False,
                        help="Parse args and exit without connecting to PostgreSQL.")
    args = parser.parse_args()
    global QUERIES_DIR
    QUERIES_DIR = args.queries_dir

    # Expand the shorthand.
    if args.price_n:
        args.price_n_parsing = True
        args.price_n_filter = True
        args.price_n_fanout = True
        args.price_n_pairwise = True

    if args.dry_run:
        print(f"[dry_run] db={args.db} flags="
              f"filter={args.price_n_filter} fanout={args.price_n_fanout} "
              f"pairwise={args.price_n_pairwise} parsing={args.price_n_parsing} "
              f"per_value={args.per_value}")
        return

    flags = dict(
        price_n_filter=args.price_n_filter,
        price_n_fanout=args.price_n_fanout,
        price_n_pairwise=args.price_n_pairwise,
        per_value=args.per_value,
    )

    if args.db == "all":
        for db in sorted(DB_CONFIG.keys()):
            try:
                generate_stats_for_db(db, **flags)
            except Exception as e:
                print(f"ERROR generating stats for {db}: {e}")
                import traceback
                traceback.print_exc()
    else:
        if args.db not in DB_CONFIG:
            print(f"Unknown database: {args.db}. Valid: {valid_dbs}")
            sys.exit(1)
        generate_stats_for_db(args.db, **flags)


if __name__ == "__main__":
    main()
