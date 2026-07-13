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
from collections import defaultdict

import json
import numpy as np
import psycopg2

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))  # experiments/ for sice_lib

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
BIN_SIZE = 40

# Same-table column pairs that get a 2D 8x8 joint histogram for col-op-col
# predicates (rule j). Source: tpch_tpcds_predicate_audit.md.
PAIRWISE_INTRA_WHITELIST = [
    ("lineitem", "l_shipdate", "l_commitdate"),
    ("lineitem", "l_commitdate", "l_receiptdate"),
    ("lineitem", "l_shipdate", "l_receiptdate"),
    ("date_dim", "d_date", "d_date"),
    ("customer_demographics", "cd_marital_status", "cd_marital_status"),
    ("customer_address", "ca_city", "ca_city"),
]

# Cross-table 2D histogram (rule h). Single hardcoded entry from TPC-DS q72.
PAIRWISE_XTAB_WHITELIST = [
    ("inventory", "inv_quantity_on_hand", "catalog_sales", "cs_quantity"),
]

PRICE_STATS_BASE = str(Path(__file__).resolve().parents[1] / "canon" / "statistics")
QUERIES_DIR = None  # set from --queries_dir in main()
DEEPDB_BASE = str(Path(__file__).resolve().parents[1] / "deepdb_augmented")  # optional, not shipped

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

