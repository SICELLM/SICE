"""SICE training entry point.

Builds the requested estimator (SICE = LLM plan embedding + 512-d Canon statistics
embedding fused by one-directional cross-attention; ablation variants: concat /
bidirectional / PRICE-B statistics; prior baselines) and runs training + evaluation.
Invoked by the run scripts in experiment_scripts/; see README for usage.
"""
import os
import re
import pandas as pd
import torch
import sys
import torch.nn as nn
import argparse
import torch.nn.init as init
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader, TensorDataset
import utilsTrain
from huggingface_hub import HfApi, login
# Ensure experiments/ dir is on path (for sice_lib and utilsTrain)
_this_dir = os.path.dirname(os.path.abspath(__file__))
if _this_dir not in sys.path:
    sys.path.insert(0, _this_dir)
sys.path.append('../evaluation/')
from dataset_utils import *
from time import time as timer
import numpy as np
import csv


def _price_dims(argsP, bin_size):
    """Return (filter_dim, fanout_dim, pairwise_intra_dim) per active flags.

    NOTE: Sql2FeatureN always emits 75-dim filter and 42-dim fanout tokens
    regardless of which PRICE_N sub-flag is set. So if any PRICE_N flag is
    on, both dims must use Sql2FeatureN's shape — the sub-flags only gate
    which atoms are populated, not the token shape.
    """
    use_price_n = any([
        getattr(argsP, "price_n_filter", False),
        getattr(argsP, "price_n_fanout", False),
        getattr(argsP, "price_n_pairwise", False),
        getattr(argsP, "price_n_parsing", False),
    ])
    if use_price_n:
        filter_dim = bin_size + 3 * 11 + 2          # 75
        fanout_dim = bin_size + 2                   # 42
    else:
        filter_dim = bin_size + 3                   # 43 (PRICE_S or base PRICE)
        fanout_dim = bin_size                       # 40

    pairwise_intra_dim = (64 + 2 * 3) if getattr(argsP, "price_n_pairwise", False) else 0   # 70
    return filter_dim, fanout_dim, pairwise_intra_dim


def _price_path_suffix(argsP):
    """Statistics-encoder suffix: priceB (original PRICE) / canon (ours), plus DNF flags."""
    parts = []
    if getattr(argsP, 'price_b', False):           parts.append("priceB")
    # Canon sub-flags: collapse to a single "canon" token when all four are
    # set (the common case after the --price_n shorthand) — keeps filenames
    # under the ext4 255-byte limit. Otherwise emit only the active subset.
    _pn = (getattr(argsP, 'price_n_filter', False),
           getattr(argsP, 'price_n_fanout', False),
           getattr(argsP, 'price_n_pairwise', False),
           getattr(argsP, 'price_n_parsing', False))
    if all(_pn):
        parts.append("canon")
    else:
        if _pn[0]: parts.append("canonFlt")
        if _pn[1]: parts.append("canonFan")
        if _pn[2]: parts.append("canonPw")
        if _pn[3]: parts.append("canonPrs")
    if getattr(argsP, 'price_n_or', False):        parts.append("canonOr")
    # Default for max_clauses is 16 — only emit if non-default
    mc = getattr(argsP, 'price_n_or_max_clauses', 16)
    if mc != 16:
        parts.append(f"mc{mc}")
    # NOTE: deliberately omit price_max_n_pairwise_intra from the suffix.
    # That value is overridden at data-load time (utilsLLM.py) to the observed
    # max_n_pairwise_intra in the batch, which fires AFTER the LLM weight path
    # is constructed in inference but BEFORE the save path is constructed at
    # train end — producing inconsistent suffixes.  The pairwise dim is
    # baked into the saved tensor shapes; PyTorch's weight loader will surface
    # a clear shape-mismatch error if train/inference data disagree.
    return ("_" + "_".join(parts)) if parts else ""


def _arch_path_suffix(argsP):
    """Architecture-flag suffix: fusion modes, freezing, gates, residual toggle."""
    parts = []
    # OR Transformer ablation toggle
    if getattr(argsP, 'no_or_transformer', False):
        parts.append("noORt")
    # LLM residual toggle (new)
    if getattr(argsP, 'no_llm_residual', False):
        parts.append("noLLMres")
    # Fusion: cross-attention is active for llm_price_finetune with cx>0.
    _cx_active = (getattr(argsP, 'algo', '') == 'llm_price_finetune'
                  and getattr(argsP, 'n_cross_layers', 0) > 0)
    if _cx_active:
        if getattr(argsP, 'cross_attn_direction', 'one') == 'bi':
            parts.append("biCrossAttn")
        else:
            parts.append("crossAttn")
    if getattr(argsP, 'refined_pool', False):                 parts.append("refinedPool")
    # Other architecture toggles
    if getattr(argsP, 'freeze_all_price', False):             parts.append("freezeAllPRICE")
    if getattr(argsP, 'freeze_price_encoder', False):         parts.append("freezePRICEenc")
    # Hyperparameter overrides only when non-default
    if getattr(argsP, 'freeze_llm_until_epoch', 0) > 0:
        parts.append(f"frzLLM{argsP.freeze_llm_until_epoch}")
    n_cross = getattr(argsP, 'n_cross_layers', 2)
    if n_cross != 2 and _cx_active:
        parts.append(f"cx{n_cross}")
    ca_drop = getattr(argsP, 'cross_attn_dropout', 0.1)
    if ca_drop != 0.1 and _cx_active:
        # e.g. drop0.3, drop0.5
        parts.append(f"drop{ca_drop:g}")
    if getattr(argsP, 'unified_window_pool', False) and _cx_active:
        parts.append("unifPool")
    pod = getattr(argsP, 'price_output_dim', 0)
    if pod and pod > 0:
        parts.append(f"pod{pod}")
    nl = getattr(argsP, 'price_n_layers', 6)
    if nl != 6:
        parts.append(f"nl{nl}")
    fr = getattr(argsP, 'price_ffn_ratio', 4.0)
    if fr != 4.0:
        parts.append(f"fr{fr}")
    # OR-Transformer config — emit only when --price_n_or is active and the
    # value is non-default (default = the new minimal config: 1 layer, 4 heads,
    # ffn_ratio 1.0). Lets you A/B different OR-Transformer sizes without
    # path collisions.
    if getattr(argsP, 'price_n_or', False):
        or_nl = getattr(argsP, 'or_n_layers', 1)
        if or_nl != 1:
            parts.append(f"orNL{or_nl}")
        or_nh = getattr(argsP, 'or_n_heads', 4)
        if or_nh != 4:
            parts.append(f"orNH{or_nh}")
        or_fr = getattr(argsP, 'or_ffn_ratio', 1.0)
        if or_fr != 1.0:
            parts.append(f"orFR{or_fr:g}")
    # Schedule overrides (only when --price_random_init is on, since that's
    # when the price-warmup→2e-5 schedule actually fires).
    if getattr(argsP, 'price_random_init', False):
        pwm = getattr(argsP, 'price_warmup_epochs', 0)
        if pwm != 0:
            parts.append(f"pwm{pwm}")
        plr = getattr(argsP, 'price_warmup_lr', None)
        if plr is not None and plr != 1e-3:
            parts.append(f"pLR{plr:g}")
    return ("_" + "_".join(parts)) if parts else ""


argsP = utilsTrain.parse_args()

# --price_lr / --price_warmup_lr share argparse dest 'price_warmup_lr', but
# trainer.py's random-init scheduler (and the optimizer's PRICE base lr) read
# argsP.price_lr — which argparse never creates. Without this alias the CLI flag
# is dead in that path (PRICE base lr silently falls back to 1e-3). Alias them so
# --price_lr actually pins the PRICE warmup base lr (e.g. flat 2e-5 when the
# warmup lr == the post-warmup _finetune_lr=2e-5). Only affects runs that pass it.
if getattr(argsP, 'price_warmup_lr', None) is not None:
    argsP.price_lr = argsP.price_warmup_lr

# --no_llm_residual reroute: must happen BEFORE data-loader construction so
# the PRICE-only path (PriceOnlyDataset + price_only_collate) is selected
# instead of LLMPriceDataset (which would feed an 8-tuple including raw texts
# into PRICEFinetunWrapper and break with "list has no attribute 'size'").
# We deliberately leave argsP.card alone — forcing card=True breaks tpcds/tpch
# (those workloads only support time prediction in utilsTrain.prepare_paths).
if getattr(argsP, 'no_llm_residual', False) and argsP.algo == "llm_price_finetune":
    print("[no_llm_residual] Rerouting algo: llm_price_finetune → price_finetune")
    argsP.algo = "price_finetune"

if getattr(argsP, 'baseline_price_cross', False):
    if argsP.algo != "qf":
        raise SystemExit("--baseline_price_cross requires --algo qf (only QueryFormer "
                         "produces a token sequence to cross-attend)")
    if argsP.card:
        raise SystemExit("--baseline_price_cross is time-only for now (no --card)")
    if getattr(argsP, 'baseline_price_concat', False):
        raise SystemExit("--baseline_price_cross and --baseline_price_concat are mutually exclusive")
    # Tag result CSV + log stems with _priceCross so a cross-attn run never collides
    # with the plain-baseline or the _priceConcat cell.
    def _bpx_tag(p, tag="_priceCross"):
        if not p:
            return p
        _stem, _ext = os.path.splitext(p)
        return f"{_stem}{tag}{_ext}" if tag not in _stem else p
    if getattr(argsP, 'output_dir_qerror', None):
        argsP.output_dir_qerror = _bpx_tag(argsP.output_dir_qerror)
    if getattr(argsP, 'log_file', None):
        argsP.log_file = _bpx_tag(argsP.log_file)
if getattr(argsP, 'baseline_price_concat', False):
    if argsP.algo not in ("qf", "aimai", "e2e_cost", "bao"):
        raise SystemExit("--baseline_price_concat requires --algo qf|aimai|e2e_cost|bao")
    if argsP.card:
        raise SystemExit("--baseline_price_concat is time-only for now (no --card)")
    # Tag the result CSV + log stems so a joint (base+PRICE) run never overwrites
    # the plain-baseline cdf cell / log. Insert "_priceConcat" before the suffix.
    def _bp_tag_path(p, tag="_priceConcat"):
        if not p:
            return p
        _stem, _ext = os.path.splitext(p)
        return f"{_stem}{tag}{_ext}" if tag not in _stem else p
    if getattr(argsP, 'output_dir_qerror', None):
        argsP.output_dir_qerror = _bp_tag_path(argsP.output_dir_qerror)
    if getattr(argsP, 'log_file', None):
        argsP.log_file = _bp_tag_path(argsP.log_file)

# Global subdir component: inserted into every finetuned_models/{db}/<_GSUB>/... path
# when --subdir_tag is set (e.g. "model_selection"). Empty string otherwise.
_GSUB = f"/{argsP.subdir_tag}" if getattr(argsP, 'subdir_tag', '') else ""
log_dir = os.path.dirname(argsP.log_file)
os.makedirs(log_dir, exist_ok=True)

# Only create inference logger for LLM algorithms
if "llm" in argsP.algo:
    main_logger, inference_logger = utilsTrain.setup_loggers(argsP.log_file, argsP.log_file.replace(".log", "_inference.log"))
    argsP.main_logger = main_logger
    argsP.inference_logger = inference_logger
else:
    main_logger, inference_logger = utilsTrain.setup_loggers(argsP.log_file)
    argsP.main_logger = main_logger
    argsP.inference_logger = None

