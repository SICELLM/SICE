# Query Plans Data

This folder holds the pre-generated query plans used in the SICE experiments.

## Download

Due to size constraints (191 MB compressed, 2.8 GB extracted), the query plans are hosted externally:

**Download**: [queryPlans.zip](https://drive.google.com/file/d/1O7U8h4Ng9T-wWkaV_wIKr3C93K1hTDs5/view?usp=sharing)

## Usage

1. Download the `queryPlans.zip` archive from the link above
2. Extract it at the repository root (the archive contains a top-level `queryPlans/` folder that merges with this directory):
   ```bash
   unzip queryPlans.zip -d /path/to/SICE
   ```
3. This folder should then contain one subdirectory per dataset:
   - `tpch/`
   - `tpcds/`
   - `imdb/`
   - `stats/`

   Each dataset directory holds shared workload metadata (`col_min_max.csv`, `histogram_string.csv`, `long_df_samples.npy`) and one plan-CSV subdirectory per database system (`postgres/`, `duckdb/`, `spark/`).

## Note

If you need to reproduce these query plans from scratch, see the "Reproducing Query Plans" section in the main README.
