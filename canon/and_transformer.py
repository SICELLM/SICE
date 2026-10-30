"""Canon AND-transformer: per-clause conjunction encoding.

Attribution: the encoder architecture is vendored PRICE self-attention
(``canon/price/model/module.py::Encoder``); Canon contributes its use as the
AND-transformer over each conjunctive clause of the DNF. Canon rewrites every
predicate set into disjunctive normal form, then runs the vendored PRICE
scale/filter self-attention stack once per conjunctive clause (clause index
folded into the batch dimension). The per-clause CLS embeddings are afterwards
composed by the OR-transformer (``canon/or_transformer.py``).

``AndTransformer`` is a thin subclass of the vendored ``Encoder`` — identical
parameters, initialization order, and state-dict keys — so pretrained PRICE
weights load unchanged. ``reshape_clauses`` is the pure batching helper that
unfolds the clause dimension and builds the clause padding mask for the
OR-transformer.
"""

import torch

from canon.price.model.module import Encoder as _PriceEncoder


class AndTransformer(_PriceEncoder):
    """Vendored PRICE self-attention encoder, used per DNF conjunctive clause.

    Behaviorally identical to ``canon.price.model.module.Encoder``; the
    subclass exists to name the role the encoder plays in Canon's
    tokenization → AND encoding → OR composition pipeline.
    """


def reshape_clauses(per_clause_emb, num_clauses):
    """Unfold the clause axis and build the OR-transformer padding mask.

    ``per_clause_emb`` has shape (batch * max_clauses, n_embd) with the clause
    index folded into the batch dimension; ``max_clauses`` is the GLOBAL
    padding count baked into the input tensor by ``pad_and_cache_features``,
    NOT the batch-local max of ``num_clauses``. Returns
    ``(emb, clause_mask)`` where ``emb`` is (batch, max_clauses, n_embd) and
    ``clause_mask`` is True at padded clause slots. Pure function, no state.
    """
    bsz = num_clauses.size(0)
    max_c = per_clause_emb.size(0) // bsz
    # `.reshape` instead of `.view`: per_clause_emb is a slice of the encoder
    # output and may be non-contiguous.
    emb = per_clause_emb.reshape(bsz, max_c, -1)
    clause_mask = (
        torch.arange(max_c, device=emb.device).unsqueeze(0)
        >= num_clauses.unsqueeze(1)   # True where padded
    )
    return emb, clause_mask