# Get Hugging Face token from environment variable
token = os.getenv("HF_TOKEN")

# Hugging Face auth is only needed for gated models; the paper's backbones
# (BERT-2, SentBERT, BERT-4) are public. If a token is provided, log in with
# it; otherwise proceed and let the model download fail naturally if gated.
if token and "llm" in argsP.algo:
    try:
        login(token=token)  # caches the token locally
    except Exception as _e:
        print(f"[HF] login with HF_TOKEN failed ({_e}); continuing without auth")


db = argsP.db
dat_path = argsP.dat_path_test
dat_paths_train_list, dat_path_test, dat_dict = utilsTrain.prepare_paths(argsP)

if argsP.algo not in ("llm_finetune", "llm_price_finetune", "price_finetune"):
    output_dir = os.path.dirname(argsP.output_dir_qerror)
    if not os.path.exists(output_dir):
        os.makedirs(output_dir, exist_ok=True)

# --retrain_mlp was removed 2026-05-11. Mode 7/12 inference now caches the
# post-PRICE + post-cross-attn combined embeddings by default in
# get_embeddings(); subsequent runs skip LLM forward, PRICE encoder, AND
# cross-attn fusion, then train a fresh MLP head on the cached combined
# features.

# Print CUDA availability (optional, for verification)
print(f"Cuda available? {torch.cuda.is_available()}")
if "llm" in argsP.algo:
  if not argsP.embeddings_exist:
    from utilsLLM import QueryPlanDataset, QueryPlanPredictor, get_llm_ds_from_csv
    
    LLM = QueryPlanPredictor(
        argsP.model_name,
        argsP.llm_mode,
        use_sliding_window=True,
        window_stride_ratio=0.8,
        quantification=argsP.quantification
    )
    device = LLM.model.device if hasattr(LLM.model, 'device') else torch.device("cuda" if torch.cuda.is_available() else "cpu")
    LLM.to(device)
    # Configure stats token injection settings (if enabled)
    LLM.stats_token_dim = int(getattr(argsP, "stats_token_dim", 5))
    LLM.stats_token_str = getattr(argsP, "stats_token_str", "[STAT]")
    if argsP.algo == "llm_price" and argsP.llm_pretrained:
      # Load finetuned LLM weights — source depends on price_weights_source
      task_str = "card" if argsP.card else "time"
      pws = getattr(argsP, 'price_weights_source', 'joint')
      ft_bs = getattr(argsP, 'ft_batch_size', 16)
      _price_suffix = _price_path_suffix(argsP)
      if pws == "joint":
        # Joint finetuning: LLM weights saved with _llm_price_llm suffix.
        # Per-seed path — matches the per-seed save in train.py:1376 and the
        # PRICE-side loader in utilsLLM._load_price_embedder.
        _arch_suffix = _arch_path_suffix(argsP)
        rand_init_suffix = "_randInit" if getattr(argsP, 'price_random_init', False) else ""
        ft_epochs = getattr(argsP, 'ft_num_epoch', 0)
        epoch_suffix = f"_e{ft_epochs}" if ft_epochs > 0 else ""
        seed_suffix = (f"_seed{int(argsP.seed)}"
                       if getattr(argsP, 'seed', None) is not None else "")
        llm_path = f"finetuned_models/{argsP.db}{_GSUB}/{argsP.canonical_wl_prefix}_{task_str}_{argsP.llm_pretrained}_{argsP.model_name.replace('/','-')}_b{ft_bs}{_price_suffix}_llm_price{_arch_suffix}{rand_init_suffix}{epoch_suffix}{seed_suffix}_llm.pt"
      else:
        # Standalone LLM finetune: weights saved with _llm suffix
        llm_path = f"finetuned_models/{argsP.db}{_GSUB}/{argsP.canonical_wl_prefix}_{task_str}_{argsP.llm_pretrained}_{argsP.model_name.replace('/','-')}_b{ft_bs}_llm.pt"
      state_dict = torch.load(llm_path, map_location=device)
      try:
        result = LLM.model.load_state_dict(state_dict, strict=False)
        # Diagnostic: detect silent failures from key mismatches
        n_loaded = len(state_dict) - len(result.unexpected_keys)
        print(f"[LLM weight load] Keys in state_dict: {len(state_dict)}, loaded: {n_loaded}, "
              f"missing: {len(result.missing_keys)}, unexpected: {len(result.unexpected_keys)}")
        if len(result.unexpected_keys) > 0:
          print(f"[LLM weight load] WARNING: {len(result.unexpected_keys)} unexpected keys (first 5): {result.unexpected_keys[:5]}")
        if n_loaded == 0:
          print(f"[LLM weight load] ERROR: No keys loaded! Model keys and state_dict keys may have different prefixes.")
          print(f"  Model key sample: {list(LLM.model.state_dict().keys())[:3]}")
          print(f"  State dict key sample: {list(state_dict.keys())[:3]}")
      except RuntimeError as e:
        raise
      print(f"Loaded LLM weights from {llm_path} (price_weights_source={pws})")
    elif argsP.algo == "llm" and argsP.llm_pretrained:
      stats_suffix = ""
      if getattr(argsP, "stats_token_inject", False):
        stats_mode = getattr(argsP, "stats_token_mode", "per_column")
        stats_suffix = f"_statTok-{stats_mode}"
      ft_bs = getattr(argsP, 'ft_batch_size', 16)
      llm_path = f"finetuned_models/{argsP.db}{_GSUB}/{argsP.canonical_wl_prefix}_{argsP.llm_pretrained_task}_{argsP.llm_pretrained}_{argsP.model_name.replace('/','-')}_b{ft_bs}{stats_suffix}_llm.pt"
      state_dict = torch.load(llm_path, map_location=device)
      try:
        result = LLM.model.load_state_dict(state_dict, strict=False)
        n_loaded = len(state_dict) - len(result.unexpected_keys)
        print(f"[LLM weight load] Keys in state_dict: {len(state_dict)}, loaded: {n_loaded}, "
              f"missing: {len(result.missing_keys)}, unexpected: {len(result.unexpected_keys)}")
        if len(result.unexpected_keys) > 0:
          print(f"[LLM weight load] WARNING: {len(result.unexpected_keys)} unexpected keys (first 5): {result.unexpected_keys[:5]}")
        if n_loaded == 0:
          print(f"[LLM weight load] ERROR: No keys loaded! Model keys and state_dict keys may have different prefixes.")
          print(f"  Model key sample: {list(LLM.model.state_dict().keys())[:3]}")
          print(f"  State dict key sample: {list(state_dict.keys())[:3]}")
      except RuntimeError as e:
        # Common case: stats token added during finetune, tokenizer size mismatch
        if "size mismatch" in str(e) and "tok_embeddings.weight" in str(e):
          try:
            LLM._ensure_stats_token(getattr(argsP, "stats_token_str", "[STAT]"))
            LLM.model.load_state_dict(state_dict, strict=False)
          except Exception:
            raise
        else:
          raise
      print(f"Loaded LLM weights from {llm_path}")
  else:
    LLM = None


# Set up device and seed
device = 'cuda' if torch.cuda.is_available() else 'cpu'
argsP.device = device
torch.manual_seed(argsP.seed)
torch.cuda.manual_seed_all(argsP.seed)
torch.backends.cudnn.deterministic = True
torch.backends.cudnn.benchmark = False

# --deterministic_algorithms: opt-in full PyTorch determinism. Without this,
# CUDA matmul/attention reductions are non-deterministic across runs (silent).
# This flag forces deterministic algorithms — useful for diagnosing whether
# observed cross-architecture differences come from non-determinism or are
# structural. Slows training somewhat. Off by default; set --deterministic_algorithms
# to enable. Reversible at any time by removing the CLI flag.
if getattr(argsP, 'deterministic_algorithms', False):
    os.environ.setdefault("CUBLAS_WORKSPACE_CONFIG", ":4096:8")
    torch.use_deterministic_algorithms(True, warn_only=True)
    print("[determinism] use_deterministic_algorithms(True, warn_only=True); "
          "CUBLAS_WORKSPACE_CONFIG=:4096:8")

def llm_collate(batch):
    # batch is a list of tuples:
    # - (text, cost) OR (text, stats_vecs, cost)
    if len(batch[0]) == 3:
        texts, stats_vecs, costs = zip(*batch)
        costs_tensor = torch.tensor(
            costs, dtype=torch.float32, device=device
        ).unsqueeze(1)
        return (list(texts), list(stats_vecs)), costs_tensor
    texts, costs = zip(*batch)
    costs_tensor = torch.tensor(
        costs, dtype=torch.float32, device=device
    ).unsqueeze(1)
    return list(texts), costs_tensor

def _batch_llm_inputs(texts):
    """Batch the LLMPriceDataset 'texts' column: keep it a list for the
    LLM tokenizer."""
    return list(texts)


def llm_price_collate(batch):
    """Collate function for LLMPriceDataset.
    Each item: (text_or_emb, price_feat, pad_mask, njc, nfo, ntb, nfc, label)
    Returns: ((texts_or_embs, price_feats, pad_masks, njcs, nfos, ntbs, nfcs), labels_tensor)
    """
    texts, pf, pm, njc, nfo, ntb, nfc, labels = zip(*batch)
    labels_tensor = torch.tensor(labels, dtype=torch.float32, device=device).unsqueeze(1)
    price_feats = torch.stack([f if isinstance(f, torch.Tensor) else torch.tensor(f, dtype=torch.float32) for f in pf]).float().to(device)
    pad_masks = torch.stack([m if isinstance(m, torch.Tensor) else torch.tensor(m) for m in pm]).float().to(device)
    njcs = torch.tensor(njc, dtype=torch.float32, device=device).unsqueeze(1)
    nfos = torch.tensor(nfo, dtype=torch.float32, device=device).unsqueeze(1)
    ntbs = torch.tensor(ntb, dtype=torch.float32, device=device).unsqueeze(1)
    nfcs = torch.tensor(nfc, dtype=torch.float32, device=device).unsqueeze(1)
    return (_batch_llm_inputs(texts), price_feats, pad_masks, njcs, nfos, ntbs, nfcs), labels_tensor


def llm_price_or_collate(batch):
    """Collate function for LLMPriceDataset under --price_n_or (multi-clause DNF).
    Each item: (text, price_feat, pad_mask, njc, nfo, ntb, nfc, num_clauses_i, label)
        where price_feat has shape (max_clauses, flat_size) and pad_mask matches
        (max_clauses, mask_len) — the dataset stores per-query packed tensors.
    Returns: ((texts, price_feats, pad_masks, njcs, nfos, ntbs, nfcs, num_clauses), labels_tensor)
        where price_feats is reshaped to (batch * max_clauses, flat_size) — the
        flat layout RegressionModel.forward expects in multi-clause mode.
    """
    texts, pf, pm, njc, nfo, ntb, nfc, nc, labels = zip(*batch)
    labels_tensor = torch.tensor(labels, dtype=torch.float32, device=device).unsqueeze(1)
    # Each pf[i]/pm[i] is (max_clauses, *) → stack gives (batch, max_clauses, *).
    price_feats = torch.stack([f if isinstance(f, torch.Tensor) else torch.tensor(f, dtype=torch.float32) for f in pf]).float().to(device)
    pad_masks = torch.stack([m if isinstance(m, torch.Tensor) else torch.tensor(m) for m in pm]).float().to(device)
    njcs = torch.tensor(njc, dtype=torch.float32, device=device).unsqueeze(1)
    nfos = torch.tensor(nfo, dtype=torch.float32, device=device).unsqueeze(1)
    ntbs = torch.tensor(ntb, dtype=torch.float32, device=device).unsqueeze(1)
    nfcs = torch.tensor(nfc, dtype=torch.float32, device=device).unsqueeze(1)
    num_clauses = torch.tensor(nc, dtype=torch.long, device=device)
    # Flatten (batch, max_clauses, *) → (batch * max_clauses, *) for both
    # the feature tensor (3D) and the padding mask (3D).
    if price_feats.dim() == 3:
        bsz, max_c, flat_size = price_feats.shape
        price_feats = price_feats.view(bsz * max_c, flat_size)
    if pad_masks.dim() == 3:
        bsz, max_c, mask_len = pad_masks.shape
        pad_masks = pad_masks.view(bsz * max_c, mask_len)
    return (_batch_llm_inputs(texts), price_feats, pad_masks, njcs, nfos, ntbs, nfcs, num_clauses), labels_tensor

