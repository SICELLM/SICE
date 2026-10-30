"""Budget-efficient model selection: round-based Pareto filtering vs. random sampling.

Evaluates the model-selection strategies of the paper on a pre-computed pool
of fine-tuned backbones (data/model_selection/<workload>_pool.csv):

  * random sampling                (init random,     no filter)
  * latency-stratified sampling    (init stratified, no filter)
  * random + multi-fidelity filter (init random,     Pareto filter at e12)
  * full design                    (init stratified, Pareto filter at e12)

Pool CSV schema (one row per candidate backbone):
  model, params_m,
  val_p90_e4, val_p90_e8, val_p90_e12, val_p90_e16,   # validation P90 Q-error
  test_p90_e16,                                       # test P90 Q-error
  train_h_e1_4, train_h_e5_8, train_h_e9_12, train_h_e13_16,  # fine-tuning hours per 4-epoch chunk
  inference_ms                                        # deployed per-query latency

Metric: deployment regret. At each latency budget tau (the latencies of the
pool's true Pareto-frontier models), the practitioner deploys the evaluated
model with the best validation Q-error among those with inference_ms <= tau
and pays its TEST Q-error; regret(tau) is the ratio to the pool-optimal test
Q-error under tau. We report the worst case and the mean over budgets.

All selection decisions use validation P90; regret is paid in test P90.
"""
from __future__ import annotations

import argparse
from pathlib import Path
from typing import Optional

import numpy as np
import pandas as pd

REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_POOL_CSV = REPO_ROOT / "data/model_selection/stats_pool.csv"

DEFAULT_INIT_KS = (6, 8, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36,
                   38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66,
                   68, 70, 72, 74, 76, 78)
DEFAULT_SEEDS = tuple(range(30))
N_BUCKETS = 6
REF_QERR_MARGIN = 1.05  # reference Q-error margin used by --uncovered ref


# ---------- Pareto utilities ----------

def pareto_levels(points) -> list:
    """Assign a Pareto level to each point (lower = better; both axes
    minimized). Level 1 = Pareto frontier, level 2 = frontier of the
    remaining points, and so on. Ties in (x, y) share a level."""
    n = len(points)
    level = [0] * n
    remaining = list(range(n))
    lvl = 1
    while remaining:
        front = []
        for i in remaining:
            dominated = False
            xi, yi = points[i]
            for j in remaining:
                if i == j:
                    continue
                xj, yj = points[j]
                if (xj <= xi and yj <= yi) and (xj < xi or yj < yi):
                    dominated = True
                    break
            if not dominated:
                front.append(i)
        if not front:
            break
        for idx in front:
            level[idx] = lvl
        remaining = [i for i in remaining if i not in front]
        lvl += 1
    return level


def pareto_frontier_indices(points: np.ndarray) -> list:
    pts = [(float(x), float(y)) for x, y in points]
    levels = pareto_levels(pts)
    return [i for i, lvl in enumerate(levels) if lvl == 1]


# ---------- bucketing + init picks ----------

