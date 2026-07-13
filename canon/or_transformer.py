"""Canon OR-transformer: DNF disjunction composition.

Aggregates per-conjunctive-clause embeddings (produced by the AND-transformer,
i.e. the vendored PRICE self-attention encoder) into a single statistics
embedding. Part of SICE's Canon layer, injected into the vendored PRICE model
(see canon/price/model/module.py).
"""

import torch
import torch.nn as nn


class OrTransformer(nn.Module):
    """Aggregator over per-clause embeddings via attention pooling.

    Always applied as the third stage of the PRICE_N encoder, after
    scale_encoder + filter_encoder. Input: (batch, num_clauses, n_embd) +
    optional clause padding mask. Output: (batch, n_embd) — the CLS
    position-0 attention output.

    For single-clause input (the common case in TPC-H/DS), the layer is
    degenerate (length-1 non-CLS sequence + CLS) but still runs and is
    trained by every query. This keeps statistics-core embedding semantics
    uniform across queries.
    """
    def __init__(self, n_embd, n_layers=2, n_heads=8, dropout_rate=0.1, ffn_ratio=4.0):
        super().__init__()
        self.cls_token = nn.Parameter(torch.zeros(1, 1, n_embd))
        nn.init.normal_(self.cls_token, std=0.02)
        encoder_layer = nn.TransformerEncoderLayer(
            d_model=n_embd, nhead=n_heads,
            dim_feedforward=int(n_embd * ffn_ratio),
            dropout=dropout_rate, batch_first=True,
        )
        self.encoder = nn.TransformerEncoder(encoder_layer, num_layers=n_layers)

    def forward(self, clause_embs, clause_mask=None):
        """
        clause_embs: (batch, num_clauses, n_embd) — per-clause embeddings.
        clause_mask: (batch, num_clauses) bool, True for padded positions.
        Returns: (batch, n_embd) — the CLS position-0 output.
        """
        bsz = clause_embs.size(0)
        cls = self.cls_token.expand(bsz, 1, -1)
        seq = torch.cat([cls, clause_embs], dim=1)   # (batch, 1 + num_clauses, n_embd)
        if clause_mask is not None:
            cls_mask = torch.zeros(bsz, 1, dtype=torch.bool, device=clause_mask.device)
            full_mask = torch.cat([cls_mask, clause_mask], dim=1)
        else:
            full_mask = None
        out = self.encoder(seq, src_key_padding_mask=full_mask)
        return out[:, 0, :]