def price_only_collate(batch):
    """Collate function for PriceOnlyDataset.
    Each item: (price_feat, pg_est_card, pad_mask, njc, nfo, ntb, nfc, label)
    Returns: ((price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs), labels_tensor)
    """
    pf, pgc, pm, njc, nfo, ntb, nfc, labels = zip(*batch)
    labels_tensor = torch.tensor(labels, dtype=torch.float32, device=device).unsqueeze(1)
    price_feats = torch.stack([f if isinstance(f, torch.Tensor) else torch.tensor(f, dtype=torch.float32) for f in pf]).float().to(device)
    # pg_est_card: apply log(pg_est_card+1)+1 normalization
    pgc_raw = torch.tensor(pgc, dtype=torch.float32, device=device).unsqueeze(1)
    pg_est_cards = torch.log(pgc_raw + 1) + 1
    pad_masks = torch.stack([m if isinstance(m, torch.Tensor) else torch.tensor(m) for m in pm]).float().to(device)
    njcs = torch.tensor(njc, dtype=torch.float32, device=device).unsqueeze(1)
    nfos = torch.tensor(nfo, dtype=torch.float32, device=device).unsqueeze(1)
    ntbs = torch.tensor(ntb, dtype=torch.float32, device=device).unsqueeze(1)
    nfcs = torch.tensor(nfc, dtype=torch.float32, device=device).unsqueeze(1)
    return (price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs), labels_tensor


def price_or_collate(batch):
    """Collate function for PriceOnlyDataset with --price_n_or (multi-clause DNF).
    Each item: (price_feat, pg_est_card, pad_mask, njc, nfo, ntb, nfc, num_clauses_i, label)
    Returns: ((price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs, num_clauses), labels_tensor)
    where price_feats has shape (batch * max_n_clauses, flat_size).
    """
    pf, pgc, pm, njc, nfo, ntb, nfc, nc, labels = zip(*batch)
    labels_tensor = torch.tensor(labels, dtype=torch.float32, device=device).unsqueeze(1)
    price_feats = torch.stack([f if isinstance(f, torch.Tensor) else torch.tensor(f, dtype=torch.float32) for f in pf]).float().to(device)
    pgc_raw = torch.tensor(pgc, dtype=torch.float32, device=device).unsqueeze(1)
    pg_est_cards = torch.log(pgc_raw + 1) + 1
    pad_masks = torch.stack([m if isinstance(m, torch.Tensor) else torch.tensor(m) for m in pm]).float().to(device)
    njcs = torch.tensor(njc, dtype=torch.float32, device=device).unsqueeze(1)
    nfos = torch.tensor(nfo, dtype=torch.float32, device=device).unsqueeze(1)
    ntbs = torch.tensor(ntb, dtype=torch.float32, device=device).unsqueeze(1)
    nfcs = torch.tensor(nfc, dtype=torch.float32, device=device).unsqueeze(1)
    num_clauses = torch.tensor(nc, dtype=torch.long, device=device)
    return (price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs, num_clauses), labels_tensor


if argsP.algo == "price_finetune":
  from utilsLLM import get_price_only_ds_from_csv
  ds, val_ds, test_ds, val_costs, test_costs = get_price_only_ds_from_csv(
      dat_paths_train_list, dat_path_test, dat_dict['ds_info'], argsP
  )
  ds_info = dat_dict['ds_info']
  # Use price_or_collate when --price_n_or is set to carry num_clauses through batching
  _price_collate = price_or_collate if getattr(argsP, 'price_n_or', False) else price_only_collate
  train_loader = DataLoader(dataset=ds, batch_size=argsP.batch_size, shuffle=True,
                            collate_fn=_price_collate,
                            generator=torch.Generator().manual_seed(argsP.seed))
  val_loader = DataLoader(dataset=val_ds, batch_size=argsP.batch_size, shuffle=False,
                          collate_fn=_price_collate)
  test_loader = DataLoader(dataset=test_ds, batch_size=1, shuffle=False,
                           collate_fn=_price_collate)
  # Set dummy values for variables expected later
  train_roots = train_js_nodes = train_costs = None
  val_roots = val_js_nodes = val_costs_raw = None
  test_roots = test_js_nodes = test_costs_raw = None
  test_lengths = test_templates = None
elif "llm" in argsP.algo:
  # Cross-attention inference needs llm_price_finetune data loading (raw texts + PRICE features)
  _cross_attn_inf = (argsP.algo == "llm_price" and
                     getattr(argsP, 'price_weights_source', 'pretrained') in ("cross_attn_joint", "bi_cross_attn_joint", "reverse_cross_attn_joint"))
  # Pick the right LLM+PRICE collate. Under --price_n_or the dataset emits
  # 9-tuples with num_clauses_i; the OR collate reshapes price_feats to
  # (batch * max_clauses, flat_size) for the OR-Transformer's multi-clause path.
  _llm_price_active_collate = llm_price_or_collate if getattr(argsP, 'price_n_or', False) else llm_price_collate
  if _cross_attn_inf:
    active_collate = _llm_price_active_collate
    _saved_algo = argsP.algo
    argsP.algo = "llm_price_finetune"  # temporarily switch for correct data loading
  else:
    active_collate = _llm_price_active_collate if argsP.algo == "llm_price_finetune" else llm_collate
  ds_info, train_roots, train_js_nodes, train_costs, \
            val_roots,   val_js_nodes,   val_costs,   \
            test_roots,  test_js_nodes,  test_costs,  \
            ds,  val_ds,  test_ds,  \
            train_loader,  val_loader,  test_loader,  \
            test_lengths, test_templates, _ = utilsTrain.load_data(argsP, dat_path, dat_paths_train_list, dat_path_test, dat_dict, LLM, active_collate)
  if _cross_attn_inf:
    argsP.algo = _saved_algo  # restore for model construction
else:
  ds_info, train_roots, train_js_nodes, train_costs, \
            val_roots,   val_js_nodes,   val_costs,   \
            test_roots,  test_js_nodes,  test_costs,  \
            ds,  val_ds,  test_ds,  \
            train_loader,  val_loader,  test_loader,  \
            test_lengths, test_templates, _ = utilsTrain.load_data(argsP, dat_path, dat_paths_train_list, dat_path_test, dat_dict)

# --baseline_price_concat: wrap the baseline datasets with per-query PRICE
# features (aligned 1:1 to the baseline split) and rebuild the loaders so each
# batch is (base_batch, price_batch). The base half still flows through the
# baseline's own collate; the price half is the mode-7 PRICEEmbedder tuple.
if ((getattr(argsP, 'baseline_price_concat', False) and argsP.algo in ("qf", "aimai", "e2e_cost"))
        or (getattr(argsP, 'baseline_price_cross', False) and argsP.algo == "qf")):
    from functools import partial as _bp_partial
    from torch.utils.data import DataLoader as _BPDataLoader
    from torch.utils.data import default_collate as _bp_default_collate
    from sice_lib import (
        PriceAugmentedDataset, baseline_price_collate,
        build_aligned_price_feats_for_splits,
    )
    print("[baseline_price_concat] Building aligned PRICE features for "
          f"{argsP.algo} (train/val/test)...", flush=True)
    _bp_train_feats, _bp_val_feats, _bp_test_feats = \
        build_aligned_price_feats_for_splits(
            argsP, dat_paths_train_list, dat_path_test, dat_dict)
    print(f"[baseline_price_concat] PRICE feats: train={len(_bp_train_feats)} "
          f"val={len(_bp_val_feats)} test={len(_bp_test_feats)}", flush=True)

    # The baseline's existing collate (must match how load_data built the loaders).
    if argsP.algo == "qf":
        from algorithms.queryformer.dataset_utils import collator as _bp_base_collate
    elif argsP.algo == "e2e_cost":
        from algorithms.e2e_cost.e2e_dataset import collator as _bp_base_collate
    else:  # aimai uses the default collate (TensorDataset, no custom collate)
        _bp_base_collate = _bp_default_collate

    ds = PriceAugmentedDataset(ds, _bp_train_feats)
    val_ds = PriceAugmentedDataset(val_ds, _bp_val_feats)
    test_ds = PriceAugmentedDataset(test_ds, _bp_test_feats)
    _bp_collate = _bp_partial(baseline_price_collate, base_collate=_bp_base_collate)

    train_loader = _BPDataLoader(
        dataset=ds, batch_size=argsP.batch_size, shuffle=True,
        collate_fn=_bp_collate,
        generator=torch.Generator().manual_seed(argsP.seed if hasattr(argsP, 'seed') else 42))
    val_loader = _BPDataLoader(
        dataset=val_ds, batch_size=argsP.batch_size, shuffle=False,
        collate_fn=_bp_collate)
    test_loader = _BPDataLoader(
        dataset=test_ds, batch_size=1, shuffle=False, collate_fn=_bp_collate)

from trainer import *

