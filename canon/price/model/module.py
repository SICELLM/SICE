import torch
import torch.nn as nn
import torch.nn.functional as F
import math

# SICE extension: the OR-transformer (Canon) is injected into the vendored
# PRICE model. See canon/or_transformer.py.
from canon.or_transformer import OrTransformer  # noqa: F401 (re-exported)


class Head(nn.Module):
    def __init__(self, head_size, n_embd, dropout_rate):
        super(Head, self).__init__()
        self.head_size = head_size
        self.n_embd = n_embd
        self.dropout_rate = dropout_rate

        self.Key = nn.Linear(n_embd, head_size)
        self.Query = nn.Linear(n_embd, head_size)
        self.Value = nn.Linear(n_embd, head_size)

    def forward(self, inputs, padding_mask=None):
        # inputs: [batch_size, n_feature, n_embd]
        # Apply linear transformations to obtain Key, Query, and Value
        keys = self.Key(inputs)
        queries = self.Query(inputs)
        values = self.Value(inputs)
        # Calculate attention scores
        attention_scores = torch.matmul(queries, keys.transpose(-1, -2))
        attention_scores = attention_scores / math.sqrt(keys.size(-1))
        # Apply masking to attention scores
        if padding_mask is not None:
            attention_scores = attention_scores.masked_fill(padding_mask.unsqueeze(1) == 0, -1e9)
        # Apply softmax activation to obtain attention weights
        attention_weights = F.softmax(attention_scores, dim=-1)
        # Apply dropout to attention weights
        attention_weights = F.dropout(attention_weights, p=self.dropout_rate, training=self.training)
        # Apply attention weights to values
        out = torch.matmul(attention_weights, values)

        return out


class MultiHeadAttention(nn.Module):
    def __init__(self, n_heads, head_size, n_embd, dropout_rate):
        super(MultiHeadAttention, self).__init__()
        self.n_heads = n_heads
        self.head_size = head_size
        self.dropout_rate = dropout_rate

        # Create individual heads
        self.heads = nn.ModuleList([Head(head_size, n_embd, dropout_rate) for i in range(n_heads)])
        # Linear projection layer
        self.projection = nn.Linear(n_heads * head_size, n_embd)

    def forward(self, inputs, padding_mask=None):        
        # Split inputs into multiple heads
        head_outputs = [head(inputs, padding_mask) for head in self.heads]
        # Concatenate head outputs along the head dimension
        out = torch.cat(head_outputs, dim=-1)
        # Apply linear projection to obtain the final output
        return self.projection(out)
    

class FeedForward(nn.Module):
    def __init__(self, n_embd, ffn_ratio=4):
        super(FeedForward, self).__init__()
        self.n_embd = n_embd
        ffn_dim = int(ffn_ratio * n_embd)

        self.net = nn.Sequential(
            nn.Linear(n_embd, ffn_dim),
            nn.ELU(),
            nn.Linear(ffn_dim, n_embd),
        )

    def forward(self, inputs):
        return self.net(inputs)


