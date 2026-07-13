# PRICE: TPC-H and TPC-DS SQL Syntax Handling

This document catalogs every SQL construct encountered in TPC-H (22 templates)
and TPC-DS (99 templates), how the PRICE pipeline transforms them, and what
information is lost or approximated in the process.

**Pipeline entry point:** `sice_lib.generate_price_features()`
**Core transformer:** `sice_lib.transform_sql_for_price()`

---

## 1. PRICE Native SQL Support

PRICE (`Sql2Feature.parse_sql()` in `canon/price/setup/features_tool.py`) was
designed for IMDB JOB queries and natively supports only:

| Construct | Example |
|-----------|---------|
| Comma-separated FROM | `FROM t1 alias1, t2 alias2` |
| Equi-join in WHERE | `alias1.col = alias2.col` |
| Simple filter | `alias.col op literal` (op: `=`, `!=`, `<`, `<=`, `>`, `>=`) |
| Tree topology | Exactly `N-1` joins for `N` tables |
| `SELECT COUNT(*)` | Required header |

Everything else — CTEs, subqueries, OR, LIKE, IN, BETWEEN, HAVING, self-joins,
date literals, functions — must be rewritten before PRICE can process it.

---

## 2. Transformation Pipeline Overview

Each query passes through these stages in order:

```
transform_sql_for_price(sql, db_name)
 1. _convert_timestamps_to_epoch(sql)        → date/interval → epoch int
 2. flatten_sql_for_price(sql, db_name)       → CTEs/VIEWs/subquery-in-FROM → flat SQL
    [fallback: _ast_collect_predicates()]     → walk entire AST
    [fallback: _regex_collect_predicates()]   → raw regex scan
 3. _preprocess_predicates(sql, db_name)      → inline EXISTS/IN subqueries,
                                                 estimate scalar subqueries,
                                                 decompose BETWEEN, simplify IN/LIKE
 4. Alias replacement                         → original aliases → PRICE aliases
 5. Bare column prefixing                     → c_custkey → tpch_c.c_custkey
 6. _lower_except_quotes(sql)
 7. _collapse_self_joins(sql)                 → tpcds_dd2 → tpcds_dd (if tautological)
 8. _add_missing_from_tables(sql, db_name)    → add WHERE-referenced tables to FROM
 9. _convert_between_to_range(sql)            → BETWEEN → >= AND <=
10. _strip_same_table_conditions(sql)         → drop tautological/bare-col conditions
11. _clean_sql_artifacts(sql)                 → strip GROUP BY/ORDER BY/HAVING/CASE/substring
12. _hoist_joins_from_or_blocks(sql)          → Q19-style OR → top-level join + envelope
13. _prune_disconnected_tables(sql)           → remove table islands
14. _prune_redundant_joins(sql)               → union-find spanning tree
15. _strip_tautologies(sql)                   → remove 1 = 1 leftovers
16. Single-table handling                     → custom feature gen (0-join queries)
17. _try_create_features(sql)                 → retry with filter stripping on error
```

---

## 3. SQL Construct Reference

### 3.1 Date and Timestamp Literals

**Function:** `_convert_timestamps_to_epoch()`

| Pattern | Example | Handling |
|---------|---------|----------|
| `date 'YYYY-MM-DD'` | `date '1995-03-17'` | → epoch int `795484800` |
| `date '...' + interval 'N unit'` | `date '1993-01-01' + interval '1 year'` | → computed epoch |
| `date '...' - interval 'N unit'` | `date '1998-12-01' - interval '68 days'` | → computed epoch |
| `CAST('...' AS DATE) + N` | `CAST('1999-01-01' AS DATE) + 30` | → computed epoch (TPC-DS pattern) |
| `CAST('...' AS DATE)` (standalone) | `CAST('2001-03-16' AS DATE)` | → epoch int |
| `'...'::timestamp` | `'2014-09-04 23:10:09'::timestamp` | → epoch int |
| `CAST('...' AS TIMESTAMP)` | `CAST('...' AS TIMESTAMP)` | → epoch int |

**Interval units handled:** day(s), month(s), year(s).

**Applies to:** TPC-H Q1, Q3, Q4, Q5, Q6, Q7, Q8, Q10, Q12, Q14, Q15, Q20;
TPC-DS virtually all templates (date_dim filters).

### 3.2 CTEs (`WITH ... AS`)

**Function:** `flatten_sql_for_price()` → `_build_cte_info()`

**Handling:** The flattener parses each CTE body, extracts:
- Alias maps (CTE column → base column name)
- Base tables referenced inside the CTE
- Joins and filters inside the CTE

The main query's references to CTE columns are resolved back to base table
columns via `_resolve_col_through_cte()`. The CTE body's tables, joins, and
filters are inlined into a flat `SELECT COUNT(*) FROM ... WHERE ...`.

**Applies to:** TPC-DS Q1, Q2, Q4, Q5, Q11, Q14, Q23, Q24, Q30, Q31, Q47,
Q51, Q57, Q59, Q64, and many more.

### 3.3 UNION ALL in CTEs

**Function:** `_collect_union_branches()` + `_build_cte_info()`

**Handling:** When a CTE body is a UNION ALL, all branches are enumerated.
Each branch produces its own alias map, tables, joins, and filters. All are
collected:

- Tables: union of all branches
- Alias maps: one per branch (column resolution tries all branches)
- Joins/filters: concatenated from all branches