if argsP.algo == "bao":
  # Get total_roots and IDs for verbose output
  total_roots = dat_dict.get('total_roots', None)
  total_costs = dat_dict.get('total_costs', None)
  train_ids = dat_dict.get('train_ids', None)
  test_ids = dat_dict.get('test_ids', None)
  
  # Set test_original_indices only when train/val/test are from the same file
  same_file = (len(dat_paths_train_list) == 1 and dat_paths_train_list[0] == dat_path_test)
  if same_file and test_ids is not None:
    argsP.test_original_indices = test_ids
    print(f"  BAO: Set test_original_indices for index mapping (same file scenario)")
  else:
    # Don't set test_original_indices when train and test are from different files
    print(f"  BAO: Separate train/test files - no index mapping")
  
  # Set metadata for verbose output
  argsP.test_plan_file_path = dat_path_test

  # --baseline_price_concat: build the mode-7 cx=0 PRICE embedder + per-query
  # PRICE features aligned 1:1 to the bao train/val/test roots, and thread them
  # into train_and_test_bao for joint training. train_and_test_bao has no
  # dat_dict, so we build everything here (where dat_dict / split ids are in
  # scope), exactly as the qf/aimai/e2e_cost block does.
  _bao_price_embedder = None
  _bao_train_feats = _bao_val_feats = _bao_test_feats = None
  if getattr(argsP, 'baseline_price_concat', False):
    from sice_lib import build_aligned_price_feats_for_splits
    from sice_lib import build_price_embedder
    print("[baseline_price_concat] Building aligned PRICE features for bao "
          "(train/val/test)...", flush=True)
    _bao_train_feats, _bao_val_feats, _bao_test_feats = \
        build_aligned_price_feats_for_splits(
            argsP, dat_paths_train_list, dat_path_test, dat_dict)
    print(f"[baseline_price_concat] PRICE feats: train={len(_bao_train_feats)} "
          f"val={len(_bao_val_feats)} test={len(_bao_test_feats)}", flush=True)
    # build_aligned_price_feats_for_splits publishes the unified price_max_n_*
    # dims onto argsP, so build_price_embedder sizes the PRICE model to match.
    _bao_price_embedder, _bao_price_dim = build_price_embedder(argsP, device)
    print(f"[baseline_price_concat] bao: PRICE emb dim = {_bao_price_dim}",
          flush=True)

  results = train_and_test_bao(
      train_roots, train_costs, test_roots, test_costs, argsP, device,
      total_roots=total_roots, total_costs=total_costs,
      train_ids=train_ids, test_ids=test_ids,
      plan_file_path=dat_path_test,
      output_dir_qerror=argsP.output_dir_qerror,
      dat_paths_train_list=dat_paths_train_list,
      val_roots=val_roots, val_costs=val_costs,
      price_embedder=_bao_price_embedder,
      train_price_feats=_bao_train_feats,
      val_price_feats=_bao_val_feats,
      test_price_feats=_bao_test_feats,
  )
  save_error_cdf(results['qerr_dist'], argsP.output_dir_qerror, error_type="Qerror")
  # save_error_cdf(results['abserr_dist'], argsP.output_dir_abs,   error_type="abs_error")
  sys.exit(0)
elif argsP.algo == "postgres":
  results = train_and_test_postgres(train_roots, train_costs, test_roots, test_costs, argsP,
                                    dat_paths_train_list=dat_paths_train_list)
  save_error_cdf(results['qerr_dist'], argsP.output_dir_qerror, error_type="Qerror")
  # save_error_cdf(results['abserr_dist'], argsP.output_dir_abs,   error_type="abs_error")
  sys.exit(0)



_baseline_price_cross = (getattr(argsP, 'baseline_price_cross', False)
                         and argsP.algo == "qf")
_baseline_price_concat = (getattr(argsP, 'baseline_price_concat', False)
                          and argsP.algo in ("qf", "aimai", "e2e_cost"))
if _baseline_price_cross:
  # --baseline_price_cross: qf token sequence attends to the projected statistics
  # token via one-directional cross-attn blocks, then cat([refined-qf-CLS,
  # stats]) -> MLP. Same PRICEEmbedder design as the LLM path, with
  # llm_hidden_dim == the QueryFormer token hidden dim.
  from sice_lib import build_price_embedder
  from sice_lib import BaselinePriceCrossAttnModel
  from sice_lib import PRICEEmbedder
  from algorithms.queryformer.model import QueryFormer
  input_dim = 393                                       # QueryFormer embed dim (qf token hidden)
  n_cross = getattr(argsP, 'n_cross_layers', 2) or 2
  argsP.n_cross_layers = n_cross
  _, _, price_model = build_price_embedder(argsP, device, return_price_model=True)
  price_embedder = PRICEEmbedder(
      price_model, n_cross_layers=n_cross, llm_hidden_dim=input_dim,
      n_heads=getattr(argsP, 'price_n_heads', 8),
      dropout_rate=getattr(argsP, 'cross_attn_dropout', 0.1),
      cross_attn_direction='one')
  price_dim = price_embedder.price_output_dim
  base_encoder = QueryFormer(emb_size=64, use_sample=True, use_hist=True)
  model_comb = BaselinePriceCrossAttnModel(base_encoder, price_embedder, input_dim,
                                           argsP.hid_units, price_emb_dim=price_dim)
  model_comb.is_baseline_price_joint = True             # reuse the (base, price) tuple trainer path
  print(f"[baseline_price_cross] qf: cx={n_cross} (one-directional) | MLP input_dim = "
        f"{input_dim} + {price_dim} = {input_dim + price_dim}")
elif _baseline_price_concat:
  # --baseline_price_concat: concat a mode-7-style cx=0 PRICE embedding (512-dim)
  # onto the baseline encoder output before the prediction MLP, trained jointly.
  # Build the SAME base encoder the plain-baseline branch builds (so the encoder
  # output dim feeding the MLP is identical), but route it through
  # BaselinePriceJointModel instead of an MLP / nn.Sequential.
  from sice_lib import build_price_embedder
  from sice_lib import BaselinePriceJointModel
  price_embedder, price_dim = build_price_embedder(argsP, device)
  if argsP.algo == "aimai":
    base_encoder = nn.Identity()
    input_dim = len(ds_info.nodeParallels) * 5          # aimai feature width
  elif argsP.algo == "qf":
    from algorithms.queryformer.model import *
    base_encoder = QueryFormer(emb_size=64, use_sample=True, use_hist=True)
    input_dim = 393                                     # QueryFormer embed dim
  else:  # e2e_cost
    from algorithms.e2e_cost.e2e_model import *
    input_dim = 32                                      # E2E encoder embed dim
    base_encoder = E2E_model(input_dim, 64, 64, ds_info)
  model_comb = BaselinePriceJointModel(base_encoder, price_embedder, input_dim,
                                       argsP.hid_units, price_emb_dim=price_dim)
  # Marker consumed by trainer.train()/evaluate() to thread the (base, price) batch
  # tuple through forward(base_input, price_feats); plain baselines are unaffected.
  model_comb.is_baseline_price_joint = True
  print(f"[baseline_price_concat] {argsP.algo}: MLP input_dim = "
        f"{input_dim} + {price_dim} = {input_dim + price_dim}")
elif argsP.algo == "aimai":
  input_dim = len(ds_info.nodeParallels) * 5
  MLP = Prediction(input_dim, argsP.hid_units)
  model_comb = MLP
elif argsP.algo == "qf":
  from algorithms.queryformer.model import *
  model = QueryFormer(emb_size=64, use_sample = True, use_hist = True)
  input_dim = 393
  MLP = Prediction(input_dim, argsP.hid_units)
  model_comb = nn.Sequential(model, MLP)
elif argsP.algo == "e2e_cost":
    from algorithms.e2e_cost.e2e_model import *
    input_dim = 32
    model = E2E_model(input_dim, 64, 64, ds_info)
    MLP = Prediction(input_dim, argsP.hid_units)
    model_comb = nn.Sequential(model, MLP)
elif argsP.algo == "llm":
  input_dim = argsP.embed_size
  MLP = Prediction(input_dim, argsP.hid_units)
  model_comb = MLP
elif argsP.algo == "llm_stats":
  # Deprecated: stats fusion is disabled. Behave like plain LLM embeddings.
  input_dim = argsP.embed_size
  MLP = Prediction(input_dim, argsP.hid_units)
  model_comb = MLP
elif argsP.algo == "llm_price":
  # Standard llm_price inference: pre-computed LLM+PRICE combined embeddings → MLP.
  # The earlier unified-routing block (above) has already converted any biCross /
  # cross-attn / reverse-cross-attn price_weights_source to "joint", so we always
  # land on this MLP path. Cross-attn featurization (when n_cross_layers > 0) is
  # handled inside utilsLLM.py:get_embeddings via _compute_combined_for_dat_path,
  # which produces post-cross-attn combined embeddings cached to CSV.
  input_dim = argsP.embed_size
  MLP = Prediction(input_dim, argsP.hid_units)
  model_comb = MLP
elif argsP.algo == "llm_finetune":
  input_dim = argsP.embed_size
  MLP = Prediction(input_dim, argsP.hid_units)
  model_comb = nn.Sequential(LLM, MLP)
