"""Canon (formerly PRICE_N): full hybrid PRICE-LLM SQL feature extractor.

filter_dim         = bin_size + 3*(K+1) + 2 = 75   (K = 10)
fanout_dim         = bin_size + 2          = 42
pairwise_intra_dim = 64 + 2*3              = 70  (anti-diagonal range-slot format)

Design: two universal statistical interfaces (a multi-range filter token and an
operator-conditioned join fanout) plus a DNF rewrite, so every filter, join, and
Boolean composition reduces to the same token formats.
for the full design.
"""
import os
import pickle
import re
from typing import Optional, Sequence, Tuple

import numpy as np
import torch
import sqlglot

import os as _os, sys as _sys
_repo_root = _os.path.dirname(_os.path.dirname(_os.path.abspath(__file__)))
if _repo_root not in _sys.path:
    _sys.path.insert(0, _repo_root)

from canon.price.setup.features_tool import Sql2Feature


class Sql2FeatureN(Sql2Feature):
    """PRICE_N feature extractor.

    Subclass of Sql2Feature (PRICE_N's
    IN-list slot rule differs fundamentally from frequency-ordered
    encoding).
    """

    K = 10
    PAIRWISE_GRID = 8

    def __init__(self, database: str, bin_size: int, usage: str):
        super().__init__(database, bin_size, usage)
        self._null_fraction = self._safe_load_pkl("null_fraction.pkl") or {}
        # Fanout file already loaded by parent into self.information_fanout.
        # The orphan dict (added by Task 4) is nested under '__orphan__'.
        self._orphan_fraction = self.information_fanout.get("__orphan__", {})
        self._pairwise_intra = self._safe_load_pkl("pairwise_intra40.pkl") or {}
        self._pairwise_xtab = self._safe_load_pkl("nonequi_pair_xtab.pkl") or {}
        self._nonequi_fanout_op = self._safe_load_pkl(
            "nonequi_fanout_op40.pkl") or {}
        # Build reverse mapping: price_alias -> raw_table_name
        # (used to look up null_fraction keys which use raw table names)
        self._abbrev = self.information_coltype.get("abbrev", {})
        self._alias_to_table = {v: k for k, v in self._abbrev.items()}
        # SQL-alias -> canonical stats key. Populated by parse_sql so self-join
        # instances like `tpcds_dd2` resolve to the base stats key `tpcds_dd`.
        # Stats dicts (histogram/size/summary/col_type) are keyed once per
        # physical table via abbrev; self-join SQL aliases are not stats keys.
        self._stats_alias_key = {}
        # Cache for lex-sorted SpaceSaving summaries (populated lazily).
        self._lex_sorted_summary = {}
        # Constructor args remembered for lazy Sql2FeatureS helper used to
        # produce table tokens byte-identical to the shared Sql2FeatureS helper.
        self._init_database = database
        self._init_bin_size = bin_size
        self._init_usage = usage
        self._s_helper = None

    def _get_s_helper(self):
        """Lazily build a Sql2FeatureS instance to delegate table-token
        computation. Canon reuses the shared helper's table-feature output verbatim
        so the table token is byte-identical between the two extractors.
        """
        if self._s_helper is None:
            from canon.price.setup.features_tool_s import Sql2FeatureS
            self._s_helper = Sql2FeatureS(
                self._init_database, self._init_bin_size, self._init_usage)
        return self._s_helper

    @staticmethod
    def _is_inside_subquery(node):
        """True if `node` has a Subquery/Exists ancestor (PRICE_N treats those
        as residual; their tables/columns must not pollute outer stat-core)."""
        p = node.parent
        while p is not None:
            if isinstance(p, (sqlglot.exp.Subquery, sqlglot.exp.Exists)):
                return True
            p = p.parent
        return False

    def parse_sql(self, sql):
        """PRICE_N override: like the base parser but skips Tables/Columns/EQs
        that live inside a Subquery or Exists node.

        Why: parse_sql in features_tool.py uses `find_all(Table)` /
        `find_all(Column)` which recurse into subqueries. Under PRICE_N,
        subqueries are intentionally left in the SQL as residual (their atoms
        become QRT input). If their inner tables get pulled into the outer
        `tables` list, downstream lookups like `get_table_size("lineitem")`
        fail with KeyError (TPC-H q18's `lineitem` (no alias) in the inner
        SELECT is a classic example).
        """
        parsed = sqlglot.parse_one(sql)
        is_sub = self._is_inside_subquery

        columns = []
        for column in parsed.find_all(sqlglot.exp.Column):
            if is_sub(column):
                continue
            col_str = f"{column.table}.{column.name}" if column.table else column.name
            if col_str not in columns:
                columns.append(col_str)

        tables = []
        ref_to_tables = {}
        for table in parsed.find_all(sqlglot.exp.Table):
            if is_sub(table):
                continue
            name = table.alias_or_name
            if name not in tables:
                tables.append(name)
                ref_to_tables[name] = table.name

        # Build the SQL-alias -> canonical-stats-key map. Stats are keyed once
        # per physical table via `abbrev` (e.g. {date_dim: tpcds_dd}); the SQL
        # may use self-join aliases like `tpcds_dd2`. Resolve each SQL alias
        # back to the canonical key so downstream lookups index the real entry.
        self._stats_alias_key = {
            alias: self._abbrev[phys]
            for alias, phys in ref_to_tables.items()
            if phys in self._abbrev
        }

        joins = []
        where_clause = parsed.args.get("where")
        if where_clause is not None:
            for eq in where_clause.find_all(sqlglot.exp.EQ):
                if is_sub(eq):
                    continue
                if isinstance(eq.args["expression"], sqlglot.exp.Column):
                    left = eq.args["this"]
                    right = eq.args["expression"]
                    left_str = (f"{left.table}.{left.name}"
                                if hasattr(left, 'table') and left.table else str(left))
                    right_str = (f"{right.table}.{right.name}"
                                 if hasattr(right, 'table') and right.table else str(right))
                    joins.append(f"{left_str} = {right_str}")
        return columns, tables, joins, ref_to_tables

    # ---- canonical stats-key resolution ----

    def _canon_table(self, token: str) -> str:
        """Return the canonical stats-dict key for a SQL-alias table token.

        Stats dicts (histogram/size/summary/col_type) are keyed once per
        physical table; SQL self-join aliases like `tpcds_dd2` resolve to
        the same key as `tpcds_dd`. Falls back to the input token when no
        mapping exists (e.g. parse_sql wasn't called, or the table isn't
        in abbrev).
        """
        return self._stats_alias_key.get(token, token)

    def _canon_col(self, column: str) -> str:
        """Canonicalize the table prefix of a `table.column` string."""
        if "." not in column:
            return column
        t, c = column.split(".", 1)
        return f"{self._canon_table(t)}.{c}"

    def get_column_histograms(self, column):
        """Override: look up stats under the canonical table key, but cache
        under the original SQL-alias key so downstream callers indexing
        `columns_bin_edges['tpcds_dd2.d_year']` continue to work."""
        canon_t = self._canon_table(column.split(".", 1)[0])
        c = column.split(".", 1)[1]
        info = self.information_histogram[canon_t][c]
        self.columns_distributions[column] = info['hist']
        self.columns_bin_edges[column] = info['bin_edges']
        return list(info['hist'] / info['len'])

    def get_table_size(self, table):
        return self.information_size[self._canon_table(table)]['size']

    def get_fanout_features(self, join):
        """Override: canonicalize both sides of `L.col = R.col` before
        indexing the fanout dict. Returns zero-fanout when the canonical
        key has no entry — e.g. self-joins like `tpcds_dd ⋈ tpcds_dd` on
        the same PK, which collapse to (same_col, same_col) and aren't
        in fanout40.pkl (it only stores cross-table joins)."""
        left_join, right_join = join.split(" = ")[0], join.split(" = ")[1]
        canon_key = (self._canon_col(left_join), self._canon_col(right_join))
        rec = self.information_fanout.get(canon_key)
        if rec is None:
            zeros = [0.0] * self.bin_size
            return zeros, zeros
        return rec[0], rec[1]

    @property
    def filter_dim_n(self) -> int:
        return self.bin_size + 3 * (self.K + 1) + 2

    @property
    def fanout_dim_n(self) -> int:
        return self.bin_size + 2

    @property
    def pairwise_dim_n(self) -> int:
        # 64-dim anti-diagonal H_xy + 2 range slots × (low, high, sel) = 70
        return 64 + 2 * 3

    def _safe_load_pkl(self, fname: str):
        """Load a stats pkl if present; return None if missing (lets pre-stats
        environments still construct the class for unit tests)."""
        current_dir = os.path.dirname(os.path.abspath(__file__))
        path = f'{current_dir}/statistics/{self.database}/{fname}'
        if not os.path.exists(path):
            return None
        with open(path, 'rb') as f:
            return pickle.load(f)

    def space_saving_summary(self, column):
        """PRICE_N override: returns top-39 keys sorted lexicographically when
        the keys are STRINGS (no natural numeric ordering, lex-bisect is the
        best we can do for range predicates). For numeric-discrete columns
        we now route ranges through _range_to_region_continuous (bin-edges),
        so reordering the SpaceSaving bins is unnecessary AND would break EQ
        on numeric-discrete top-K values (where the shared/PRICE extractors use the original
        frequency-descending order — the SpaceSaving guarantee).

        OtHeRs (bin 39) stays at the end as the catch-all.
        """
        if column in self._lex_sorted_summary:
            return self._lex_sorted_summary[column]
        # super() splits column.table.col and indexes information_summary[t][c];
        # rewrite the table prefix to its canonical key so self-join aliases
        # like `tpcds_dd2.d_year` resolve to the `tpcds_dd` entry.
        keys, vals = super().space_saving_summary(self._canon_col(column))
        # Only lex-sort if the top-39 keys are strings. Numeric keys keep the
        # original frequency order so EQ-on-top-K matches the PRICE extractors'
        # SpaceSaving bin encoding.
        non_pad_top = [k for k in keys[:39] if k != -1e3]
        if non_pad_top and isinstance(non_pad_top[0], str):
            top_pairs = list(zip(keys[:39], vals[:39]))
            top_pairs.sort(key=lambda kv: str(kv[0]))
            sorted_keys = [k for k, _ in top_pairs] + [keys[39]]
            sorted_vals = [v for _, v in top_pairs] + [vals[39]]
        else:
            sorted_keys, sorted_vals = list(keys), list(vals)
        self._lex_sorted_summary[column] = (sorted_keys, sorted_vals)
        return self._lex_sorted_summary[column]

    # ---- filter token (rules a, b) ----

    EMPTY_ATOMS = {
        "eq_values": [], "in_values": [], "not_in_values": [],
        "range_low": None, "range_high": None,
        "is_null": False, "is_not_null": False,
        "or_atoms": [],   # list of (op, value) tuples for same-column disjunctions
        # Note: LIKE/NOT LIKE/ILIKE go to LLM residual under PRICE_N (rule a
        # extension does not encode them).
    }

    def _value_selectivity_continuous(self, column: str, value) -> Tuple[float, float, float]:
        """For a continuous column, map a single value to (low_norm, high_norm, sel)."""
        bin_edges = self.columns_bin_edges[column]
        try:
            v = float(value)
        except (TypeError, ValueError):
            return 0.0, 0.0, 0.0
        rng = bin_edges[-1] - bin_edges[0]
        rng = rng or 1.0
        low_norm = (v - bin_edges[0]) / rng
        high_norm = (v + 1e-5 - bin_edges[0]) / rng
        low_norm = max(0.0, min(1.0, low_norm))
        high_norm = max(0.0, min(1.0, high_norm))
        dist = self.columns_distributions[column]
        sel = self.calculate_hist_selectivity(dist, bin_edges, v, v + 1e-5)
        sel = sel / max(1.0, dist.sum())
        return low_norm, high_norm, max(0.0, min(1.0, float(sel)))

    def _value_selectivity_discrete(self, column: str, value,
                                    keys, vals, table_size: int) -> Tuple[float, float, float]:
        """For a discrete column, map a value to (low_norm, high_norm, sel)
        via the SpaceSaving summary."""
        try:
            idx = keys.index(value)
            freq = vals[idx]
        except ValueError:
            idx = len(keys) - 1   # OtHeRs
            freq = vals[-1]
        low = idx / self.bin_size
        high = (idx + 1) / self.bin_size
        sel = float(freq) / max(1.0, table_size)
        return low, high, max(0.0, min(1.0, sel))

    def _atom_to_slot(self, op: str, value, column: str,
                      is_discrete: bool, keys, vals, table_size: int,
                      high_value=None,
                      ) -> Tuple[float, float, float]:
        """Convert a single atom to a (low, high, sel) range slot.

        Accepts either a 2-tuple atom (op, value) or a 3-tuple atom
        ("between", low, high) where high_value is passed separately.
        Used to encode same-column OR chains from the or_atoms field.
        """
        if op == "between":
            # 3-tuple BETWEEN atom: value=low_val, high_value=high_val
            low_val = value
            high_val = high_value
            if is_discrete:
                try:
                    lo_idx = keys.index(low_val)
                except ValueError:
                    lo_idx = len(keys) - 1
                try:
                    hi_idx = keys.index(high_val)
                except ValueError:
                    hi_idx = len(keys) - 1
                if lo_idx > hi_idx:
                    lo_idx, hi_idx = hi_idx, lo_idx
                low = lo_idx / self.bin_size
                high = (hi_idx + 1) / self.bin_size
                sel = float(sum(vals[i] for i in range(lo_idx, hi_idx + 1)
                                if i < len(vals))) / max(1.0, table_size)
                return low, high, max(0.0, min(1.0, sel))
            else:
                bin_edges = self.columns_bin_edges.get(column)
                if bin_edges is None:
                    return 0.0, 0.0, 0.0
                try:
                    lo_v = float(low_val)
                    hi_v = float(high_val)
                except (TypeError, ValueError):
                    return 0.0, 0.0, 0.0
                rng = max(1e-9, bin_edges[-1] - bin_edges[0])
                low = max(0.0, min(1.0, (lo_v - bin_edges[0]) / rng))
                high = max(0.0, min(1.0, (hi_v - bin_edges[0]) / rng))
                if low > high:
                    low, high = high, low
                dist = self.columns_distributions.get(column)
                if dist is None:
                    return 0.0, 0.0, 0.0
                sel = self.calculate_hist_selectivity(dist, bin_edges, lo_v, hi_v)
                sel = float(sel) / max(1.0, dist.sum())
                return low, high, max(0.0, min(1.0, sel))
        if is_discrete:
            try:
                idx = keys.index(value)
                freq = vals[idx]
            except ValueError:
                idx = len(keys) - 1
                freq = vals[-1]
            bin_lo = idx / self.bin_size
            bin_hi = (idx + 1) / self.bin_size
            sel_unit = float(freq) / max(1.0, table_size)
            if op == "=":
                return bin_lo, bin_hi, max(0.0, min(1.0, sel_unit))
            elif op in ("<", "<="):
                # Everything before this bin
                lo_norm = 0.0
                hi_norm = bin_hi if op == "<=" else bin_lo
                gap_sel = sum(float(vals[b]) for b in range(0, idx + (1 if op == "<=" else 0))
                              if b < len(vals)) / max(1.0, table_size)
                return lo_norm, hi_norm, max(0.0, min(1.0, gap_sel))
            elif op in (">", ">="):
                lo_norm = bin_lo if op == ">=" else bin_hi
                hi_norm = 1.0
                start = idx if op == ">=" else idx + 1
                gap_sel = sum(float(vals[b]) for b in range(start, len(vals))) / max(1.0, table_size)
                return lo_norm, hi_norm, max(0.0, min(1.0, gap_sel))
            else:
                return 0.0, 0.0, 0.0
        else:
            bin_edges = self.columns_bin_edges.get(column)
            if bin_edges is None:
                return 0.0, 0.0, 0.0
            try:
                v = float(value)
            except (TypeError, ValueError):
                return 0.0, 0.0, 0.0
            lo_edge = float(bin_edges[0])
            hi_edge = float(bin_edges[-1])
            rng = max(1e-9, hi_edge - lo_edge)
            dist = self.columns_distributions.get(column)
            if dist is None:
                return 0.0, 0.0, 0.0
            dist_sum = max(1.0, float(dist.sum()))
            v_norm = max(0.0, min(1.0, (v - lo_edge) / rng))

            if op == "=":
                lo_n = v_norm
                hi_n = min(1.0, v_norm + 1e-5)
                sel = self.calculate_hist_selectivity(dist, bin_edges, v, v + 1e-5)
                sel = float(sel) / dist_sum
            elif op == "<":
                lo_n, hi_n = 0.0, v_norm
                sel = self.calculate_hist_selectivity(dist, bin_edges, lo_edge, v)
                sel = float(sel) / dist_sum
            elif op == "<=":
                lo_n, hi_n = 0.0, min(1.0, v_norm + 1e-5)
                sel = self.calculate_hist_selectivity(dist, bin_edges, lo_edge, v + 1e-5)
                sel = float(sel) / dist_sum
            elif op == ">":
                lo_n, hi_n = min(1.0, v_norm + 1e-5), 1.0
                sel = self.calculate_hist_selectivity(dist, bin_edges, v + 1e-5, hi_edge)
                sel = float(sel) / dist_sum
            elif op == ">=":
                lo_n, hi_n = v_norm, 1.0
                sel = self.calculate_hist_selectivity(dist, bin_edges, v, hi_edge)
                sel = float(sel) / dist_sum
            else:
                return 0.0, 0.0, 0.0
            return lo_n, hi_n, max(0.0, min(1.0, sel))

    def _populate_range_pair_slots(self, column: str, not_in_values: Sequence,
                                   is_discrete: bool, keys, vals,
                                   table_size: int):
        """Build N+1 range slots for `col != X` (and multi-NEQ) predicates.

        For continuous columns, sorts the excluded values numerically and emits
        slots covering the gaps between them (below first, between each pair,
        above last).

        For discrete columns, uses SpaceSaving bin indices as positions.

        Returns a list of 3*(K+1) = 33 floats, same layout as _populate_in_slots.
        """
        eps = 1e-6
        slots: list = []

        if is_discrete:
            # Map each excluded value to its SpaceSaving bin index.
            excluded_bins = []
            for v in not_in_values:
                try:
                    idx = keys.index(v)
                except ValueError:
                    idx = len(keys) - 1  # OtHeRs bin
                excluded_bins.append(idx)
            excluded_bins = sorted(set(excluded_bins))
            n_bins = self.bin_size  # typically 40

            # Build gap ranges: (lo_bin_incl, hi_bin_excl)
            boundaries = [-1] + excluded_bins + [n_bins]
            for i in range(len(boundaries) - 1):
                lo_bin = boundaries[i] + 1
                hi_bin = boundaries[i + 1]  # exclusive
                if lo_bin > hi_bin:
                    continue
                lo_norm = lo_bin / n_bins
                hi_norm = hi_bin / n_bins
                # Selectivity: sum of freq for bins [lo_bin, hi_bin)
                gap_sel = 0.0
                for b in range(lo_bin, hi_bin):
                    if b < len(vals):
                        gap_sel += float(vals[b]) / max(1.0, table_size)
                slots.append((lo_norm, hi_norm, min(1.0, gap_sel)))
        else:
            # Continuous: sort excluded values numerically.
            try:
                excl_sorted = sorted(float(v) for v in not_in_values)
            except (TypeError, ValueError):
                return [0.0] * (3 * (self.K + 1))
            bin_edges = self.columns_bin_edges.get(column)
            if bin_edges is None:
                return [0.0] * (3 * (self.K + 1))
            lo_edge = float(bin_edges[0])
            hi_edge = float(bin_edges[-1])
            rng = max(1e-9, hi_edge - lo_edge)
            dist = self.columns_distributions[column]
            dist_sum = max(1.0, dist.sum())

            # Boundaries including sentinel min/max
            boundaries = [lo_edge] + excl_sorted + [hi_edge]
            for i in range(len(boundaries) - 1):
                lo_v = boundaries[i] + (eps if i > 0 else 0.0)
                hi_v = boundaries[i + 1] - (eps if i < len(boundaries) - 2 else 0.0)
                if lo_v > hi_v:
                    continue
                lo_norm = max(0.0, min(1.0, (lo_v - lo_edge) / rng))
                hi_norm = max(0.0, min(1.0, (hi_v - lo_edge) / rng))
                sel = self.calculate_hist_selectivity(dist, bin_edges, lo_v, hi_v)
                sel = float(sel) / dist_sum
                slots.append((lo_norm, hi_norm, max(0.0, min(1.0, sel))))

        # Fill top K slots sorted by selectivity descending, remainder goes to tail.
        slots.sort(key=lambda t: t[2], reverse=True)
        top = slots[: self.K]
        tail = slots[self.K:]
        result = []
        for lo, hi, sel in top:
            result.extend([lo, hi, sel])
        while len(result) < self.K * 3:
            result.extend([0.0, 0.0, 0.0])
        if tail:
            tail_lo = min(t[0] for t in tail)
            tail_hi = max(t[1] for t in tail)
            tail_sel = sum(t[2] for t in tail)
            result.extend([tail_lo, tail_hi, min(1.0, tail_sel)])
        else:
            result.extend([0.0, 0.0, 0.0])
        return result  # 3*(K+1) = 33 floats

    def _populate_in_slots(self, column: str, values: Sequence,
                           is_discrete: bool, keys, vals, table_size: int):
        """Sort by selectivity, take top K, fold remainder into tail."""
        triples = []
        for v in values:
            if is_discrete:
                triples.append(self._value_selectivity_discrete(
                    column, v, keys, vals, table_size))
            else:
                triples.append(self._value_selectivity_continuous(column, v))
        triples.sort(key=lambda t: t[2], reverse=True)
        top = triples[: self.K]
        tail = triples[self.K:]
        slots = []
        for low, high, sel in top:
            slots.extend([low, high, sel])
        while len(slots) < self.K * 3:
            slots.extend([0.0, 0.0, 0.0])
        if tail:
            tail_low = min(t[0] for t in tail)
            tail_high = max(t[1] for t in tail)
            tail_sel = sum(t[2] for t in tail)
            slots.extend([tail_low, tail_high, min(1.0, tail_sel)])
        else:
            slots.extend([0.0, 0.0, 0.0])
        return slots  # 3*(K+1) = 33 floats

    # ---- Interval arithmetic for unified atom combination ----

    # A "region" is a (low_norm, high_norm) tuple in [0, 1] coordinates.
    # A "regions list" is a sorted list of disjoint regions.

    EPS = 1e-9   # numerical guard

    @staticmethod
    def _intersect_one(r1, r2):
        """Intersect two regions; return None if empty.

        Use strict `>` so a degenerate (lo == hi) boundary region survives —
        PRICE_S/B emits e.g. (1.0, 1.0, sel=0) for out-of-range EQ predicates;
        intersecting that with the initial (0, 1) here used to drop it under
        the previous `>=`, leaving slot 0 = (0,0,0). The boundary-point form
        is what PRICE_S/B carries through, so we keep it.
        """
        lo = max(r1[0], r2[0])
        hi = min(r1[1], r2[1])
        if lo > hi:
            return None
        return (lo, hi)

    @classmethod
    def _intersect_with_region(cls, regions, r):
        """Intersect every region in `regions` with single region `r`."""
        out = []
        for x in regions:
            i = cls._intersect_one(x, r)
            if i is not None:
                out.append(i)
        return out

    @classmethod
    def _intersect_with_union(cls, regions, region_list):
        """Intersect `regions` with the union of `region_list`."""
        if not region_list:
            return []
        out = []
        for r in region_list:
            for x in regions:
                i = cls._intersect_one(x, r)
                if i is not None:
                    out.append(i)
        return cls._normalize_regions(out)

    @classmethod
    def _subtract_region(cls, regions, r):
        """Remove region `r` from each region in `regions`. Splits regions as needed."""
        out = []
        lo_r, hi_r = r
        for x in regions:
            lo, hi = x
            if hi_r <= lo or lo_r >= hi:
                out.append(x)   # no overlap
                continue
            if lo_r > lo:
                out.append((lo, lo_r))
            if hi_r < hi:
                out.append((hi_r, hi))
        return out

    @staticmethod
    def _normalize_regions(regions):
        """Sort regions and merge overlapping/touching ones."""
        if not regions:
            return []
        sorted_r = sorted(regions)
        out = [sorted_r[0]]
        for lo, hi in sorted_r[1:]:
            prev_lo, prev_hi = out[-1]
            if lo <= prev_hi:
                out[-1] = (prev_lo, max(prev_hi, hi))
            else:
                out.append((lo, hi))
        return out

    def _value_to_region_continuous(self, column, value):
        """Map a single literal value v to a tiny point region (v_norm, v_norm + ε/rng).

        PRICE_S/B's EQ-on-continuous adds 1e-5 in VALUE space:
        `range_high = literal + 1e-5`. Adding 1e-5 to v_norm directly would
        give a value-space width of `rng × 1e-5` — fine for small ranges but
        thousands of seconds for timestamp columns. Add ε in value space then
        re-normalise to keep the recovered selectivity bit-identical to
        PRICE_S/B's `calculate_hist_selectivity(dist, edges, v, v+1e-5)`.

        For values OUTSIDE the histogram range we CLAMP both bounds to [0, 1]
        (matching PRICE_S/B's get_filter_norm_range, which clamps and returns
        a point region at the boundary). Returning None here would cause
        _compute_regions to treat the predicate as impossible (regions=[])
        and emit a zero-slot, while PRICE_S/B emits a (1, 1, 0) or (0, 0, 0)
        boundary point — different encodings for the same semantic (no match).
        """
        bin_edges = self.columns_bin_edges[column]
        try:
            v = float(value)
        except (TypeError, ValueError):
            return None
        rng = max(1e-9, bin_edges[-1] - bin_edges[0])
        lo = max(0.0, min(1.0, (v - bin_edges[0]) / rng))
        hi = max(0.0, min(1.0, (v + 1e-5 - bin_edges[0]) / rng))
        if lo > hi:
            return None
        return (lo, hi)

    def _value_to_region_discrete(self, column, value, keys):
        """Map a SpaceSaving-key value to a single-bin region (idx/B, (idx+1)/B)."""
        try:
            idx = keys.index(value)
        except ValueError:
            idx = len(keys) - 1   # OtHeRs
        return (idx / self.bin_size, (idx + 1) / self.bin_size)

    def _range_to_region_continuous(self, column, low_v, high_v):
        """Map [low_v, high_v] (with None = unbounded) to a normalized region.

        The strict/non-strict ε is baked into low_v/high_v by the upstream
        atoms parser (sice_lib._extract_filter_atoms): `> v` arrives
        as `low_v = v + 1e-5`, `<= v` as `high_v = v + 1e-5`. So this function
        just maps the literal directly through bin-edges normalization, with
        no further ε adjustment — matches PRICE_S/B's get_filter_norm_range.
        """
        bin_edges = self.columns_bin_edges[column]
        try:
            low_f = float(low_v) if low_v is not None else bin_edges[0]
            high_f = float(high_v) if high_v is not None else bin_edges[-1]
        except (TypeError, ValueError):
            return None
        rng = max(1e-9, bin_edges[-1] - bin_edges[0])
        lo = max(0.0, min(1.0, (low_f - bin_edges[0]) / rng))
        hi = max(0.0, min(1.0, (high_f - bin_edges[0]) / rng))
        if lo > hi:
            return None
        return (lo, hi)

    def _range_to_region_discrete(self, column, low_v, high_v, keys):
        """Map a discrete-column range [low_v, high_v] to a normalized region.

        Uses lex-order over the top-39 SpaceSaving keys (already guaranteed by
        PRICE_N's space_saving_summary override). Per the design:
          - OtHeRs (bin 39) is excluded from range slots (its lex distribution
            is unknown; we drop the OtHeRs contribution for simplicity).
          - For literals not in top-39, find the closest top-39 key in the
            appropriate lex direction (binary search over the lex-sorted top-39).

        Returns (low_norm, high_norm) in [0, 1] coordinates over the 40-bin
        histogram, or None if the range is empty/unrepresentable.
        """
        import bisect
        top_39_keys = [str(k) for k in keys[:39]]   # already lex-sorted by override
        # Drop padding sentinels (e.g., str(-1e3) = '-1000.0')
        padding_sentinel = str(-1e3)
        real_keys = [k for k in top_39_keys if k != padding_sentinel]
        if not real_keys:
            return None

        # For col >= low_v: lex-position of the smallest top-39 key >= low_v.
        if low_v is None:
            lo_idx = 0
        else:
            lo_idx = bisect.bisect_left(top_39_keys, str(low_v))

        # For col <= high_v: lex-position-after the largest top-39 key <= high_v.
        if high_v is None:
            hi_idx = 39   # all 39 top-39 keys (excluding OtHeRs at bin 39)
        else:
            hi_idx = bisect.bisect_right(top_39_keys, str(high_v))

        if lo_idx >= hi_idx:
            return None   # empty range under top-39 lex window

        return (lo_idx / self.bin_size, hi_idx / self.bin_size)

    def _region_selectivity_continuous(self, column, lo_norm, hi_norm):
        """Compute the histogram selectivity for a normalized [lo, hi] region.

        Match PRICE_S/B's denominator (table_size, includes null rows) rather
        than distribution.sum() (excludes nulls). On null-heavy columns like
        st_p.answercount (53% null) the two differ by ≈1/(1-null_frac), which
        was driving the dim-42 mismatch.
        """
        bin_edges = self.columns_bin_edges[column]
        rng = bin_edges[-1] - bin_edges[0]
        lo_v = bin_edges[0] + lo_norm * rng
        hi_v = bin_edges[0] + hi_norm * rng
        distribution = self.columns_distributions[column]
        sel = self.calculate_hist_selectivity(distribution, bin_edges, lo_v, hi_v)
        # PRICE_S divides by self.get_table_size(col_table); column here is
        # "<table>.<col>", so derive the table from the prefix.
        table_alias = column.split(".", 1)[0]
        total = max(1.0, float(self.get_table_size(table_alias)))
        return float(sel) / total

    def _region_selectivity_discrete(self, lo_norm, hi_norm, keys, vals, table_size):
        """Sum SpaceSaving frequencies for bins covered by [lo_norm, hi_norm)."""
        lo_idx = max(0, int(round(lo_norm * self.bin_size)))
        hi_idx = min(self.bin_size, int(round(hi_norm * self.bin_size)))
        if lo_idx >= hi_idx:
            return 0.0
        total = max(1.0, float(table_size))
        return float(sum(vals[i] for i in range(lo_idx, hi_idx))) / total

    def _atom_to_region(self, atom, column, is_discrete, keys, vals):
        """Convert a 2-tuple (op, value) or 3-tuple ('between', low, high) atom
        to a normalized region. Returns None on failure."""
        if len(atom) == 3 and atom[0] == "between":
            _, low_v, high_v = atom
            if is_discrete:
                r1 = self._value_to_region_discrete(column, low_v, keys)
                r2 = self._value_to_region_discrete(column, high_v, keys)
                if r1 is None or r2 is None:
                    return None
                return (min(r1[0], r2[0]), max(r1[1], r2[1]))
            return self._range_to_region_continuous(column, low_v, high_v)

        op, val = atom[0], atom[1]
        if is_discrete:
            pt = self._value_to_region_discrete(column, val, keys)
        else:
            pt = self._value_to_region_continuous(column, val)
        if pt is None:
            return None

        if op == "=":
            return pt
        if op == "<":
            return (0.0, pt[0])
        if op == "<=":
            return (0.0, pt[1])
        if op == ">":
            return (pt[1], 1.0)
        if op == ">=":
            return (pt[0], 1.0)
        return None

    def _compute_regions(self, column, atoms, is_discrete, keys, vals, table_size,
                          force_continuous_range=False):
        """Run interval arithmetic over all atoms on `column` to produce a
        sorted list of disjoint (low_norm, high_norm, sel) regions.

        Combines per-kind atoms via:
          - EQ values (AND semantics): each value independently intersects the
            current region set (c=5 AND c=10 → empty; c=5 alone → {5}).
          - IN values (OR semantics): intersect current regions with the union
            of all IN-list point regions (c IN (1,2,3) → {1}∪{2}∪{3}).
          - When both EQ and IN are present, EQ is applied first (each value
            intersects), then IN (union intersects); combined this correctly
            handles c=5 AND c IN (1,2,3) → {5}∩{1,2,3} = empty if 5∉{1,2,3}.
          - Range bounds (range_low, range_high): intersect with the range region.
          - or_atoms (same-column OR block): intersect with the union of their regions.
          - NEQ / NOT IN values: subtract each value's point region.
          - NULL atoms: orthogonal (handled separately via null_pred_flag).

        `force_continuous_range`: for numeric-discrete columns (`is_discrete=True`
        but the column has a meaningful numeric ordering), route range bounds
        through `_range_to_region_continuous` (bin-edges-normalized), while
        keeping EQ/IN/NEQ on `_value_to_region_discrete` (SpaceSaving bin) so
        EQ on top-K values still matches PRICE_S's SpaceSaving encoding.
        Selectivity computation auto-switches based on which atom kinds
        populated the regions (range-only → continuous selectivity, EQ/IN-only
        → SpaceSaving frequencies; mixed columns are rare in practice and
        fall back to the discrete selectivity path).
        """
        # Start with the universal region.
        regions = [(0.0, 1.0)]

        # 1a. EQ values: AND semantics — each value narrows the region.
        eq_vals = list(atoms.get("eq_values", []))
        for v in eq_vals:
            if is_discrete:
                pt = self._value_to_region_discrete(column, v, keys)
            else:
                pt = self._value_to_region_continuous(column, v)
            if pt is not None:
                regions = self._intersect_with_region(regions, pt)
            else:
                regions = []   # value out of range → impossible predicate
            if not regions:
                break

        # 1b. IN values: OR semantics — intersect with the union of point regions.
        in_vals = list(atoms.get("in_values", []))
        if in_vals:
            in_regions = []
            for v in in_vals:
                if is_discrete:
                    pt = self._value_to_region_discrete(column, v, keys)
                else:
                    pt = self._value_to_region_continuous(column, v)
                if pt is not None:
                    in_regions.append(pt)
            if in_regions:
                regions = self._intersect_with_union(regions, in_regions)
            else:
                regions = []   # all IN values out of range

        # 2. Range bounds: intersect with [range_low, range_high].
        # For numeric-discrete columns we want continuous (bin-edges) ranges,
        # not lex-bisect over str(key) SpaceSaving keys.
        rl = atoms.get("range_low")
        rh = atoms.get("range_high")
        if rl is not None or rh is not None:
            if is_discrete and not force_continuous_range:
                range_r = self._range_to_region_discrete(column, rl, rh, keys)
            else:
                range_r = self._range_to_region_continuous(column, rl, rh)
            if range_r is not None:
                regions = self._intersect_with_region(regions, range_r)

        # 3. or_atoms: intersect with union of their regions (each or_atom is a
        #    same-column predicate, the OR makes their disjunction).
        or_atoms = atoms.get("or_atoms", [])
        if or_atoms:
            or_regions = []
            for a in or_atoms:
                r = self._atom_to_region(a, column, is_discrete, keys, vals)
                if r is not None:
                    or_regions.append(r)
            if or_regions:
                regions = self._intersect_with_union(regions, or_regions)

        # 4. NEQ / NOT IN values: subtract each value's point region.
        not_in = atoms.get("not_in_values", [])
        for v in not_in:
            if is_discrete:
                pt = self._value_to_region_discrete(column, v, keys)
            else:
                pt = self._value_to_region_continuous(column, v)
            if pt is not None:
                regions = self._subtract_region(regions, pt)

        regions = self._normalize_regions(regions)

        # Compute selectivity per region. Pick the matching coordinate space:
        # - regions populated by EQ/IN/NEQ on a discrete column live in
        #   SpaceSaving-bin space (lo_norm = idx/40) → use frequency table.
        # - regions populated by range_low/range_high (or by EQ on a continuous
        #   column) live in value-norm space → use histogram CDF.
        # For numeric-discrete columns under `force_continuous_range`, pick by
        # which atom kinds populated the region. (For stats-style workloads,
        # each column has one kind of atom at a time, so this is unambiguous.)
        has_pointwise = bool(atoms.get("eq_values") or atoms.get("in_values")
                              or atoms.get("not_in_values"))
        has_range = (atoms.get("range_low") is not None
                     or atoms.get("range_high") is not None
                     or bool(atoms.get("or_atoms")))
        if force_continuous_range and is_discrete:
            use_continuous_sel = has_range and not has_pointwise
        else:
            use_continuous_sel = not is_discrete

        out = []
        for lo, hi in regions:
            if use_continuous_sel:
                sel = self._region_selectivity_continuous(column, lo, hi)
            else:
                sel = self._region_selectivity_discrete(lo, hi, keys, vals, table_size)
            out.append((lo, hi, max(0.0, min(1.0, sel))))
        return out

    def _encode_filter_token(self, filter_column: str, atoms: dict) -> torch.Tensor:
        """Build a 75-dim filter token from the atoms dict produced by the
        AST tag pass.

        atoms keys:
          eq_values    : list  — single-equality literal(s)
          in_values    : list  — IN-list literals
          not_in_values: list  — NOT IN literals
          range_low    : float | None
          range_high   : float | None
          is_null      : bool
          is_not_null  : bool
          or_atoms     : list  — same-column OR chain atoms
        """
        col_table = filter_column.split(".")[0]
        col_name = filter_column.split(".")[-1]
        canon_table = self._canon_table(col_table)
        raw_table = self._alias_to_table.get(canon_table, canon_table)
        table_size = self.get_table_size(col_table)
        is_discrete = col_name in self.information_coltype['col_type'][canon_table]['dsct']

        # Refined rule: SpaceSaving (summary40) is meant for STRING discrete
        # columns (where there's no natural ordering for bin-width histograms).
        # Numeric discrete columns get the bin-width histogram (histogram40),
        # matching PRICE_S's range-fallback path on the same column type.
        is_string_discrete = False
        if is_discrete:
            try:
                _summary_keys = self.information_summary[canon_table][col_name]["keys"]
                if _summary_keys:
                    is_string_discrete = isinstance(_summary_keys[0], str)
            except Exception:
                is_string_discrete = False

        if is_string_discrete:
            keys, vals = self.space_saving_summary(filter_column)
            histogram = (torch.tensor(vals, dtype=torch.float32)
                         / max(1.0, table_size))
        elif is_discrete:
            # Numeric discrete column — keep summary keys/vals for
            # _compute_regions (which uses them to map atom values to bin
            # indices), but use bin-width histogram (matches PRICE_S's
            # range-fallback path on the same column).
            keys, vals = self.space_saving_summary(filter_column)
            histogram = torch.tensor(
                self.get_column_histograms(filter_column),
                dtype=torch.float32)
        else:
            keys, vals = None, None
            histogram = torch.tensor(
                self.get_column_histograms(filter_column),
                dtype=torch.float32)

        # Run interval arithmetic over all atoms.
        #
        # For NUMERIC-discrete columns (is_discrete=True, is_string_discrete=False)
        # we pass `force_continuous_range=True`. _compute_regions then keeps EQ/IN
        # on SpaceSaving-bin encoding (matches PRICE_S's top-K branch) while
        # routing range_low/range_high through bin-edges-based normalization
        # (matches PRICE_S's range-fallback branch). Selectivity is computed in
        # whichever coordinate space the atoms produced.
        regions = self._compute_regions(filter_column, atoms,
                                        is_discrete,
                                        keys, vals, table_size,
                                        force_continuous_range=(is_discrete and not is_string_discrete))

        # Sort by selectivity descending; top K populate slots, rest fold to tail.
        regions.sort(key=lambda t: t[2], reverse=True)
        top = regions[: self.K]
        tail = regions[self.K:]

        slot_floats = []
        for lo, hi, sel in top:
            slot_floats.extend([lo, hi, sel])
        while len(slot_floats) < self.K * 3:
            slot_floats.extend([0.0, 0.0, 0.0])

        if tail:
            tail_lo = min(t[0] for t in tail)
            tail_hi = max(t[1] for t in tail)
            tail_sel = sum(t[2] for t in tail)
            slot_floats.extend([tail_lo, tail_hi, min(1.0, tail_sel)])
        else:
            slot_floats.extend([0.0, 0.0, 0.0])

        # NULL bits (rule b) — orthogonal to interval arithmetic.
        null_fraction = float(self._null_fraction.get((raw_table, col_name), 0.0))
        if atoms.get("is_null"):
            null_pred_flag = 1.0
        elif atoms.get("is_not_null"):
            null_pred_flag = -1.0
        else:
            null_pred_flag = 0.0

        feature = torch.cat([
            histogram,
            torch.tensor(slot_floats, dtype=torch.float32),
            torch.tensor([null_fraction, null_pred_flag], dtype=torch.float32),
        ])
        assert feature.shape[0] == self.filter_dim_n, \
            f"filter token shape {feature.shape[0]} != {self.filter_dim_n}"
        return feature

    # ---- extended fanout token (rule g) ----

    _PRESERVE_TABLE = {
        # side -> (preserve_LR, preserve_RL)
        "INNER": (0.0, 0.0),
        "LEFT":  (1.0, 0.0),
        "RIGHT": (0.0, 1.0),
        "FULL":  (1.0, 1.0),
    }

    def _encode_fanout_tokens_extended(self, join: str, side: str = "INNER"
                                       ) -> Tuple[torch.Tensor, torch.Tensor]:
        """Return (fanout_LR, fanout_RL) each a 42-dim tensor.

        Layout: [raw_fanout_hist[0:40], orphan_fraction, outer_preserve_flag].

        Pretrained PRICE consumes only the 40-dim raw histogram; the 2 new
        dims are zero-filled when the orphan stats are missing or for INNER
        joins.
        """
        ff1, ff2 = self.get_fanout_features(join)
        ff1_t = torch.tensor(ff1, dtype=torch.float32)
        ff2_t = torch.tensor(ff2, dtype=torch.float32)
        if ff1_t.shape[0] != self.bin_size:
            ff1_t = torch.nn.functional.pad(
                ff1_t[:self.bin_size], (0, self.bin_size - ff1_t.shape[0]))
        if ff2_t.shape[0] != self.bin_size:
            ff2_t = torch.nn.functional.pad(
                ff2_t[:self.bin_size], (0, self.bin_size - ff2_t.shape[0]))

        left_join, right_join = join.split(" = ")[0], join.split(" = ")[1]
        orph_lr, orph_rl = self._orphan_fraction.get(
            (left_join, right_join), (0.0, 0.0))
        preserve_lr, preserve_rl = self._PRESERVE_TABLE.get(
            side.upper(), (0.0, 0.0))

        f_lr = torch.cat([ff1_t,
                          torch.tensor([orph_lr, preserve_lr],
                                       dtype=torch.float32)])
        f_rl = torch.cat([ff2_t,
                          torch.tensor([orph_rl, preserve_rl],
                                       dtype=torch.float32)])
        return f_lr, f_rl

    # ---- pairwise intra/cross-table filter token (rules h, j) ----

    # Operator → range slots in the anti-diagonal-ordered 64-vector.
    # Format: list of (lo_bin, hi_bin) inclusive bounds.
    _OP_RANGES = {
        "<":  [(0, 27)],
        "<=": [(0, 35)],
        "=":  [(28, 35)],
        "!=": [(0, 27), (36, 63)],
        ">":  [(36, 63)],
        ">=": [(28, 63)],
    }

    def _encode_pairwise_intra_token(self, left_table: str, col_x: str,
                                     col_y: str, op: Optional[str] = None,
                                     right_table: Optional[str] = None,
                                     right_col: Optional[str] = None) -> torch.Tensor:
        """Build a 70-dim pairwise filter token using anti-diagonal range slots.

        Format: H_xy[64] + 2 range slots (low, high, sel) = 70 dims.
        For self-pairs (right_table is None or == left_table), draws H from
        pairwise_intra40.pkl. For cross-table pairs (rule h), draws from
        nonequi_pair_xtab.pkl.

        The H_xy vector uses anti-diagonal ordering (see
        _order_8x8_anti_diagonal in generate_price_stats_from_pg.py).
        Operators map to 1 or 2 contiguous bin ranges via _OP_RANGES.
        """
        # Auto-detect xtab calling convention (op passed as 3rd positional)
        if right_table is not None and right_table != left_table and op is None:
            op = col_y
            col_y = None

        if right_table is None or right_table == left_table:
            rec = self._pairwise_intra.get((left_table, col_x, col_y))
        else:
            rec = self._pairwise_xtab.get(
                (left_table, col_x, right_table, right_col))

        if rec is None:
            return torch.zeros(self.pairwise_dim_n, dtype=torch.float32)

        H = torch.tensor(rec["H8x8_ordered"], dtype=torch.float32)
        if H.shape != (64,):
            H = H.flatten()[:64]

        total_mass = float(H.sum().item()) or 1.0
        ranges = self._OP_RANGES.get(op, [])

        slots = []
        for slot_idx in range(2):
            if slot_idx < len(ranges):
                lo_bin, hi_bin = ranges[slot_idx]
                low = lo_bin / 64.0
                high = (hi_bin + 1) / 64.0
                sel = float(H[lo_bin:hi_bin + 1].sum().item()) / total_mass
            else:
                low, high, sel = 0.0, 0.0, 0.0
            slots.extend([low, high, sel])

        feature = torch.cat([H, torch.tensor(slots, dtype=torch.float32)])
        assert feature.shape[0] == self.pairwise_dim_n
        return feature

    def create_sql_features(self, sql: str, atoms_meta=None):
        """Build PRICE_N feature tuple(s) for a query.

        Args:
            sql: The transformed SQL string.
            atoms_meta: Either:
              - dict (single-clause, default): returns one 6-tuple.
              - list[dict] (multi-clause): returns a list of 6-tuples per clause.
              - None: defaults to single-clause empty atoms.

        Returns:
            Single mode: (feats_5tuple, n_jc, n_fo, n_tb, n_fc, n_pi)
            Multi mode: list of the above tuple, one per clause.
        """
        is_multi = isinstance(atoms_meta, list)
        if not is_multi:
            return self._create_features_single(sql, atoms_meta or {
                "filter_atoms": {}, "pairwise_atoms": [], "join_sides": {}})

        # Multi-clause: iterate over per-clause atoms_meta dicts.
        # If any entry is the blowup sentinel (None), fall back to empty single-clause.
        out = []
        for clause_meta in atoms_meta:
            if clause_meta is None:
                # Sentinel from _extract_atoms_per_clause meaning "blowup → fall back".
                return self._create_features_single(sql, {
                    "filter_atoms": {}, "pairwise_atoms": [], "join_sides": {}})
            out.append(self._create_features_single(sql, clause_meta))
        return out

    def _create_features_single(self, sql: str, atoms_meta: dict):
        """Internal: build a single-clause 6-tuple for sql + atoms_meta dict."""
        if atoms_meta is None:
            atoms_meta = {"filter_atoms": {}, "join_sides": {}, "pairwise_atoms": []}
        filter_atoms = atoms_meta.get("filter_atoms", {})
        join_sides = atoms_meta.get("join_sides", {})
        pairwise_atoms = atoms_meta.get("pairwise_atoms", [])

        columns, tables, joins, _ = self.parse_sql(sql)
        # Rule f: skip the cyclic-join check entirely (cyclic graphs are now legal).

        table_join_cols, table_filter_cols = {}, {}
        for t in tables:
            table_join_cols[t] = []
            table_filter_cols[t] = []
        for col in columns:
            tbl = col.split(".")[0]
            is_join_col = any(col == j.split("=")[0].strip()
                              or col == j.split("=")[1].strip()
                              for j in joins)
            if is_join_col:
                table_join_cols[tbl].append(col)
            else:
                table_filter_cols[tbl].append(col)

        join_columns = self.flatten_list(list(table_join_cols.values()))
        filter_columns = self.flatten_list(list(table_filter_cols.values()))

        # Join-column histograms (existing PRICE machinery).
        # Skip any column whose stats are missing — mirrors PRICE_S's partial
        # encoding tolerance so a single unknown column doesn't reject the
        # whole query.  The list `join_columns` is rebuilt to reflect which
        # ones actually got encoded so downstream `n_join_cols` agrees with
        # the tensor length.
        _kept_join_columns = []
        join_column_histograms = []
        for jc in join_columns:
            try:
                join_column_histograms.append(
                    torch.tensor(self.get_column_histograms(jc), dtype=torch.float32))
                _kept_join_columns.append(jc)
            except (KeyError, IndexError, AttributeError):
                continue
        join_columns = _kept_join_columns

        # Extended fanout tokens (rule g). Same partial-encoding tolerance.
        _kept_joins = []
        fanout_tokens = []
        for j in joins:
            side = join_sides.get(j, "INNER")
            try:
                f_lr, f_rl = self._encode_fanout_tokens_extended(j, side=side)
                fanout_tokens.append(f_lr)
                fanout_tokens.append(f_rl)
                _kept_joins.append(j)
            except (KeyError, IndexError, AttributeError):
                continue
        joins = _kept_joins

        # Filter tokens (75 dim each)
        filter_tokens = []
        _kept_filter_columns = []
        table_sels = {t: [] for t in tables}
        for fc in filter_columns:
            atoms = filter_atoms.get(fc, dict(self.EMPTY_ATOMS))
            try:
                tok = self._encode_filter_token(fc, atoms)
            except (KeyError, IndexError, AttributeError):
                continue
            filter_tokens.append(tok)
            _kept_filter_columns.append(fc)
            # token layout: hist[40] + (10×3) slots + tail(3) + (null_fraction, null_pred_flag)
            # The (lo, hi, sel) triplet starts at offset 40, so sels live at
            # 42, 45, 48, ..., 69 (every 3rd starting at offset 2 inside the
            # slot block). The tail's sel is at offset 40+30+2=72.
            #
            # For PRICE_S compatibility, table_sels gets the TOTAL matched
            # selectivity (sum of slot sels + tail sel), matching PRICE_S's
            # bbox total_freq/table_size convention.
            slot_sels = tok[42:40 + 30:3]
            tail_sel = tok[40 + 30 + 2].item()
            total_sel = sum(slot_sels.tolist()) + tail_sel
            null_pred = tok[-1].item()
            null_frac = tok[-2].item()
            if null_pred == 1.0:
                effective = max(null_frac, 1e-6)
            elif null_pred == -1.0:
                effective = max(1.0 - null_frac, 1e-6)
            elif total_sel > 0:
                effective = total_sel
            else:
                effective = 1e-6
            table_sels[fc.split(".")[0]].append(effective)
        # Reassign filter_columns to the kept set so downstream uses of
        # this list (e.g. n_filter_cols) reflect what actually got encoded.
        filter_columns = _kept_filter_columns

        # Pairwise intra-table tokens (rules h, j). Tolerant: skip atoms
        # whose stats lookup fails.
        pairwise_tokens = []
        for atom in pairwise_atoms:
            # atom: (left_table, col_x, col_y, op, right_table, right_col)
            l_t, cx, cy, op, r_t, r_c = atom
            try:
                pairwise_tokens.append(self._encode_pairwise_intra_token(
                    l_t, cx, cy, op, right_table=r_t, right_col=r_c))
            except (KeyError, IndexError, AttributeError):
                continue

        # Table tokens: delegate to Sql2FeatureS for byte-identical output.
        # PRICE_S computes per-column filter selectivity via histogram40
        # integration (for ranges) or summary40 lookup (for eq/in/like), then
        # feeds them into avi/minsel/ebo. PRICE_N's interval-arithmetic slot
        # sels structurally differ (SpaceSaving OtHeRs underflow), so we use
        # PRICE_S's result directly to keep table tokens equivalent.
        try:
            s_out = self._get_s_helper().create_sql_features(sql)
            # PRICE_S returns (sql_features, n_jc, n_fo, n_tb, n_fc) where
            # sql_features = (join_hist, fanout_feat, table_feat_cat, filter_feat).
            # We want sql_features[2] (the cat'd table token of shape (n_tables*4,)).
            # Use PRICE_S's reported n_tb so it matches the tensor length —
            # PRICE_S may drop tables not in stats (partial encoding), so
            # len(tables) from PRICE_N's parse_sql can overcount. The reported
            # n_tb propagates to downstream padding, which then breaks
            # torch.stack with size mismatches across queries/clauses.
            table_features = [s_out[0][2]]
            n_tb_from_s = int(s_out[3])
            # WARN if PRICE_S silently dropped tables PRICE_N expected.
            # This should be unreachable once PRICE_S's alias canonicalization
            # is in place (porting `_stats_alias_key` from the Canon extractor).
            # If it fires, something — a new edge case or an alias outside
            # `abbrev` — is being dropped from the table tokens while
            # join_hist / fanout / filter were computed against the larger
            # set. The encoder is then semantically inconsistent (per-table
            # summary count differs from per-join cardinality count). Fix
            # the canonicalization gap rather than silencing this warning.
            if n_tb_from_s < len(tables):
                import warnings
                warnings.warn(
                    f"PRICE_S dropped {len(tables) - n_tb_from_s} of "
                    f"{len(tables)} tables ({tables!r}) under delegation "
                    f"in Sql2FeatureN. table_features length is consistent "
                    f"with PRICE_S's reduced view, but join/fanout/filter "
                    f"tokens reflect PRICE_N's full view — possible "
                    f"semantic mismatch. Fix the canonicalization gap.",
                    RuntimeWarning, stacklevel=2)
        except Exception:
            # Fall back to PRICE_N's own computation if PRICE_S can't parse.
            n_tb_from_s = None
            table_features = []
            for t in tables:
                sels = table_sels[t]
                if not sels:
                    avi = torch.tensor([1.0]); minsel = torch.tensor([1.0]); ebo = torch.tensor([1.0])
                else:
                    avi = torch.prod(torch.tensor(sels))
                    minsel = torch.min(torch.tensor(sels))
                    sorted_sels = sorted(sels, reverse=True)
                    ebo_v = 1.0
                    for i, s in enumerate(sorted_sels):
                        if i > 3: break
                        ebo_v *= s ** (1 / (2 ** i))
                    ebo = torch.tensor([ebo_v])
                table_size = self.get_table_size(t)
                table_features.append(torch.cat([
                    torch.tensor([np.log(table_size)], dtype=torch.float32),
                    torch.tensor([avi.item()], dtype=torch.float32),
                    torch.tensor([minsel.item()], dtype=torch.float32),
                    torch.tensor([ebo.item()], dtype=torch.float32),
                ]))

        # Single-table fall-through: zero-pad join_hist + fanout
        if len(join_columns) == 0:
            join_hist = torch.zeros(self.bin_size)
            fanout_feat = torch.zeros(self.fanout_dim_n * 2)
            n_jc, n_fo = 1, 2
        else:
            join_hist = torch.cat(join_column_histograms)
            fanout_feat = torch.cat(fanout_tokens)
            n_jc, n_fo = len(join_columns), len(joins) * 2

        if filter_tokens:
            filter_feat = torch.cat(filter_tokens)
        else:
            filter_feat = torch.zeros(self.filter_dim_n)
        n_fc = max(len(filter_columns), 1)

        if pairwise_tokens:
            pairwise_feat = torch.cat(pairwise_tokens)
            n_pi = len(pairwise_tokens)
        else:
            pairwise_feat = torch.zeros(0)
            n_pi = 0

        feats = (join_hist, fanout_feat,
                 torch.cat(table_features),
                 filter_feat, pairwise_feat)
        # n_tb must match the actual table_features tensor length so the
        # downstream padding produces consistent shapes across queries.
        # When PRICE_S delegated and reported a count, trust that; otherwise
        # derive it from the concatenated tensor (each token is 4 floats).
        n_tb_actual = (n_tb_from_s if n_tb_from_s is not None
                       else feats[2].shape[0] // 4)
        return feats, n_jc, n_fo, n_tb_actual, n_fc, n_pi