**Applies to:** TPC-DS Q2, Q5, Q14, Q23, Q33, Q56, Q58, Q60.

**Information loss:** Minimal — the union semantics (each branch is independent)
are lost, but all participating tables and predicates are captured.

### 3.4 VIEWs

**Functions:** `extract_raw_sql()`, `_flatten_revenue0_query()`

**Handling:** TPC-H Q15 is the only VIEW-based template. The `tpch.sql` file
contains `CREATE OR REPLACE VIEW revenue0` statements preceding each Q15 EXPLAIN
query, with per-instance date filters (`l_shipdate >= date '...'`).

`extract_raw_sql()` detects these CREATE VIEW statements and
attaches the date range as a `-- REVENUE0_DATES: start end` comment to the
extracted SQL. `flatten_sql_for_price()` extracts the dates and passes them to
`_flatten_revenue0_query()`, producing:

```sql
SELECT COUNT(*) FROM supplier, lineitem
WHERE s_suppkey = l_suppkey AND l_shipdate >= date '...' AND l_shipdate < date '...'
```

**Information loss:** 99/100 instances get per-instance date filters. The first
instance in `tpch.sql` lacks a preceding CREATE VIEW (it was pre-created), so it
falls back to the join without date filters. The scalar subquery
`total_revenue = (SELECT MAX(total_revenue) FROM revenue0)` is always dropped.

**Applies to:** TPC-H Q15 only.

### 3.5 Subquery-in-FROM

**Function:** `_unwrap_from_subquery()` in `flatten_sql_for_price()`

**Handling:** `FROM (SELECT ... FROM ... WHERE ...) AS sub` is unwrapped:
the inner SELECT's tables and conditions are promoted to the outer level.

**Applies to:** TPC-H Q8, Q22; TPC-DS Q2, Q14, Q23, Q33, Q47, Q54, Q56, Q58.

### 3.6 EXISTS / NOT EXISTS Subqueries

**Function:** `_inline_exists_subqueries()`

**Handling:**
1. The inner subquery's tables are added to the outer FROM clause
2. The EXISTS node is replaced with the inner WHERE conditions
3. Only equi-join (`=`) and comparison (`>`, `>=`, `<`, `<=`) conditions are kept
4. NEQ (`<>`), LIKE, and complex expressions inside the inner WHERE are dropped

**Information loss:**
- **NOT EXISTS is treated as EXISTS** — anti-join semantics are lost. The inlined
  query adds tables and joins as if it were a regular join, not an exclusion.
  This means PRICE overestimates the number of result rows for anti-join patterns.
- **NEQ conditions dropped:** e.g., `l2.l_suppkey <> l1.l_suppkey` in Q21

**Applies to:** TPC-H Q4, Q21, Q22; TPC-DS Q35, Q38, Q69, Q87.

### 3.7 IN (Subquery) / NOT IN (Subquery)

**Function:** `_inline_in_subqueries()`

**Handling:**
1. The inner subquery's tables are added to the outer FROM clause
2. An equi-join is created: `outer_col = inner_first_select_col`
3. Inner WHERE conditions (equi-join and comparisons) are kept
4. The IN node is replaced with the conjunction of these conditions

**Information loss:**
- **NOT IN treated as IN** — anti-semi-join semantics lost (same issue as NOT EXISTS)
- Inner GROUP BY / HAVING are dropped

**Applies to:** TPC-H Q16, Q18, Q20; TPC-DS Q6, Q16, Q23, Q38, Q69, Q85, Q94, Q95.

### 3.8 Scalar Subqueries

**Function:** `_estimate_scalar_subqueries()`

**Handling:** For patterns like `col op (SELECT AGG(x) FROM ...)`, the aggregate
is estimated from PRICE histogram statistics:

| Aggregate | Estimation Method |
|-----------|-------------------|
| `MIN(col)` | Minimum value from histogram (`bin_edges[0]`) |
| `MAX(col)` | Maximum value from histogram (`bin_edges[-1]`) |
| `AVG(col)` | Weighted mean from histogram bins |
| `SUM(col)` | `AVG(col) × group_size_heuristic` |
| `COUNT(*)` | Total rows in table |

Multipliers are preserved: `0.2 * AVG(col)` → `0.2 * estimated_value`.

The subquery's tables and correlated conditions can optionally be inlined.

**Information loss:**
- The estimated value is static — it doesn't account for correlation with
  the outer query's filters or GROUP BY context
- SUM uses a heuristic group size (not the actual number of groups)

**Applies to:** TPC-H Q2, Q11, Q15, Q17, Q20, Q22;
TPC-DS Q1, Q6, Q17, Q23, Q32, Q92.

### 3.9 BETWEEN

**Functions:** `_preprocess_predicates()` (AST-level), `_convert_between_to_range()` (text-level)

**Handling:** `col BETWEEN low AND high` → `col >= low AND col <= high`

Two levels of conversion:
1. **AST-level** in `_preprocess_predicates()`: sqlglot `Between` nodes → `GTE` + `LTE`
2. **Text-level** in `_convert_between_to_range()`: regex-based, handles constant
   arithmetic (e.g., `BETWEEN 1998 AND 1998 + 2` → `>= 1998 AND <= 2000`)

**Special cases:**
- Mixed-type BETWEEN (e.g., `BETWEEN 'string' AND number`): keeps only the
  numeric bound
