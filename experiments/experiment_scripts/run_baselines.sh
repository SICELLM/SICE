#!/usr/bin/env bash
# Run the four prior cost estimators (AiMeetsAi, Bao, E2E-Cost, QueryFormer)
# on one database system.
#
# Usage:
#   bash experiment_scripts/run_baselines.sh <postgres|duckdb|spark> [workload]
#
#   workload ∈ {tpch, tpcds, syn, job, job_full, stats}; omit to run all six.
#
# Environment overrides:
#   ALGOS   space-separated subset of: aimai bao e2e_cost qf postgres (default: the four learned baselines)
#   SEEDS   space-separated seeds (default: 42)
#   TASK    time | card (default: time)
#   CUDA_VISIBLE_DEVICES (default: 0)
set -euo pipefail

usage() { echo "Usage: bash $0 <postgres|duckdb|spark> [workload]"; exit 1; }
[[ $# -ge 1 ]] || usage
SYSTEM="$1"
case "$SYSTEM" in postgres|duckdb|spark) ;; *) usage ;; esac
WORKLOADS=(${2:-tpch tpcds syn job job_full stats})

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."   # experiments/

export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:-0}
DB_ENGINE="$SYSTEM"
NUM_EPOCH=${NUM_EPOCH:-30}
EARLY_STOP_PATIENCE=${EARLY_STOP_PATIENCE:-5}
EARLY_STOP_AFTER_EPOCH=${EARLY_STOP_AFTER_EPOCH:-20}

ALGOS=(${ALGOS:-aimai bao e2e_cost qf})
SEEDS=(${SEEDS:-42})
TASK=${TASK:-time}

# Map a workload name to its query-plan directory (the IMDB family shares one).
plan_dir() {
  case "$1" in
    syn|job|job_full) echo "../queryPlans/imdb/${DB_ENGINE}/" ;;
    *)                echo "../queryPlans/$1/${DB_ENGINE}/" ;;
  esac
}

# Train and evaluate one (train workload, test workload, ratio, seed, algo, task) cell.
run_one() {
  local TRAIN_WL="$1" TEST_WL="$2" RATIO="$3" SEED="$4" ALGO="$5" TASK="$6"

  # Algorithm-specific hyperparameters (each method's recommended setting).
  local hid_units lr batch_size
  case "$ALGO" in
    postgres) hid_units=99999999; lr=-1;     batch_size=99999999 ;;
    bao)      hid_units=256;      lr=0.001;  batch_size=16 ;;
    aimai)    hid_units=256;      lr=0.0001; batch_size=64 ;;
    qf)       hid_units=256;      lr=0.001;  batch_size=64 ;;
    e2e_cost) hid_units=256;      lr=0.001;  batch_size=64 ;;
    *) echo "Unknown algorithm: $ALGO. Supported: postgres, bao, aimai, qf, e2e_cost"; return 1 ;;
  esac

  if [[ "$TASK" == "card" && "$TEST_WL" != "job" && "$TEST_WL" != "syn" && "$TEST_WL" != "stats" ]]; then
    echo "Cardinality prediction only supported for job, syn, stats workloads"; return 1
  fi

  local CARD_ARG=""
  [[ "$TASK" == "card" ]] && CARD_ARG="--card"
  local VERBOSE_ARG=""
  [[ "${VERBOSE_INFO:-}" == "true" || "${VERBOSE_INFO:-}" == "True" ]] && VERBOSE_ARG="--verbose_info"
  local EARLY_STOP_ARG=""
  if [[ "${EARLY_STOP_PATIENCE}" -gt 0 ]]; then
    EARLY_STOP_ARG="--early_stop_patience $EARLY_STOP_PATIENCE"
    [[ "${EARLY_STOP_AFTER_EPOCH}" -gt 0 ]] && EARLY_STOP_ARG="$EARLY_STOP_ARG --early_stop_after_epoch $EARLY_STOP_AFTER_EPOCH"
  fi

  local RESULTS_DIR="results/${DB_ENGINE}" LOGS_DIR="logs/${DB_ENGINE}"
  local RUN_DIR="results_Train_${TRAIN_WL}_Test_${TEST_WL}_ours"
  local base_name="${TASK}_${ALGO}_${RATIO}_cdf_${DB_ENGINE}_${lr}_b${batch_size}_h${hid_units}_seed${SEED}"

  python train.py \
    --dat_paths_train "$(plan_dir "$TRAIN_WL")" \
    --dat_path_test "$(plan_dir "$TEST_WL")" \
    --output_dir_qerror "${RESULTS_DIR}/${RUN_DIR}/${base_name}.csv" \
    --output_dir_abs "${RESULTS_DIR}/${RUN_DIR}/${base_name}_abs.txt" \
    --log_file "${LOGS_DIR}/logs_Train_${TRAIN_WL}_Test_${TEST_WL}_ours/${base_name}.log" \
    --db "${DB_ENGINE}" \
    --workloads_train "$TRAIN_WL" \
    --workload_test "$TEST_WL" \
    --algo "$ALGO" \
    --num_epoch "${NUM_EPOCH}" \
    --learning_rate "$lr" \
    --batch_size "$batch_size" \
    --train_ratio "$RATIO" \
    --seed "$SEED" \
    $CARD_ARG $VERBOSE_ARG $EARLY_STOP_ARG
}

for WL in "${WORKLOADS[@]}"; do
  case "$WL" in
    syn|job|job_full) TRAIN_WL="job" ;;
    *)                TRAIN_WL="$WL" ;;
  esac
  for ALGO in "${ALGOS[@]}"; do
    for SEED in "${SEEDS[@]}"; do
      echo "=== baseline ${ALGO} | ${SYSTEM}/${WL} | seed ${SEED} ==="
      run_one "$TRAIN_WL" "$WL" 1.0 "$SEED" "$ALGO" "$TASK"
    done
  done
done
echo "Done. Baseline Q-error CDFs are under experiments/results/${SYSTEM}/."
