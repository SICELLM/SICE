#!/usr/bin/env bash
# Run the SICE main experiment: the full design (LLM plan embedding + Canon
# statistics embedding + one-directional cross-attention) on one database
# system, across the six workloads and the three paper backbones.
#
# Usage:
#   bash experiment_scripts/run_main.sh <postgres|duckdb|spark> [workload]
#
#   workload ∈ {tpch, tpcds, syn, job, job_full, stats}; omit to run all six.
#
# Environment overrides:
#   MODELS   space-separated HF model names   (default: the three paper backbones)
#   SEEDS    space-separated seeds            (default: 42)
#   EPOCHS   fine-tuning epochs               (default: 30)
#   CUDA_VISIBLE_DEVICES                      (default: 0)
#
# Query plans must be downloaded and extracted to queryPlans/ first (see README).
set -euo pipefail

usage() { echo "Usage: bash $0 <postgres|duckdb|spark> [workload]"; exit 1; }
[[ $# -ge 1 ]] || usage
SYSTEM="$1"
case "$SYSTEM" in postgres|duckdb|spark) ;; *) usage ;; esac
WORKLOADS=(${2:-tpch tpcds syn job job_full stats})

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."   # experiments/

export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:-0}
export PYTORCH_CUDA_ALLOC_CONF=${PYTORCH_CUDA_ALLOC_CONF:-expandable_segments:True}

MODELS=(${MODELS:-google/bert_uncased_L-2_H-256_A-4 sentence-transformers/all-MiniLM-L12-v2 google/bert_uncased_L-4_H-768_A-12})
SEEDS=(${SEEDS:-42})
EPOCHS=${EPOCHS:-30}

for WL in "${WORKLOADS[@]}"; do
  # IMDB-family workloads (syn / job / job_full) train on the generated IMDB
  # workload ("job" training split) and share the imdb plan directory.
  case "$WL" in
    syn|job|job_full) TRAIN_WL="job"; CANON="imdb" ;;
    *)                TRAIN_WL="$WL"; CANON="$WL" ;;
  esac
  DAT_TRAIN="../queryPlans/${CANON}/${SYSTEM}/"
  DAT_TEST="../queryPlans/${CANON}/${SYSTEM}/"
  if [[ ! -d "$DAT_TRAIN" ]]; then
    echo "[skip] no plans for ${SYSTEM}/${WL} (expected ${DAT_TRAIN}) — download queryPlans first"; continue
  fi

  # tpch / tpcds plans are long; keep the 24-plan effective batch via
  # micro-batch 4 + gradient accumulation 6 to fit 16 GB GPUs.
  BS=24; GRAD_ACCUM_ARGS=()
  case "$WL" in tpch|tpcds) BS=4; GRAD_ACCUM_ARGS=(--grad_accum_steps 6) ;; esac

  for MODEL in "${MODELS[@]}"; do
    M1="${MODEL//\//-}"
    for SEED in "${SEEDS[@]}"; do
      OUT_DIR="results/${SYSTEM}/Train_${TRAIN_WL}_Test_${WL}"
      LOG_DIR="logs/${SYSTEM}/Train_${TRAIN_WL}_Test_${WL}"
      mkdir -p "$OUT_DIR" "$LOG_DIR"
      TAG="sice_full_${M1}_b${BS}_cx2_seed${SEED}"
      echo "=== SICE full design | ${SYSTEM}/${WL} | ${MODEL} | seed ${SEED} ==="
      python train.py \
        --dat_paths_train "$DAT_TRAIN" --dat_path_test "$DAT_TEST" \
        --db "$SYSTEM" --workloads_train "$TRAIN_WL" --workload_test "$WL" \
        --algo llm_price_finetune --llm_mode lora \
        --model_name "$MODEL" \
        --learning_rate 0.0001 --batch_size "$BS" --hid_units 2048 \
        --train_ratio 1.0 --num_epoch "$EPOCHS" --seed "$SEED" \
        --quantification 4-bit \
        --canon --canon_or --price_random_init \
        --n_cross_layers 2 --cross_attn_direction one --unified_window_pool \
        --checkpoint_interval 5 \
        "${GRAD_ACCUM_ARGS[@]}" \
        --log_file "${LOG_DIR}/${TAG}.log" \
        --output_dir_qerror "${OUT_DIR}/${TAG}.csv" \
        --output_dir_abs "${OUT_DIR}/${TAG}_abs.txt"
    done
  done
done
echo "Done. Q-error CDFs are under experiments/results/${SYSTEM}/."
