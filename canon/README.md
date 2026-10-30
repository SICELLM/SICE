# Canon: Statistics-Grounded Predicate Canonicalization

Canon is the predicate canonicalization layer of SICE. It reduces every filter,
join, and Boolean combination of them onto two universal statistical interfaces:

- **Multi-range filtering interface** — a token carrying multiple value ranges
  with their selectivities (covers comparisons, `BETWEEN`, `IN`, `NOT`, and
  same-row column comparisons via difference columns).
- **Operator-conditioned joining interface** — per-direction fanout tokens for
  any comparison operator (equi- and non-equi joins).

Arbitrary `AND`/`OR`/`NOT` structure is handled by a DNF rewrite: each
conjunctive clause is encoded by the AND-transformer, and clause embeddings
are aggregated by the OR-transformer.

Canon builds on the statistics format of the PRICE cardinality estimator
(vendored under `price/`). The pipeline is tokenization → AND encoding → OR
composition, realized by three pieces:

- `features_tool.py` — tokenization: the Canon feature extractor
  (`Sql2FeatureN`) maps predicates onto the two interfaces above.
- `and_transformer.py` — AND encoding: encodes one DNF conjunctive clause.
  The encoder architecture is the vendored PRICE self-attention stack; Canon
  contributes its use per clause (see the file's docstring for attribution).
- `or_transformer.py` — OR composition: aggregates per-clause embeddings
  (DNF disjunction composition), injected into the vendored PRICE model.
- `price/` — the vendored PRICE feature extraction and statistics-encoder model.
- `statistics/` — per-workload statistics (histograms, fanouts, summaries)
  and the pretrained statistics-encoder weights (`statistics/model/`).