elif argsP.algo == "llm_price_finetune":
  import sys as _sys, os as _os
  _experiments_dir = _os.path.dirname(_os.path.abspath(__file__))
  if _experiments_dir not in _sys.path:
      _sys.path.insert(0, _experiments_dir)
  _repo_root = _os.path.dirname(_experiments_dir)
  if _repo_root not in _sys.path:
      _sys.path.insert(0, _repo_root)
  from canon.price.model.encoder import RegressionModel
  from sice_lib import PRICEEmbedder, LLMPriceJointModel

  # --no_llm_residual: skip LLM/fusion components; build a PRICE-only model
  # (mirrors the price_finetune branch) and reroute algo so the rest of the
  # training/save logic uses the correct path.
  if getattr(argsP, 'no_llm_residual', False):
      print("[train] --no_llm_residual: building PRICE-only model; "
            "LLM and fusion components are skipped.")
      from sice_lib import PRICEFinetunWrapper
      bin_size = getattr(argsP, 'price_bin_size', 40)
      table_dim = 4
      filter_dim_nr, fanout_dim_nr, pairwise_intra_dim_nr = _price_dims(argsP, bin_size)
      _price_n_embd_nr = getattr(argsP, 'price_n_embd', 256)
      _price_n_heads_nr = getattr(argsP, 'price_n_heads', 8)
      _price_ffn_ratio_nr = getattr(argsP, 'price_ffn_ratio', 4.0)
      _use_or_transformer_nr = any([
          getattr(argsP, "price_n_pairwise", False),
          getattr(argsP, "price_n_filter", False),
          getattr(argsP, "price_n_fanout", False),
          getattr(argsP, "price_n_parsing", False),
      ]) and not getattr(argsP, "no_or_transformer", False)
      _nr_price_model = RegressionModel(
          n_join_col=argsP.price_max_n_join_col, n_fanout=argsP.price_max_n_fanout,
          n_table=argsP.price_max_n_table, n_filter_col=argsP.price_max_n_filter_col,
          n_pairwise_intra=getattr(argsP, "price_max_n_pairwise_intra", 8)
                            if getattr(argsP, "price_n_pairwise", False) else 0,
          hist_dim=bin_size, table_dim=table_dim, filter_dim=filter_dim_nr,
          fanout_dim=fanout_dim_nr, pairwise_intra_dim=pairwise_intra_dim_nr,
          query_hidden_dim=512, final_hidden_dim=1024, output_dim=1,
          n_embd=_price_n_embd_nr, n_layers=getattr(argsP, 'price_n_layers', 6),
          n_heads=_price_n_heads_nr, dropout_rate=0.1, ffn_ratio=_price_ffn_ratio_nr,
          use_or_transformer=_use_or_transformer_nr,
        or_n_layers=getattr(argsP, "or_n_layers", 1),
        or_n_heads=getattr(argsP, "or_n_heads", 4),
        or_ffn_ratio=getattr(argsP, "or_ffn_ratio", 1.0),
      )
      if not getattr(argsP, 'price_random_init', False):
          _nr_sd = torch.load(argsP.price_model_path, map_location=device)
          _nr_sd = {k.replace('module.', ''): v for k, v in _nr_sd.items()}
          _nr_model_sd = _nr_price_model.state_dict()
          for k, v in _nr_sd.items():
              if k not in _nr_model_sd:
                  continue
              if _nr_model_sd[k].shape == v.shape:
                  _nr_model_sd[k] = v
              elif _nr_model_sd[k].dim() == v.dim():
                  slices = tuple(slice(0, min(ms, vs)) for ms, vs in
                                 zip(_nr_model_sd[k].shape, v.shape))
                  _nr_model_sd[k][slices] = v[slices]
          _nr_price_model.load_state_dict(_nr_model_sd)
          print(f"[no_llm_residual] Loaded PRICE weights from {argsP.price_model_path}")
      else:
          print("[no_llm_residual] Random PRICE initialization")
      model_comb = PRICEFinetunWrapper(_nr_price_model)
      # Reroute: treat this as price_finetune for training + save logic
      argsP.algo = "price_finetune"
      if not getattr(argsP, 'card', False):
          print("[no_llm_residual] Forcing --card=True for price_finetune save path")
          argsP.card = True

  if argsP.algo == "llm_price_finetune":
    # Full LLM+PRICE model construction (--no_llm_residual was NOT set)

    # Build the cx=0 / mode-7 PRICEEmbedder. Extracted into build_price_embedder
    # so the non-LLM baselines (--baseline_price_concat) construct the identical
    # embedder. The cross-attn branches below build their own embedders from the
    # SAME price_model (seeded from price_embedder's shared weights), exactly as
    # before — so build_price_embedder also hands back that RegressionModel.
    from sice_lib import build_price_embedder
    price_embedder, _, price_model = build_price_embedder(argsP, device, return_price_model=True)

    if getattr(argsP, 'n_cross_layers', 0) > 0:
      # Cross-attention fusion (the SICE full design; --cross_attn_direction bi
      # gives the bidirectional ablation variant). The 512-d statistics
      # embedding is projected to the LLM hidden dim inside PRICEEmbedder
      # (stat_proj) and serves as a length-1 attention context for the plan tokens.
      n_cross = getattr(argsP, 'n_cross_layers', 2)
      fusion_embedder = PRICEEmbedder(
          price_model,
          n_cross_layers=n_cross,
          llm_hidden_dim=argsP.embed_size,
          n_heads=8,
          dropout_rate=getattr(argsP, 'cross_attn_dropout', 0.1),
          cross_attn_direction=getattr(argsP, 'cross_attn_direction', 'one'),
          # --unified_window_pool: the fusion runs on each sliding window
          # separately, then segment-means over windows (the cx=0 pooled
          # embedding is the identity-blocks limit).
          unified_window_pool=getattr(argsP, 'unified_window_pool', False),
      )
      if not getattr(argsP, 'price_random_init', False):
        shared_sd = {k: v for k, v in price_embedder.state_dict().items()
                     if k in fusion_embedder.state_dict() and
                     fusion_embedder.state_dict()[k].shape == v.shape}
        fusion_embedder.load_state_dict(shared_sd, strict=False)
        print(f"[cross_attn] Copied {len(shared_sd)} shared PRICE weight tensors; "
              f"fusion layers randomly initialized")
      model_comb = LLMPriceJointModel(
          LLM, fusion_embedder, argsP.embed_size,
          fusion_embedder.price_output_dim, argsP.hid_units,
      )
      n_cross_params = sum(p.numel() for p in fusion_embedder.cross_attn_parameters())
      _dirn = getattr(argsP, 'cross_attn_direction', 'one')
      print(f"[cross_attn] direction={_dirn}, {n_cross} fusion blocks, {n_cross_params:,} fusion params")
      _mlp_in_dim = argsP.embed_size + fusion_embedder.price_output_dim
      print(f"[cross_attn] MLP input dim = {_mlp_in_dim} = LLM({argsP.embed_size}) + stats({fusion_embedder.price_output_dim})")
    else:
      # Concat fusion (cx=0): MLP over [pooled LLM embedding ; 512-d statistics embedding].
      model_comb = LLMPriceJointModel(LLM, price_embedder, argsP.embed_size, 512, argsP.hid_units)

    # Freeze PRICE parameters if requested
    if getattr(argsP, 'freeze_all_price', False):
      # Freeze ALL PRICE parameters (for LLMOnly control)
      n_frozen = 0
      for param in model_comb.price.parameters():
        param.requires_grad = False
        n_frozen += 1
      print(f"[freeze_all_price] Froze ALL {n_frozen} PRICE param tensors (0 trainable)")
    elif getattr(argsP, 'freeze_price_encoder', False):
      unfreeze_last_n = getattr(argsP, 'unfreeze_last_n_blocks', 0)
      n_frozen = 0
      for name, param in model_comb.price.named_parameters():
        # Check if this is an embedding layer (always freeze)
        if name.startswith(('scale_embedding', 'filter_embedding')):
          param.requires_grad = False
          n_frozen += 1
        # Check if this is an encoder block
        elif name.startswith(('scale_encoder.blocks.', 'filter_encoder.blocks.')):
          block_num = int(name.split('blocks.')[1].split('.')[0])
          if block_num < getattr(argsP, 'price_n_layers', 6) - unfreeze_last_n:
            param.requires_grad = False
            n_frozen += 1
      n_trainable_price = sum(1 for p in model_comb.price.parameters() if p.requires_grad)
      total_trainable = sum(p.numel() for p in model_comb.price.parameters() if p.requires_grad)
      print(f"[freeze_price_encoder] Froze {n_frozen} PRICE param tensors, {n_trainable_price} remain trainable ({total_trainable:,} params)"
            f" (unfreeze_last_n_blocks={unfreeze_last_n})")

    # Load LLM weights from another finetune run (e.g. mode 7 LLM into mode 12)
    _init_llm_from = getattr(argsP, 'init_llm_from', '') or ''
    if _init_llm_from and os.path.exists(_init_llm_from):
      _init_llm_sd = torch.load(_init_llm_from, map_location='cpu', weights_only=False)
      # The actual HF+LoRA model lives at model_comb.llm.model, not model_comb.llm.
      _result = model_comb.llm.model.load_state_dict(_init_llm_sd, strict=False)
      _n_loaded = len(_init_llm_sd) - len(_result.unexpected_keys)
      print(f"[init_llm_from] Loaded LLM weights from {_init_llm_from}")
      print(f"[init_llm_from] state_dict keys={len(_init_llm_sd)}, loaded={_n_loaded}, "
            f"missing={len(_result.missing_keys)}, unexpected={len(_result.unexpected_keys)}")
      if _n_loaded == 0:
        print(f"[init_llm_from] ERROR: nothing loaded. sd-keys[:3]={list(_init_llm_sd.keys())[:3]}")
    elif _init_llm_from:
      print(f"[init_llm_from] WARNING: file not found: {_init_llm_from}")

elif argsP.algo == "price_finetune":
  import sys as _sys, os as _os
  _experiments_dir = _os.path.dirname(_os.path.abspath(__file__))
  if _experiments_dir not in _sys.path:
      _sys.path.insert(0, _experiments_dir)
  _repo_root = _os.path.dirname(_experiments_dir)
  if _repo_root not in _sys.path:
      _sys.path.insert(0, _repo_root)
  from canon.price.model.encoder import RegressionModel
  from sice_lib import PRICEFinetunWrapper

  # Load pretrained PRICE model
  price_state_dict = torch.load(argsP.price_model_path, map_location=device)
  price_state_dict = {k.replace('module.', ''): v for k, v in price_state_dict.items()}

  max_njc = argsP.price_max_n_join_col
  max_nfo = argsP.price_max_n_fanout
  max_ntb = argsP.price_max_n_table
  max_nfc = argsP.price_max_n_filter_col
  bin_size = getattr(argsP, 'price_bin_size', 40)
  table_dim = 4
  filter_dim, fanout_dim, pairwise_intra_dim = _price_dims(argsP, bin_size)

  _price_n_embd = getattr(argsP, 'price_n_embd', 256)
  _price_n_heads = getattr(argsP, 'price_n_heads', 8)
  _price_ffn_ratio = getattr(argsP, 'price_ffn_ratio', 4.0)
  _use_or_transformer = any([
      getattr(argsP, "price_n_pairwise", False),
      getattr(argsP, "price_n_filter", False),
      getattr(argsP, "price_n_fanout", False),
      getattr(argsP, "price_n_parsing", False),
  ])
  price_model = RegressionModel(
      n_join_col=max_njc, n_fanout=max_nfo, n_table=max_ntb, n_filter_col=max_nfc,
      n_pairwise_intra=getattr(argsP, "price_max_n_pairwise_intra", 8)
                        if getattr(argsP, "price_n_pairwise", False) else 0,
      hist_dim=bin_size, table_dim=table_dim, filter_dim=filter_dim,
      fanout_dim=fanout_dim, pairwise_intra_dim=pairwise_intra_dim,
      query_hidden_dim=512, final_hidden_dim=1024, output_dim=1,
      n_embd=_price_n_embd, n_layers=getattr(argsP, 'price_n_layers', 6), n_heads=_price_n_heads,
      dropout_rate=0.1, ffn_ratio=_price_ffn_ratio,
      use_or_transformer=_use_or_transformer,
        or_n_layers=getattr(argsP, "or_n_layers", 1),
        or_n_heads=getattr(argsP, "or_n_heads", 4),
        or_ffn_ratio=getattr(argsP, "or_ffn_ratio", 1.0),
  )
  # Load with partial init for dimension-extended variants (histogram bins shared, operator dims differ)
  def _load_price_sd_ft(model, ckpt_sd, label=""):
      model_sd = model.state_dict()
      for k, v in ckpt_sd.items():
          if k not in model_sd:
              continue
          if model_sd[k].shape == v.shape:
              model_sd[k] = v
          elif model_sd[k].dim() == v.dim():
              slices = tuple(slice(0, min(ms, vs)) for ms, vs in zip(model_sd[k].shape, v.shape))
              model_sd[k][slices] = v[slices]
              print(f"  Partial init {k}: copied {[s.stop for s in slices]} of {list(model_sd[k].shape)} from checkpoint {list(v.shape)}")
      model.load_state_dict(model_sd)
      if label:
          print(label)
  if getattr(argsP, 'price_random_init', False):
    print("[PRICE] Random initialization (skipping pretrained weights)")
  else:
    _load_price_sd_ft(price_model, price_state_dict, f"Loaded pretrained PRICE weights from {argsP.price_model_path}")

  model_comb = PRICEFinetunWrapper(price_model)
  # Move to device BEFORE optimizer creation. nn.Module._apply replaces
  # Parameter objects when only device changes; the optimizer would otherwise
  # bind stale CPU references and the first .step() raises a cuda/cpu mismatch
  # in _multi_tensor_adam (state_dict tensors land on the wrong device).
  model_comb.to(device)


# --retrain_mlp removed 2026-05-11: the post-PRICE + cross-attn combined
# embedding caching now lives inside get_embeddings() and runs by default
# for argsP.algo == "llm_price" (Mode 7 / Mode 12 inference).

crit = nn.MSELoss()

# Custom optimizer/scheduler for price_finetune
price_finetune_optimizer = None
price_finetune_scheduler = None
if argsP.algo == "price_finetune":
    _raw_price_lr = getattr(argsP, 'price_warmup_lr', None)
    price_lr = _raw_price_lr if _raw_price_lr is not None else (1e-3 if getattr(argsP, 'price_random_init', False) else 2.85e-5)
    price_finetune_optimizer = torch.optim.Adam(model_comb.parameters(), lr=price_lr)
    if getattr(argsP, 'price_random_init', False):
        _finetune_lr = 2e-5
        _price_warmup = getattr(argsP, 'price_warmup_epochs', 0)
        def _random_init_schedule_ft(epoch, _price_lr=price_lr, _ft_lr=_finetune_lr, _pw=_price_warmup):
            if epoch < _pw:
                return 1.0
            else:
                return _ft_lr / _price_lr
        price_finetune_scheduler = torch.optim.lr_scheduler.LambdaLR(
            price_finetune_optimizer, _random_init_schedule_ft)
        print(f"[price_finetune] Random init LR schedule: {price_lr} for epochs 0-{_price_warmup-1}, {_finetune_lr} for epochs {_price_warmup}+")
    else:
        price_finetune_scheduler = torch.optim.lr_scheduler.OneCycleLR(
            price_finetune_optimizer, max_lr=price_lr,
            steps_per_epoch=len(train_loader), epochs=argsP.num_epoch
        )

