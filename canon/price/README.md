# Vendored PRICE (original)

This directory vendors the feature extraction and statistics-encoder model of
**PRICE** ("PRICE: A Pretrained Model for Cross-Database Cardinality
Estimation"), which SICE's Canon layer builds on. We thank the PRICE authors.

Local adaptations are marked in-place:

- `model/module.py` contains a marked SICE extension (the Canon
  OR-transformer).
- `setup/features_tool_b.py` is the PRICE feature format adapted to SICE's
  harness (used by `--price_b`, the "original PRICE encoder" ablation).
- `setup/features_tool_s.py` is shared plumbing used by both extractors (not
  user-selectable).
- Statistics are read from `../statistics/` (i.e., `canon/statistics/`).