def latency_buckets(latencies: np.ndarray, n_buckets: int = N_BUCKETS) -> np.ndarray:
    """Even-rank quantile buckets: each bucket gets ~n/n_buckets models."""
    n = len(latencies)
    order = np.argsort(latencies, kind="stable")
    buckets = np.empty(n, dtype=int)
    for rank, idx in enumerate(order):
        buckets[idx] = min(rank * n_buckets // n, n_buckets - 1)
    return buckets


def latency_priority(pool: pd.DataFrame, n_bins: int, seed: int) -> list:
    """Round-robin priority list across `n_bins` latency-quantile bins.
    Within each bin, members are shuffled by `seed`. Then we emit
    bin0[0], bin1[0], ..., bin{N-1}[0], bin0[1], bin1[1], ..., until
    every member appears.

    Property: priority[:K] is the init at init_K=K, and is strictly
    nested in K (larger K is a superset of smaller K).
    """
    rng = np.random.default_rng(seed)
    lat = pool["inference_ms"].to_numpy(dtype=float)
    n_bins = min(n_bins, len(pool))
    buckets = latency_buckets(lat, n_bins)
    bin_members = []
    for b in range(n_bins):
        members = list(np.where(buckets == b)[0])
        rng.shuffle(members)
        bin_members.append(members)
    priority = []
    while any(bin_members):
        for b in range(n_bins):
            if bin_members[b]:
                priority.append(int(bin_members[b].pop(0)))
    return priority


def random_priority(pool: pd.DataFrame, seed: int) -> list:
    """Uniform random priority list. Nested-in-K monotonicity holds because
    we draw a single permutation per seed and return its prefix."""
    rng = np.random.default_rng(seed)
    perm = np.arange(len(pool))
    rng.shuffle(perm)
    return [int(i) for i in perm]


def pick_init(pool: pd.DataFrame, K: int, method: str, seed: int,
              n_init_bins: int = N_BUCKETS) -> list:
    """First-round seed picker: 'stratified' (latency-quantile round-robin)
    or 'random' (uniform permutation prefix)."""
    if method == "random":
        priority = random_priority(pool, seed)
    elif method == "stratified":
        priority = latency_priority(pool, n_init_bins, seed)
    else:
        raise ValueError(f"unknown init strategy: {method}")
    return priority[:min(K, len(priority))]


# ---------- keep step (multi-fidelity Pareto filter) ----------

def keep_top(survivors: list, val_p90_arr: np.ndarray, latency_arr: np.ndarray,
             keep_ratio: float, n_buckets: int = N_BUCKETS) -> list:
    """Dynamic-floor keep: keep_n = max(n_buckets, frontier_size, ceil(prev*kr)),
    then keep top-keep_n by (pareto_level, val_p90, latency) ascending."""
    n = len(survivors)
    if n == 0:
        return []
    pts = [(float(latency_arr[s]), float(val_p90_arr[s])) for s in survivors]
    levels = pareto_levels(pts)
    frontier_size = sum(1 for lvl in levels if lvl == 1)
    keep_n = max(n_buckets, frontier_size, int(np.ceil(n * keep_ratio)))
    keep_n = min(keep_n, n)
    if keep_n >= n:
        return list(survivors)
    order = sorted(range(n), key=lambda i: (
        levels[i],
        float(val_p90_arr[survivors[i]]),
        float(latency_arr[survivors[i]]),
    ))
    keep_set = set(order[:keep_n])
    return [survivors[i] for i in range(n) if i in keep_set]


def keep_top_random(survivors: list, val_p90_arr: np.ndarray,
                    latency_arr: np.ndarray, keep_ratio: float,
                    n_buckets: int = N_BUCKETS,
                    rng: Optional[np.random.Generator] = None) -> list:
    """Pareto-level-priority keep with random tie-breaking inside the cutoff
    level: sweep levels 1, 2, ... in ascending order, accepting every model at
    a level while it fits inside keep_n; at the first level that overflows,
    fill the remaining slots by sampling uniformly without replacement from
    that level. Same keep_n floor as keep_top."""
    n = len(survivors)
    if n == 0:
        return []
    pts = [(float(latency_arr[s]), float(val_p90_arr[s])) for s in survivors]
    levels = pareto_levels(pts)
    frontier_size = sum(1 for lvl in levels if lvl == 1)
    keep_n = max(n_buckets, frontier_size, int(np.ceil(n * keep_ratio)))
    keep_n = min(keep_n, n)
    if keep_n >= n:
        return list(survivors)
    if rng is None:
        rng = np.random.default_rng()
    by_level: dict = {}
    for i, lvl in enumerate(levels):
        by_level.setdefault(lvl, []).append(i)
    kept_local: list = []
    for lvl in sorted(by_level):
        bucket = by_level[lvl]
        remaining = keep_n - len(kept_local)
        if remaining <= 0:
            break
        if len(bucket) <= remaining:
            kept_local.extend(bucket)
        else:
            picks = rng.choice(len(bucket), size=remaining, replace=False)
            kept_local.extend(bucket[int(p)] for p in picks)
            break
    keep_set = set(kept_local)
    return [survivors[i] for i in range(n) if i in keep_set]


# ---------- selection strategies ----------

def run_ours(pool: pd.DataFrame, init_K: int, method: str, seed: int,
             keep_ratio: float = 0.85,
             n_init_bins: int = N_BUCKETS,
             keep_strategy: str = "random",
             decision_epochs: Optional[list] = None) -> dict:
    """Round-based Pareto filtering.

    `decision_epochs` is the list of epoch milestones (subset of {4, 8, 12})
    at which the multi-fidelity filter prunes; [] means no filter (train the
    whole init set to e16).
    """
    if decision_epochs is None:
        decision_epochs = []
    for ep in decision_epochs:
        if ep not in (4, 8, 12):
            raise ValueError(f"decision_epochs must contain only 4/8/12, got {ep}")
    decision_epochs = sorted(set(decision_epochs))
    init_idx = pick_init(pool, init_K, method, seed, n_init_bins=n_init_bins)

    t_chunks = [
        (4, pool["train_h_e1_4"].to_numpy(dtype=float)),
        (8, pool["train_h_e5_8"].to_numpy(dtype=float)),
        (12, pool["train_h_e9_12"].to_numpy(dtype=float)),
        (16, pool["train_h_e13_16"].to_numpy(dtype=float)),
    ]
    lat = pool["inference_ms"].to_numpy(dtype=float)
    val_at = {
        4: pool["val_p90_e4"].to_numpy(dtype=float),
        8: pool["val_p90_e8"].to_numpy(dtype=float),
        12: pool["val_p90_e12"].to_numpy(dtype=float),
    }

    if keep_strategy == "random":
        _keep_rng = np.random.default_rng(seed)
        def keep_fn(survivors, val_arr, lat_arr, kr, n_buckets):
            return keep_top_random(survivors, val_arr, lat_arr, kr,
                                   n_buckets=n_buckets, rng=_keep_rng)
    elif keep_strategy == "topval":
        keep_fn = keep_top
    else:
        raise ValueError(f"unknown keep strategy: {keep_strategy}")

    survivors = list(init_idx)
    cost_h = 0.0
    for end_ep, t_chunk in t_chunks:
        cost_h += float(t_chunk[survivors].sum())
        if end_ep in decision_epochs:
            survivors = keep_fn(survivors, val_at[end_ep], lat, keep_ratio,
                                n_buckets=n_init_bins)

    return {
        "init_idx": init_idx,
        "final_idx": survivors,
        "total_train_h": cost_h,
        "decision_epochs": decision_epochs,
    }


def random_monotonic_prefix(pool: pd.DataFrame, total_train_h: float,
                            seed: int) -> dict:
    """Cost-matched random baseline: one shuffle per seed; take the prefix of
    models whose full 16-epoch fine-tuning cost fits the budget.

    The budget comparison uses a small relative tolerance so that a model
    whose inclusion consumes the budget *exactly* (which happens by
    construction when the compared strategy also trained whole models to
    e16) is deterministically included, instead of depending on
    floating-point summation order."""
    rng = np.random.default_rng(seed)
    order = rng.permutation(len(pool))
    full_cost = (
        pool["train_h_e1_4"].to_numpy()
        + pool["train_h_e5_8"].to_numpy()
        + pool["train_h_e9_12"].to_numpy()
        + pool["train_h_e13_16"].to_numpy()
    )
    budget = total_train_h * (1.0 + 1e-9)
    chosen, used = [], 0.0
    for i in order:
        if used + full_cost[i] > budget:
            break
        chosen.append(int(i))
        used += float(full_cost[i])
    return {"idx": chosen, "total_train_h": used}


# ---------- evaluation: deployment regret ----------

def regret_metrics(pool: pd.DataFrame, idxs: list,
                   true_front_lat: np.ndarray, true_front_q: np.ndarray,
                   ref_qerr: float, uncovered: str = "skip") -> dict:
    """Deployment regret of a selection, over the true-frontier latency budgets.

    At each budget tau, the practitioner val-selects among the evaluated
    models that fit the budget (argmin val_p90_e16 with inference_ms <= tau)
    and pays that model's TEST Q-error. Regret(tau) = that test Q-error /
    the pool-optimal test Q-error under tau. Regret is a ratio >= 1.

    Budgets with no evaluated model that fits are handled per `uncovered`:
    - "skip" (default): exclude the budget from the max/mean; coverage is
      reported separately via `uncovered_frac`.
    - "ref": charge `ref_qerr` (frontier-worst Q-error x margin) as the
      achieved value.
    """
    if uncovered not in ("ref", "skip"):
        raise ValueError(f"uncovered must be 'ref' or 'skip', got {uncovered!r}")
    if not idxs:
        return {"regret_worst": float("inf"), "regret_mean": float("inf"),
                "uncovered_frac": 1.0}
    sub = pool.iloc[idxs]
    lat = sub["inference_ms"].to_numpy(dtype=float)
    val = sub["val_p90_e16"].to_numpy(dtype=float)
    test = sub["test_p90_e16"].to_numpy(dtype=float)
    regrets, n_uncovered = [], 0
    for tau, q_opt in zip(true_front_lat, true_front_q):
        mask = lat <= tau
        if not mask.any():
            n_uncovered += 1
            if uncovered == "skip":
                continue
            achieved = ref_qerr
        else:
            achieved = float(test[int(np.argmin(np.where(mask, val, np.inf)))])
        regrets.append(achieved / float(q_opt))
    return {
        "regret_worst": float(np.max(regrets)) if regrets else float("nan"),
        "regret_mean": float(np.mean(regrets)) if regrets else float("nan"),
        "uncovered_frac": n_uncovered / len(true_front_lat),
    }


def true_frontier(pool: pd.DataFrame):
    """Sorted (latencies, q-errors) of the pool's test-side Pareto frontier,
    plus the reference Q-error used by --uncovered ref."""
    pts = np.column_stack([pool["inference_ms"].astype(float),
                           pool["test_p90_e16"].astype(float)])
    front_idx = pareto_frontier_indices(pts)
    fr = sorted((float(pts[i, 0]), float(pts[i, 1])) for i in front_idx)
    lat = np.array([x for x, _ in fr])
    q = np.array([y for _, y in fr])
    return lat, q, q.max() * REF_QERR_MARGIN


# ---------- main ----------

def main():
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--pool_csv", default=str(DEFAULT_POOL_CSV),
                   help="Model pool CSV (data/model_selection/<workload>_pool.csv).")
    p.add_argument("--init_Ks", type=int, nargs="+", default=list(DEFAULT_INIT_KS))
    p.add_argument("--seeds", type=int, nargs="+", default=list(DEFAULT_SEEDS))
    p.add_argument("--init_strategy", type=str, default="stratified",
                   choices=["stratified", "random"],
                   help="First-round sampling: latency-stratified or uniform random.")
    p.add_argument("--decision_epochs", type=int, nargs="*", default=[],
                   help="Epoch milestones (subset of {4,8,12}) at which the "
                        "multi-fidelity Pareto filter prunes. Empty = no filter.")
    p.add_argument("--keep_ratio", type=float, default=0.85,
                   help="Fraction of survivors retained at each pruning point.")
    p.add_argument("--keep_strategy", type=str, default="random",
                   choices=["random", "topval"],
                   help="Tie-breaking inside the Pareto boundary layer at a "
                        "pruning point.")
    p.add_argument("--n_init_bins", type=int, default=N_BUCKETS,
                   help="Latency-quantile bins for stratified init.")
    p.add_argument("--uncovered", type=str, default="skip",
                   choices=["skip", "ref"],
                   help="How regret treats budgets no evaluated model fits.")
    p.add_argument("--output", default="model_selection_summary.csv")
    p.add_argument("--per_seed_output", default="model_selection_per_seed.csv")
    args = p.parse_args()

    pool = pd.read_csv(args.pool_csv)
    required = {"model", "val_p90_e4", "val_p90_e8", "val_p90_e12",
                "val_p90_e16", "test_p90_e16", "train_h_e1_4", "train_h_e5_8",
                "train_h_e9_12", "train_h_e13_16", "inference_ms"}
    missing = required - set(pool.columns)
    if missing:
        raise SystemExit(f"{args.pool_csv} lacks columns: {sorted(missing)}")
    print(f"Loaded {len(pool)} models from {args.pool_csv}.")

    true_front_lat, true_front_q, ref_qerr = true_frontier(pool)
    print(f"True frontier: {len(true_front_lat)} models; "
          f"budgets (ms): {np.round(true_front_lat, 1).tolist()}")

    # Brute force: fine-tune every candidate, select by validation.
    brute = regret_metrics(pool, list(range(len(pool))), true_front_lat,
                           true_front_q, ref_qerr, uncovered=args.uncovered)
    print(f"Fully fine-tune all models: regret worst={brute['regret_worst']:.3f}x "
          f"mean={brute['regret_mean']:.3f}x")

    rows = []
    for K in args.init_Ks:
        for seed in args.seeds:
            r = run_ours(pool, K, args.init_strategy, seed,
                         keep_ratio=args.keep_ratio,
                         n_init_bins=args.n_init_bins,
                         keep_strategy=args.keep_strategy,
                         decision_epochs=args.decision_epochs)
            rd = random_monotonic_prefix(pool, r["total_train_h"], seed)
            rg = regret_metrics(pool, r["final_idx"], true_front_lat,
                                true_front_q, ref_qerr, uncovered=args.uncovered)
            rg_r = regret_metrics(pool, rd["idx"], true_front_lat,
                                  true_front_q, ref_qerr, uncovered=args.uncovered)
            _sched = ",".join(str(e) for e in r["decision_epochs"]) or "(none)"
            rows.append({
                "schedule": _sched,
                "keep_ratio": args.keep_ratio,
                "init_K": K,
                "seed": seed,
                "total_h": r["total_train_h"],
                "n_rand": len(rd["idx"]),
                "regret_worst_ours": rg["regret_worst"],
                "regret_mean_ours": rg["regret_mean"],
                "regret_worst_rand": rg_r["regret_worst"],
                "regret_mean_rand": rg_r["regret_mean"],
                "uncovered_ours": rg["uncovered_frac"],
                "uncovered_rand": rg_r["uncovered_frac"],
                "brute_regret_worst": brute["regret_worst"],
                "brute_regret_mean": brute["regret_mean"],
                "n_final_ours": len(r["final_idx"]),
            })

    per_seed_df = pd.DataFrame(rows)
    per_seed_df.to_csv(args.per_seed_output, index=False)
    print(f"Wrote per-seed rows: {args.per_seed_output}")

    agg = per_seed_df.groupby(["schedule", "keep_ratio", "init_K"]).agg(
        total_h=("total_h", "mean"),
        n_rand=("n_rand", "mean"),
        regret_worst_ours=("regret_worst_ours", "mean"),
        regret_worst_rand=("regret_worst_rand", "mean"),
    ).reset_index()
    agg["dRegret"] = agg["regret_worst_rand"] - agg["regret_worst_ours"]
    agg = agg.round({"total_h": 2, "n_rand": 2, "regret_worst_ours": 3,
                     "regret_worst_rand": 3, "dRegret": 3})
    agg.to_csv(args.output, index=False)
    print(f"\n=== Deployment regret (means over {len(args.seeds)} seeds) ===")
    print(agg.to_string(index=False))
    print(f"\nWrote summary: {args.output}")


if __name__ == "__main__":
    main()