# Compute experiment-specific checkpoint prefix for PRICE finetuning
_ckpt_prefix = None
if argsP.algo == "llm_price_finetune":
    _task = "card" if argsP.card else "time"
    _price_suffix = _price_path_suffix(argsP)
    _arch_suffix = _arch_path_suffix(argsP)
    _ri = "_randInit" if getattr(argsP, 'price_random_init', False) else ""
    _seed_ckpt = f"_seed{argsP.seed}" if hasattr(argsP, 'seed') else ""
    _ckpt_prefix = f"{argsP.canonical_wl_prefix}_{_task}_{argsP.llm_mode}_{argsP.model_name.replace('/','-')}_b{argsP.batch_size}{_price_suffix}_llm_price{_arch_suffix}{_ri}{_seed_ckpt}"
elif argsP.algo == "price_finetune":
    _price_suffix = _price_path_suffix(argsP)
    _arch_suffix_ckpt = _arch_path_suffix(argsP)
    _ri = "_randInit" if getattr(argsP, 'price_random_init', False) else ""
    _task_ckpt = "card" if argsP.card else "time"
    _seed_ckpt = f"_seed{argsP.seed}" if hasattr(argsP, 'seed') else ""
    _ckpt_prefix = f"{argsP.canonical_wl_prefix}_{_task_ckpt}_b{argsP.batch_size}{_price_suffix}{_arch_suffix_ckpt}{_ri}{_seed_ckpt}_price_separate"
elif argsP.algo == "llm_finetune":
    _task = "card" if argsP.card else "time"
    _ckpt_prefix = f"{argsP.canonical_wl_prefix}_{_task}_{argsP.llm_mode}_{argsP.model_name.replace('/','-')}_b{argsP.batch_size}"
argsP.checkpoint_prefix = _ckpt_prefix

# Resume from checkpoint if specified (or auto-detect latest)
resume_ckpt = getattr(argsP, 'resume_checkpoint', '')
start_epoch = 0
_resumed_from_weights = False
# Auto-skip finetuning when the FINAL weights for this exact config already exist (a
# completed finetune; an early-stopped run still saves its final _llm/_price/_mlp.pt).
# Without this, a later workload sharing the canonical LoRA (e.g. job/job_full after syn)
# would auto-resume syn's latest periodic checkpoint and CONTINUE finetuning to num_epoch
# instead of reusing it as-is. Routes to the skip_train_load_finetuned_weights branch
# below (load LLM+PRICE+MLP, no training). Delete the weights to force a re-finetune.
if (not resume_ckpt and argsP.algo == "llm_price_finetune"
        and not getattr(argsP, '_cross_attn_inference', False)
        and not getattr(argsP, 'skip_train_load_finetuned_weights', False)):
    _ts_as = "card" if argsP.card else "time"
    _pfx_as = (f"{argsP.canonical_wl_prefix}_{_ts_as}_{argsP.llm_mode}_{argsP.model_name.replace('/','-')}"
               f"_b{argsP.batch_size}{_price_path_suffix(argsP)}_llm_price{_arch_path_suffix(argsP)}"
               f"{'_randInit' if getattr(argsP, 'price_random_init', False) else ''}_e{argsP.num_epoch}"
               f"{'_seed' + str(argsP.seed) if getattr(argsP, 'seed', None) is not None else ''}")
    _dir_as = f"finetuned_models/{argsP.db}{_GSUB}/"
    _ok_llm_as = os.path.exists(os.path.join(_dir_as, f"{_pfx_as}_llm.pt"))
    if (os.path.exists(os.path.join(_dir_as, f"{_pfx_as}_price.pt"))
            and os.path.exists(os.path.join(_dir_as, f"{_pfx_as}_mlp.pt")) and _ok_llm_as):
        argsP.skip_train_load_finetuned_weights = True
        print(f"[auto-skip-finetune] Final finetune weights already exist -> load + skip training "
              f"(no resume/continue to e{argsP.num_epoch}): {_pfx_as}_*.pt")
if (not resume_ckpt and _ckpt_prefix and getattr(argsP, 'checkpoint_interval', 0) > 0
        and not getattr(argsP, 'skip_train_load_finetuned_weights', False)):
    import glob as _glob
    # Checkpoints live under .../checkpoints/{subdir}/ (subdir AFTER "checkpoints").
    _ckpt_dir = f"finetuned_models/{argsP.db}/checkpoints{_GSUB}"
    _pattern = os.path.join(_ckpt_dir, f"{_ckpt_prefix}_epoch*.pt")
    _ckpts = sorted(_glob.glob(_pattern), key=lambda p: int(re.search(r'_epoch(\d+)', p).group(1)))
    if _ckpts:
        resume_ckpt = _ckpts[-1]
        print(f"[Checkpoint] Auto-detected: {resume_ckpt}")
    else:
        # Fallback: look for final weight files from a previous epoch count
        # These are separate files (llm.pt, price.pt, mlp.pt) saved after training
        _weight_dir = f"finetuned_models/{argsP.db}{_GSUB}"
        _weight_pattern = os.path.join(_weight_dir, f"{_ckpt_prefix}_e*_llm.pt")
        _weight_files = _glob.glob(_weight_pattern)
        if _weight_files:
            # Find the highest epoch among available weight files
            _epochs_found = []
            for wf in _weight_files:
                m = re.search(r'_e(\d+)_llm\.pt$', wf)
                if m:
                    ep = int(m.group(1))
                    if ep < argsP.num_epoch:  # Only resume from earlier epochs
                        _epochs_found.append(ep)
            if _epochs_found:
                _best_ep = max(_epochs_found)
                _weight_prefix = os.path.join(_weight_dir, f"{_ckpt_prefix}_e{_best_ep}")
                _llm_f = f"{_weight_prefix}_llm.pt"
                _price_f = f"{_weight_prefix}_price.pt"
                _mlp_f = f"{_weight_prefix}_mlp.pt"
                _gate_f = f"{_weight_prefix}_gate.pt"
                if os.path.exists(_llm_f) and os.path.exists(_price_f):
                    print(f"[Resume] Loading separate weight files from epoch {_best_ep}")
                    # Load PRICE weights
                    _price_sd = torch.load(_price_f, map_location=argsP.device, weights_only=True)
                    model_comb.price.load_state_dict(_price_sd)
                    print(f"[Resume] Loaded PRICE weights from {_price_f}")
                    # Load MLP weights
                    if os.path.exists(_mlp_f):
                        _mlp_sd = torch.load(_mlp_f, map_location=argsP.device, weights_only=True)
                        model_comb.mlp.load_state_dict(_mlp_sd)
                        print(f"[Resume] Loaded MLP weights from {_mlp_f}")
                    # Load LLM LoRA weights (filter to only LoRA keys)
                    _llm_sd = torch.load(_llm_f, map_location=argsP.device, weights_only=True)
                    _lora_keys = {k: v for k, v in _llm_sd.items() if 'lora_' in k}
                    if _lora_keys:
                        _current_sd = model_comb.llm.model.state_dict()
                        _current_sd.update(_lora_keys)
                        model_comb.llm.model.load_state_dict(_current_sd, strict=False)
                        print(f"[Resume] Loaded {len(_lora_keys)} LoRA weight tensors from {_llm_f}")
                    # Load gate weights if applicable
                    if os.path.exists(_gate_f) and hasattr(model_comb, 'gate'):
                        _gate_sd = torch.load(_gate_f, map_location=argsP.device, weights_only=True)
                        model_comb.gate.load_state_dict(_gate_sd)
                        print(f"[Resume] Loaded gate weights from {_gate_f}")
                    start_epoch = _best_ep
                    _resumed_from_weights = True
                    print(f"[Resume] Will start training from epoch {start_epoch}")
if resume_ckpt and os.path.exists(resume_ckpt) and not _resumed_from_weights:
    print(f"[Checkpoint] Resuming from {resume_ckpt}")
    ckpt = torch.load(resume_ckpt, map_location=argsP.device, weights_only=False)
    _load_result = model_comb.load_state_dict(ckpt['model_state_dict'], strict=False)
    if _load_result.unexpected_keys:
        print(f"[Checkpoint] Ignored {len(_load_result.unexpected_keys)} unexpected keys (e.g. bitsandbytes metadata)")
    if _load_result.missing_keys:
        print(f"[Checkpoint] WARNING: {len(_load_result.missing_keys)} missing keys: {_load_result.missing_keys[:5]}")
    start_epoch = ckpt['epoch']
    # Optimizer/scheduler will be loaded inside train() if we pass them
    if price_finetune_optimizer and ckpt.get('optimizer_state_dict'):
        price_finetune_optimizer.load_state_dict(ckpt['optimizer_state_dict'])
    if price_finetune_scheduler and ckpt.get('scheduler_state_dict'):
        price_finetune_scheduler.load_state_dict(ckpt['scheduler_state_dict'])
    print(f"[Checkpoint] Resuming from epoch {start_epoch}")

# Check for cached baseline model
_baseline_cached = False
if argsP.algo in ("aimai", "qf", "e2e_cost"):
    _cache_dir = f"finetuned_models/{argsP.db}{_GSUB}/"
    _task_str = "card" if argsP.card else "time"
    _prefix = f"long_raw_{argsP.db}_"
    _data_names = []
    for _p in sorted(set(dat_paths_train_list)):
        _stem = os.path.splitext(os.path.basename(_p))[0]
        _data_names.append(_stem[len(_prefix):] if _stem.startswith(_prefix) else _stem)
    _data_str = '-'.join(_data_names)
    # --baseline_price_concat / --baseline_price_cross: a joint (base+PRICE) run has
    # a different model architecture than the plain baseline (and from each other),
    # so it must NOT share the cache file.
    _bp_tag = ("_priceConcat" if getattr(argsP, 'baseline_price_concat', False)
               else "_priceCross" if getattr(argsP, 'baseline_price_cross', False)
               else "")
    _cache_name = f"{_data_str}_{_task_str}_{argsP.algo}_d{input_dim}_{argsP.train_ratio}_b{argsP.batch_size}_h{argsP.hid_units}_seed{argsP.seed}{_bp_tag}_model.pt"
    _cache_path = os.path.join(_cache_dir, _cache_name)
    if os.path.exists(_cache_path):
        # The cache key uses the MLP input_dim, which does NOT capture model-internal
        # dims that depend on the dataset encoding (e.g. e2e_cost's LSTM input size
        # differs between test=job (186) and test=job_full (187)). On any state_dict
        # mismatch, fall back to training from scratch instead of crashing.
        try:
            model_comb.load_state_dict(torch.load(_cache_path, map_location=argsP.device))
            model_comb.to(argsP.device)
            print(f"Loaded cached {argsP.algo} model from {_cache_path}")
            trained_model = model_comb
            _baseline_cached = True
        except RuntimeError as _e:
            print(f"[cache] {argsP.algo} cache {_cache_path} is incompatible with the "
                  f"current model architecture; retraining. ({_e})")
            _baseline_cached = False

