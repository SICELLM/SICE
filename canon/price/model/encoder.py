import torch
import torch.nn as nn
import torch.nn.functional as F
# SICE extension: OrTransformer (Canon) is re-exported through .module.
from .module import ScaleEmbedding, FilterEmbedding, Encoder, OrTransformer
# SICE extension: the AND-transformer (Canon) names the vendored Encoder's role
# of encoding one DNF conjunctive clause; identical parameters and state-dict keys.
from canon.and_transformer import AndTransformer


class RegressionModel(nn.Module):
    def __init__(self, n_join_col, n_fanout, n_table, n_filter_col,
                 hist_dim, table_dim, filter_dim,
                 query_hidden_dim, final_hidden_dim, output_dim,
                 n_embd, n_layers, n_heads, dropout_rate, ffn_ratio=4,
                 n_pairwise_intra=0, pairwise_intra_dim=0,
                 fanout_dim=None, use_or_transformer=False,
                 or_n_layers=1, or_n_heads=4, or_ffn_ratio=1.0):
        super(RegressionModel, self).__init__()
        self.n_join_col, self.n_fanout = n_join_col, n_fanout
        self.n_table, self.n_filter_col = n_table, n_filter_col
        self.n_pairwise_intra = n_pairwise_intra
        self.pairwise_intra_dim = pairwise_intra_dim
        self.fanout_dim = fanout_dim or hist_dim
        self.use_or_transformer = use_or_transformer
        n_features_total = n_join_col + n_fanout + n_table + n_filter_col + n_pairwise_intra
        print(f"n_features: {n_features_total}!")
        self.hist_dim, self.table_dim, self.filter_dim = hist_dim, table_dim, filter_dim
        self.query_hidden_dim, self.final_hidden_dim, self.output_dim = query_hidden_dim, final_hidden_dim, output_dim
        self.n_embd, self.n_layers, self.n_heads = n_embd, n_layers, n_heads
        self.dropout_rate = dropout_rate
        self.ffn_ratio = ffn_ratio

        self.scale_embedding = ScaleEmbedding(
            n_join_col, n_fanout, hist_dim, n_embd,
            fanout_token_dim=self.fanout_dim)
        self.filter_embedding = FilterEmbedding(
            n_join_col, n_fanout, n_table, n_filter_col,
            hist_dim, table_dim, filter_dim, n_embd,
            fanout_token_dim=self.fanout_dim,
            n_pairwise_intra=n_pairwise_intra,
            pairwise_intra_dim=pairwise_intra_dim)
        # Together these two stacks form Canon's AND-transformer: they encode
        # one DNF conjunctive clause (clause index folded into the batch dim).
        self.scale_encoder = AndTransformer(n_embd, n_layers, n_heads, dropout_rate, ffn_ratio)
        self.filter_encoder = AndTransformer(n_embd, n_layers, n_heads, dropout_rate, ffn_ratio)

        if use_or_transformer:
            # Minimal-size OR-Transformer: 1 encoder layer, 4 heads, ffn_ratio=1.0
            # (~396K params at n_embd=256). Override with `or_*` constructor args
            # if you need a different size. The 263K floor is from the QKV/out
            # projections at d_model=256; further reduction would require
            # dropping d_model.
            self.or_transformer = OrTransformer(
                n_embd,
                n_layers=or_n_layers,
                n_heads=or_n_heads,
                dropout_rate=dropout_rate,
                ffn_ratio=or_ffn_ratio)
        else:
            self.or_transformer = None

        self.len_net = nn.Linear(4, 16)
        self.linear = nn.Linear(n_embd + 16, query_hidden_dim)
        self.elu = nn.ELU()
        self.output = nn.Linear(query_hidden_dim, output_dim)

        self.final_linear1 = nn.Linear(3, final_hidden_dim)
        self.final_linear2 = nn.Linear(final_hidden_dim, 1)
        self.relu = nn.ReLU()

    def forward(self, x, pg_est_card=None, padding_mask=None,
                n_join_col=None, n_fanout=None, n_table=None, n_filter_col=None,
                num_clauses=None):
        """
        x: (batch * num_clauses, flat_features) when use_or_transformer and
           num_clauses is provided for multi-clause queries.
           Else (batch, flat_features) like before.
        num_clauses: (batch,) int tensor with clause count per query, used only
           when use_or_transformer=True and multiple clauses are present.
        """
        if self.use_or_transformer:
            # Run scale+filter per-clause (x is already flattened to
            # (batch * num_clauses, flat_features) for multi-clause case,
            # or (batch, flat_features) for the single-clause case).
            scale_features = self.scale_embedding(x)
            masks1 = padding_mask[:, :1 + self.n_join_col + self.n_fanout] if padding_mask is not None else None
            scaling_output = self.scale_encoder(scale_features, masks1)
            filter_features = self.filter_embedding(scaling_output, x)
            masks2 = padding_mask[:, :] if padding_mask is not None else None
            filtering_output = self.filter_encoder(filter_features, masks2)
            per_clause_emb = filtering_output[:, 0, :]   # (batch * num_clauses, n_embd)

            # Reshape to (batch, max_clauses, n_embd) and build clause padding mask
            if num_clauses is not None:
                bsz = num_clauses.size(0)
                max_c = int(num_clauses.max().item())
                per_clause_emb = per_clause_emb.view(bsz, max_c, -1)
                clause_mask = (
                    torch.arange(max_c, device=per_clause_emb.device).unsqueeze(0)
                    >= num_clauses.unsqueeze(1)   # True where padded
                )
            else:
                # Single-clause: wrap as (batch, 1, n_embd)
                per_clause_emb = per_clause_emb.unsqueeze(1)
                clause_mask = None
            query_output = self.or_transformer(per_clause_emb, clause_mask)
        else:
            # Existing path — unchanged
            scale_features = self.scale_embedding(x)
            masks1 = padding_mask[:, :1 + self.n_join_col + self.n_fanout] if padding_mask is not None else None
            scaling_output = self.scale_encoder(scale_features, masks1)
            filter_features = self.filter_embedding(scaling_output, x)
            masks2 = padding_mask[:, :] if padding_mask is not None else None
            filtering_output = self.filter_encoder(filter_features, masks2)
            query_output = filtering_output[:, 0, :]

        # For multi-clause forward, len_features come from the first copy of
        # each query (or must be provided at the batch level).  When
        # num_clauses is set the n_* args are already at batch-level shape.
        len_features = torch.cat([n_join_col, n_fanout, n_table, n_filter_col], dim=1)
        len_features = self.len_net(len_features)

        query_output = self.linear(torch.cat([query_output, len_features], dim=1))
        query_output = self.elu(query_output)
        query_output = F.dropout(query_output, p=self.dropout_rate, training=self.training)
        output = self.output(query_output)

        # Extract table sizes from the raw feature tensor.  When
        # use_or_transformer and num_clauses is not None, x has shape
        # (batch * max_c, flat), so we take the first max_c rows per batch
        # item.  For simplicity, always use x[0::max_c] when multi-clause.
        if self.use_or_transformer and num_clauses is not None:
            max_c = int(num_clauses.max().item())
            x_first = x[::max_c]   # first clause row per query
        else:
            x_first = x

        table_sizes = []
        bias = self.n_join_col * self.hist_dim + self.n_fanout * self.fanout_dim
        for i in range(self.n_table):
            begin, end = bias + i * self.table_dim, bias + (i + 1) * self.table_dim
            table_size = x_first[:, begin:begin+1]  # table_size, without avi, minsel, ebo
            table_sizes.append(table_size)
        cartesian_product = torch.sum(torch.stack(table_sizes, dim=1), dim=1)

        output = self.final_linear1(torch.cat([output, pg_est_card, cartesian_product], dim=1))
        output = self.relu(output)
        output = F.dropout(output, p=self.dropout_rate, training=self.training)
        output = self.final_linear2(output)
        return output