# Database name mapping: --db arg -> (pg_db_name, abbrev_dict, stats_output_name)
DB_CONFIG = {
    "tpch": ("tpch", TPCH_ABBREV, "tpch"),
    "tpcds": ("tpcds", TPCDS_ABBREV, "tpcds"),
    "imdb": ("imdb", IMDB_ABBREV, "imdb"),
    "stats": ("stats", STATS_ABBREV, "stats"),
}

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
ALIAS_AWARE_DBS = {"stats"}


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
    row = query_one(conn, f"""
        SELECT min({expr}), max({expr}), count(*)
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
                   count(*) AS cnt
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
    rows = query_all(conn, f"""
        SELECT {qcol}, count(*) AS cnt
        FROM {qtable}
        WHERE {qcol} IS NOT NULL
        GROUP BY {qcol}
        ORDER BY cnt DESC
    """)
    if not rows:
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
# Generate pairwise_intra40.pkl (rule j) — 2D joint histograms
# ---------------------------------------------------------------------------
def _compress_40_to_8(h40):
    """Aggregate a 40x40 histogram down to 8x8 by summing 5x5 blocks."""
    h40 = np.asarray(h40, dtype=np.float64)
    h8 = np.zeros((8, 8), dtype=np.float64)
    for i in range(8):
        for j in range(8):
            h8[i, j] = h40[i * 5:(i + 1) * 5, j * 5:(j + 1) * 5].sum()
    return h8


def _order_8x8_anti_diagonal(h8):
    """Flatten an 8x8 grid into a 64-vector ordered by anti-diagonal level
    d = j - i, sweeping from d = +7 (most x<y) through d = 0 (diagonal)
    to d = -7 (most x>y). Within each anti-diagonal, cells ordered by
    increasing i.

    Resulting layout (0-indexed):
      bins 0-27 : x<y region (28 cells)
      bins 28-35: diagonal x=y (8 cells)
      bins 36-63: x>y region (28 cells)

    Operators map to consecutive bin ranges (see _OP_RANGES in
    canon/features_tool.py).
    """
    h8 = np.asarray(h8)
    out = []
    for d in range(7, -8, -1):
        for i in range(8):
            j = i + d
            if 0 <= j < 8:
                out.append(h8[i, j])
    out = np.array(out, dtype=np.float32)
    assert out.shape == (64,)
    return out


def _pairwise_intra_discrete_self(conn, table, col, top_k=40):
    """Build an 8×8 ordered joint histogram for a self-pair on a discrete
    column via the SpaceSaving outer-product trick.

    Drops the OtHeRs bucket from the marginal: only the top-39 most frequent
    values contribute. The resulting 8×8 histogram represents the joint
    distribution conditional on both rows having one of the top-39 values.
    For low-cardinality columns (≤39 distinct), this is exact. For
    high-cardinality columns, the conditional s_eq is a tight estimate of
    P(equal | both top-39); the rest of the predicate's selectivity contribution
    (rows in OtHeRs) is small and can be inferred by the model from the
    column's 1D filter-token marginal.
    """
    cur = conn.cursor()
    cur.execute(f"""
        SELECT "{col}", COUNT(*)
        FROM "{table}" WHERE "{col}" IS NOT NULL
        GROUP BY 1 ORDER BY 2 DESC LIMIT {top_k}
    """)
    rows = cur.fetchall()
    cur.execute(f'SELECT COUNT(*) FROM "{table}" WHERE "{col}" IS NOT NULL')
    (total,) = cur.fetchone()
    cur.close()

    if not rows or total == 0:
        # Empty column — return uniform-zero token-shaped record.
        return {
            "H8x8_ordered": np.zeros(64, dtype=np.float32),
            "s_lt": 0.0, "s_eq": 0.0, "s_gt": 0.0,
        }

    # Build a 40-element marginal of top-39 frequencies. Slot 39 stays zero
    # (OtHeRs is intentionally dropped — see commit message). Effect: outer
    # product produces a 39x39 non-zero submatrix; after total-mass
    # normalization, s_eq is the conditional P(equal | both rows in top-39),
    # which is tight even for high-cardinality columns where the OtHeRs
    # bucket would otherwise dominate the diagonal.
    p = np.zeros(40, dtype=np.float64)
    for i, (_, cnt) in enumerate(rows[:39]):
        p[i] = cnt / float(total)
    # p[39] = 0 (deliberate: no OtHeRs lumping)

    # Analytical s_eq = Sigma p_i² (collision probability under independence).
    # This is exact and avoids any binning/compression artifact.
    p_vals = list(p)
    s_eq = float(sum(v ** 2 for v in p_vals))
    # For a discrete self-pair, the non-equality mass is symmetric (no natural
    # ordering between two independent aliases of the same text column).
    s_lt = (1.0 - s_eq) / 2.0
    s_gt = s_lt

    # Construct H8x8_ordered to match (s_lt, s_eq, s_gt) exactly.
    # Diagonal (8 cells): s_eq * total / 8 each.
    # Upper-triangle (28 cells): s_lt * total / 28 each.
    # Lower-triangle (28 cells): s_gt * total / 28 each.
    ordered = np.empty(64, dtype=np.float32)
    ordered[:28] = s_lt * float(total) / 28.0   # region 1: upper triangle (x<y)
    ordered[28:36] = s_eq * float(total) / 8.0  # region 2: diagonal (x≈y)
    ordered[36:64] = s_gt * float(total) / 28.0  # region 3: lower triangle (x>y)

    return {
        "H8x8_ordered": ordered,
        "s_lt": s_lt,
        "s_eq": s_eq,
        "s_gt": s_gt,
    }


def generate_pairwise_intra(conn, pairs, col_types=None):
    """Compute the 8x8 ordered joint histogram + (s_lt, s_eq, s_gt) per pair.

    For self-pairs on discrete columns, uses the SpaceSaving outer-product
    trick (no width_bucket needed). For numeric pairs (or cross-column
    pairs), uses width_bucket on the column expression.

    Args:
        conn: psycopg2 connection.
        pairs: iterable of (table, col_x, col_y).
        col_types: optional dict[(table, col)] -> 'ctn' | 'dsct'. When the
            self-pair's column is 'dsct', uses the discrete code path.

    Returns dict[(table, col_x, col_y)] -> {
        'H8x8_ordered': np.ndarray (64,) float32,
        's_lt': float, 's_eq': float, 's_gt': float,
    }.
    """
    # Fetch column dtypes once so we can cast dates to epoch via _col_expr.
    table_col_dtypes = build_table_columns(conn)
    out = {}
    cur = conn.cursor()
    for table, col_x, col_y in pairs:
        try:
            is_self = (col_x == col_y)
            is_discrete = bool(col_types) and col_types.get((table, col_x)) == "dsct"
            if is_self and is_discrete:
                out[(table, col_x, col_y)] = _pairwise_intra_discrete_self(
                    conn, table, col_x)
                continue
            dtype_x = table_col_dtypes.get(table, {}).get(col_x, "")
            dtype_y = table_col_dtypes.get(table, {}).get(col_y, "")
            expr_x = _col_expr(table, col_x, dtype_x)
            expr_y = _col_expr(table, col_y, dtype_y)
            cur.execute(
                f'SELECT MIN({expr_x}), MAX({expr_x}), '
                f'       MIN({expr_y}), MAX({expr_y}) FROM "{table}"'
            )
            xmin, xmax, ymin, ymax = cur.fetchone()
            if xmin is None or ymin is None or xmin == xmax or ymin == ymax:
                continue
            xmin, xmax = float(xmin), float(xmax)
            ymin, ymax = float(ymin), float(ymax)
            cur.execute(f"""
                SELECT
                  width_bucket({expr_x}, %s, %s, 40) AS bx,
                  width_bucket({expr_y}, %s, %s, 40) AS by,
                  COUNT(*) AS cnt
                FROM "{table}"
                WHERE "{col_x}" IS NOT NULL AND "{col_y}" IS NOT NULL
                GROUP BY 1, 2
            """, (xmin, xmax, ymin, ymax))
            h40 = np.zeros((40, 40), dtype=np.float64)
            for bx, by, cnt in cur.fetchall():
                if bx is None or by is None:
                    continue
                bx_i = max(1, min(40, int(bx))) - 1
                by_i = max(1, min(40, int(by))) - 1
                h40[bx_i, by_i] += cnt
            h8 = _compress_40_to_8(h40)
            ordered = _order_8x8_anti_diagonal(h8)
            total = ordered.sum() or 1.0
            s_lt = float(ordered[:28].sum() / total)
            s_eq = float(ordered[28:36].sum() / total)
            s_gt = float(ordered[36:64].sum() / total)
            out[(table, col_x, col_y)] = {
                "H8x8_ordered": ordered,
                "s_lt": s_lt, "s_eq": s_eq, "s_gt": s_gt,
            }
        except Exception as e:
            print(f"    WARN pairwise_intra({table}.{col_x}, {col_y}): {e}")
            conn.rollback()
    cur.close()
    return out


# ---------------------------------------------------------------------------
# Generate nonequi_pair_xtab.pkl (rule h) — cross-table 2D joint histograms
# ---------------------------------------------------------------------------
def generate_pairwise_xtab(conn, pairs, sample_n=1_000_000):
    """Compute cross-table 8x8 ordered joint histogram via independent uniform sampling.

    The two columns come from different tables with no join key relating them
    (e.g. TPC-DS q72: inv_quantity_on_hand < cs_quantity). The "joint" here is
    computed under the independence assumption — equivalent to the outer product
    of the two marginal sample histograms. This is what we want for predicates
    that mix unrelated columns from unrelated tables.

    Args:
        conn: psycopg2 connection.
        pairs: iterable of (L_table, L_col, R_table, R_col).
        sample_n: rows drawn from each side independently (default 1M).

    Returns dict[(L_table, L_col, R_table, R_col)] -> same schema as
    generate_pairwise_intra.
    """
    out = {}
    cur = conn.cursor()
    for tL, cL, tR, cR in pairs:
        try:
            cur.execute(
                f'SELECT MIN("{cL}"), MAX("{cL}") FROM "{tL}"'
            )
            x_lo, x_hi = cur.fetchone()
            cur.execute(
                f'SELECT MIN("{cR}"), MAX("{cR}") FROM "{tR}"'
            )
            y_lo, y_hi = cur.fetchone()
            if x_lo is None or y_lo is None or x_lo == x_hi or y_lo == y_hi:
                continue

            # Cast to float to avoid Decimal slow path (mirrors generate_pairwise_intra).
            x_lo, x_hi = float(x_lo), float(x_hi)
            y_lo, y_hi = float(y_lo), float(y_hi)

            # --- Left marginal: 1D bucketed counts from an independent sample ---
            cur.execute(f"""
                WITH s AS (
                    SELECT "{cL}" AS x FROM "{tL}"
                    WHERE "{cL}" IS NOT NULL ORDER BY random() LIMIT %s
                )
                SELECT width_bucket(x, %s, %s, 40) AS bx, COUNT(*) AS cnt
                FROM s GROUP BY 1
            """, (sample_n, x_lo, x_hi))
            h_x = np.zeros(40, dtype=np.float64)
            for bx, cnt in cur.fetchall():
                if bx is None:
                    continue
                bx_i = max(1, min(40, int(bx))) - 1
                h_x[bx_i] += cnt

            # --- Right marginal: 1D bucketed counts from an independent sample ---
            cur.execute(f"""
                WITH s AS (
                    SELECT "{cR}" AS y FROM "{tR}"
                    WHERE "{cR}" IS NOT NULL ORDER BY random() LIMIT %s
                )
                SELECT width_bucket(y, %s, %s, 40) AS bx, COUNT(*) AS cnt
                FROM s GROUP BY 1
            """, (sample_n, y_lo, y_hi))
            h_y = np.zeros(40, dtype=np.float64)
            for by, cnt in cur.fetchall():
                if by is None:
                    continue
                by_i = max(1, min(40, int(by))) - 1
                h_y[by_i] += cnt

            # --- Outer product under the independence assumption ---
            h40 = np.outer(h_x, h_y)

            h8 = _compress_40_to_8(h40)
            ordered = _order_8x8_anti_diagonal(h8)
            total = ordered.sum() or 1.0
            out[(tL, cL, tR, cR)] = {
                "H8x8_ordered": ordered,
                "s_lt": float(ordered[:28].sum() / total),
                "s_eq": float(ordered[28:36].sum() / total),
                "s_gt": float(ordered[36:64].sum() / total),
            }
        except Exception as e:
            print(f"    WARN pairwise_xtab({tL}.{cL} × {tR}.{cR}): {e}")
            conn.rollback()
    cur.close()
    return out


# ---------------------------------------------------------------------------
# Generate orphan_fraction (rule g) — nested inside fanout40.pkl
# ---------------------------------------------------------------------------
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
            cur.execute(f"""
                WITH lc AS (
                    SELECT "{cL}" AS k, COUNT(*) AS lcnt
                    FROM "{tL}" WHERE "{cL}" IS NOT NULL GROUP BY 1
                ),
                rc AS (
                    SELECT "{cR}" AS k, COUNT(*) AS rcnt
                    FROM "{tR}" WHERE "{cR}" IS NOT NULL GROUP BY 1
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

    min_val = float(bin_edges[0])
    max_val = float(bin_edges[-1])

    if min_val == max_val:
        left_count = query_one(conn, f"""
            SELECT count(*) FROM {ql_table} WHERE {ql_col} IS NOT NULL
        """)[0]
        right_count = query_one(conn, f"""
            SELECT count(*) FROM {qr_table}
            WHERE {qr_col} IS NOT NULL AND {right_expr_inner} = {min_val}
        """)[0]
        fanout = [0.0] * bin_size
        if left_count > 0:
            fanout[0] = float(right_count)
        return fanout

    eps = (max_val - min_val) * 1e-10 + 1e-10

    sql = f"""
        WITH left_counts AS (
            SELECT {left_expr} AS val, count(*) AS lcnt
            FROM {ql_table}
            WHERE {ql_col} IS NOT NULL
            GROUP BY {left_expr}
        ),
        right_counts AS (
            SELECT {right_expr_inner} AS val, count(*) AS rcnt
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
    left_rows = query_all(conn, f"""
        SELECT {ql_col}, count(*) AS cnt
        FROM {qi(left_table)} WHERE {ql_col} IS NOT NULL
        GROUP BY {ql_col} ORDER BY cnt DESC
    """)
    if not left_rows:
        return [0.0] * bin_size

    # Get right value counts
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
        if f.endswith(".json") and not f.startswith("index_"):
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
                          price_n_pairwise=False):
    """Generate all 5 PRICE statistics files for the given database."""
    print(f"\n{'='*60}")
    print(f"Generating PRICE statistics for: {db_name}")
    print(f"{'='*60}")

    if db_name not in DB_CONFIG:
        raise ValueError(f"Unknown database: {db_name}. Valid: {list(DB_CONFIG.keys())}")

    pg_db, abbrev, output_name = DB_CONFIG[db_name]
    use_json_discovery = db_name in JSON_DISCOVERY_DBS
    use_alias_aware = db_name in ALIAS_AWARE_DBS

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
        print(f"\n[3] Discovering joins/filters from deepdb_augmented/{db_name}/ ...")
        joins, filter_cols = discover_joins_and_filters_from_json(db_name, abbrev)
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

    for (t1, c1), (t2, c2) in sorted(joins):
        print(f"      JOIN: {t1}.{c1} = {t2}.{c2}")

    # Collect all columns needing stats
    all_cols = set()
    for (t1, c1), (t2, c2) in joins:
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

    print(f"\n[4] Classifying columns ...")
    col_types = classify_columns(conn, all_cols, table_col_dtypes)
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

    pairwise_intra_data = {}
    if price_n_pairwise:
        print()
        print(f"    Computing pairwise_intra (rule j) for "
              f"{len(PAIRWISE_INTRA_WHITELIST)} pairs ...")
        # Filter whitelist to pairs whose table exists in this db.
        relevant = [p for p in PAIRWISE_INTRA_WHITELIST if p[0] in abbrev]
        # col_types may not yet include whitelist columns that weren't found in
        # discovered queries (e.g. text columns never appear in join/filter
        # discovery). Classify any missing ones here so we can dispatch
        # discrete self-pairs to the outer-product path.
        pairwise_cols = set()
        for t, cx, cy in relevant:
            pairwise_cols.add((t, cx))
            pairwise_cols.add((t, cy))
        new_cols = pairwise_cols - set(col_types.keys())
        if new_cols:
            extra_types = classify_columns(conn, new_cols, table_col_dtypes)
            col_types_full = {**col_types, **extra_types}
        else:
            col_types_full = col_types
        pairwise_intra_data = generate_pairwise_intra(conn, relevant,
                                                      col_types=col_types_full)

    pairwise_xtab_data = {}
    if price_n_pairwise:
        print()
        print(f"    Computing nonequi_pair_xtab (rule h) for "
              f"{len(PAIRWISE_XTAB_WHITELIST)} pairs ...")
        relevant_xtab = [p for p in PAIRWISE_XTAB_WHITELIST
                         if p[0] in abbrev and p[2] in abbrev]
        pairwise_xtab_data = generate_pairwise_xtab(conn, relevant_xtab)

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
    if price_n_pairwise:
        files["pairwise_intra40.pkl"] = pairwise_intra_data
        files["nonequi_pair_xtab.pkl"] = pairwise_xtab_data
        # Empty stub for now (per spec §5.5). Future cross-table non-equi
        # entries beyond the §5.4 whitelist plug in here.
        files["nonequi_fanout_op40.pkl"] = {}
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
                        help="Extend fanout40.pkl with orphan_fraction (rule g).")
    parser.add_argument("--price_n_pairwise", action="store_true", default=False,
                        help="Compute pairwise_intra40.pkl, nonequi_pair_xtab.pkl, "
                             "nonequi_fanout_op40.pkl (rules d/h/j).")
    parser.add_argument("--price_n", action="store_true", default=False,
                        help="Shorthand: enable all four PRICE_N flags above.")
    parser.add_argument("--queries_dir", type=str, required=True,
                        help="Directory of per-query .sql files, one subdirectory per database "
                             "(e.g. <dir>/tpch/1.sql ...). Only needed to REGENERATE statistics "
                             "from a live PostgreSQL instance; the repository already ships "
                             "pre-generated statistics for all four workloads under canon/statistics/.")
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
              f"pairwise={args.price_n_pairwise} parsing={args.price_n_parsing}")
        return

    flags = dict(
        price_n_filter=args.price_n_filter,
        price_n_fanout=args.price_n_fanout,
        price_n_pairwise=args.price_n_pairwise,
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