if getattr(argsP, '_cross_attn_inference', False):
    # Cross-attention inference: model already has loaded weights, skip training
    trained_model = model_comb
    trained_model.to(argsP.device)
    training_time = 0.0
    argsP.main_logger.info(f"[Train] Skipped training (cross-attention inference with pre-loaded weights)")
elif getattr(argsP, 'skip_train_load_finetuned_weights', False) and argsP.algo == "llm_finetune":
    # Load saved LLM + MLP weights and skip training so we can regenerate the
    # mode-2 finetune-phase eval CSV without rerunning the heavy LLM finetune.
    _sp = f"finetuned_models/{argsP.db}{_GSUB}/"
    _ts = "card" if argsP.card else "time"
    _stats_suffix = ""
    if getattr(argsP, "stats_token_inject", False):
        _stats_suffix = f"_statTok-{getattr(argsP, 'stats_token_mode', 'per_column')}"
    _prefix = f"{argsP.canonical_wl_prefix}_{_ts}_{argsP.llm_mode}_{argsP.model_name.replace('/','-')}_b{argsP.batch_size}{_stats_suffix}"
    _llm_p = os.path.join(_sp, f"{_prefix}_llm.pt")
    # model_comb is nn.Sequential(LLM, MLP); LLM is index 0, MLP is index 1.
    _r = model_comb[0].model.load_state_dict(
        torch.load(_llm_p, map_location=argsP.device), strict=False)
    print(f"[skip_train] Loaded LLM weights from {_llm_p}"
          f" (missing={len(_r.missing_keys)}, unexpected={len(_r.unexpected_keys)})")
    _mlp_p = os.path.join(_sp, f"{_prefix}_mlp.pt")
    if os.path.exists(_mlp_p):
        _r = model_comb[1].load_state_dict(
            torch.load(_mlp_p, map_location=argsP.device), strict=False)
        print(f"[skip_train] Loaded MLP weights from {_mlp_p}"
              f" (missing={len(_r.missing_keys)}, unexpected={len(_r.unexpected_keys)})")
    else:
        print(f"[skip_train] WARNING: no saved MLP at {_mlp_p}; MLP is freshly initialised")
    model_comb.to(argsP.device)
    trained_model = model_comb
    training_time = 0.0
    argsP.main_logger.info(f"[Train] Skipped training (loaded saved llm_finetune weights from {_sp})")
elif getattr(argsP, 'skip_train_load_finetuned_weights', False) and argsP.algo == "llm_price_finetune":
    # Load saved finetune weights and skip training so we can regenerate the
    # finetune-phase eval CSV without rerunning the heavy joint finetune.
    _sp = f"finetuned_models/{argsP.db}{_GSUB}/"
    _ts = "card" if argsP.card else "time"
    _ps = _price_path_suffix(argsP)
    _as = _arch_path_suffix(argsP)
    _ri = "_randInit" if getattr(argsP, 'price_random_init', False) else ""
    _es = f"_e{argsP.num_epoch}"
    _seed_suf = f"_seed{argsP.seed}" if getattr(argsP, 'seed', None) is not None else ""
    _prefix = f"{argsP.canonical_wl_prefix}_{_ts}_{argsP.llm_mode}_{argsP.model_name.replace('/','-')}_b{argsP.batch_size}{_ps}_llm_price{_as}{_ri}{_es}{_seed_suf}"
    # strict=False tolerates bitsandbytes 4-bit quant metadata keys
    # (.absmax / .quant_map / .quant_state.*) present in saved weights but
    # not in the freshly-built PEFT model.
    _llm_p = os.path.join(_sp, f"{_prefix}_llm.pt")
    _r = model_comb.llm.model.load_state_dict(
        torch.load(_llm_p, map_location=argsP.device), strict=False)
    print(f"[skip_train] Loaded LLM weights from {_llm_p}"
          f" (missing={len(_r.missing_keys)}, unexpected={len(_r.unexpected_keys)})")
    _price_p = os.path.join(_sp, f"{_prefix}_price.pt")
    _r = model_comb.price.load_state_dict(
        torch.load(_price_p, map_location=argsP.device), strict=False)
    print(f"[skip_train] Loaded PRICE weights from {_price_p}"
          f" (missing={len(_r.missing_keys)}, unexpected={len(_r.unexpected_keys)})")
    _mlp_p = os.path.join(_sp, f"{_prefix}_mlp.pt")
    _r = model_comb.mlp.load_state_dict(
        torch.load(_mlp_p, map_location=argsP.device), strict=False)
    print(f"[skip_train] Loaded MLP weights from {_mlp_p}"
          f" (missing={len(_r.missing_keys)}, unexpected={len(_r.unexpected_keys)})")
    model_comb.to(argsP.device)
    trained_model = model_comb
    training_time = 0.0
    argsP.main_logger.info(f"[Train] Skipped training (loaded saved finetune weights from {_sp})")
elif _baseline_cached:
    training_time = 0.0
    argsP.main_logger.info(f"[Train] Skipped training (loaded from cache)")
else:
    # retrainMLP inference phase (the fresh MLP trained on the cached post-cross-attn
    # combined embeddings): default to early stopping on val p90 — patience 5, first
    # allowed after epoch 20 — unless the user set it explicitly. Finetunes are
    # unaffected: the joint finetune runs with --llm_mode lora, so it is
    # excluded by algo.
    if (getattr(argsP, 'llm_mode', '') == 'inference'
            and argsP.algo != "llm_price_finetune"
            and not getattr(argsP, 'no_retrain_mlp_at_inference', False)):
        if not int(getattr(argsP, 'early_stop_patience', 0) or 0):
            argsP.early_stop_patience = 5
        if not int(getattr(argsP, 'early_stop_after_epoch', 0) or 0):
            argsP.early_stop_after_epoch = 20
        argsP.main_logger.info(
            f"[retrainMLP] early stop: patience={argsP.early_stop_patience} "
            f"after_epoch={argsP.early_stop_after_epoch}")
    training_start = timer()
    trained_model = train(model_comb, train_loader, val_loader, ds_info, argsP, crit=crit,
                          optimizer=price_finetune_optimizer, scheduler=price_finetune_scheduler,
                          start_epoch=start_epoch,
                          test_loader=test_loader)
    training_time = timer() - training_start
    argsP.main_logger.info(f"[Train] Training took {training_time*1000:.2f} ms")

if argsP.algo == "llm_finetune":
    # Create save directory
    save_path = f"finetuned_models/{argsP.db}{_GSUB}/"
    if not os.path.exists(save_path):
        os.makedirs(save_path)
    save_dir = os.path.dirname(save_path)
    if save_dir and not os.path.exists(save_dir):
        os.makedirs(save_dir, exist_ok=True)

    llm_sd = LLM.model.state_dict()

    stats_suffix = ""
    if getattr(argsP, "stats_token_inject", False):
        stats_mode = getattr(argsP, "stats_token_mode", "per_column")
        stats_suffix = f"_statTok-{stats_mode}"
    task_str = "card" if argsP.card else "time"
    _ft_prefix = f"{argsP.canonical_wl_prefix}_{task_str}_{argsP.llm_mode}_{argsP.model_name.replace('/','-')}_b{argsP.batch_size}{stats_suffix}"
    llm_out = os.path.join(save_dir, f"{_ft_prefix}_llm.pt")
    torch.save(llm_sd, llm_out)
    print(f"🔖  Saved LLM weights to {llm_out}")
    # Also save the jointly-trained MLP head so it can be reloaded for
    # finetune-phase evaluation (skip_train_load_finetuned_weights).
    # trained_model is nn.Sequential(LLM, MLP); MLP is index 1.
    mlp_out = os.path.join(save_dir, f"{_ft_prefix}_mlp.pt")
    torch.save(trained_model[1].state_dict(), mlp_out)
    print(f"🔖  Saved MLP weights to {mlp_out}")

    # Trained-MLP-head test evaluation + CSV (mirrors the llm_price_finetune
    # branch). Derives CSV path from --log_file so it lands in results/
    # alongside the retrain-MLP CSV with a distinct _llm_finetune_ token.
    try:
        import re as _re
        _norm_ft = ds_info.card_norm if argsP.card else ds_info.cost_norm
        _ft_csv_path = None
        _lf = getattr(argsP, 'log_file', None)
        if _lf:
            _csv_dir = _re.sub(r'(^|/)logs/', r'\1results/',
                               os.path.dirname(_lf), count=1)
            _csv_dir = _csv_dir.replace('logs_Train_', 'results_Train_', 1)
            _stem = os.path.basename(_lf).rsplit('.log', 1)[0]
            # Strip any trailing _seed{N} from the log stem so we can re-append
            # one in the canonical _cdf_seed{N}.csv position. The downstream
            # aggregator (to_table_relative.py) globs for "*cdf*seed*.csv", so
            # the _seed suffix MUST be present — even on mode-2 logs whose
            # filenames don't carry a seed by default.
            _stem_no_seed = _re.sub(r'_seed\d+$', '', _stem)
            _seed_for_csv = getattr(argsP, 'seed', None)
            _seed_suf = f'_seed{int(_seed_for_csv)}' if _seed_for_csv is not None else ''
            _csv_name = f'{_stem_no_seed}_cdf{_seed_suf}.csv'
            _ft_csv_path = os.path.join(_csv_dir, _csv_name)
            os.makedirs(_csv_dir, exist_ok=True)
        print("\n[Trained-MLP-head] Running test evaluation on trained joint LLM+MLP...")
        _q_errs_ft, _, _q_dist_ft, _ = evaluate(
            trained_model, argsP, test_loader, _norm_ft, device, data_sec="test",
            save_embeddings=False, test_embeddings=None,
            test_templates=test_templates, output_dir_qerror=None,
            workload_test=argsP.workload_test, verbose_info=False,
            train_embeddings=None, test_texts=None,
        )
        print("[Trained-MLP-head] Test Q-errors (joint LLM+MLP):", _q_errs_ft)
        if _ft_csv_path is not None and _q_dist_ft is not None:
            save_error_cdf(_q_dist_ft, _ft_csv_path, error_type="Qerror")
    except Exception as _e_eval:
        print(f"[Trained-MLP-head] Test evaluation failed: {_e_eval}")