- BETWEEN with string bounds: stripped entirely (PRICE can't use string ranges)

**Information loss:** None for numeric BETWEEN. String BETWEEN is dropped.

**Applies to:** TPC-H Q19; TPC-DS nearly all templates (date ranges, size ranges).

### 3.10 IN (Value List)

**Function:** `_classify_condition()` (during flattening), `_preprocess_predicates()` (after)

**Handling differs by statistics encoder:**

| Encoder | Numeric IN | String IN |
|---------|-----------|-----------|
| **PRICE (`--price_b`)** | Range envelope: `IN (4, 22, 35)` → `BETWEEN 4 AND 35` | Representative equality: `IN ('Books', 'Children')` → `= 'Books'` (first value) |
| **Canon (`--canon`)** | Preserved — multi-range filter token (point range per value) | Preserved — multi-range encoding over top-K summary values |

**Information loss (PRICE):**
- Numeric: range envelope is always wider than the actual set of values
  (e.g., `IN (1, 5, 15)` becomes `BETWEEN 1 AND 15`, covering 2-4, 6-14 too)
- String: only one value from the set is used; all others are dropped

**Applies to:** TPC-H Q12, Q16, Q19; TPC-DS most templates (category lists, size lists).

### 3.11 LIKE / ILIKE

**Function:** `_preprocess_predicates()`

**Handling:**

| Encoder | Handling |
|---------|----------|
| **PRICE (`--price_b`)** | Replaced with `1 = 1` (dropped) |
| **Canon (`--canon`)** | Dropped from the statistics tokens (LIKE has no range semantics); the predicate remains visible to the LLM in the plan text |

**Information loss (PRICE):** Complete — the LIKE predicate and its
selectivity are entirely ignored in the statistics tokens.

**Applies to:** TPC-H Q2, Q9, Q13, Q16, Q20; TPC-DS Q41.

### 3.12 NOT LIKE / NOT ILIKE

**Function:** `_preprocess_predicates()`

**Handling:** Same as LIKE above (dropped from the statistics tokens; still
read by the LLM from the plan text).

**Applies to:** TPC-H Q13, Q16.

### 3.13 OR Conditions

**Function:** `_classify_condition()`, `_hoist_joins_from_or_blocks()`

**General handling:** OR is classified as `('skip', 'OR')` during CTE flattening
— OR-connected predicates are dropped.

**Exception — TPC-H Q19 pattern:** When the entire WHERE clause is an OR
expression (no top-level ANDs), `_hoist_joins_from_or_blocks()` applies:

1. Scans all OR branches for equi-joins (`alias.col = alias.col`)
2. Hoists the common join to top level
3. Collects simple numeric filters from all branches
4. Uses the **OR-envelope** — widest range covering all branches:
   - For `>=`/`>`: keeps the smallest lower bound
   - For `<=`/`<`: keeps the largest upper bound
5. Limits to 4 extra filter conditions beyond the joins

**Information loss:**
- OR semantics → AND semantics (widens the predicate)
- String equality filters inside OR branches are dropped
- IN value lists inside OR branches are dropped (only numeric ranges kept)

**Applies to:** TPC-H Q19 (the OR-hoist path); OR inside other queries is simply dropped.

### 3.14 NEQ (Not-Equal) Conditions

**Handling:** Dropped in all cases. PRICE only supports `=`, `<`, `<=`, `>`, `>=`.

- Between two columns (`l_suppkey <> l1.l_suppkey`): dropped during EXISTS inlining
- Between column and literal string (`!= 'value'`): dropped in `_preprocess_predicates()`

**Applies to:** TPC-H Q16, Q21; TPC-DS various templates.

### 3.15 Self-Joins

**Functions:** `transform_sql_for_price()` (alias numbering), `_collapse_self_joins()`,
`_patch_self_join_stats()`

**Handling:**
1. When the same table appears multiple times (e.g., `nation n1, nation n2`),
   each occurrence gets a numbered PRICE alias: `tpch_n`, `tpch_n2`, `tpch_n3`
2. Statistics are copied from the base alias to numbered aliases via
   `_patch_self_join_stats()`: histogram, summary, size, col_type, fanout
3. Self-join fanout uses uniform arrays of `1.0` (each row matches ~1 row)
4. `_collapse_self_joins()` merges back numbered aliases that only have
   tautological joins (`tpcds_dd.col = tpcds_dd.col`), which are then pruned

**Applies to:**
- TPC-H Q7, Q8 (nation self-join); Q21 (lineitem l1, l2, l3)
- TPC-DS Q1, Q4, Q5, Q11, Q14, Q30, Q31, Q64 (date_dim d1, d2, d3);
  Q64 (customer_demographics cd1, cd2; customer_address ad1, ad2;
  household_demographics hd1, hd2; income_band ib1, ib2)

### 3.16 Cyclic Joins

**Function:** `_prune_redundant_joins()`

**Handling:** Uses union-find to build a spanning tree. Redundant joins
(those that would create cycles) are replaced with `1 = 1` tautologies,
then cleaned by `_strip_tautologies()`.

PRICE requires exactly `N-1` joins for `N` tables (tree topology). When
subquery inlining or self-joins introduce additional join paths, this
function ensures the constraint is met.

**Information loss:** The pruned join conditions are lost. The union-find
picks joins in discovery order, not necessarily the most selective ones.

**Applies to:** Queries with inlined subqueries that create join cycles;
TPC-DS Q64 (18 tables, many join paths).

### 3.17 Single-Table Queries

**Function:** `_create_single_table_features()`

**Handling:** PRICE crashes on single-table queries because `torch.cat` on an
empty list (no joins) fails. The custom handler:

1. Calls `sql2feat.parse_sql()` to extract the single table and filter columns
2. Computes filter features using PRICE's internal methods (histogram, ranges, selectivity)
3. Computes table features: `[log(table_size), avi, minsel, ebo]`
4. Uses zero-filled placeholders for join histogram (1 × 40) and fanout (2 × 40)

**Information loss:** None for filters. Join/fanout features are zeros
(padded by `features_padding` anyway).

**Applies to:** TPC-H Q1, Q6 (single-table after flattening).

### 3.18 GROUP BY / ORDER BY / LIMIT

**Function:** `_strip_trailing_clauses()`, `_clean_sql_artifacts()`

**Handling:** Stripped entirely. PRICE features don't depend on grouping,
ordering, or limit counts.

**Applies to:** Nearly all TPC-H and TPC-DS templates.

### 3.19 HAVING

**Function:** `_clean_sql_artifacts()`

**Handling:** Stripped entirely.

**Information loss:** HAVING conditions (e.g., `HAVING count(*) > 4`) are
selectivity-relevant but cannot be represented in PRICE's feature model.

**Applies to:** TPC-H Q11, Q18; TPC-DS Q1, Q11, Q18, Q23, Q47.

### 3.20 CASE / WHEN Expressions

**Function:** `_clean_sql_artifacts()`

**Handling:** CASE/WHEN fragments in the WHERE clause are stripped via regex
(`") else (...` and `end as ...` patterns).

**Applies to:** TPC-DS Q2, Q14, Q47, Q51.

### 3.21 SUBSTRING() and Function Calls

**Function:** `_clean_sql_artifacts()`

**Handling:** Conditions containing `substring(` are dropped entirely.

**Applies to:** TPC-H Q22 (`substring(c_phone from 1 for 2) in (...)`).

### 3.22 Non-Equi String Comparisons

**Function:** `_preprocess_predicates()`

**Handling:** Comparisons like `col > 'string_value'`, `col <= 'string_value'`,
`col != 'string_value'` are replaced with `1 = 1` (dropped).

PRICE histograms encode strings as integer frequency-rank indices, so
string ordering comparisons are not meaningful.

**Applies to:** Various TPC-DS templates with string range filters.

### 3.23 Column-to-Column Comparisons (Non-Join)

**Handling:** Conditions like `l_receiptdate > l_commitdate` (comparing two
columns from the same table) are dropped. PRICE only supports
`column op literal` filters, not column-to-column comparisons.

**Applies to:** TPC-H Q4 (`l_commitdate < l_receiptdate`),
Q21 (`l_receiptdate > l_commitdate`).

### 3.24 INTERSECT

**Function:** `_build_cte_info()`

**Handling:** INTERSECT within CTEs is treated similarly to UNION ALL — all
branches are collected, their tables and predicates are merged.

**Information loss:** INTERSECT semantics (only rows in ALL branches) are lost;
the merger collects predicates from all branches as if they were UNION ALL.

**Applies to:** TPC-DS Q14 (`store_sales INTERSECT catalog_sales INTERSECT web_sales`).

### 3.25 LEFT JOIN / RIGHT JOIN / OUTER JOIN

**Handling:** During CTE flattening, `JOIN ... ON` syntax is parsed and the
ON conditions are extracted as equi-joins. The join type (LEFT, RIGHT, INNER)
is discarded — all joins are treated as inner joins.

**Information loss:** Outer join semantics (NULL-producing side) are lost.

**Applies to:** TPC-H Q13 (`customer LEFT JOIN orders`); TPC-DS various templates.

### 3.26 Constant Arithmetic

**Function:** `_eval_constant_arithmetic()`

**Handling:** Constant expressions in the AST are evaluated:
- `6 + 10` → `16`
- `1999 + 1` → `2000`
- `95/100.0` → `0.95`

Uses sqlglot AST walker to find `Add`, `Sub`, `Mul`, `Div` nodes where both
children are literals, and replaces with the computed result.

**Applies to:** TPC-H Q19 (`l_quantity <= 6 + 10`);
TPC-DS Q14, Q23 (`d_year between 1998 AND 1998 + 2`).

### 3.27 Window Functions (RANK, ROW_NUMBER)

**Handling:** Not explicitly handled, but these only appear in SELECT lists
and ORDER BY, not in WHERE clauses. They are naturally stripped when the
query is rewritten to `SELECT COUNT(*) FROM ... WHERE ...`.

**Applies to:** TPC-DS Q34, Q44, Q46, Q49, Q50, Q51, Q67.

### 3.28 ROLLUP / GROUPING SETS

**Handling:** Appear in GROUP BY, which is stripped entirely.

**Applies to:** TPC-DS Q27, Q36, Q70, Q86.

### 3.29 COALESCE / NULLIF

**Handling:** Not explicitly handled. If they appear in WHERE conditions,
they are typically dropped as unrecognized expressions by `_classify_condition()`
returning `('skip', ...)`.

**Applies to:** TPC-DS Q64, Q78.

---

## 4. TPC-H Template-by-Template Analysis

### Legend

- **Difficulty:** Easy (flat SQL, simple filters), Medium (subqueries or
  special constructs), Hard (multiple nested subqueries, complex patterns)
- **Information Loss:** Low (minor or no semantic loss), Medium (some predicates
  dropped), High (significant semantic loss)

| Template | Tables | Difficulty | Key Constructs | Handling | Information Loss |
|----------|--------|------------|---------------|----------|-----------------|
| **Q1** | 1 (lineitem) | Easy | Date arithmetic, single-table | Date → epoch; single-table feature gen | Low |
| **Q2** | 5 (part, supplier, partsupp, nation, region) | Hard | Scalar subquery `MIN(ps_supplycost)`, LIKE on p_type | Scalar estimated from histogram; LIKE dropped | Medium — LIKE selectivity lost |
| **Q3** | 3 (customer, orders, lineitem) | Easy | Date filters, string equality | Date → epoch; direct mapping | Low |
| **Q4** | 2 (orders, lineitem) | Medium | EXISTS subquery, column-column comparison `l_commitdate < l_receiptdate` | EXISTS inlined; column-column comparison dropped | Medium — temporal ordering lost |
| **Q5** | 6 (customer, orders, lineitem, supplier, nation, region) | Easy | Date range, string equality | Date → epoch; direct mapping | Low |
| **Q6** | 1 (lineitem) | Easy | Date arithmetic, single-table, BETWEEN | Date → epoch; BETWEEN → range; single-table gen | Low |
| **Q7** | 6 (supplier, lineitem, orders, customer, nation ×2) | Medium | Self-join on nation (n1, n2), date BETWEEN | Self-join numbered aliases; BETWEEN → range | Low |
| **Q8** | 8 (part, supplier, lineitem, orders, customer, nation ×2, region) | Medium | Self-join on nation, subquery-in-FROM | Subquery unwrapped; self-join handled | Low |
| **Q9** | 6 (part, supplier, lineitem, partsupp, orders, nation) | Medium | LIKE on p_name (`'%color%'`) | LIKE dropped in standard PRICE | Medium — LIKE selectivity lost |
| **Q10** | 4 (customer, orders, lineitem, nation) | Easy | Date range | Date → epoch | Low |
| **Q11** | 3 (partsupp, supplier, nation) | Medium | HAVING, scalar subquery `SUM * fraction` | HAVING dropped; scalar estimated | Medium — HAVING threshold lost |
| **Q12** | 2 (orders, lineitem) | Medium | IN value list (l_shipmode), date range | IN → range envelope (standard) or preserved (M/S) | Low–Medium |
| **Q13** | 2 (customer, orders) | Medium | LEFT JOIN, NOT LIKE on o_comment | LEFT → inner join; NOT LIKE dropped | Medium — outer join + pattern lost |
| **Q14** | 2 (lineitem, part) | Easy | Date range | Date → epoch | Low |
| **Q15** | 2 (supplier, lineitem) | Hard | CREATE VIEW revenue0, scalar subquery `MAX(total_revenue)` | VIEW dates extracted from CREATE VIEW; scalar subquery dropped | **Low** — 99/100 have dates; scalar lost |
| **Q16** | 3 (partsupp, part, supplier) | Hard | NOT IN (subquery), NOT LIKE, IN value list (p_size) | NOT IN inlined; NOT LIKE dropped; IN → range/equality | Medium — anti-join + LIKE lost |
| **Q17** | 2 (lineitem, part) | Medium | Correlated scalar subquery `0.2 * AVG(l_quantity)` | Scalar estimated from histogram × 0.2 | Medium — correlation context lost |
| **Q18** | 3 (customer, orders, lineitem) | Medium | IN (subquery with HAVING) | IN inlined; HAVING dropped | Medium — HAVING threshold lost |
| **Q19** | 2 (lineitem, part) | Hard | Entire WHERE is OR blocks, each with join + IN + BETWEEN | Join hoisted; OR-envelope on ranges; string IN dropped | **High** — OR selectivity lost, string filters lost |
| **Q20** | 4 (supplier, nation, partsupp, part, lineitem) | Hard | 3-level nested subqueries, LIKE, scalar `0.5 * SUM(l_quantity)` | All inlined; LIKE dropped; scalar estimated | Medium–High |
| **Q21** | 5 (supplier, lineitem ×3, orders, nation) | Hard | EXISTS + NOT EXISTS, self-join on lineitem (l1, l2, l3), NEQ `<>` | EXISTS/NOT EXISTS inlined; self-join numbered; NEQ dropped | **High** — anti-join lost, NEQ lost |
| **Q22** | 2 (customer, orders) | Hard | Subquery-in-FROM, NOT EXISTS, scalar `AVG(c_acctbal)`, SUBSTRING, IN | Subquery unwrapped; NOT EXISTS inlined; scalar estimated; SUBSTRING dropped; IN dropped | **High** — substring-based partitioning lost |

### Success Rate

TPC-H: **4400/4400 (100%)** feature extraction success.

---

## 5. TPC-DS Template-by-Template Analysis

TPC-DS has 99 templates. Below is a categorized analysis grouping templates by
their dominant challenge pattern.

### 5.1 Simple Templates (Flat Joins + Filters)

These templates have no subqueries, CTEs, or complex constructs beyond basic
joins, filters, and date ranges.

| Template | Tables | Key Constructs | Information Loss |
|----------|--------|----------------|-----------------|
| Q3 | 4 (date_dim, store_sales, item, ...) | Date equality, string IN | Low — IN → envelope |
| Q7 | 4 | Date range, string IN | Low |
| Q12 | 3 | Date range, string IN | Low |
| Q13 | 5 | Date range, BETWEEN, string IN | Low |
| Q15 | 3 | Date BETWEEN, numeric range | Low |
| Q17 | 4 | Date range, numeric filters | Low |
| Q19 | 4 | Date range, string IN | Low |
| Q20 | 3 | Date range, string IN | Low |
| Q21 | 3 | Date range, string IN | Low |
| Q25 | 4 | Date range | Low |
| Q26 | 4 | Date range, string IN, numeric range | Low |
| Q29 | 4 | Date range | Low |
| Q37 | 3 | Date range, string IN | Low |
| Q40 | 3 | Date range | Low |
| Q42 | 3 | Date range, string equality | Low |
| Q43 | 2 | Date range, string IN | Low |
| Q46 | 4 | Date range, string IN | Low |
| Q48 | 4 | Date range, numeric range, string IN | Low |
| Q52 | 3 | Date range, string equality | Low |
| Q53 | 3 | Date range, string IN | Low |
| Q55 | 3 | Date range, string equality | Low |
| Q62 | 4 | Date range | Low |
| Q63 | 3 | Date range, string IN | Low |
| Q65 | 3 | Date range | Low |
| Q68 | 4 | Date range, string IN | Low |
| Q72 | 5 | Date range, numeric range | Low |
| Q73 | 3 | Date range, string IN, numeric IN | Low |
| Q76 | 3 | Date range | Low |
| Q79 | 4 | Date range, string IN | Low |
| Q82 | 3 | Date range, numeric IN, string IN | Low |
| Q84 | 4 | String equality | Low |
| Q85 | 6 | Date range, numeric range, string IN | Low |
| Q88 | 3 | Date range, numeric range | Low |
| Q89 | 3 | Date range, string IN | Low |
| Q90 | 3 | Date range, numeric range | Low |
| Q91 | 5 | Date range, string equality | Low |
| Q93 | 3 | Numeric filter | Low |
| Q96 | 3 | Numeric/string equality | Low |
| Q98 | 3 | Date range, string IN | Low |
| Q99 | 3 | Date range | Low |

### 5.2 CTE Templates (Single CTE, No UNION)

| Template | Tables | Key Constructs | Handling | Information Loss |
|----------|--------|----------------|----------|-----------------|
| Q1 | 3 (store_returns, date_dim, store, customer) | CTE with GROUP BY/SUM, scalar subquery `AVG * 1.2`, string equality | CTE flattened; scalar estimated; GROUP BY stripped | Medium — aggregation context lost |
| Q4 | 6+ | CTE with joins, self-join on date_dim | CTE flattened; self-join numbered | Low–Medium |
| Q10 | 4 | CTE, date range | CTE flattened | Low |
| Q24 | 5 | CTE with GROUP BY/HAVING, numeric filter | CTE flattened; HAVING dropped | Medium |
| Q30 | 5 | CTE, self-join on date_dim, scalar subquery | CTE flattened; self-join collapsed; scalar estimated | Medium |
| Q31 | 3 | CTE, self-join on date_dim | CTE flattened; self-join handled | Low |
| Q34 | 3 | CTE, date range, BETWEEN | CTE flattened | Low |
| Q39 | 3 | CTE, date range | CTE flattened | Low |
| Q44 | 2 | CTE with correlated subquery | CTE flattened; scalar estimated | Medium |
| Q50 | 3 | CTE, date range | CTE flattened | Low |
| Q54 | 5 | CTE, subquery-in-FROM | CTE flattened; subquery unwrapped | Low–Medium |
| Q57 | 4 | CTE, date range | CTE flattened | Low |
| Q59 | 3 | CTE, date range | CTE flattened | Low |
| Q66 | 5 | CTE, date range, string IN | CTE flattened | Low |
| Q67 | 3 | CTE, ROLLUP | CTE flattened; ROLLUP stripped | Low |
| Q70 | 3 | CTE, ROLLUP | CTE flattened; ROLLUP stripped | Low |
| Q71 | 4 | CTE, date range, string IN | CTE flattened | Low |
| Q74 | 4 | CTE, self-join on date_dim | CTE flattened; self-join collapsed | Low |
| Q75 | 6 | CTE, date range | CTE flattened | Low |
| Q77 | 3 | CTE, date range | CTE flattened | Low |
| Q78 | 4 | CTE, COALESCE | CTE flattened; COALESCE dropped | Low–Medium |
| Q80 | 6 | CTE, date range | CTE flattened | Low |
| Q81 | 5 | CTE, scalar subquery, self-join | CTE flattened; scalar estimated; self-join collapsed | Medium |
| Q83 | 3 | CTE, date IN list | CTE flattened; IN → envelope | Low |
| Q86 | 2 | CTE, ROLLUP | CTE flattened; ROLLUP stripped | Low |
| Q92 | 3 | CTE, scalar subquery | CTE flattened; scalar estimated | Medium |
| Q97 | 3 | CTE, date range | CTE flattened | Low |

### 5.3 CTE Templates with UNION ALL

| Template | Tables | Key Constructs | Handling | Information Loss |
|----------|--------|----------------|----------|-----------------|
| Q2 | 5 | CTE with UNION ALL (web_sales ∪ catalog_sales), date range, self-join on date_dim, CASE/WHEN | All UNION branches collected; self-join collapsed; CASE stripped | Low–Medium |
| Q5 | 6 | CTE with UNION ALL, date range | All branches collected | Low |
| Q14 | 8 | CTE with INTERSECT (3-way: store ∩ catalog ∩ web), UNION ALL, subquery-in-FROM, CASE | INTERSECT treated as UNION; all branches collected; subquery unwrapped; CASE stripped | Medium — INTERSECT semantics lost |
| Q23 | 5 | 3 CTEs (frequent_ss_items, max_store_sales, best_ss_customer), HAVING, scalar subquery, IN (CTE reference), UNION ALL in main query | CTEs flattened; HAVING dropped; scalar estimated; IN from CTE → equi-join | Medium–High |
| Q33 | 5 | CTE with UNION ALL, date range, string IN | All branches collected | Low |
| Q49 | 5 | CTE, UNION ALL | Branches collected | Low |
| Q56 | 5 | CTE with UNION ALL, date range, string IN | All branches collected | Low |
| Q58 | 5 | CTE with UNION ALL, date IN list | All branches collected | Low |
| Q60 | 5 | CTE with UNION ALL, date range, string IN | All branches collected | Low |
| Q61 | 5 | Subquery-in-FROM with UNION-like structure | Unwrapped | Low |

### 5.4 Templates with EXISTS / NOT EXISTS / IN Subqueries

| Template | Tables | Key Constructs | Handling | Information Loss |
|----------|--------|----------------|----------|-----------------|
| Q6 | 3 | IN (subquery), scalar subquery `AVG * 1.2`, date range | IN inlined; scalar estimated | Medium |
| Q16 | 3 | IN (subquery), date range | IN inlined | Low |
| Q32 | 3 | Scalar subquery `AVG * 1.3`, date range | Scalar estimated | Medium |
| Q35 | 4 | EXISTS subqueries (2×), date range | EXISTS inlined | Low — EXISTS adds tables |
| Q38 | 3 | INTERSECT of 3 subqueries, EXISTS | INTERSECT → collect branches; EXISTS inlined | Medium |
| Q41 | 1 | NOT EXISTS, LIKE on i_product_name | NOT EXISTS inlined; LIKE dropped | Medium |
| Q45 | 3 | IN (subquery), date range | IN inlined | Low |
| Q69 | 4 | EXISTS + NOT EXISTS, date range, string IN | EXISTS inlined; NOT EXISTS → join (lossy) | Medium — anti-join lost |
| Q87 | 3 | EXISTS (3×), date range | EXISTS inlined (adds store_sales, catalog_sales, web_sales) | Low |
| Q94 | 4 | IN (subquery), NOT IN (subquery), date range | IN inlined; NOT IN → join (lossy) | Medium — anti-join lost |
| Q95 | 4 | IN (subquery), NOT IN (subquery), date range | Same as Q94 | Medium |

### 5.5 Templates with Heavy Self-Joins

| Template | Tables | Self-Join Tables | Handling | Information Loss |
|----------|--------|-----------------|----------|-----------------|
| Q4 | 6+ | date_dim ×2 | Numbered aliases; collapse if tautological | Low |
| Q11 | 4 | date_dim ×2 | Same | Low |
| Q14 | 8 | date_dim ×3, item ×3 (via INTERSECT branches) | Same | Low |
| Q30 | 5 | date_dim ×2 | Same | Low |
| Q31 | 3 | date_dim ×2 | Same | Low |
| Q47 | 4 | date_dim ×2 | Same | Low |
| Q51 | 3 | date_dim ×2 | Same | Low |
| Q57 | 4 | date_dim ×2 | Same | Low |
| **Q64** | **18** | date_dim ×3, customer_demographics ×2, customer_address ×2, household_demographics ×2, income_band ×2 | All numbered; CTE reference resolved; **many redundant joins pruned** | Medium — many joins pruned |
| Q74 | 4 | date_dim ×2 | Same | Low |

### 5.6 Most Complex TPC-DS Templates

| Template | Why Complex | Key Handling |
|----------|------------|--------------|
| **Q14** | INTERSECT of 3 sales channels in CTE, UNION ALL, subquery-in-FROM, 3+ self-joins, CASE/WHEN | INTERSECT → UNION treatment; all branches collected; CASE stripped |
| **Q23** | 3 nested CTEs, HAVING, scalar subquery `(95/100.0) * (SELECT * FROM max_store_sales)`, IN (CTE reference), UNION ALL | CTEs flattened; HAVING dropped; scalar estimated; constant arithmetic evaluated |
| **Q64** | 18-table join with 6 self-join pairs, CTE reference `cs_ui`, cyclic joins | CTE resolved; self-joins numbered; redundant joins pruned via union-find |
| **Q4** | 2 CTEs, self-join date_dim, CASE/WHEN, complex aggregation | CTEs flattened; self-joins handled; CASE stripped |
| **Q47** | 2 CTEs, self-join date_dim, window function, CASE | CTEs flattened; window func stripped; self-join handled |
| **Q51** | 2 CTEs, self-join date_dim, window function | CTEs flattened; window func stripped; self-join handled |

### Success Rate

TPC-DS: **19800/19800 (100%)** feature extraction success.

---

## 6. Fallback Mechanisms

When the primary flattening path fails (e.g., the flattened SQL still references
CTE names instead of real tables), the pipeline has two fallback layers:

### 6.1 AST Predicate Collection (`_ast_collect_predicates`)

Walks the **entire** sqlglot AST at all nesting levels:
1. Collects all real tables (excluding CTE names)
2. Collects all equi-joins (`Column = Column`)
3. Collects all simple filters (`Column op Literal`)
4. Collects BETWEEN and IN conditions
5. Uses column prefix mapping (`l_` → lineitem, `ss_` → store_sales) to
   resolve bare column names to tables
6. Builds the largest connected component (BFS)
7. Constructs synthetic flat SQL

### 6.2 Regex Predicate Collection (`_regex_collect_predicates`)

No sqlglot dependency — pure regex:
1. Scans for `alias.col = alias.col` patterns (joins)
2. Scans for `alias.col op number` patterns (filters)
3. Scans for table names matching known PRICE aliases
4. Constructs flat SQL from regex matches

### 6.3 Filter Stripping Retry (`_try_create_features`)

After SQL transformation, if `Sql2Feature.create_sql_features()` fails with:
- `AssertionError` ("selectivity should not be 0")
- `KeyError` (missing column in statistics)
- `IndexError` (unqualified column)

The function retries by stripping filter conditions one at a time from the end,
keeping all joins. This progressively simplifies the query until PRICE can
process it.

### 6.4 Zero-Feature Placeholder

If all retries fail, the query gets zero-filled placeholder features:
- 1 zero join histogram (40 dims)
- 2 zero fanout arrays (80 dims)
- 1 zero table feature (4 dims)
- 1 zero filter feature (43 or 61 dims)

---

## 7. Information Loss Summary

### Fully Preserved

| Construct | Notes |
|-----------|-------|
| Equi-joins | Core PRICE feature |
| Numeric equality/range filters | Core PRICE feature |
| Date literals | Converted to epoch, then treated as numeric |
| BETWEEN (numeric) | Decomposed to range |
| CTE table references | Resolved through alias maps |
| Self-join table copies | Statistics duplicated |

### Approximated

| Construct | Approximation | Impact |
|-----------|---------------|--------|
| Scalar subqueries | Estimated from histogram statistics | Medium — static estimate ignores correlation |
| IN (numeric value list) | Range envelope (standard PRICE) | Low–Medium — wider than actual set |
| IN (string value list) | First value as equality (standard PRICE) | Medium — only 1 of N values used |
| OR blocks (Q19 pattern) | Common join hoisted, range envelope | Medium–High — OR → AND semantics |
| Constant arithmetic | Evaluated at transform time | None — exact |

### Dropped (Information Lost)

| Construct | Impact Assessment |
|-----------|-------------------|
| LIKE / NOT LIKE | Medium — pattern selectivity completely lost |
| NOT EXISTS / NOT IN | **High** — anti-join → join inverts the semantics |
| HAVING | Medium — post-aggregation threshold lost |
| OR conditions (general) | Medium — entire OR branch dropped |
| NEQ conditions | Low–Medium — inequality selectivity lost |
| Column-column comparisons | Medium — temporal ordering predicates lost |
| CASE/WHEN | Low — typically in SELECT, not WHERE |
| SUBSTRING() | Medium — partitioning logic lost (Q22) |
| LEFT/RIGHT JOIN type | Low–Medium — NULL-producing side semantics lost |
| VIEW date filters (Q15) | **Low** — 99/100 instances now have date filters extracted from CREATE VIEW |

### Canon Recovery

Canon recovers some of the information that the original PRICE encoding drops:

| Construct | PRICE (`--price_b`) | Canon (`--canon`) |
|-----------|---------------------|-------------------|
| IN (value list) | Range envelope or first value | **Preserved** — multi-range filter token |
| NOT / NOT BETWEEN | Dropped or approximated | **Preserved** — range complement (closed under negation) |
| Mixed-column OR | Dropped | **Preserved** — DNF expansion + OR-transformer |

---

## 8. Statistics

### Query Counts

| Workload | Templates | Queries per Template | Total Queries |
|----------|-----------|---------------------|---------------|
| TPC-H | 22 | 200 | 4,400 |
| TPC-DS | 99 | 200 | 19,800 |

### Feature Extraction Results

| Workload | Success | Single-Table | Failed | Rate |
|----------|---------|-------------|--------|------|
| TPC-H | 4,400 | ~400 (Q1, Q6) | 0 | 100% |
| TPC-DS | 19,800 | 0 | 0 | 100% |

### Key Implementation Files

| File | Role |
|------|------|
| `experiments/sice_lib.py` | SQL transformation pipeline (merged library) |
| `canon/price/setup/features_tool.py` | Original PRICE feature extractor (`Sql2Feature`) |
| `canon/price/setup/features_tool_b.py` | PRICE encoder used by `--price_b` (`Sql2FeatureB`) |
| `canon/price/setup/features_tool_s.py` | Shared range-encoding layer (`Sql2FeatureS`, internal) |
| `canon/features_tool.py` | Canon feature extractor (`Sql2FeatureN`) |
| `experiments/generate_price_stats_from_pg.py` | Statistics generation from PostgreSQL |
| `queries/tpch.sql` | Combined TPC-H queries (4,400) |
| `queries/tpcds.sql` | Combined TPC-DS queries (19,800) |
