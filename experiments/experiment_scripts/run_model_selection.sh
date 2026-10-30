#!/usr/bin/env bash
# Reproduce the model-selection experiment: worst-case deployment regret vs
# fine-tuning time for the four selection strategies, on the shipped 80-model
# candidate pools (data/model_selection/{tpch,tpcds,stats}_pool.csv).
#
# This replays recorded per-epoch accuracies and profiled latencies — no GPU
# and no model training required.
#
# Usage:
#   bash experiment_scripts/run_model_selection.sh [workload ...]
#     workload ∈ {tpch, tpcds, stats}; omit to run all three.
#
# Note: the shipped pools contain the 80 models common to all three workloads,
# so regenerated curves differ slightly in magnitude from the paper's figures
# (which used the full per-workload pools); shapes and conclusions match.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$REPO_ROOT/experiments"

if [[ $# -gt 0 ]]; then WORKLOADS=("$@"); else WORKLOADS=(tpch tpcds stats); fi

declare -A TITLES=( [tpch]="TPC-H" [tpcds]="TPC-DS" [stats]="STATS" )

for WL in "${WORKLOADS[@]}"; do
  POOL="$REPO_ROOT/data/model_selection/${WL}_pool.csv"
  [[ -f "$POOL" ]] || { echo "Missing pool CSV: $POOL"; exit 1; }
  echo "=== model selection | ${WL} ==="
  mkdir -p "$REPO_ROOT/experiments/results/model_selection"
  python experiment_scripts/plot_model_selection.py \
    --pool_csv "$POOL" \
    --tmpdir "/tmp/model_selection_regret_${WL}" \
    --output "$REPO_ROOT/experiments/results/model_selection/model_selection_${WL}.png" \
    --title "${TITLES[$WL]} workload: regret vs fine-tuning time"
done
echo "Done. Figures: experiments/results/model_selection/model_selection_{tpch,tpcds,stats}.{png,pdf}"
