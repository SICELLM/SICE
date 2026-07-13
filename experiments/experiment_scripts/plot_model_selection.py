#!/usr/bin/env python3
"""Plot deployment regret vs fine-tuning time for the model-selection strategies.

Runs compare_round_pareto.py once per strategy over a sweep of initial pool
sizes and plots mean worst-case regret against total fine-tuning hours:

    random                — random sampling, no filter
    stratified            — latency-stratified sampling, no filter
    random+filter         — random sampling + multi-fidelity Pareto filter
    full                  — latency-stratified sampling + multi-fidelity filter

Outputs: <output>.png (dots + interpolated curves + in-figure legend),
<output>.pdf (paper styling, lines + dots, no legend), and
<output>_legend.pdf (standalone shared legend).

Usage:
    python experiments/experiment_scripts/plot_model_selection.py \\
        --pool_csv data/model_selection/tpch_pool.csv \\
        --output ./model_selection_tpch.png --title "TPC-H"
"""
from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

SCRIPT = Path(__file__).resolve().parent / "compare_round_pareto.py"

# (key, display label, color, marker, extra CLI args for compare_round_pareto)
STRATEGIES = [
    ("full", "Latency stratified sampling + multi-fidelity filter (full design)",
     "#8c564b", "P",
     ["--init_strategy", "stratified", "--decision_epochs", "12",
      "--keep_strategy", "random"]),
    ("stratified", "Latency stratified sampling", "#e377c2", "*",
     ["--init_strategy", "stratified"]),
    ("random_filter", "Random sampling + multi-fidelity filter", "#17becf", "h",
     ["--init_strategy", "random", "--decision_epochs", "12",
      "--keep_strategy", "random"]),
    ("random", "Random sampling", "#7f7f7f", "x",
     ["--init_strategy", "random"]),
]

# Paper-figure styling: axis labels 24pt bold, ticks 20pt, legend 20pt (PDF only).
PAPER_LABEL_FS = 24
PAPER_TICK_FS = 20
PAPER_LEGEND_FS = 20


def run_and_load(extra_args, seeds, init_Ks, keep_ratio, pool_csv, out_csv,
                 regret_kind="worst", uncovered="skip"):
    """Run compare_round_pareto.py; return per-init_K aggregate DataFrame."""
    cmd = [
        sys.executable, str(SCRIPT),
        "--pool_csv", str(pool_csv),
        "--keep_ratio", str(keep_ratio),
        "--seeds", *map(str, seeds),
        "--init_Ks", *map(str, init_Ks),
        "--uncovered", uncovered,
        "--per_seed_output", str(out_csv),
        "--output", str(Path(out_csv).with_suffix(".summary.csv")),
        *extra_args,
    ]
    print(f"  $ {' '.join(cmd)}", flush=True)
    subprocess.run(cmd, capture_output=True, text=True, check=True)

    df = pd.read_csv(out_csv)
    col = f"regret_{regret_kind}_ours"
    df["metric_val"] = df[col]
    brute = df[f"brute_regret_{regret_kind}"].iloc[0]
    agg = df.groupby("init_K").agg(
        regret_mean=("metric_val", "mean"),
        regret_sem=("metric_val",
                    lambda s: s.dropna().std() / np.sqrt(max(len(s.dropna()), 1))),
        hours_mean=("total_h", "mean"),
        n=("metric_val", "size"),
    ).reset_index()
    agg["brute"] = brute
    return agg


def _fit_curve(x, y, x_grid):
    """Monotone piecewise-cubic (PCHIP) interpolation through the mean dots,
    parameterized in log(x): the curve passes exactly through every dot with
    no overshoot between dots."""
    if len(x) < 3:
        return np.interp(x_grid, x, y)
    from scipy.interpolate import PchipInterpolator
    ux, inv = np.unique(x, return_inverse=True)
    uy = np.array([y[inv == i].mean() for i in range(len(ux))])
    return PchipInterpolator(np.log(ux), uy)(np.log(x_grid))


def _plot_axes(ax, records, *, xlabel, ylabel, title, show_dots, no_band,
               label_fs, label_weight, tick_fs, title_fs, line_scale,
               with_legend, setting_lw=None):
    """Draw all strategy curves (+ brute-force line) onto `ax`."""
    brute = None
    for rec in records:
        agg, label, color, marker = rec["agg"], rec["label"], rec["color"], rec["marker"]
        x = agg["hours_mean"].to_numpy()
        y = agg["regret_mean"].to_numpy()
        y_sem = agg["regret_sem"].to_numpy()
        order = np.argsort(x)
        x, y, y_sem = x[order], y[order], y_sem[order]
        if show_dots:
            ax.errorbar(x, y, yerr=(None if no_band else y_sem),
                        fmt=marker, color=color, markersize=6,
                        elinewidth=1.0, capsize=3, alpha=0.85,
                        zorder=3, linestyle="None")
        x_grid = np.linspace(x.min(), x.max(), 200)
        lw = setting_lw if setting_lw is not None else 1.8 * line_scale
        ax.plot(x_grid, _fit_curve(x, y, x_grid), color=color, label=label,
                linewidth=lw, linestyle="-", zorder=2, alpha=0.85)
        brute = agg["brute"].iloc[0]

    if brute is not None and pd.notna(brute):
        ax.axhline(brute, color="black", linestyle=":",
                   linewidth=2.0 * line_scale, zorder=5, alpha=0.9,
                   label=f"Fully fine-tune all models: {brute:.2f}×")

    ax.set_xlabel(xlabel, fontsize=label_fs, weight=label_weight)
    ax.set_ylabel(ylabel, fontsize=label_fs, weight=label_weight)
    if title:
        ax.set_title(title, fontsize=title_fs, weight=label_weight)
    if tick_fs:
        ax.tick_params(labelsize=tick_fs)
    ax.grid(True, alpha=0.3)
    if with_legend:
        ax.legend(loc="upper right", fontsize=9, framealpha=0.95)
    return brute


