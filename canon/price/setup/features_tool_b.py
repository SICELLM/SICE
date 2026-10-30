"""PRICE_B: original-PRICE feature extractor relaxed to encode cyclic
join graphs and tolerate missing-column stats.

PRICE_B uses the *original* PRICE design — only equi-join and col-op-literal
predicates are kept (BETWEEN/IN/LIKE/NULL/NOT/OR/subqueries are dropped
upstream in `transform_sql_for_price(price_b=True)`).  The token format is
identical to base PRICE.

We inherit from Sql2FeatureS rather than Sql2Feature to pick up:
  - the spanning-tree relaxation (so JOB-style triangle joins encode
    instead of returning None), and
  - the partial-encoding tolerance (so unknown columns get skipped
    instead of raising KeyError).

Since PRICE_B's upstream transform has already stripped every IN/LIKE
predicate, Sql2FeatureS's IN/LIKE-specific code paths never fire — the
extractor reduces to byte-identical col-op-literal + equi-join encoding.
"""
from .features_tool_s import Sql2FeatureS


class Sql2FeatureB(Sql2FeatureS):
    pass
