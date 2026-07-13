"""
Shared feature-extraction layer with bounding-box range encoding.

Not user-selectable: both the PRICE (--price_b) and Canon (--canon) extractors
subclass or delegate to this class for table tokens and range handling
for IN/LIKE/NOT LIKE predicates.

Filter encoding: 43 dims = histogram(40) + range(2) + selectivity(1)

Same dimensionality as standard PRICE — pretrained weights load perfectly.

For discrete (categorical) filter columns with IN/LIKE/NOT LIKE:
- histogram(40): SpaceSaving values / table_size (same as PRICE)
- range(2): bounding-box [min_idx/bin_size, (max_idx+1)/bin_size] over matched values
- selectivity(1): sum of all matched value frequencies / table_size

For discrete columns with EQ (single value):
- Same as standard PRICE

For continuous filter columns:
- Same as standard PRICE
"""

import re
import numpy as np
import torch
import sqlglot

from .features_tool import Sql2Feature


class Sql2FeatureS(Sql2Feature):
    """Improved PRICE feature extractor with bounding-box range for IN/LIKE/NOT LIKE.

    filter_dim = bin_size + 3 = 43 (same as standard PRICE)
    """

    @staticmethod
    def _is_inside_subquery(node):
        """True if `node` has a Subquery/Exists ancestor (those nodes belong
        to non-inlined subqueries and should not contribute to the outer
        query's stat-core encoding)."""
        p = node.parent
        while p is not None:
            if isinstance(p, (sqlglot.exp.Subquery, sqlglot.exp.Exists)):
                return True
            p = p.parent
        return False

    def parse_sql(self, sql):
        """PRICE_S override: like base parser, but skips Tables/Columns/EQs
        that live inside a Subquery/Exists. Mirrors Sql2FeatureN.parse_sql so
        TPC-DS-style correlated-subquery queries (q18, q35, etc.) don't pull
        their inner tables into the outer table list.
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

    def _like_to_in_values(self, pattern, keys):
        """Convert a LIKE pattern to a list of matching SpaceSaving keys.

        Args:
            pattern: SQL LIKE pattern string (e.g., "'%Drama%'" with quotes)
            keys: SpaceSaving keys list (last entry is 'OtHeRs' or padding)

        Returns:
            List of matching key values (excluding 'OtHeRs' and padding).
        """
        # Strip surrounding quotes
        p = pattern.strip("'\"")
        # Convert SQL LIKE pattern to regex:
        # Split on % (any-sequence wildcard), escape literal parts, rejoin with .*
        # Also convert _ (single-char wildcard) to .
        parts = p.split('%')
        regex_parts = [re.escape(part).replace('_', '.') for part in parts]
        regex_str = '.*'.join(regex_parts)
        regex = re.compile(f'^{regex_str}$', re.IGNORECASE)

        matched = []
        for key in keys:
            if key == 'OtHeRs' or key == -1e3:
                continue
            if isinstance(key, str) and regex.match(key):
                matched.append(key)
        return matched

    def _get_filter_type_from_sql(self, sql, column):
        """Detect filter type and values for a column from parsed SQL.

        Returns:
            ('eq', value)           for single equality
            ('in', [values])        for IN list
            ('not_like', pattern)   for NOT LIKE / NOT ILIKE
            ('like', pattern_str)   for LIKE / ILIKE
            None                    if no recognized filter found
        """
        parsed_sql = sqlglot.parse_one(sql)
        where = parsed_sql.args.get("where")
        if where is None:
            return None

        # Priority: IN > NOT LIKE > LIKE > EQ
        for in_node in where.find_all(sqlglot.exp.In):
            if column == str(in_node.this):
                values = in_node.expressions
                if values:
                    parsed_vals = []
                    for v in values:
                        try:
                            parsed_vals.append(int(str(v)))
                        except ValueError:
                            try:
                                parsed_vals.append(float(str(v)))
                            except ValueError:
                                parsed_vals.append(str(v).replace("'", ""))
                    return ('in', parsed_vals)

        # NOT LIKE / NOT ILIKE (check before bare LIKE since Not wraps Like)
        for not_node in where.find_all(sqlglot.exp.Not):
            child = not_node.this
            if isinstance(child, (sqlglot.exp.Like, sqlglot.exp.ILike)):
                if column == str(child.this):
                    pattern = str(child.expression)
                    return ('not_like', pattern)

        for like_type in (sqlglot.exp.Like, sqlglot.exp.ILike):
            for like_node in where.find_all(like_type):
                if column == str(like_node.this):
                    pattern = str(like_node.expression)
                    return ('like', pattern)

        for eq_node in where.find_all(sqlglot.exp.EQ):
            if column != str(eq_node.args["this"]):
                continue
            if isinstance(eq_node.args["expression"], sqlglot.exp.Column):
                continue  # join condition, not filter
            try:
                val = int(str(eq_node.args["expression"]))
            except ValueError:
                try:
                    val = float(str(eq_node.args["expression"]))
                except ValueError:
                    val = str(eq_node.args["expression"]).replace("'", "")
            return ('eq', val)

        return None

    def _encode_bounding_box(self, matched_values, keys, values):
        """Encode matched values as a bounding-box range (2 dims) + total frequency.

        Args:
            matched_values: list of values to look up in SpaceSaving
            keys: SpaceSaving keys (list, last is 'OtHeRs')
            values: SpaceSaving frequencies (list, same length as keys)

        Returns:
            (range_tensor[2], total_frequency)
        """
        if not matched_values:
            # No match: fall back to OtHeRs bucket
            others_idx = len(keys) - 1
            return torch.tensor([others_idx / self.bin_size,
                                 (others_idx + 1) / self.bin_size]), values[-1]

        matched_indices = []
        total_freq = 0.0
        for val in matched_values:
            try:
                idx = keys.index(val)
                freq = values[idx]
            except ValueError:
                # Value not in top-(bin_size-1), falls into OtHeRs bucket
                idx = len(keys) - 1
                freq = values[-1]
            matched_indices.append(idx)
            total_freq += freq

        lo = min(matched_indices) / self.bin_size
        hi = (max(matched_indices) + 1) / self.bin_size
        return torch.tensor([lo, hi]), total_freq

    def create_sql_features(self, sql):
        """Create SQL features with PRICE_S encoding (43-dim filters).

        Same structure and dimensionality as standard PRICE but with improved
        discrete column encoding: IN/LIKE/NOT LIKE predicates are resolved to
        matched SpaceSaving values, then encoded as a bounding-box range.
        """
        columns, tables, joins, ref_to_tables = self.parse_sql(sql)

        # Partial-encoding mode: do NOT enforce the spanning-tree check
        # (len(tables) == len(joins) + 1). Encode whatever equi-joins and
        # col-op-literal filters we can; drop predicates we can't handle.
        # Filters columns that don't appear in the schema are skipped below
        # via try/except. Tables not in the stats are also skipped.

        # Restrict to tables the stats know about — drop the rest silently.
        _known_tables = set(self.information_size.keys())
        tables = [t for t in tables if t in _known_tables]
        if not tables:
            # Nothing encodable — return a dummy zero-feature tuple. The caller
            # (sice_lib.generate_price_features) wraps this in a
            # try/except and substitutes zero-fill anyway, but a clean None
            # signals "intentionally empty".
            return None
        # Drop joins / columns whose tables are gone.
        joins = [j for j in joins
                 if j.split("=")[0].split(".")[0].strip() in _known_tables
                 and j.split("=")[1].split(".")[0].strip() in _known_tables]
        columns = [c for c in columns if c.split(".")[0] in _known_tables]

        table_join_cols_dict, table_filter_cols_dict = {}, {}
        for table in tables:
            table_join_cols_dict[table] = []
            table_filter_cols_dict[table] = []

        for column in columns:
            table = column.split(".")[0]
            join_flag = False
            for join in joins:
                left_join_col = join.split("=")[0].strip()
                right_join_col = join.split("=")[1].strip()
                if column == left_join_col or column == right_join_col:
                    join_flag = True
                    break
            if join_flag:
                table_join_cols_dict[table].append(column)
            else:
                table_filter_cols_dict[table].append(column)

        join_columns = self.flatten_list(list(table_join_cols_dict.values()))
        filter_columns = self.flatten_list(list(table_filter_cols_dict.values()))

        table_features = []
        table_sels = {}
        for table in tables:
            table_sels[table] = []

        # Join column histograms (same as PRICE). Skip joins whose columns
        # don't have stats (partial-encoding mode).
        join_column_histograms = []
        _kept_join_columns = []
        for join_column in join_columns:
            try:
                join_column_histogram = self.get_column_histograms(join_column)
                join_column_histograms.append(torch.tensor(join_column_histogram))
                _kept_join_columns.append(join_column)
            except (KeyError, IndexError):
                continue
        join_columns = _kept_join_columns

        # Fanout features. Skip joins whose stats aren't available.
        fanout_features = []
        _kept_joins = []
        for join in joins:
            try:
                ff1, ff2 = self.get_fanout_features(join)
                fanout_features.append(torch.tensor(ff1))
                fanout_features.append(torch.tensor(ff2))
                _kept_joins.append(join)
            except (KeyError, IndexError):
                continue
        joins = _kept_joins

        # PRICE_S filter encoding (43-dim: histogram + bounding-box range + selectivity)
        # Partial-encoding mode: each filter_column is wrapped in try/except.
        # On any failure (column missing from schema/stats, unsupported predicate
        # shape, etc.) we silently skip that column. Both filter_column_features
        # and the final filter_columns list get updated to track only the
        # successfully-encoded columns — so n_fc downstream stays consistent.
        fdim = self.bin_size + 3
        filter_column_features = []
        _kept_filter_columns = []

        for filter_column in filter_columns:
          try:
            col_name = filter_column.split('.')[-1]
            col_table = filter_column.split('.')[0]
            is_discrete = col_name in self.information_coltype['col_type'][col_table]['dsct']

            if is_discrete:
                keys, vals = self.space_saving_summary(filter_column)
                table_size = self.get_table_size(col_table)
                # SpaceSaving (summary40) is for STRING discrete columns where
                # there's no natural ordering for bin-width histograms. Numeric
                # discrete columns use the bin-width histogram (histogram40),
                # consistent with the range-fallback path below and with
                # Sql2FeatureN's same-column-type logic.
                _is_string_discrete = bool(keys) and isinstance(keys[0], str)
                if _is_string_discrete:
                    histogram = torch.tensor(vals) / table_size
                else:
                    histogram = torch.tensor(
                        self.get_column_histograms(filter_column),
                        dtype=torch.float32)

                filter_info = self._get_filter_type_from_sql(sql, filter_column)

                if filter_info is not None:
                    ftype, fval = filter_info

                    if ftype == 'eq':
                        # Same as standard PRICE: single value range + selectivity
                        try:
                            idx = keys.index(fval)
                            freq = vals[idx]
                        except ValueError:
                            idx = len(keys) - 1
                            freq = vals[-1]
                        filter_column_ranges = torch.tensor(
                            [idx / self.bin_size, (idx + 1) / self.bin_size])
                        filter_column_selectivity = torch.tensor([freq / table_size])

                    elif ftype == 'in':
                        filter_column_ranges, total_freq = self._encode_bounding_box(
                            fval, keys, vals)
                        filter_column_selectivity = torch.tensor([total_freq / table_size])

                    elif ftype == 'like':
                        matched = self._like_to_in_values(fval, keys)
                        if matched:
                            filter_column_ranges, total_freq = self._encode_bounding_box(
                                matched, keys, vals)
                            filter_column_selectivity = torch.tensor([total_freq / table_size])
                        else:
                            # No match in top keys; attribute to OtHeRs
                            others_idx = len(keys) - 1
                            filter_column_ranges = torch.tensor(
                                [others_idx / self.bin_size,
                                 (others_idx + 1) / self.bin_size])
                            filter_column_selectivity = torch.tensor([vals[-1] / table_size])

                    elif ftype == 'not_like':
                        # NOT LIKE: match pattern, then take complement
                        matched = self._like_to_in_values(fval, keys)
                        matched_set = set(matched)
                        # Unmatched = all real keys (excluding OtHeRs/padding) minus matched
                        unmatched = [k for k in keys
                                     if k != 'OtHeRs' and k != -1e3 and k not in matched_set]
                        if unmatched:
                            filter_column_ranges, total_freq = self._encode_bounding_box(
                                unmatched, keys, vals)
                            filter_column_selectivity = torch.tensor([total_freq / table_size])
                        else:
                            # Everything matched -> NOT LIKE selects nothing from top keys
                            # Only OtHeRs values remain
                            others_idx = len(keys) - 1
                            filter_column_ranges = torch.tensor(
                                [others_idx / self.bin_size,
                                 (others_idx + 1) / self.bin_size])
                            filter_column_selectivity = torch.tensor([vals[-1] / table_size])

                    if filter_column_selectivity.item() == 0.0:
                        filter_column_selectivity = torch.tensor([1e-6])

                    table_sels[col_table].append(filter_column_selectivity.item())
                    feature = torch.cat([histogram, filter_column_ranges,
                                         filter_column_selectivity])

                else:
                    # Discrete column with non-EQ/IN/LIKE filter (e.g., <, >)
                    # Fall back to histogram-based encoding
                    histogram = torch.tensor(self.get_column_histograms(filter_column))
                    filter_column_ranges = torch.tensor(self.get_filter_norm_range(
                        sql, filter_column, self.columns_bin_edges[filter_column]))
                    range_low, range_high = self.get_filter_ranges(sql, filter_column)
                    distribution = self.columns_distributions[filter_column]
                    bin_edges = self.columns_bin_edges[filter_column]
                    selectivity = self.calculate_hist_selectivity(
                        distribution, bin_edges, range_low, range_high
                    ) / table_size
                    if selectivity == 0.0:
                        selectivity = 1e-6
                    sel_tensor = torch.tensor([selectivity])
                    table_sels[col_table].append(selectivity)
                    feature = torch.cat([histogram, filter_column_ranges, sel_tensor])

            else:
                # Continuous column: histogram + range + selectivity (same as PRICE)
                histogram = torch.tensor(self.get_column_histograms(filter_column))
                filter_column_ranges = torch.tensor(self.get_filter_norm_range(
                    sql, filter_column, self.columns_bin_edges[filter_column]))
                range_low, range_high = self.get_filter_ranges(sql, filter_column)
                distribution = self.columns_distributions[filter_column]
                bin_edges = self.columns_bin_edges[filter_column]
                selectivity = self.calculate_hist_selectivity(
                    distribution, bin_edges, range_low, range_high
                ) / self.get_table_size(col_table)
                if selectivity == 0.0:
                    selectivity = 1e-6
                sel_tensor = torch.tensor([selectivity])
                table_sels[col_table].append(selectivity)
                feature = torch.cat([histogram, filter_column_ranges, sel_tensor])

            assert feature.shape[0] == fdim, \
                f"Expected {fdim}-dim filter feature, got {feature.shape[0]}"
            filter_column_features.append(feature)
            _kept_filter_columns.append(filter_column)
          except (KeyError, IndexError, AttributeError, AssertionError, ValueError):
            # Column missing from stats, predicate shape we can't decode, or
            # any related lookup failure — skip silently (partial-encoding mode).
            continue
        filter_columns = _kept_filter_columns

        # Table features: log_size, avi, minsel, ebo (same as PRICE)
        for table in tables:
            if len(table_sels[table]) == 0:
                avi = torch.tensor([1])
                minsel = torch.tensor([1])
                ebo = torch.tensor([1])
            else:
                avi = torch.prod(torch.tensor(table_sels[table]))
                minsel = torch.min(torch.tensor(table_sels[table]))
                sorted_sels = sorted(table_sels[table], reverse=True)
                ebo = 1
                for i in range(len(sorted_sels)):
                    if i > 3:
                        break
                    ebo = ebo * sorted_sels[i] ** (1 / (2 ** i))
                ebo = torch.tensor([ebo])
            table_size = self.get_table_size(table)
            assert avi.item() != 0.0 and minsel.item() != 0.0 and ebo.item() != 0.0
            table_features.append(torch.cat([
                torch.tensor([np.log(table_size)]),
                torch.tensor([avi]),
                torch.tensor([minsel]),
                torch.tensor([ebo])
            ]))

        # Handle single-table queries (no joins/fanout) and the partial-
        # encoding edge case where some join cols / fanout pairs survived
        # but the other side dropped entirely (e.g. JOB queries whose
        # join columns are in `histogram40.pkl` but the join PAIR isn't
        # in `fanout40.pkl`). Treat each side independently so a non-empty
        # list isn't paired with an empty one.
        if len(join_column_histograms) == 0:
            join_hist = torch.zeros(self.bin_size)
            n_jc = 1
        else:
            join_hist = torch.cat(join_column_histograms)
            n_jc = len(join_columns)
        if len(fanout_features) == 0:
            fanout_feat = torch.zeros(self.bin_size * 2)
            n_fo = 2
        else:
            fanout_feat = torch.cat(fanout_features)
            n_fo = len(joins) * 2

        if len(filter_column_features) > 0:
            filter_feat = torch.cat(filter_column_features)
        else:
            filter_feat = torch.zeros(fdim)

        n_tb = len(tables)
        n_fc = max(len(filter_columns), 1)

        tensor_list = [join_hist, fanout_feat, torch.cat(table_features), filter_feat]
        sql_feature_len = len(torch.cat(tensor_list))

        sql_features = (join_hist, fanout_feat, torch.cat(table_features), filter_feat)

        expected = self.bin_size * (n_jc + n_fo) + 4 * n_tb + fdim * n_fc
        assert sql_feature_len == expected, \
            f"Expected feature length {expected}, got {sql_feature_len}"

        # Spanning-tree assertions removed — partial encoding tolerance
        # mode already drops tables and may produce queries where
        # len(joins) != len(tables) - 1 (e.g. JOB queries with cyclic joins,
        # or post-pruning of unknown tables).
        return sql_features, n_jc, n_fo, n_tb, n_fc