elif argsP.algo == "llm_price_finetune" and not getattr(argsP, '_cross_attn_inference', False):
    # Save components: LLM, PRICE, MLP
    save_path = f"finetuned_models/{argsP.db}{_GSUB}/"
    os.makedirs(save_path, exist_ok=True)

    task_str = "card" if argsP.card else "time"
    _price_suffix = _price_path_suffix(argsP)
    _arch_suffix = _arch_path_suffix(argsP)
    rand_init_suffix = "_randInit" if getattr(argsP, 'price_random_init', False) else ""
    epoch_suffix = f"_e{argsP.num_epoch}"
    # Per-seed joint-finetune weights: different evaluation seeds get distinct
    # LLM+PRICE+MLP artifacts (re-finetune required) so a result CSV with
    # seedN can be traced back to a finetune run that actually used seedN.
    seed_suffix = f"_seed{argsP.seed}" if getattr(argsP, 'seed', None) is not None else ""
    prefix = f"{argsP.canonical_wl_prefix}_{task_str}_{argsP.llm_mode}_{argsP.model_name.replace('/','-')}_b{argsP.batch_size}{_price_suffix}_llm_price{_arch_suffix}{rand_init_suffix}{epoch_suffix}{seed_suffix}"

    llm_sd = trained_model.llm.model.state_dict()
    llm_out = os.path.join(save_path, f"{prefix}_llm.pt")
    torch.save(llm_sd, llm_out)
    print(f"Saved LLM weights to {llm_out}")

    price_sd = trained_model.price.state_dict()
    price_out = os.path.join(save_path, f"{prefix}_price.pt")
    torch.save(price_sd, price_out)
    print(f"Saved PRICE weights to {price_out}")

    mlp_sd = trained_model.mlp.state_dict()
    mlp_out = os.path.join(save_path, f"{prefix}_mlp.pt")
    torch.save(mlp_sd, mlp_out)
    print(f"Saved MLP weights to {mlp_out}")


    # Trained-model test evaluation: run the joint LLM+PRICE+MLP forward on the
    # test split (same path used for val during training) and report q-errors.
    # This is independent of the (separate) llm_price inference invocation and
    # isolates how well the trained joint MLP head itself generalises to
    # unseen test queries.
    try:
        _norm_train_test = ds_info.card_norm if argsP.card else ds_info.cost_norm
        # Derive a CSV path from --log_file so the finetune-phase MLP results
        # land in results/ alongside the retrain-MLP CSVs (same dir, distinct
        # name via _finetune_lora_ token vs _pretrained-lora_). Insert _cdf
        # before _seed so the filename matches to_table_seeds' *cdf*seed* glob.
        import re as _re
        _ft_csv_path = None
        _lf = getattr(argsP, 'log_file', None)
        if _lf:
            # Swap top-level logs/ → results/ and the per-experiment
            # logs_Train_… → results_Train_… subdir.
            _csv_dir = _re.sub(r'(^|/)logs/', r'\1results/',
                               os.path.dirname(_lf), count=1)
            _csv_dir = _csv_dir.replace('logs_Train_', 'results_Train_', 1)
            _stem = os.path.basename(_lf).rsplit('.log', 1)[0]
            _csv_name = _re.sub(r'_seed(\d+)$', r'_cdf_seed\1', _stem) + '.csv'
            _ft_csv_path = os.path.join(_csv_dir, _csv_name)
            os.makedirs(_csv_dir, exist_ok=True)
        print("\n[Trained-MLP-head] Running test evaluation on trained joint model...")
        _q_errs_train, _, _q_dist_train, _ = evaluate(
            trained_model, argsP, test_loader, _norm_train_test, device, data_sec="test",
            save_embeddings=False, test_embeddings=None,
            test_templates=test_templates, output_dir_qerror=None,
            workload_test=argsP.workload_test, verbose_info=False,
            train_embeddings=None, test_texts=None,
        )
        print("\n[Trained-MLP-head] Test Q-errors (joint LLM+PRICE+MLP, end-to-end):")
        print("Q Errors:", _q_errs_train)
        if _ft_csv_path is not None and _q_dist_train is not None:
            save_error_cdf(_q_dist_train, _ft_csv_path, error_type="Qerror")
    except Exception as _e_eval:
        print(f"[Trained-MLP-head] Test evaluation failed: {_e_eval}")

elif argsP.algo == "price_finetune":
    # Save finetuned PRICE model (the inner RegressionModel state_dict).
    # Filename now includes the task tag (time/card), the architecture suffix
    # (e.g. _noLLMres), and the seed so multi-seed runs don't overwrite each
    # other.  After saving, run evaluation on the test loader and emit the
    # same `_cdf_*.csv` artifact as the llm/llm_price branches so this mode
    # is comparable in downstream plotting.
    save_path = f"finetuned_models/{argsP.db}{_GSUB}/"
    os.makedirs(save_path, exist_ok=True)

    _price_suffix = _price_path_suffix(argsP)
    _arch_suffix = _arch_path_suffix(argsP)
    rand_init_suffix = "_randInit" if getattr(argsP, 'price_random_init', False) else ""
    n_layers_suffix = f"_pL{argsP.price_n_layers}" if getattr(argsP, 'price_n_layers', 6) != 6 else ""
    ffn_ratio_suffix = f"_ffn{argsP.price_ffn_ratio:g}" if getattr(argsP, 'price_ffn_ratio', 4.0) != 4.0 else ""
    epoch_suffix = f"_e{argsP.num_epoch}"
    seed_suffix = f"_seed{argsP.seed}" if hasattr(argsP, 'seed') else ""
    task_tag = "card" if argsP.card else "time"
    price_out = os.path.join(
        save_path,
        f"{argsP.canonical_wl_prefix}_{task_tag}_b{argsP.batch_size}{_price_suffix}{_arch_suffix}{rand_init_suffix}{n_layers_suffix}{ffn_ratio_suffix}{epoch_suffix}{seed_suffix}_price_separate.pt"
    )
    torch.save(trained_model.model.state_dict(), price_out)
    print(f"Saved separately finetuned PRICE weights to {price_out}")

    # Run test evaluation + emit CSV (mirrors the llm/llm_price `else` branch
    # at the bottom of train.py).  Without this the no_llm_residual variant
    # produces no result file and can't be compared against modes 1/2/7/12.
    # Skip silently when no --output_dir_qerror was passed (e.g. legacy
    # price_finetune callers that don't supply one).
    if getattr(argsP, 'output_dir_qerror', None):
        test_start = timer()
        _norm = ds_info.card_norm if argsP.card else ds_info.cost_norm
        q_errors, abs_errors, q_errors_dist, abs_errors_dist = evaluate(
            trained_model, argsP, test_loader, _norm, device, data_sec="test",
            save_embeddings=False, test_embeddings=None,
            test_templates=test_templates,
            output_dir_qerror=argsP.output_dir_qerror,
            workload_test=argsP.workload_test,
            verbose_info=False,
            train_embeddings=None,
            test_texts=None,
        )
        test_time = timer() - test_start
        argsP.main_logger.info(f"[Test] Testing took {test_time*1000:.2f} ms")
        save_error_cdf(q_errors_dist, argsP.output_dir_qerror, error_type="Qerror")
        print("\nTest Results:")
        print("Q Errors:", q_errors)
else:
  # Save cached baseline model after training
  if argsP.algo in ("aimai", "qf", "e2e_cost") and not _baseline_cached:
    os.makedirs(_cache_dir, exist_ok=True)
    torch.save(trained_model.state_dict(), _cache_path)
    print(f"Saved {argsP.algo} model to {_cache_path}")

  # Save MLP weights for llm / llm_price inference (seed in filename)
  if argsP.algo in ("llm", "llm_price") and isinstance(trained_model, nn.Module):
    save_path = f"finetuned_models/{argsP.db}{_GSUB}/"
    os.makedirs(save_path, exist_ok=True)
    task_str = "card" if argsP.card else "time"
    pretrained_str = argsP.llm_pretrained or "None"
    model_str = argsP.model_name.replace('/', '-')
    wl_str = '-'.join(argsP.workloads_train)
    # Truncate long workload strings to avoid exceeding filesystem filename limits (255 chars)
    if len(wl_str) > 80:
        import hashlib
        wl_hash = hashlib.md5(wl_str.encode()).hexdigest()[:8]
        wl_str = f"{len(argsP.workloads_train)}dbs_{wl_hash}"
    # Note: this path is only used for the non-joint-price MLP save (line 767+).
    # The joint-price path uses argsP.canonical_wl_prefix which is already truncated.
    ftb_str = f"_ftb{argsP.ft_batch_size}" if pretrained_str != "None" else ""
    price_str = ""
    price_variant_str = _price_path_suffix(argsP)
    if argsP.algo == "llm_price":
        price_source = getattr(argsP, 'price_weights_source', 'pretrained')
        price_str = f"_price-{price_source}"
    test_str = f"_test-{argsP.workload_test}" if argsP.workload_test else ""
    mlp_name = f"{wl_str}{test_str}_{task_str}_{argsP.algo}_pretrained-{pretrained_str}{price_str}{price_variant_str}_{model_str}_emb{argsP.embed_size}_h{argsP.hid_units}{ftb_str}_seed{argsP.seed}_mlp.pt"
    mlp_out = os.path.join(save_path, mlp_name)
    torch.save(trained_model.state_dict(), mlp_out)
    print(f"Saved MLP weights to {mlp_out}")

  # Log testing time for all other algorithms
  test_start = timer()
  
  # Prepare embeddings and metadata for verbose output
  train_embeddings_verbose = None
  
  if argsP.verbose_info:
    print("Preparing data for verbose output...")
    
    if argsP.algo in ("llm", "llm_price"):
      # For LLM/LLM+PRICE algorithm, get training embeddings for KNN calculation
      train_embeddings_verbose = ds.tensors[0].cpu().numpy()
    
    elif argsP.algo in ['aimai', 'qf', 'e2e_cost']:
      # For non-LLM algorithms with Sequential models
      train_embeddings_verbose = utilsTrain.prepare_non_llm_verbose_embeddings(
          argsP, trained_model, device, ds_info, dat_dict,
          dat_paths_train_list, dat_path_test, dat_path
      )
  
  if not argsP.card:
    q_errors, abs_errors, q_errors_dist, abs_errors_dist = evaluate(trained_model, argsP, test_loader, ds_info.cost_norm, device, data_sec="test",
                                                                    save_embeddings=False,
                                                                    # save_embeddings=(argsP.workload_test in ["tpch", "tpcds"] and test_templates is not None),
                                                                    test_embeddings=(test_ds.tensors[0].cpu().numpy() if argsP.algo in ("llm", "llm_price") and hasattr(test_ds, 'tensors') else None),
                                                                    test_templates=test_templates,
                                                                    output_dir_qerror=argsP.output_dir_qerror,
                                                                    workload_test=argsP.workload_test,
                                                                    verbose_info=argsP.verbose_info,
                                                                    train_embeddings=train_embeddings_verbose,
                                                                    test_texts=None)
  else:
    q_errors, abs_errors, q_errors_dist, abs_errors_dist = evaluate(trained_model, argsP, test_loader, ds_info.card_norm, device, data_sec="test",
                                                                    save_embeddings=False,
                                                                    test_embeddings=(test_ds.tensors[0].cpu().numpy() if argsP.algo in ("llm", "llm_price") and hasattr(test_ds, 'tensors') else None),
                                                                    test_templates=test_templates,
                                                                    output_dir_qerror=argsP.output_dir_qerror,
                                                                    workload_test=argsP.workload_test,
                                                                    verbose_info=argsP.verbose_info,
                                                                    train_embeddings=train_embeddings_verbose,
                                                                    test_texts=None)
  test_time = timer() - test_start
  argsP.main_logger.info(f"[Test] Testing took {test_time*1000:.2f} ms")

  save_error_cdf(q_errors_dist, argsP.output_dir_qerror, error_type="Qerror")
  # save_error_cdf(abs_errors_dist, argsP.output_dir_abs, error_type="abs_error")

  if argsP.algo in ("llm", "llm_price"):
    output_dir_lvq = argsP.output_dir_qerror.replace("cdf", "length_vs_qerror")
    if test_lengths is not None:
        with open(output_dir_lvq, "w") as f:
            w = csv.writer(f)
            w.writerow(["plan_length", "q_error"])
            for L, Q in zip(test_lengths, q_errors_dist):
                w.writerow([L, Q])

  print("\nTest Results:")
  print("Q Errors:", q_errors)
  # print("Absolute Errors:", abs_errors)
