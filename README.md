# SICE: A System-Independent Cost Estimator

This repository contains the code and data for **SICE** (**S**ystem-**I**ndependent **C**ost **E**stimator), an LLM-based query-cost estimation framework that applies directly across database systems.

SICE treats the query plan as *textual execution semantics*: an LLM embeds the plan text directly, so no hand-engineered, system-specific feature extractor is needed. Because plan text alone exposes little of the data distribution, a **predicate canonicalization layer** grounds the query's predicates in database statistics, producing a 512-dimensional **statistics embedding** that covers all filters, joins, and their Boolean combinations through two universal statistical interfaces. A **one-directional cross-attention** fuses the two: plan tokens attend to the (projected) statistics embedding before pooling, while the statistics embedding itself enters the final representation unaltered. A **budget-efficient model selection** algorithm picks the LLM backbone under a latency budget without fully fine-tuning every candidate.

All experiments run on Ubuntu 22.04 with CUDA-enabled NVIDIA GPUs.

---

## Repository Layout

```
SICE/
├── canon/                       # Canon predicate-canonicalization layer (ours)
│   ├── features_tool.py         #   Tokenization: multi-range filtering + operator-conditioned joining
│   ├── and_transformer.py       #   AND encoding of each DNF clause (adapts the vendored PRICE encoder)
│   ├── or_transformer.py        #   OR composition across clauses
│   ├── statistics/              #   Per-workload statistics + pretrained encoder weights (model/)
│   └── price/                   #   Vendored PRICE internals (see Citations)
├── evaluation/                  # Shared library: training loop, data loading, metrics, baselines
│   └── algorithms/              #   AiMeetsAi, Bao, E2E-Cost, QueryFormer, PostgreSQL
├── experiments/
│   ├── train.py                 # Main entry point
│   ├── sice_lib.py              # SICE library: models, Canon feature pipeline, datasets
│   ├── utilsLLM.py              # LLM wrappers, embedding generation
│   ├── utilsTrain.py            # CLI arguments and path setup
│   └── experiment_scripts/
│       ├── run_main.sh          # Main experiment (SICE full design, per system)
│       ├── run_baselines.sh     # The four prior cost estimators
│       ├── run_ablations.sh     # Ablation variants (per the paper's ablation table)
│       ├── run_model_selection.sh  # Model-selection experiment (no GPU needed)
│       ├── compare_round_pareto.py # Selection-strategy simulator (deployment regret)
│       ├── plot_model_selection.py # Regret-vs-time figures
│       ├── convert_duckdb_plans.py / convert_spark_plans.py  # Plan-collection tools
│       └── generate_price_stats_from_pg.py  # Regenerate statistics from a live PostgreSQL
├── data/model_selection/        # Candidate-pool tables (80 models × 3 workloads)
├── queries/                     # Workload SQL used by the canonicalization layer
├── queryPlans/                  # Query plans — downloaded separately (see Data Setup)
├── requirements.txt / setup_manual.sh / Dockerfile
└── README.md
```

---

## Environment Setup

| Option        | When to use                                                       |
| ------------- | ----------------------------------------------------------------- |
| **A. Manual** | You prefer a local/conda environment or need to tweak CUDA/Python |
| **B. Docker** | You want a plug-and-play environment with GPU support             |

### A. Manual installation

```bash
bash setup_manual.sh          # PyTorch 2.7.0 (cu128), Transformers 4.55.2, FlashAttention 2.8.3, ...
```

### B. Docker

```bash
docker build -t sice .
docker run --gpus all -it --shm-size 16g -v $(pwd):/workspace sice bash
```

### Model access

The three paper backbones — `google/bert_uncased_L-2_H-256_A-4` (BERT-2), `sentence-transformers/all-MiniLM-L12-v2` (SentBERT), and `google/bert_uncased_L-4_H-768_A-12` (BERT-4) — are public on Hugging Face; no token is required. If you swap in gated backbones (e.g., Llama), set `export HF_TOKEN="hf_xxx"`.

---

## Data Setup

