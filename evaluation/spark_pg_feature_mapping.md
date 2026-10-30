# Spark to PostgreSQL Feature Mapping

This document describes how Spark EXPLAIN ANALYZE
query plans are converted to PostgreSQL-style JSON so that all baseline
algorithms (AIMeetsAI, BAO, QueryFormer, E2E, PostgreSQL estimator) and the
LLM pipeline can process them without modification.

## Approach Difference from DuckDB

| Aspect | DuckDB | Spark |
|--------|--------|---------------|
| Storage format | Native DuckDB JSON | **Pre-converted** to PG-style JSON |
| Traversal code | Custom `traversePlanDuckDB()` | Reuses existing `traversePlan()` |
| Field categories | the DuckDB field categories (`sice_lib.py`) | Reuses the PostgreSQL field categories (`sice_lib.py`) |
| Conversion scripts | `convert_duckdb_plans.py` | `convert_spark_plans.py` |

Because the conversion happens *before* CSV storage, no engine-specific
traversal code is needed in `feature_extractor.py`.

---

## Spark

### Raw Format

Files: `stats_<ID>_run0.txt` (one per query)

```
time cost: 231 ms
actual cardinality: 133949
query plan:
Join Inner, (PostId#83 = Id#19)
:- Filter (...)
:  +- Relation spark_catalog.stats.comments[Id#82,PostId#83,...] parquet
+- Filter (...)
   +- Relation spark_catalog.stats.posts[Id#19,...] parquet

statsOutput:
Join estimated row count: 4984, size in bytes: 378784
Filter estimated row count: 4828, size in bytes: 154496
LogicalRelation estimated row count: 174305, size in bytes: 5577760
...
```

- Header: `time cost: X ms`, `actual cardinality: Y`
- Plan tree: Indentation via `+-`, `:-`, `:`, spaces (3 chars per level)
- Statistics: Pre-order traversal mapping operator → estimated row count

### Operator Name Mapping

| Spark Operator | Mapped `Node Type` |
|---|---|
| `Join Inner` | `Hash Join` |
| `Join LeftOuter` | `Hash Left Join` |
| `Join RightOuter` | `Hash Right Join` |
| `Filter` | Merged into child Relation/Join |
| `Relation` | `Seq Scan` |
| `Project` | `Projection` |
| `Aggregate` | `Aggregate` |
| `Sort` | `Sort` |

### Per-Node Field Mapping

| PostgreSQL Field | Spark Source | Notes |
|---|---|---|
| `Node Type` | Operator type (mapped) | See table above |
| `Actual Startup Time` | **Not available** | Always 0 |
| `Actual Total Time` | `time cost` from header (root only) | 0 for non-root nodes |
| `Actual Rows` | `actual cardinality` (root only) | Non-root: uses `Plan Rows` |
| `Actual Loops` | **Not available** | Always 1 |
| `Total Cost` | **Not available** | Always 0 |
| `Plan Rows` | From `statsOutput` (pre-order) | Estimated row count |
| `Plan Width` | **Not available** | Defaults to 0 |
| `Filter` | From `Filter (condition)` nodes | Wrapped in `()` if needed |
| `Relation Name` | From `Relation spark_catalog.db.table[...]` | Table name only |
| `Hash Cond` | From `Join type, (condition)` | Column refs qualified with table names |
| `Join Type` | From `Join <type>` | e.g., `Inner`, `LeftOuter` |
| `Plans` | Children from indentation tree | Recursive |

### Column Reference Resolution

Spark uses `column#id` format (e.g., `PostId#83`). The converter resolves
these to `table.column` format by building a column → table map from
Relation node column lists:

```
PostId#83 = Id#19  →  (comments.PostId = posts.Id)
```

### Label Extraction

| Task | Field | Source |
|---|---|---|
| Time estimation | `Actual Total Time` (root) | `time cost: X ms` from header |
| Cardinality | `Actual Rows` (root) | `actual cardinality: Y` from header |

### Spark Limitations

- **No per-operator timing**: Only total query time is available
- **No per-operator actual rows**: Only root-level actual cardinality
- **No cost estimates**: Spark doesn't expose optimizer costs
- Baselines that depend on per-operator timing/cost (BAO, AIMeetsAI) will see
  zeros for these fields

### Post-processing

1. **Stats attachment**: statsOutput rows mapped to plan nodes via pre-order traversal
2. **Filter merging**: Filter nodes merged into child Relation/Join nodes
3. **Column qualification**: Join conditions get `table.column` format from column map
4. **Filter wrapping**: Filters wrapped in `()` for `condPipeline` compatibility
5. **Null replacement**: All `None` values replaced with `0.0`

---

## Dataset Statistics

| Engine | Files | Plans Written | Empty/Skipped | Errors |
|--------|-------|---------------|---------------|--------|
| Spark | 70,799 | 67,958 | 4 | 0 |

All workload: STATS (CEB benchmark)

## Pipeline Integration

### Files Modified

| File | Change |
|------|--------|
| `experiments/utilsTrain.py` | Added `'spark'` to `--db` choices |

### Files Created

| File | Purpose |
|------|---------|
| `experiments/convert_spark_plans.py` | Converts Spark .txt → CSV (self-contained, no external deps) |

### No Changes Needed

| File | Reason |
|------|--------|
| `evaluation/feature_extractor.py` | `extractNode()` already uses `.get()` with defaults; `traversePlan()` handles PG-style JSON |
| `evaluation/dataset_utils.py` | `get_costs()` uses `Actual Total Time` / `Actual Rows` (present in converted plans) |
| `experiments/sice_lib.py` (field categories section) | PostgreSQL field categories apply (same field names) |

### Usage

```bash
# Convert raw plans

python convert_spark_plans.py \
    --output_csv queryPlans/stats/spark/long_raw_spark_stats.csv

# Run LLM experiment
python train.py --db spark --workload stats --algo llm ...
```
