#!/usr/bin/env bash
# Run the ablation variants of SICE on one (system, workload) pair, matching
# the paper's ablation table:
#
#   pt_llm        PT LLM                       (pretrained LLM, no fine-tuning, no statistics)
#   ft_llm        FT LLM                       (fine-tuned LLM, no statistics)
#   price_concat  FT LLM + PRICE  (concat)     (original PRICE statistics encoder)
#   canon_concat  FT LLM + Canon  (concat)     (our canonicalization layer, concatenation fusion)
#   full          FT LLM + Canon  (cross-attn) (the full design: one-directional cross-attention)
#   bicross       FT LLM + Canon  (bi-cross-attn) (bidirectional ablation)
#   qf_canon      QF + Canon      (cross-attn) (QueryFormer replaces the LLM plan encoder)
#
# Usage:
#   bash experiment_scripts/run_ablations.sh <postgres|duckdb|spark> <workload> [variant]
#
#   variant: one of the seven above; omit to run all.
#
# Environment overrides: MODELS, SEEDS, EPOCHS, CUDA_VISIBLE_DEVICES (as run_main.sh).
set -euo pipefail

usage() { echo "Usage: bash $0 <postgres|duckdb|spark> <workload> [variant]"; exit 1; }
[[ $# -ge 2 ]] || usage
SYSTEM="$1"; WL="$2"
case "$SYSTEM" in postgres|duckdb|spark) ;; *) usage ;; esac
VARIANTS=(${3:-pt_llm ft_llm price_concat canon_concat full bicross qf_canon})

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."   # experiments/

export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:-0}
export PYTORCH_CUDA_ALLOC_CONF=${PYTORCH_CUDA_ALLOC_CONF:-expandable_segments:True}

MODELS=(${MODELS:-google/bert_uncased_L-2_H-256_A-4 sentence-transformers/all-MiniLM-L12-v2 google/bert_uncased_L-4_H-768_A-12})
SEEDS=(${SEEDS:-42})
EPOCHS=${EPOCHS:-30}

case "$WL" in
  syn|job|job_full) TRAIN_WL="job"; CANON="imdb" ;;
  *)                TRAIN_WL="$WL"; CANON="$WL" ;;
esac
DAT="../queryPlans/${CANON}/${SYSTEM}/"
[[ -d "$DAT" ]] || { echo "No plans at ${DAT} — download queryPlans first"; exit 1; }

BS=24; GRAD_ACCUM_ARGS=()
case "$WL" in tpch|tpcds) BS=4; GRAD_ACCUM_ARGS=(--grad_accum_steps 6) ;; esac

COMMON=(
  --dat_paths_train "$DAT" --dat_path_test "$DAT"
  --db "$SYSTEM" --workloads_train "$TRAIN_WL" --workload_test "$WL"
  --learning_rate 0.0001 --hid_units 2048 --train_ratio 1.0
  --quantification 4-bit
  --early_stop_patience 5 --early_stop_after_epoch 20 --checkpoint_interval 5
)
CANON_FLAGS=(--canon --canon_or --price_random_init)
PRICE_FLAGS=(--price_b --price_random_init)
SCHED=(--price_warmup_epochs 5 --freeze_llm_until_epoch 5)

run_one() {  # $1 variant  $2 model  $3 seed
  local V="$1" MODEL="$2" SEED="$3"
  local M1="${MODEL//\//-}"
  local OUT_DIR="results/${SYSTEM}/Train_${TRAIN_WL}_Test_${WL}"
  local LOG_DIR="logs/${SYSTEM}/Train_${TRAIN_WL}_Test_${WL}"
  mkdir -p "$OUT_DIR" "$LOG_DIR"
  local TAG="ablation_${V}_${M1}_seed${SEED}"
  local IO=(--log_file "${LOG_DIR}/${TAG}.log"
            --output_dir_qerror "${OUT_DIR}/${TAG}.csv"
            --output_dir_abs "${OUT_DIR}/${TAG}_abs.txt")
  echo "=== ablation ${V} | ${SYSTEM}/${WL} | ${MODEL} | seed ${SEED} ==="
  case "$V" in
    pt_llm)
      python train.py "${COMMON[@]}" "${IO[@]}" --seed "$SEED" \
        --algo llm --llm_mode inference --model_name "$MODEL" \
        --batch_size 64 --embed_size 1000 ;;
    ft_llm)
      python train.py "${COMMON[@]}" "${IO[@]}" --seed "$SEED" \
        --algo llm_finetune --llm_mode lora --model_name "$MODEL" \
        --batch_size "$BS" --num_epoch "$EPOCHS" "${GRAD_ACCUM_ARGS[@]}" ;;
    price_concat)
      python train.py "${COMMON[@]}" "${IO[@]}" --seed "$SEED" \
        --algo llm_price_finetune --llm_mode lora --model_name "$MODEL" \
        --batch_size "$BS" --num_epoch "$EPOCHS" "${GRAD_ACCUM_ARGS[@]}" \
        "${PRICE_FLAGS[@]}" --n_cross_layers 0 "${SCHED[@]}" ;;
    canon_concat)
      python train.py "${COMMON[@]}" "${IO[@]}" --seed "$SEED" \
        --algo llm_price_finetune --llm_mode lora --model_name "$MODEL" \
        --batch_size "$BS" --num_epoch "$EPOCHS" "${GRAD_ACCUM_ARGS[@]}" \
        "${CANON_FLAGS[@]}" --n_cross_layers 0 "${SCHED[@]}" ;;
    full)
      python train.py "${COMMON[@]}" "${IO[@]}" --seed "$SEED" \
        --algo llm_price_finetune --llm_mode lora --model_name "$MODEL" \
        --batch_size "$BS" --num_epoch "$EPOCHS" "${GRAD_ACCUM_ARGS[@]}" \
        "${CANON_FLAGS[@]}" --n_cross_layers 2 --cross_attn_direction one \
        --unified_window_pool "${SCHED[@]}" ;;
    bicross)
      python train.py "${COMMON[@]}" "${IO[@]}" --seed "$SEED" \
        --algo llm_price_finetune --llm_mode lora --model_name "$MODEL" \
        --batch_size "$BS" --num_epoch "$EPOCHS" "${GRAD_ACCUM_ARGS[@]}" \
        "${CANON_FLAGS[@]}" --n_cross_layers 2 --cross_attn_direction bi \
        --unified_window_pool "${SCHED[@]}" ;;
    qf_canon)
      # QueryFormer replaces the LLM plan encoder; Canon + cross-attention kept.
      # Model-independent (no LLM backbone), so it runs once per seed.
      python train.py "${COMMON[@]}" "${IO[@]}" --seed "$SEED" \
        --algo qf --baseline_price_cross \
        --learning_rate 0.001 --batch_size 64 --hid_units 256 \
        --num_epoch "$EPOCHS" "${CANON_FLAGS[@]}" ;;
    *) echo "Unknown variant: $V"; exit 1 ;;
  esac
}

for V in "${VARIANTS[@]}"; do
  for SEED in "${SEEDS[@]}"; do
    if [[ "$V" == "qf_canon" ]]; then
      run_one "$V" "qf" "$SEED"
    else
      for MODEL in "${MODELS[@]}"; do run_one "$V" "$MODEL" "$SEED"; done
    fi
  done
done
echo "Done. Ablation Q-error CDFs are under experiments/results/${SYSTEM}/."