1. **Query plans** (191 MB compressed, 2.8 GB extracted; required for training/evaluation): download `queryPlans.zip` from
   [this link](https://drive.google.com/file/d/1O7U8h4Ng9T-wWkaV_wIKr3C93K1hTDs5/view?usp=sharing)
   and extract it at the repository root — the archive contains a top-level `queryPlans/` folder (subdirectories `tpch/`, `tpcds/`, `imdb/`, `stats/`, each with `postgres/`, `duckdb/`, `spark/` plan CSVs). See `queryPlans/README.md`.
2. **Workload SQL** (shipped compressed; extracted automatically by `setup_manual.sh`, or manually):
   ```bash
   ```
3. **Statistics** ship in-repo under `canon/statistics/` (per-workload histograms, fanouts, and summaries), together with the pretrained statistics-encoder weights at `canon/statistics/model/`. To regenerate them from a live PostgreSQL instance, see `experiments/experiment_scripts/generate_price_stats_from_pg.py` (its `--queries_dir` expects per-query `.sql` files; regeneration is optional since the statistics ship in-repo).

To reproduce the query plans themselves from scratch (instead of downloading them), load the datasets into each DBMS and run the SQL in `queries/`: TPC-H and TPC-DS data come from the official TPC toolkits (https://www.tpc.org/), IMDB from the End-to-End Cost Estimator benchmark, and STATS from the End-to-End CardEst benchmark.

---

## Running the Experiments

All scripts live in `experiments/experiment_scripts/` and are run from anywhere; outputs land in `experiments/results/<system>/` (Q-error CDFs), `experiments/logs/`, and `experiments/results/model_selection/` (selection figures).

### 1. Main experiment (Table: overall accuracy per system)

```bash
bash experiments/experiment_scripts/run_main.sh postgres          # all six workloads
bash experiments/experiment_scripts/run_main.sh duckdb stats      # one workload
bash experiments/experiment_scripts/run_main.sh spark
```

Runs the SICE full design — `--algo llm_price_finetune --canon --canon_or --n_cross_layers 2 --cross_attn_direction one --unified_window_pool` — for the three backbones. All components (LoRA adapters, cross-attention, Canon, prediction MLP) train jointly from epoch 0, matching the paper protocol. Override backbones/seeds/epochs via `MODELS`, `SEEDS`, `EPOCHS` environment variables; select the GPU with `CUDA_VISIBLE_DEVICES`.

### 2. Prior methods

```bash
bash experiments/experiment_scripts/run_baselines.sh postgres
ALGOS="bao qf" bash experiments/experiment_scripts/run_baselines.sh duckdb job_full
```

### 3. Ablations (Table: ablation study)

```bash
bash experiments/experiment_scripts/run_ablations.sh postgres stats            # all 7 variants
bash experiments/experiment_scripts/run_ablations.sh duckdb job_full bicross   # one variant
```

Variants: `pt_llm`, `ft_llm`, `price_concat`, `canon_concat`, `full`, `bicross`, `qf_canon`.

### 4. Model selection (Figure: regret vs fine-tuning time)

```bash
bash experiments/experiment_scripts/run_model_selection.sh          # all three workloads; no GPU needed
```

This replays recorded fine-tuning trajectories from `data/model_selection/*_pool.csv`. Schema, one row per candidate LLM:

| column | meaning |
| --- | --- |
| `model` | Hugging Face model name |
| `params_m` | parameter count (millions) |
| `val_p90_e{4,8,12,16}` | validation p90 Q-error after 4/8/12/16 fine-tuning epochs |
| `test_p90_e16` | test p90 Q-error at full fidelity |
| `train_h_e{1_4,5_8,9_12,13_16}` | fine-tuning wall-clock per 4-epoch stage (H100 hours) |
| `inference_ms` | deployed per-query inference latency (ms) |

---

## Reproducibility Notes

- **Model-selection pool.** The shipped pool contains the **80 models common to all three workloads**. The paper's figures used the full per-workload pools (87–88 models), so regenerated curves differ slightly in magnitude; shapes and conclusions are unchanged.
- **Cross-attention implementation.** This repository implements the paper's one-directional design directly. It is mathematically equivalent to the configuration behind the published numbers (whose reverse-direction blocks were frozen at zero initialization, i.e., exact identities), but it is a fresh implementation — retraining from scratch can produce slightly different numbers than the published tables.

---

---

## Citations

Our statistics encoder builds on **PRICE**; we thank the authors:

```bibtex
@article{zeng2024price,
  title={PRICE: a pretrained model for cross-database cardinality estimation},
  author={Zeng, Tianjing and Lan, Junwei and Ma, Jiahong and Wei, Wenqing and Zhu, Rong and Li, Pengfei and Ding, Bolin and Lian, Defu and Wei, Zhewei and Zhou, Jingren},
  journal={arXiv preprint arXiv:2406.01027},
  year={2024}
}
```

The evaluation framework and baselines follow:

```bibtex
@article{DBLP:journals/pvldb/ZhaoLC23,
  author  = {Yue Zhao and Zhaodonghui Li and Gao Cong},
  title   = {A Comparative Study and Component Analysis of Query Plan Representation Techniques in {ML4DB} Studies},
  journal = {Proc. {VLDB} Endow.},
  volume  = {17}, number = {4}, pages = {823--835}, year = {2023},
  doi     = {10.14778/3636218.3636235}
}
```

Datasets: TPC-H and TPC-DS are generated with the official TPC toolkits (https://www.tpc.org/). The IMDB workload follows Sun & Li (VLDB 2019, doi 10.14778/3368289.3368296); STATS follows Han et al. (VLDB 2021, doi 10.14778/3503585.3503586).
