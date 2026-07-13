import json
import numpy as np
import torch
import torch.optim
import joblib
import os
from sklearn import preprocessing
from sklearn.pipeline import Pipeline

from torch.utils.data import DataLoader
import net
from featurize import TreeFeaturizer

CUDA = torch.cuda.is_available()

def _nn_path(base):
    return os.path.join(base, "nn_weights")

def _x_transform_path(base):
    return os.path.join(base, "x_transform")

def _y_transform_path(base):
    return os.path.join(base, "y_transform")

def _channels_path(base):
    return os.path.join(base, "channels")

def _n_path(base):
    return os.path.join(base, "n")


def _inv_log1p(x):
    return np.exp(x) - 1

class BaoData:
    def __init__(self, data):
        assert data
        self.__data = data

    def __len__(self):
        return len(self.__data)

    def __getitem__(self, idx):
        return (self.__data[idx]["tree"],
                self.__data[idx]["target"])

# Import the proper collate function from featurize.py
from .featurize import collate


def _embed_price(price_embedder, price_batch, device):
    """Run the mode-7 cx=0 PRICEEmbedder on a batched PRICE tuple and return the
    512-dim query embedding.

    REUSES the exact num_clauses-keyword call pattern from
    experiments/sice_lib.py::BaselinePriceJointModel.forward:
    under --price_n_or the batched tuple carries a 7th element (num_clauses) that
    is the 9th *positional* param of PRICEEmbedder.forward (after the two llm_*
    slots), so it MUST be passed by keyword. Passing it positionally leaks it into
    llm_hidden_states and silently skips the OR aggregation -> a
    (batch*max_clauses) vs batch shape crash.
    """
    price_batch = list(price_batch)
    # Move every price tensor to the bao device.
    price_batch = [
        t.to(device) if isinstance(t, torch.Tensor) else t for t in price_batch]
    num_clauses = price_batch.pop() if len(price_batch) == 7 else None
    price_emb, _, _ = price_embedder(*price_batch, num_clauses=num_clauses)
    return price_emb


class _BaoPriceDataset(torch.utils.data.Dataset):
    """Pairs each featurized tree with its per-query PRICE feature tuple (aligned
    by index to the featurized X). __getitem__ -> (featurized_tree, price_tuple, y)."""
    def __init__(self, featurized_X, price_feats, y):
        assert len(featurized_X) == len(price_feats) == len(y), (
            f"bao joint: featurized_X ({len(featurized_X)}), price_feats "
            f"({len(price_feats)}), y ({len(y)}) length mismatch")
        self.X = featurized_X
        self.price_feats = price_feats
        self.y = y

    def __len__(self):
        return len(self.X)

    def __getitem__(self, i):
        return self.X[i], self.price_feats[i], self.y[i]


def _bao_price_collate(batch, tree_collate, stack_price):
    """Collate (featurized_tree, price_tuple, y) triples.

    The trees go through bao's existing tree collate (returns (Batch, y)); the
    price half is batched into the PRICEEmbedder tuple via _stack_price (REUSED
    from experiments/sice_lib.py, NOT hand-rolled)."""
    trees = [b[0] for b in batch]
    price_items = [b[1] for b in batch]
    ys = [b[2] for b in batch]
    tree_batch, y_batch = tree_collate(list(zip(trees, ys)))
    price_batch = stack_price(price_items)
    return tree_batch, price_batch, y_batch

