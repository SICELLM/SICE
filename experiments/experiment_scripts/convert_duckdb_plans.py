#!/usr/bin/env python3
"""Convert DuckDB query plan .txt files from zip archives into CSV format.

Reads results_duckdb_{imdb,stats}.zip from --input_dir and produces CSV files
in queryPlans/{imdb,stats}/duckdb/ matching the postgres CSV naming convention.

Each CSV has columns: id,json
"""
import csv
import json
import os
import re
import zipfile
from collections import defaultdict

DUCKDB_QP_DIR = os.environ.get("DUCKDB_QP_DIR", "")  # set via --input_dir or env
QUERY_PLANS_DIR = os.path.join(os.path.dirname(__file__), "..", "queryPlans")

# Map file prefix patterns to (database_dir, csv_suffix)
# Order matters: longer prefixes must come first to avoid partial matches
IMDB_PATTERNS = [
    (r"imdb_job_full_sub_(\d+)_run0\.txt", "imdb", "imdb_job_full_sub_selected"),
    (r"imdb_job_full_(\d+)_run0\.txt",     "imdb", "imdb_job_full"),
    (r"imdb_job_sub_(\d+)_run0\.txt",      "imdb", "imdb_job_sub"),
    (r"imdb_job_(\d+)_run0\.txt",          "imdb", "imdb_job"),
    (r"imdb_syn_sub_(\d+)_run0\.txt",      "imdb", "imdb_syn_sub"),
    (r"imdb_syn_(\d+)_run0\.txt",          "imdb", "imdb_syn"),
    (r"imdb_(\d+)_run0\.txt",              "imdb", "imdb"),
]

STATS_PATTERNS = [
    (r"stats_statsCEB_sub_(\d+)_run0\.txt", "stats", "stats_statsCEB_sub"),
    (r"stats_statsCEB_(\d+)_run0\.txt",     "stats", "stats_statsCEB"),
    (r"stats_(\d+)_run0\.txt",              "stats", "stats"),
]


def classify_file(filename, patterns):
    """Classify a filename into its workload variant and extract the query ID."""
    basename = os.path.basename(filename)
    for pattern, db_dir, csv_suffix in patterns:
        m = re.match(pattern, basename)
        if m:
            query_id = int(m.group(1))
            return db_dir, csv_suffix, query_id
    return None, None, None


def process_zip(zip_path, patterns):
    """Extract all plan files from a zip and group by workload variant."""
    groups = defaultdict(list)  # (db_dir, csv_suffix) -> [(query_id, json_str)]

    with zipfile.ZipFile(zip_path, 'r') as zf:
        for info in zf.infolist():
            if info.is_dir():
                continue
            db_dir, csv_suffix, query_id = classify_file(info.filename, patterns)
            if db_dir is None:
                print(f"  Skipping unrecognized file: {info.filename}")
                continue
            try:
                data = zf.read(info.filename)
                # Validate it's valid JSON
                json.loads(data)
                groups[(db_dir, csv_suffix)].append((query_id, data.decode('utf-8').strip()))
            except (json.JSONDecodeError, UnicodeDecodeError) as e:
                print(f"  Error reading {info.filename}: {e}")

    return groups


def write_csv(db_dir, csv_suffix, entries):
    """Write entries to a CSV file in the queryPlans directory."""
    out_dir = os.path.join(QUERY_PLANS_DIR, db_dir, "duckdb")
    os.makedirs(out_dir, exist_ok=True)

    csv_name = f"long_raw_duckdb_{csv_suffix}.csv"
    csv_path = os.path.join(out_dir, csv_name)

    # Sort by query_id for deterministic output
    entries.sort(key=lambda x: x[0])

    with open(csv_path, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['id', 'json'])
        for i, (query_id, json_str) in enumerate(entries, 1):
            # Compact JSON (single line) to match postgres format
            compact = json.dumps(json.loads(json_str), separators=(',', ':'))
            writer.writerow([i, compact])

    print(f"  Wrote {csv_path}: {len(entries)} queries")
    return csv_path


def main():
    import argparse
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--input_dir", default=DUCKDB_QP_DIR or None, required=not DUCKDB_QP_DIR,
                    help="Directory containing results_duckdb_{imdb,stats}.zip")
    args = ap.parse_args()
    input_dir = args.input_dir

    # Process IMDB zip
    imdb_zip = os.path.join(input_dir, "results_duckdb_imdb.zip")
    if os.path.exists(imdb_zip):
        print(f"Processing {imdb_zip}...")
        groups = process_zip(imdb_zip, IMDB_PATTERNS)
        for (db_dir, csv_suffix), entries in sorted(groups.items()):
            write_csv(db_dir, csv_suffix, entries)
    else:
        print(f"Not found: {imdb_zip}")

    # Process Stats zip
    stats_zip = os.path.join(input_dir, "results_duckdb_stats.zip")
    if os.path.exists(stats_zip):
        print(f"Processing {stats_zip}...")
        groups = process_zip(stats_zip, STATS_PATTERNS)
        for (db_dir, csv_suffix), entries in sorted(groups.items()):
            write_csv(db_dir, csv_suffix, entries)
    else:
        print(f"Not found: {stats_zip}")

    print("\nDone!")


if __name__ == "__main__":
    main()