class Block(nn.Module):
    def __init__(self, n_embd, n_heads, dropout_rate, ffn_ratio=4):
        super(Block, self).__init__()
        self.n_embd = n_embd
        self.n_heads = n_heads
        self.dropout_rate = dropout_rate

        # Multi-head attention layer
        self.attention = MultiHeadAttention(n_heads, n_embd // n_heads, n_embd, dropout_rate)
        # Layer normalization layers
        self.norm1 = nn.LayerNorm(n_embd)
        self.norm2 = nn.LayerNorm(n_embd)
        # Feed-forward network
        self.feed_forward = FeedForward(n_embd, ffn_ratio)

        # End of your code
    def forward(self, inputs, padding_mask=None):
        # Apply layer normalization to the inputs
        norm_inputs = self.norm1(inputs)
        # Perform multi-head attention
        attention_out = self.attention(norm_inputs, padding_mask)
        # Add residual connection and apply layer normalization
        attention_out = norm_inputs + attention_out
        # dropout
        attention_out = F.dropout(attention_out, p=self.dropout_rate, training=self.training)
        norm_attention_out = self.norm2(attention_out)
        # Apply feed-forward network
        ff_out = self.feed_forward(norm_attention_out)
        # dropout
        ff_out = F.dropout(ff_out, p=self.dropout_rate, training=self.training)
        # Add residual connection
        out = norm_attention_out + ff_out
        return out


class Encoder(nn.Module):
    def __init__(self, input_dim, n_layers, n_heads, dropout_rate, ffn_ratio=4):
        super(Encoder, self).__init__()
        self.input_dim = input_dim
        self.n_layers = n_layers
        self.n_heads = n_heads
        self.dropout_rate = dropout_rate

        # Stack of blocks
        self.blocks = nn.ModuleList([
            Block(input_dim, n_heads, dropout_rate, ffn_ratio) for _ in range(n_layers)
        ])
        # Layer normalization layer
        self.norm = nn.LayerNorm(input_dim)
        # Linear layer for output projection
        output_proj_dim = int(ffn_ratio * input_dim)
        self.linear = nn.Linear(input_dim, output_proj_dim)
        self.elu = nn.ELU()
        self.output = nn.Linear(output_proj_dim, input_dim)

    def forward(self, inputs, padding_mask=None):
        # inputs: [batch_size, seq_len, n_embd]
        # Apply stacked blocks
        out = inputs
        for block in self.blocks:
            out = block(out, padding_mask)
        # Apply layer normalization
        out = self.norm(out)
        # Linear projection
        output = self.linear(out)
        output = self.elu(output)
        # dropout
        output = F.dropout(output, p=self.dropout_rate, training=self.training)
        output = self.output(output)
        return output
    

class ScaleEmbedding(nn.Module):
    def __init__(self, n_join_col, n_fanout, hist_dim, n_embd,
                 fanout_token_dim=None):
        """
        fanout_token_dim: raw width per fanout token in the input tensor.
            Defaults to hist_dim (base PRICE / PRICE_S).
            For PRICE_N pass `hist_dim + 2` (raw 40-dim histogram + orphan
            + outer_preserve_flag).
        """
        super(ScaleEmbedding, self).__init__()
        self.n_join_col, self.n_fanout = n_join_col, n_fanout
        self.hist_dim = hist_dim
        self.fanout_token_dim = fanout_token_dim or hist_dim
        self.n_embd = n_embd

        # Both Linear layers consume hist_sum + raw_token (hence +1).
        self.join_hist_embeddings = nn.Linear(hist_dim + 1, n_embd)
        self.fanout_embeddings = nn.Linear(self.fanout_token_dim + 1, n_embd)
        self.virtual_token_embedding = nn.Embedding(2, n_embd)

    def forward(self, x):
        features_embedding = []
        virtual_token_embedding = self.virtual_token_embedding(
            torch.ones(x.size(0), dtype=torch.long, device=x.device))
        features_embedding.append(virtual_token_embedding)

        for i in range(self.n_join_col):
            begin, end = i * self.hist_dim, (i + 1) * self.hist_dim
            hist_sum = torch.sum(x[:, begin:end], dim=1)
            features_embedding.append(self.join_hist_embeddings(
                torch.cat([hist_sum.view(-1, 1), x[:, begin:end]], dim=1)))

        bias = self.n_join_col * self.hist_dim
        for i in range(self.n_fanout):
            begin = bias + i * self.fanout_token_dim
            end = begin + self.fanout_token_dim
            # hist_sum is taken from the first hist_dim slice of the token only.
            fanout_hist_part = x[:, begin:begin + self.hist_dim]
            fanout_sum = torch.sum(fanout_hist_part, dim=1)
            features_embedding.append(self.fanout_embeddings(
                torch.cat([fanout_sum.view(-1, 1), x[:, begin:end]], dim=1)))

        return torch.stack(features_embedding, dim=1)
    

class FilterEmbedding(nn.Module):
    def __init__(self, n_join_col, n_fanout, n_table, n_filter_col,
                 hist_dim, table_dim, filter_dim, n_embd,
                 fanout_token_dim=None,
                 n_pairwise_intra=0, pairwise_intra_dim=0):
        super(FilterEmbedding, self).__init__()
        self.n_join_col, self.n_fanout = n_join_col, n_fanout
        self.n_table, self.n_filter_col = n_table, n_filter_col
        self.hist_dim = hist_dim
        self.table_dim = table_dim
        self.filter_dim = filter_dim
        self.n_pairwise_intra = n_pairwise_intra
        self.pairwise_intra_dim = pairwise_intra_dim
        self.fanout_token_dim = fanout_token_dim or hist_dim
        self.n_embd = n_embd

        self.table_embeddings = nn.Linear(table_dim, n_embd)
        self.filter_embeddings = nn.Linear(filter_dim, n_embd)
        if n_pairwise_intra > 0 and pairwise_intra_dim > 0:
            self.pairwise_intra_embeddings = nn.Linear(pairwise_intra_dim, n_embd)
        else:
            self.pairwise_intra_embeddings = None

    def forward(self, scaling_output, x):
        features_embedding = []
        bias = self.n_join_col * self.hist_dim + self.n_fanout * self.fanout_token_dim
        for i in range(self.n_table):
            begin = bias + i * self.table_dim
            end = begin + self.table_dim
            features_embedding.append(self.table_embeddings(x[:, begin:end]))

        bias_f = bias + self.n_table * self.table_dim
        for i in range(self.n_filter_col):
            begin = bias_f + i * self.filter_dim
            end = begin + self.filter_dim
            features_embedding.append(self.filter_embeddings(x[:, begin:end]))

        if self.pairwise_intra_embeddings is not None:
            bias_p = bias_f + self.n_filter_col * self.filter_dim
            for i in range(self.n_pairwise_intra):
                begin = bias_p + i * self.pairwise_intra_dim
                end = begin + self.pairwise_intra_dim
                features_embedding.append(
                    self.pairwise_intra_embeddings(x[:, begin:end]))

        return torch.cat([scaling_output, torch.stack(features_embedding, dim=1)], dim=1)