class BaoRegression:
    def __init__(self, verbose=False, have_cache_data=False,
                 price_embedder=None, hid_units=256):
        self.__net = None
        self.__verbose = verbose
        # --baseline_price_concat joint path: when price_embedder is set, the
        # model becomes BaoNet (tree-conv -> 64-dim) concat the mode-7 cx=0 PRICE
        # embedding (512-dim) -> Prediction(64+512, hid_units). price_embedder is
        # None for the plain-bao path (byte-for-byte unchanged behavior).
        self.__price_embedder = price_embedder
        self.__hid_units = hid_units
        self.__head = None

        # Label normalization: use the SAME Normalizer as the qf/aimai/e2e_cost
        # baselines (evaluation/utils.py — log(x+0.001), min-max, clamped to
        # [0.001, 1.0]) instead of bao's old sklearn log1p+MinMaxScaler. This
        # unifies bao's label handling with the other baselines and, because the
        # clamp floors actuals at a small positive epsilon, eliminates the inf
        # Q-errors that zero-latency queries (e.g. duckdb tpch) produced. Fit in
        # fit() on the training labels (reset_min_max=True), persisted via mini/maxi.
        self.__norm = None

        self.__tree_transform = TreeFeaturizer()
        self.__have_cache_data = have_cache_data
        self.__in_channels = None
        self.__n = 0
        
    def __log(self, *args):
        if self.__verbose:
            print(*args)

    def num_items_trained_on(self):
        return self.__n

    def clamp_actuals(self, costs):
        """Round-trip raw actual costs through the Normalizer (normalize then
        unnormalize: log(x+0.001), clamp to [0.001,1], invert). Returns the
        SAME clamped actuals the qf/aimai/e2e_cost path compares against in
        trainer.evaluate() (labels_true = norm.unnormalize_labels(norm-labels)).
        This is what makes zero-latency queries finite instead of inf in the
        Q-error metric. Requires fit()/load() to have set self.__norm."""
        costs = list(np.asarray(costs, dtype=np.float64).reshape(-1))
        return np.asarray(self.__norm.unnormalize_labels(
            self.__norm.normalize_labels(costs))).reshape(-1)
            
    def load(self, path):
        with open(_n_path(path), "rb") as f:
            self.__n = joblib.load(f)
        with open(_channels_path(path), "rb") as f:
            self.__in_channels = joblib.load(f)
            
        self.__net = net.BaoNet(self.__in_channels)
        self.__net.load_state_dict(torch.load(_nn_path(path)))
        if torch.cuda.is_available():
            self.__net = self.__net.cuda()
        self.__net.eval()

        from utils import Normalizer
        with open(_y_transform_path(path), "rb") as f:
            _nm = joblib.load(f)
        self.__norm = Normalizer(_nm['mini'], _nm['maxi'])
        with open(_x_transform_path(path), "rb") as f:
            self.__tree_transform = joblib.load(f)

        # --baseline_price_concat joint path: restore the joint head + the
        # finetuned PRICE embedder so predict() can run the joint forward. The
        # cache key carries a "_priceConcat" suffix (set in train_and_test_bao),
        # so a joint run never loads a plain-bao cache and vice versa.
        if self.__price_embedder is not None:
            from trainer import Prediction
            _head_path = os.path.join(path, "head_weights")
            _price_path = os.path.join(path, "price_embedder_weights")
            _head_sd = torch.load(_head_path)
            _price_emb_dim = getattr(self.__price_embedder, 'price_output_dim', 512)
            _bao_emb_dim = _head_sd['out_mlp1.weight'].shape[1] - _price_emb_dim
            self.__head = Prediction(_bao_emb_dim + _price_emb_dim, self.__hid_units)
            self.__head.load_state_dict(_head_sd)
            self.__price_embedder.load_state_dict(torch.load(_price_path))
            if torch.cuda.is_available():
                self.__head = self.__head.cuda()
            self.__head.eval(); self.__price_embedder.eval()

    def save(self, path):
        # try to create a directory here
        os.makedirs(path, exist_ok=True)
        
        torch.save(self.__net.state_dict(), _nn_path(path))
        # Joint (--baseline_price_concat) extra weights: the head and the
        # finetuned PRICE embedder. Plain-bao saves none of these.
        if self.__price_embedder is not None and self.__head is not None:
            torch.save(self.__head.state_dict(), os.path.join(path, "head_weights"))
            torch.save(self.__price_embedder.state_dict(),
                       os.path.join(path, "price_embedder_weights"))
        with open(_y_transform_path(path), "wb") as f:
            joblib.dump({'mini': self.__norm.mini, 'maxi': self.__norm.maxi}, f)
        with open(_x_transform_path(path), "wb") as f:
            joblib.dump(self.__tree_transform, f)
        with open(_channels_path(path), "wb") as f:
            joblib.dump(self.__in_channels, f)
        with open(_n_path(path), "wb") as f:
            joblib.dump(self.__n, f)

    def fit(self, X, y, args, val_X=None, val_y=None,
            price_feats=None, val_price_feats=None):
        if isinstance(y, list):
            y = np.array(y)