def _render_legend_pdf(records, out_path):
    """Standalone legend PDF: the four strategies + the brute-force line,
    3 items on the first row and 2 on the second (column-major fill)."""
    entries = [(r["label"], r["color"], "-", 1.8) for r in records]
    entries.append(("Fully fine-tune all models", "black", ":", 2.0))

    ncol = 3
    nrow = int(np.ceil(len(entries) / ncol))
    grid = [[None] * ncol for _ in range(nrow)]
    for i, e in enumerate(entries):
        grid[i // ncol][i % ncol] = e
    ordered = [grid[r][c] for c in range(ncol) for r in range(nrow)
               if grid[r][c] is not None]

    handles = [plt.Line2D([0], [0], color=c, linestyle=ls, linewidth=lw * 1.6)
               for (_, c, ls, lw) in ordered]
    labels = [lbl for (lbl, _, _, _) in ordered]

    fig = plt.figure(figsize=(13, 1.1))
    ax = fig.add_subplot(111)
    ax.axis("off")
    legend = ax.legend(handles, labels, loc="center", ncol=ncol,
                       fontsize=PAPER_LEGEND_FS, frameon=True,
                       handletextpad=0.5, labelspacing=0.6, columnspacing=1.4)
    legend.get_frame().set_facecolor("white")
    legend.get_frame().set_alpha(1.0)
    fig.savefig(out_path, bbox_inches="tight", pad_inches=0.02,
                facecolor="white")
    plt.close(fig)
    print(f"Saved: {out_path}")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--pool_csv", required=True,
                    help="Model pool CSV (data/model_selection/<workload>_pool.csv).")
    ap.add_argument("--seeds", type=int, nargs="+", default=list(range(30)))
    ap.add_argument("--init_Ks", type=int, nargs="+",
                    default=[6, 8, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32,
                             34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56,
                             58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78])
    ap.add_argument("--keep_ratio", type=float, default=0.85)
    ap.add_argument("--regret_kind", choices=["worst", "mean"], default="worst")
    ap.add_argument("--uncovered", choices=["skip", "ref"], default="skip")
    ap.add_argument("--strategies", type=str, nargs="+", default=None,
                    help=f"Subset of {[s[0] for s in STRATEGIES]} (default all).")
    ap.add_argument("--tmpdir", type=str, default="/tmp/model_selection_regret")
    ap.add_argument("--output", type=str, default="./model_selection.png")
    ap.add_argument("--title", type=str, default="")
    ap.add_argument("--no_band", action="store_true",
                    help="Hide the ±1 SEM error bars on the PNG.")
    args = ap.parse_args()

    strategies = STRATEGIES
    if args.strategies:
        wanted = set(args.strategies)
        strategies = [s for s in STRATEGIES if s[0] in wanted]
        if not strategies:
            ap.error(f"No strategy matched {sorted(wanted)}")

    tmpdir = Path(args.tmpdir)
    tmpdir.mkdir(parents=True, exist_ok=True)

    records = []
    for key, label, color, marker, extra in strategies:
        print(f"\n=== {label} ===")
        agg = run_and_load(extra, args.seeds, args.init_Ks, args.keep_ratio,
                           args.pool_csv, tmpdir / f"per_seed_{key}.csv",
                           regret_kind=args.regret_kind,
                           uncovered=args.uncovered)
        records.append({"agg": agg, "label": label, "color": color,
                        "marker": marker})

    ylabel = ("Worst-case regret (×)" if args.regret_kind == "worst"
              else "Mean regret (×)")
    xlabel = "Fine-tuning time (hours)"

    # PNG: dots + curves + in-figure legend.
    fig, ax = plt.subplots(figsize=(11, 6.5))
    _plot_axes(ax, records, xlabel=xlabel, ylabel=ylabel, title=args.title,
               show_dots=True, no_band=args.no_band, label_fs=12,
               label_weight="normal", tick_fs=None, title_fs=12,
               line_scale=1.0, with_legend=True)
    plt.tight_layout()
    out_path = Path(args.output)
    png_path = out_path.with_suffix(".png")
    plt.savefig(png_path, dpi=140, bbox_inches="tight")
    print(f"\nSaved: {png_path}")
    plt.close(fig)

    # PDF: paper styling, no in-figure legend (shared legend rendered separately).
    pdf_path = out_path.with_suffix(".pdf")
    figp, axp = plt.subplots(figsize=(8, 5.5))
    _plot_axes(axp, records, xlabel=xlabel, ylabel=ylabel, title="",
               show_dots=True, no_band=True, label_fs=PAPER_LABEL_FS,
               label_weight="bold", tick_fs=PAPER_TICK_FS,
               title_fs=PAPER_LABEL_FS, line_scale=1.6, with_legend=False,
               setting_lw=4)
    figp.tight_layout(pad=0.3)
    figp.savefig(pdf_path, bbox_inches="tight", pad_inches=0.02)
    print(f"Saved: {pdf_path}")
    plt.close(figp)

    _render_legend_pdf(records, out_path.with_name(out_path.stem + "_legend.pdf"))


if __name__ == "__main__":
    main()
