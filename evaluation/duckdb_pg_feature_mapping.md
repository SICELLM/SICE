# DuckDB to PostgreSQL Feature Mapping

This document describes how DuckDB query plan JSON fields are mapped to
PostgreSQL-style `TreeNode` attributes so that baseline algorithms (AIMeetsAI,
BAO, QueryFormer, E2E, PostgreSQL estimator) can process DuckDB plans without
modification.

## Root-Level Fields

| DuckDB Field | PostgreSQL Equivalent | Notes |
|---|---|---|
| `latency` | `Execution Time` | DuckDB stores seconds; multiply by 1000 for ms |
| `rows_returned` | `Actual Rows` (root) | Used as the cost label for cardinality task |

## Per-Node Fields

| PostgreSQL Field | Used By | DuckDB Equivalent | Notes |
|---|---|---|---|
| `Node Type` | All | `operator_name` | Needs name normalisation (see table below) |
| `Actual Rows` | All (cost label) | `operator_cardinality` | |
| `Actual Total Time` | All (cost label) | `operator_timing` | In seconds; multiply by 1000 for ms |
| `Plan Rows` (card_est) | AIME, BAO, E2E, QF | `extra_info["Estimated Cardinality"]` | String in DuckDB, parse as float |
| `Total Cost` (cost_est) | AIME, BAO | **Not available** | Default to 0 |
| `Startup Cost` | feature_extractor | **Not available** | Default to 0 |
| `Plan Width` (width) | AIME | **Not available** | Default to 0 |
| `Parallel Aware` | AIME (nodeParallel) | **Not available** | Default to False |
| `Relation Name` (table) | BAO, E2E, QF | `extra_info["Table"]` | |
| `Alias` | QF, E2E | **Not available** | Use table name |
| `Index Name` | BAO, E2E | **Not available** | Default to None |
| `Buffers` | BAO | **Not available** | Default to None (BAO already handles None) |
| `Hash Cond` / `Join Filter` / `Merge Cond` | QF, E2E | `extra_info["Conditions"]` | Need parsing |
| `Filter` / `Index Cond` / `Recheck Cond` | QF, E2E | `extra_info["Filters"]` | Need parsing |
| `Join Type` | feature_extractor | `extra_info["Join Type"]` | |
| `Hash Buckets` | feature_extractor | **Not available** | Default to None |
| `Sort Key` / `Sort Method` | feature_extractor | **Not available** | Default to None |
| `Strategy` / `Command` / `Subplan Name` | feature_extractor | **Not available** | Default to None |
| `Parent Relationship` | feature_extractor | **Not available** | Default to None |
| `Plans` (children) | All | `children` | Different key name |

## DuckDB Operator Name to PostgreSQL Node Type

| DuckDB `operator_name` | PostgreSQL `Node Type` |
|---|---|
| `SEQ_SCAN` / `SEQ_SCAN ` | `Seq Scan` |
| `INDEX_SCAN` | `Index Scan` |
| `HASH_JOIN` | `Hash Join` |
| `NESTED_LOOP_JOIN` | `Nested Loop` |
| `MERGE_JOIN` | `Merge Join` |
| `FILTER` | `Filter` |
| `PROJECTION` | `Projection` |
| `HASH_GROUP_BY` | `HashAggregate` |
| `PERFECT_HASH_GROUP_BY` | `HashAggregate` |
| `ORDER_BY` | `Sort` |
| `UNGROUPED_AGGREGATE` | `Aggregate` |
| `TOP_N` | `Limit` |
| `CROSS_PRODUCT` | `Nested Loop` |
| `PIECEWISE_MERGE_JOIN` | `Merge Join` |
| `BLOCKWISE_NL_JOIN` | `Nested Loop` |
| (others) | Keep original with cleaned formatting |

## DuckDB Condition Parsing

- **Filters**: Strings like `"kind_id=7"`, `"info_type_id>99"`, `"person_id BETWEEN 1 AND 100"`
  - Parsed into `[column, op, value]` triples matching PostgreSQL filter format.
- **Conditions**: Strings like `"id = movie_id"` (join predicates)
  - Parsed into `table.col = table.col` join string format.