#         X = [json.loads(x) if isinstance(x, str) else x for x in X]
        self.__n = len(X)

        # Normalize labels with the shared Normalizer (log(x+0.001) + min-max,
        # clamped to [0.001,1]), fit on these training labels — identical to how
        # the qf/aimai/e2e_cost baselines normalize via ds_info.cost_norm.
        from utils import Normalizer
        self.__norm = Normalizer()
        y = np.asarray(
            self.__norm.normalize_labels(list(np.asarray(y, dtype=np.float64).reshape(-1)),
                                         reset_min_max=True),
            dtype=np.float32).reshape(-1, 1)

        self.__tree_transform.fit(X)
        X = self.__tree_transform.transform(X)

        # --baseline_price_concat joint path: when a PRICE embedder was injected,
        # pair each featurized tree with its (index-aligned) per-query PRICE tuple
        # so each batch is (tree_batch, price_batch, y).
        _joint = self.__price_embedder is not None
        if _joint:
            assert price_feats is not None and len(price_feats) == len(X), (
                "bao joint (--baseline_price_concat): price_feats must be aligned "
                f"1:1 to X ({len(price_feats) if price_feats is not None else None} "
                f"vs {len(X)})")
            # REUSE _stack_price from the baseline PRICE feature provider (do NOT
            # hand-roll tensor stacking) — same fn the qf/aimai/e2e_cost path uses.
            from sice_lib import _stack_price
            _bp_dev = next(self.__price_embedder.parameters()).device
            dataset = DataLoader(
                _BaoPriceDataset(X, price_feats, y),
                batch_size=args.batch_size, shuffle=True,
                collate_fn=lambda b: _bao_price_collate(b, collate, _stack_price))
        else:
            pairs = list(zip(X, y))
            dataset = DataLoader(pairs,
                                 batch_size=args.batch_size,
                                #  batch_size=16,
                                 shuffle=True,
                                 collate_fn=collate)

        # # determine the initial number of channels
        # for inp, _tar in dataset:
        #     in_channels = inp[0][0].shape[0]
        #     break

        for _batch in dataset:
        # inp is a Batch, with `inp.trees` shape [batch, channels, nodes].
        # Both collates put the tree Batch first: non-joint -> (Batch, targets),
        # joint -> (tree_batch, price_batch, y).
            inp = _batch[0]
            in_channels = inp.trees.shape[1]
            break

        self.__log("Initial input channels:", in_channels)

        if self.__have_cache_data:
            assert in_channels == self.__tree_transform.num_operators() + 3
        else:
            assert in_channels == self.__tree_transform.num_operators() + 2

        self.__net = net.BaoNet(in_channels)
        self.__in_channels = in_channels
        if CUDA:
            self.__net = self.__net.cuda()

        if _joint:
            # Probe the bao tree-embedding width on one featurized batch (should be
            # 64 — BaoNet's final Linear is commented out, so it outputs the
            # DynamicPooling width), then build the joint head over 64 + 512.
            from trainer import Prediction
            _first = next(iter(dataset))
            _ft = _first[0]
            if CUDA:
                if hasattr(_ft, 'trees'): _ft.trees = _ft.trees.cuda()
                if hasattr(_ft, 'idxes'): _ft.idxes = _ft.idxes.cuda()
            with torch.no_grad():
                bao_emb_dim = self.__net(_ft).shape[1]
            price_emb_dim = getattr(self.__price_embedder, 'price_output_dim', 512)
            self.__head = Prediction(bao_emb_dim + price_emb_dim, self.__hid_units)
            if CUDA:
                self.__head = self.__head.cuda()
            self.__log(f"[bao joint] head input_dim = {bao_emb_dim} (bao) + "
                       f"{price_emb_dim} (price) = {bao_emb_dim + price_emb_dim}")

        if _joint:
            # Train BaoNet + price_embedder + head jointly.
            _params = (list(self.__net.parameters())
                       + list(self.__price_embedder.parameters())
                       + list(self.__head.parameters()))
            optimizer = torch.optim.Adam(_params, lr=args.learning_rate)
        else:
            optimizer = torch.optim.Adam(self.__net.parameters(), lr=args.learning_rate)
        loss_fn = torch.nn.MSELoss()

        losses = []
        # Early stopping on validation p90 Q-error (same criterion as the generic
        # trainer.train() loop). Enabled only when --early_stop_patience > 0 and a
        # validation set is provided; first allowed to fire at early_stop_after_epoch.
        _es_patience = int(getattr(args, 'early_stop_patience', 0) or 0)
        _es_after = int(getattr(args, 'early_stop_after_epoch', 0) or 0)
        _do_es = _es_patience > 0 and val_X is not None and val_y is not None and len(val_X) > 0
        if _do_es:
            _val_trees = self.__tree_transform.transform(val_X)  # transform once
            _val_true = np.asarray(val_y, dtype=np.float64).reshape(-1)
            # BaoNet.forward needs a COLLATED Batch (.trees/.idxes), like the
            # training loop — feed it through a DataLoader with collate_fn=collate.
            # Joint path: pair val trees with their (aligned) PRICE feats and run
            # the SAME (tree, price, y) collate + joint forward.
            if _joint:
                assert val_price_feats is not None and len(val_price_feats) == len(_val_trees), (
                    "bao joint: val_price_feats must be aligned 1:1 to val_X")
                from sice_lib import _stack_price as _vsp
                _val_loader = DataLoader(
                    _BaoPriceDataset(_val_trees, val_price_feats, [0.0] * len(_val_trees)),
                    batch_size=args.batch_size, shuffle=False,
                    collate_fn=lambda b: _bao_price_collate(b, collate, _vsp))
            else:
                _val_loader = DataLoader(list(zip(_val_trees, [0.0] * len(_val_trees))),
                                         batch_size=args.batch_size, shuffle=False,
                                         collate_fn=collate)
            _es_best = float('inf'); _es_wait = 0; _es_best_epoch = -1
        # for epoch in range(100):
        for epoch in range(args.num_epoch):
            loss_accum = 0
            for _batch in dataset:
                if _joint:
                    x, price_batch, y = _batch
                else:
                    x, y = _batch
                if CUDA:
                    y = y.cuda()
                    if hasattr(x, 'trees'):
                        x.trees = x.trees.cuda()
                    if hasattr(x, 'idxes'):
                        x.idxes = x.idxes.cuda()
                if _joint:
                    # head(cat(BaoNet(trees), PRICEEmbedder(price)))  — _embed_price
                    # uses the num_clauses-keyword pattern from BaselinePriceJointModel.
                    price_emb = _embed_price(self.__price_embedder, price_batch, _bp_dev)
                    y_pred = self.__head(torch.cat([self.__net(x), price_emb], dim=1))
                else:
                    y_pred = self.__net(x)
                loss = loss_fn(y_pred, y)
                loss_accum += loss.item()

                optimizer.zero_grad()
                loss.backward()
                optimizer.step()

            loss_accum /= len(dataset)
            losses.append(loss_accum)
            if epoch % 15 == 0:
                self.__log("Epoch", epoch, "training loss:", loss_accum)

            # Validation-p90 early stopping (kept-current-weights semantics, matching
            # trainer.train(): we stop, we do not roll back to the best epoch).
            if _do_es and epoch >= _es_after:
                self.__net.eval()
                if _joint: self.__head.eval(); self.__price_embedder.eval()
                _vchunks = []
                with torch.no_grad():
                    for _vbatch in _val_loader:
                        if _joint:
                            _vx, _vprice, _ = _vbatch
                        else:
                            _vx, _ = _vbatch
                        if CUDA:
                            if hasattr(_vx, 'trees'): _vx.trees = _vx.trees.cuda()
                            if hasattr(_vx, 'idxes'): _vx.idxes = _vx.idxes.cuda()
                        if _joint:
                            _vpe = _embed_price(self.__price_embedder, _vprice, _bp_dev)
                            _vout = self.__head(torch.cat([self.__net(_vx), _vpe], dim=1))
                        else:
                            _vout = self.__net(_vx)
                        _vchunks.append(_vout.cpu().detach().numpy())
                self.__net.train()
                if _joint: self.__head.train(); self.__price_embedder.train()
                _vp = np.concatenate(_vchunks, axis=0)   # (N, C); BaoNet's final
                # Linear is commented out so output is C-dim. The prediction is
                # column 0 (matches the test loop's inverse_transform(...)[0,0]).
                _vpred = np.asarray(self.__norm.unnormalize_labels(_vp))[:, 0].reshape(-1)
                _vpred = np.clip(_vpred, 1e-6, None)
                # Clamp val truth through the same Normalizer round-trip the test
                # metric uses (so early-stop sees the same units / zero-handling).
                _vtrue = np.clip(np.asarray(self.clamp_actuals(_val_true)).reshape(-1), 1e-6, None)
                _qerr = np.maximum(_vpred / _vtrue, _vtrue / _vpred)
                _val_p90 = float(np.percentile(_qerr, 90))
                if _val_p90 < _es_best:
                    _es_best = _val_p90; _es_wait = 0; _es_best_epoch = epoch
                else:
                    _es_wait += 1
                if _es_wait >= _es_patience:
                    self.__log(f"[EarlyStop] bao: no val-p90 improvement for "
                               f"{_es_patience} epochs (best {_es_best:.4f} at epoch "
                               f"{_es_best_epoch+1}); stopping at epoch {epoch+1}")
                    break

            # # stopping condition
            # if len(losses) > 10 and losses[-1] < 0.1:
            #     last_two = np.min(losses[-2:])
            #     if last_two > losses[-10] or (losses[-10] - last_two < 0.0001):
            #         self.__log("Stopped training from convergence condition at epoch", epoch)
            #         break
        else:
            self.__log("Stopped training after max epochs")

    def predict(self, X, price_feats=None):
        if not isinstance(X, list):
            X = [X]
        X = [json.loads(x) if isinstance(x, str) else x for x in X]

        X = self.__tree_transform.transform(X)

        self.__net.eval()

        # --baseline_price_concat joint path: forward
        # head(cat(BaoNet(trees), PRICEEmbedder(price))) and return the predictions
        # in the SAME shape/units as the plain path (inverse_transform of an (N,1)
        # array). Batch the price feats per query via _stack_price.
        if self.__price_embedder is not None:
            assert price_feats is not None and len(price_feats) == len(X), (
                "bao joint predict: price_feats must be aligned 1:1 to X "
                f"({len(price_feats) if price_feats is not None else None} vs {len(X)})")
            from sice_lib import _stack_price
            self.__head.eval(); self.__price_embedder.eval()
            _bp_dev = next(self.__price_embedder.parameters()).device
            loader = DataLoader(
                _BaoPriceDataset(X, price_feats, [0.0] * len(X)),
                batch_size=getattr(self, '_predict_batch_size', 64), shuffle=False,
                collate_fn=lambda b: _bao_price_collate(b, collate, _stack_price))
            chunks = []
            with torch.no_grad():
                for tree_batch, price_batch, _ in loader:
                    if CUDA:
                        if hasattr(tree_batch, 'trees'): tree_batch.trees = tree_batch.trees.cuda()
                        if hasattr(tree_batch, 'idxes'): tree_batch.idxes = tree_batch.idxes.cuda()
                    pe = _embed_price(self.__price_embedder, price_batch, _bp_dev)
                    out = self.__head(torch.cat([self.__net(tree_batch), pe], dim=1))
                    chunks.append(out.cpu().detach().numpy())
            pred = np.concatenate(chunks, axis=0)   # (N, 1)
            return self.__norm.unnormalize_labels(pred)

        pred = self.__net(X).cpu().detach().numpy()
        return self.__norm.unnormalize_labels(pred)
