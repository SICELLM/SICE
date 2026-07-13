"""Training / evaluation loops shared by SICE and the prior-method baselines:
MSE training over log-normalized costs, early stopping on validation Q-error,
warmup scheduling for the joint model, and Q-error reporting.
"""
import numpy as np
import pandas as pd
import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
from torch.utils.data import DataLoader
from scipy.stats import pearsonr
from sklearn.neighbors import NearestNeighbors
import time
import os
import csv
import time
import logging

# main_logger = logging.getLogger(__name__)

# perf_counter gives you sub-microsecond resolution
timer = time.perf_counter

# Training-session state used by print_qerror to annotate val output.
# Set by train() at entry; read by print_qerror(..., data_sec="val").
_TRAINING_SESSION = {'tag': None, 'start_time': None, 'epoch': None}


def _move_price_batch_to_device(price_batch, device):
    """Move every tensor in a PRICEEmbedder price tuple to ``device``.

    Used by the --baseline_price_concat path: the joint batch is
    (base_batch, price_batch) where price_batch is a tuple of tensors
    (x, padding_mask, n_join_col, n_fanout, n_table, n_filter_col[, num_clauses]).
    """
    return tuple(t.to(device) if torch.is_tensor(t) else t for t in price_batch)



## cost prediction MLP model
class Prediction(nn.Module):
    def __init__(self, in_feature = 69, hid_units = 256, contract = 1, mid_layers = True, res_con = True,
                 no_sigmoid=False):
        super(Prediction, self).__init__()
        self.mid_layers = mid_layers
        self.res_con = res_con
        self.no_sigmoid = no_sigmoid  # if True, return pre-sigmoid logit (used for ResNet additive prediction)

        self.out_mlp1 = nn.Linear(in_feature, hid_units)
        self.mid_mlp1 = nn.Linear(hid_units, hid_units//contract)
        self.mid_mlp2 = nn.Linear(hid_units//contract, hid_units)

        self.out_mlp2 = nn.Linear(hid_units, 1)

    def forward(self, features):
        # print(f"In trainer.py Prediction(), Shape of features: {features.shape}")

        if torch.isnan(features).any():
            print("NaN detected in trainer.py Prediction.features")
            for i, feature in enumerate(features):
                print(f"Feature entry {i}: {feature}")
            print(f"features: {features}")
            # To further isolate NaN values, print only the specific positions where NaNs are located
            nan_positions = torch.isnan(features)
            print(f"NaN detected at positions: {nan_positions.nonzero()}")

        hid = F.relu(self.out_mlp1(features))
        if torch.isnan(hid).any():
            print("NaN detected after first ReLU")

        if self.mid_layers:
            mid = F.relu(self.mid_mlp1(hid))
            if torch.isnan(mid).any():
                print("NaN detected after second ReLU")

            mid = F.relu(self.mid_mlp2(mid))
            if torch.isnan(mid).any():
                print("NaN detected after third ReLU")

            if self.res_con:
                hid = hid + mid
            else:
                hid = mid

        logit = self.out_mlp2(hid)
        if self.no_sigmoid:
            # Return pre-sigmoid logit (used for ResNet additive prediction;
            # caller is responsible for applying sigmoid after summing).
            return logit
        out = torch.sigmoid(logit)
        if torch.isnan(out).any():
            print("NaN detected at output")
        return out


def print_qerror(ps, ls, prints=True,data_sec = "unknown"):
    ps = np.array(ps, dtype=float)
    ls = np.array(ls, dtype=float)

    # mask out any zeroes in ground truth or predictions
    mask = (ls != 0) & (ps != 0)
    p = ps[mask]
    l = ls[mask]

    # Q-error is max(p/l, l/p)
    q = np.maximum(p / l, l / p)

    # compute your stats
    e50   = np.median(q)
    e90   = np.percentile(q, 90)
    e95   = np.percentile(q, 95)
    emax  = np.max(q)
    emean = np.mean(q)

    if prints:
        # stdout
        if data_sec == "val":
            tag = _TRAINING_SESSION.get('tag')
            st = _TRAINING_SESSION.get('start_time')
            ep = _TRAINING_SESSION.get('epoch')
            elapsed_hours = ((time.time() - st) / 3600.0) if st else 0.0
            ep_str = f" epoch={ep}" if ep is not None else ""
            print(f"[val] model={tag}{ep_str} elapsed={elapsed_hours:.3f}h")
        print(f"Data section:       {data_sec}")
        print(f"Median:             {e50}")
        print(f"90th percentile:    {e90}")
        print(f"95th percentile:    {e95}")
        print(f"Max:                {emax}")
        print(f"Mean:               {emean}")

        # log to main logger if available
        try:
            main_logger = logging.getLogger("main_logger")
            if main_logger and main_logger.handlers:
                main_logger.info(f"[QError] Data section: {data_sec}")
                main_logger.info(f"[QError] Median: {e50}")
                main_logger.info(f"[QError] 90th percentile: {e90}")
                main_logger.info(f"[QError] 95th percentile: {e95}")
                main_logger.info(f"[QError] Max: {emax}")
                main_logger.info(f"[QError] Mean: {emean}")
        except Exception:
            pass

    return {
        'q_median': e50,
        'q_90':     e90,
        'q_95':     e95,
        'q_max':    emax,
        'q_mean':   emean,
    }



def get_abs_errors(ps, ls):
    # ensure NumPy arrays of floats
    ps = np.array(ps, dtype=float)
    ls = np.array(ls, dtype=float)

    # absolute differences for all points
    abs_diff = np.abs(ps - ls)

    # build mask: finite & nonzero
    finite_mask = np.isfinite(ps) & np.isfinite(ls)
    nonzero_mask = (ps != 0) & (ls != 0)
    mask = finite_mask & nonzero_mask

    # default fallbacks
    corr = log_corr = mre = np.nan

    # only compute these if we have at least 2 valid points
    if mask.sum() >= 2:
        p = ps[mask]
        l = ls[mask]

        # Pearson on raw values
        corr, _ = pearsonr(p, l)

        # Pearson on log-values
        log_corr, _ = pearsonr(np.log(p), np.log(l))

        # mean relative error
        relative_errors = np.abs(p - l) / np.abs(l)
        mre = np.mean(relative_errors)

    # assemble results
    res = {
        'rmse'      : np.sqrt((abs_diff**2).mean()),
        'corr'      : corr,
        'log_corr'  : log_corr,
        'mre'       : mre,
        'abs_median': np.median(abs_diff),
        'abs_90'    : np.percentile(abs_diff, 90),
        'abs_95'    : np.percentile(abs_diff, 95),
        'abs_99'    : np.percentile(abs_diff, 99),
        'abs_max'   : np.max(abs_diff),
    }
    return res

def get_qerror_distribution(ps, ls, save_path=None, drop_zeros=False):
    """
    Compute per-example Q-error: max(p/l, l/p).

    If drop_zeros=False, any pair where p==0 or l==0 becomes np.inf.
    If drop_zeros=True, those pairs are simply omitted from the returned array.
    """
    ps = np.asarray(ps, dtype=float)
    ls = np.asarray(ls, dtype=float)

    # mask non-finite inputs
    finite_mask = np.isfinite(ps) & np.isfinite(ls)
    p = ps[finite_mask]
    l = ls[finite_mask]

    # mask zeros
    zero_mask = (p == 0) | (l == 0)
    nonzero_mask = ~zero_mask

    # prepare an array to hold all q-errors
    if drop_zeros:
        # only non-zero, non-finite pairs
        p = p[nonzero_mask]
        l = l[nonzero_mask]
        q = np.maximum(p / l, l / p)
    else:
        # keep original order, zeros → inf
        q = np.empty_like(p)
        # fill zeros with inf
        q[zero_mask] = np.inf
        # compute on the rest
        q[nonzero_mask] = np.maximum(p[nonzero_mask] / l[nonzero_mask],
                                      l[nonzero_mask] / p[nonzero_mask])

    # optionally save
    if save_path:
        pd.DataFrame({'qerror': q}).to_csv(save_path, index=False)

    return q


def get_abs_error_distribution(ps, ls, save_path=None, drop_nonfinite=False):
    """
    Compute per-example absolute error: |p − l|.

    By default returns errors for all finite inputs. If drop_nonfinite=True,
    then any p or l that is NaN/Inf is dropped.
    """
    ps = np.asarray(ps, dtype=float)
    ls = np.asarray(ls, dtype=float)

    # compute raw abs diff
    abs_diff = np.abs(ps - ls)

    if drop_nonfinite:
        # only keep entries where both p and l are finite
        mask = np.isfinite(ps) & np.isfinite(ls)
        abs_diff = abs_diff[mask]

    # optionally save
    if save_path:
        pd.DataFrame({'abs_error': abs_diff}).to_csv(save_path, index=False)

    return abs_diff


def evaluate(model, args, loader, norm, device, prints=True, data_sec="unknown", 
            save_embeddings=False, test_embeddings=None, test_templates=None, 
            output_dir_qerror=None, workload_test=None, verbose_info=False,
            train_embeddings=None, test_texts=None):  
    """
    Run inference on `loader` and compute Q-error and absolute-error metrics.

    - `model`: a PyTorch model
    - `args.algo`: algorithm name, special-case 'llm_finetune' for input handling
    - `loader`: DataLoader yielding (x, y) pairs; y are normalized labels
    - `norm`: normalization object with unnormalize_labels()
    - `device`: torch device
    - `prints`: whether to print Q-error summary
    - `data_sec`: an optional label for reporting
    - `save_embeddings`: whether to save embeddings and labels
    - `test_embeddings`: embeddings for the test set (if available)
    - `test_templates`: templates for the test set (if available)
    - `output_dir_qerror`: output directory for saving files
    - `workload_test`: test workload name
    """
    print("evaluating")
    if data_sec == "test":
        eval_start = timer()
    # Non-PyTorch model branch (e.g., AutoGluon)
    if not isinstance(model, nn.Module):
        X_list, y_list = [], []
        for x, y in loader:
            X_list.append(x.detach().cpu().numpy() if torch.is_tensor(x) else np.asarray(x))
            y_list.append(y.detach().cpu().numpy() if torch.is_tensor(y) else np.asarray(y))
        X = np.concatenate(X_list, axis=0)
        y = np.concatenate(y_list, axis=0).reshape(-1)
        preds = model.predict(X).reshape(-1)
        preds_true = norm.unnormalize_labels(preds)
        labels_true = norm.unnormalize_labels(y)
        q_errors      = print_qerror(preds_true, labels_true, prints, data_sec=data_sec)
        abs_errors    = get_abs_errors(preds_true, labels_true)
        q_errors_dist = get_qerror_distribution(preds_true, labels_true)
        abs_errors_dist = get_abs_error_distribution(preds_true, labels_true)
        # Generate verbose output for LLM if requested (embeddings are produced upstream)
        if verbose_info and args.algo == "llm" and output_dir_qerror and train_embeddings is not None and test_embeddings is not None:
            try:
                # Find KNN distances
                k = getattr(args, 'knn_k', 5)
                knn_distances, knn_indices = find_knn_distances(test_embeddings, train_embeddings, k)
                # Generate verbose output path
                verbose_output_path = get_verbose_output_path(output_dir_qerror)
                # Determine plan/embedding file paths and indices mapping
                plan_file_path = getattr(args, 'test_plan_file_path', None)
                embedding_file_path = getattr(args, 'test_embedding_cache_path', None)
                index_map = getattr(args, 'test_original_indices', None)
                # Save verbose output
                save_verbose_output(
                    verbose_output_path,
                    test_texts,                 # may be None
                    test_embeddings,
                    labels_true,
                    preds_true,
                    q_errors_dist,
                    knn_distances,
                    knn_indices,
                    is_card=getattr(args, 'card', False),
                    plan_file_path=plan_file_path,
                    embedding_file_path=embedding_file_path,
                    index_map=index_map if index_map is not None else None
                )
            except Exception as e:
                print(f"[Verbose] Skipped verbose generation for non-torch model: {e}")
        if data_sec == "test":
            eval_time = timer() - eval_start
            args.main_logger.info(f"[Test] Total evaluation time — {eval_time*1000:.2f} ms")
        print("evaluated")
        return q_errors, abs_errors, q_errors_dist, abs_errors_dist
    model.to(device)
    model.eval()

    preds_list = []
    labels_list = []
    embeddings_list = []
    
    # Check if model is Sequential for non-LLM embedding extraction
    is_sequential = isinstance(model, nn.Sequential)
    
    # Determine if we need to extract embeddings for non-LLM verbose output
    # Note: For aimai, the input features ARE the embeddings (not Sequential)
    # For qf/e2e_cost, embeddings come from model[0] (Sequential)
    extract_non_llm_embeddings = (
        verbose_info and 
        args.algo in ['aimai', 'qf', 'e2e_cost'] and 
        data_sec == "test" and
        output_dir_qerror is not None and
        train_embeddings is not None
    )
    
    with torch.no_grad():
        if data_sec == "test":
            data_fetch_start = timer()
        
        for batch_idx, batch in enumerate(loader, start=1):
            if data_sec == "test":
                data_load_time = timer() - data_fetch_start
                args.main_logger.info(f"[Test] Batch {batch_idx} DataLoad — {data_load_time*1000:.2f} ms")
            
            if data_sec == "test":
                batch_start = timer()
            
            _bp_price_batch = None
            if getattr(model, 'is_baseline_price_joint', False):
                # --baseline_price_concat: batch is (base_batch, price_batch).
                base_batch, _bp_price_batch = batch
                x, y = base_batch
                _bp_price_batch = _move_price_batch_to_device(_bp_price_batch, device)
            elif isinstance(batch, (list, tuple)) and len(batch) == 3:
                x, stats, y = batch
            else:
                x, y = batch

            # Move inputs to device if not LLM/PRICE finetuning (collate already puts x on device)
            if _bp_price_batch is not None or args.algo not in ("llm_finetune", "llm_price_finetune", "price_finetune"):
                x = x.to(device)

            # Store embeddings if requested (and not already provided)
            if save_embeddings and test_embeddings is None and _bp_price_batch is None:
                embeddings_list.append(x.cpu().numpy())

            # Forward pass (handle Sequential models and extract embeddings for non-LLM)
            if _bp_price_batch is not None:
                preds = model(x, _bp_price_batch).squeeze()
            else:
                if is_sequential:
                    # For qf/e2e_cost: Extract embedding from first module
                    embedding = model[0](x)
                    # Convert embedding to float32 if needed (LLM may output float16/bfloat16)
                    if embedding.dtype != torch.float32:
                        embedding = embedding.float()
                    # Store embedding for verbose output
                    if extract_non_llm_embeddings:
                        embeddings_list.append(embedding.cpu().numpy())
                    # Get prediction from second module
                    preds = model[1](embedding).squeeze()
                else:
                    # For aimai: Input features ARE the embeddings
                    if extract_non_llm_embeddings and args.algo == 'aimai':
                        embeddings_list.append(x.cpu().numpy())
                preds = model(x).squeeze()
            
            # Collect predictions
            if isinstance(preds, torch.Tensor):
                preds_np = preds.cpu().numpy()
                preds_list_value = preds_np.tolist()
                if isinstance(preds_list_value, float):
                    preds_list.append(preds_list_value)
                else:
                    preds_list.extend(preds_list_value)
            else:
                preds_list.append(float(preds))
            # Collect true labels (assumed already on CPU)
            y_squeezed = y.squeeze()
            if isinstance(y_squeezed, torch.Tensor):
                y_np = y_squeezed.cpu().numpy()
                y_list_value = y_np.tolist()
                if isinstance(y_list_value, float):
                    labels_list.append(y_list_value)
                else:
                    labels_list.extend(y_list_value)
            else:
                labels_list.append(float(y_squeezed))
            
            # Log batch processing time (only for test)
            if data_sec == "test":
                if torch.cuda.is_available():
                    torch.cuda.synchronize()
                batch_time = timer() - batch_start
                args.main_logger.info(f"[Test] Batch {batch_idx} — {batch_time*1000:.2f} ms")
                # Mark start of next data fetch timing
                data_fetch_start = timer()

    # Convert to numpy arrays
    predss = np.array(preds_list, dtype=float).flatten()
    labelss = np.array(labels_list, dtype=float).flatten()

    # Un-normalize both predictions and labels
    preds_true = norm.unnormalize_labels(predss)
    labels_true = norm.unnormalize_labels(labelss)

    # Compute metrics
    q_errors      = print_qerror(preds_true, labels_true, prints, data_sec=data_sec)
    abs_errors    = get_abs_errors(preds_true, labels_true)
    q_errors_dist = get_qerror_distribution(preds_true, labels_true)
    abs_errors_dist = get_abs_error_distribution(preds_true, labels_true)

    # Handle verbose output if requested (only for LLM algorithm)
    if verbose_info and args.algo == "llm" and output_dir_qerror and train_embeddings is not None:
        print("Generating verbose output...")
        
        # Use provided test embeddings
        test_embeddings_verbose = test_embeddings
        
        # Get test texts
        test_texts_list = test_texts
        
        if test_embeddings_verbose is not None:
            # Find KNN distances
            k = getattr(args, 'knn_k', 5)
            knn_distances, knn_indices = find_knn_distances(test_embeddings_verbose, train_embeddings, k)
            
            # Generate verbose output path
            verbose_output_path = get_verbose_output_path(output_dir_qerror)
            
            # Determine plan/embedding file paths and indices mapping
            plan_file_path = getattr(args, 'test_plan_file_path', None)
            embedding_file_path = getattr(args, 'test_embedding_cache_path', None)
            index_map = getattr(args, 'test_original_indices', None)
            
            # Save verbose output
            save_verbose_output(
                verbose_output_path, 
                test_texts_list, 
                test_embeddings_verbose, 
                labels_true, 
                preds_true, 
                q_errors_dist,
                knn_distances, 
                knn_indices, 
                is_card=getattr(args, 'card', False),
                plan_file_path=plan_file_path,
                embedding_file_path=embedding_file_path,
                index_map=index_map if index_map is not None else None
            )
        else:
            print("Warning: Missing data for verbose output generation")
    
    # Handle verbose output for non-LLM algorithms (aimai, qf, e2e_cost)
    elif verbose_info and args.algo in ['aimai', 'qf', 'e2e_cost'] and output_dir_qerror and data_sec == "test":
        if extract_non_llm_embeddings and len(embeddings_list) > 0:
            print(f"Generating verbose output for {args.algo}...")
            
            # Convert test embeddings to numpy array
            test_embeddings_np = np.concatenate(embeddings_list, axis=0)
            print(f"  Test embeddings shape: {test_embeddings_np.shape}")
            
            # Get training embeddings - need to pass through the entire training set
            # This requires access to the train_loader and train dataset
            # For now, I'll mark this as needing to be passed from train.py
            if train_embeddings is not None:
                print(f"  Train embeddings shape: {train_embeddings.shape}")
                
                # Find KNN distances
                k = getattr(args, 'knn_k', 5)
                knn_distances, knn_indices = find_knn_distances(test_embeddings_np, train_embeddings, k)
                
                # Generate verbose output path
                verbose_output_path = get_verbose_output_path(output_dir_qerror)
                
                # Get plan file path, embedding path, and index mapping
                plan_file_path = getattr(args, 'test_plan_file_path', None)
                embedding_file_path = getattr(args, 'test_embedding_cache_path', None)
                index_map = getattr(args, 'test_original_indices', None)
                
                # Save verbose output
                if plan_file_path and embedding_file_path:
                    save_verbose_output(
                        verbose_output_path,
                        None,  # No test texts for non-LLM
                        test_embeddings_np,
                        labels_true,
                        preds_true,
                        q_errors_dist,
                        knn_distances,
                        knn_indices,
                        is_card=getattr(args, 'card', False),
                        plan_file_path=plan_file_path,
                        embedding_file_path=embedding_file_path,
                        index_map=index_map
                    )
                else:
                    print("  Warning: Plan file path not available for verbose output")
            else:
                print("  Warning: Training embeddings not provided - skipping verbose output")
                print("  (You need to generate and pass training embeddings for KNN calculation)")
        else:
            print(f"Warning: Cannot generate verbose output for {args.algo} - embeddings not extracted")

    if data_sec == "test":
        eval_time = timer() - eval_start
        args.main_logger.info(f"[Test] Total evaluation time — {eval_time*1000:.2f} ms")
    print("evaluated")
    return q_errors, abs_errors, q_errors_dist, abs_errors_dist



def get_record(model, loader, labels, bs, norm, device):
    model.to(device)
    model.eval()
    predss = np.empty(0)

    with torch.no_grad():
        for x,y in loader:
            x = x.to(device)           
            preds = model(x).squeeze()
            predss = np.append(predss, preds.cpu().detach().numpy())
    predss = norm.unnormalize_labels(predss)
    predss = predss.tolist()
    return predss, labels

def collate_record(predss, labels, method, save_file):
    if os.path.isfile(save_file):
        df = pd.read_csv(save_file)
    else:
        df = pd.DataFrame(data={'label':labels})
    df[method] = predss
    df.to_csv(save_file,index=False)
    return df

def eval_record(model, loader, labels, bs, norm, device, save_path, method, dataset):
    model.to(device)
    model.eval()
    predss = np.empty(0)

    with torch.no_grad():
        for x,y in loader:
            x = x.to(device)           
            preds = model(x).squeeze()
            predss = np.append(predss, preds.cpu().detach().numpy())
    predss = norm.unnormalize_labels(predss)
    predss = predss.tolist()
    title = [method, dataset]
    title += predss
    file = open('results/cost/test_log.csv', 'a+', newline ='')
    with file:   
        write = csv.writer(file)
        write.writerow(title)
    file.close()



def Logging(args, epoch, qscores, absscores, time, filename = None, save_model = False, model = None):
    arg_keys = [attr for attr in dir(args) if not attr.startswith('__')]
    arg_vals = [getattr(args, attr) for attr in arg_keys]
    
    res = dict(zip(arg_keys, arg_vals))
    model_checkpoint = str(hash(tuple(arg_vals))) + '.pt'

    res['epoch'] = epoch
    res['model'] = model_checkpoint 


    res = {**res, **qscores, **absscores}
    
    res['time'] = time

    filename = args.save_path + filename
    model_checkpoint = args.save_path + model_checkpoint
    
    if filename is not None: ## append if exists
        if os.path.isfile(filename):
            df = pd.read_csv(filename)
            df = df._append(res, ignore_index=True)
            df.to_csv(filename, index=False)
        else:
            df = pd.DataFrame(res, index=[0])
            df.to_csv(filename, index=False)
    if save_model:
        torch.save({
            'model': model.state_dict(),
            'args' : args
        }, model_checkpoint)
    
    return res['model']  

def train(model, train_loader, val_loader, \
    ds_info, args, crit=None, optimizer=None, scheduler=None, prints=True, record=True, start_epoch=0,
    test_loader=None):

    # Non-PyTorch model branch (e.g., AutoGluon)
    if not isinstance(model, nn.Module):
        X_list, y_list = [], []
        for x, y in train_loader:
            X_list.append(x.detach().cpu().numpy() if torch.is_tensor(x) else np.asarray(x))
            y_list.append(y.detach().cpu().numpy() if torch.is_tensor(y) else np.asarray(y))
        X = np.concatenate(X_list, axis=0)
        y = np.concatenate(y_list, axis=0).reshape(-1)
        model.fit(X, y)
        return model

    # Set random seeds for reproducibility
    if hasattr(args, 'seed'):
        np.random.seed(args.seed)

    bs, device, epochs = \
        args.batch_size, args.device, args.num_epoch
    lr = args.learning_rate

    if not optimizer:
        if args.algo == "llm_price_finetune":
            # Separate parameter groups with different LRs
            _raw_price_lr = getattr(args, 'price_warmup_lr', None)
            price_lr = _raw_price_lr if _raw_price_lr is not None else (1e-3 if getattr(args, 'price_random_init', False) else 2.85e-5)

            # Split cross-attention params from PRICE core if available
            _has_cross_attn = hasattr(model.price, 'cross_attn_parameters')
            if _has_cross_attn:
                _ca_lr_arg = getattr(args, 'cross_attn_lr', None)
                # cross-attn group keeps the same base LR as the LLM/LoRA group
                # by default (same `lr`). Earlier we tied this to `price_lr` so
                # the price-warmup schedule would cover both; in practice that
                # made cross-attn under-train (constant 2e-5 instead of ~1e-4
                # step-decay) and degraded mode 12 test results. Revert.
                _cross_attn_lr = _ca_lr_arg if _ca_lr_arg is not None else lr
                price_core_params = [p for p in model.price.price_core_parameters() if p.requires_grad]
                cross_attn_params = [p for p in model.price.cross_attn_parameters() if p.requires_grad]
                # Include refined_llm_proj if present (BiCrossAttn with refined pooling)
                if hasattr(model, 'refined_llm_proj') and model.refined_llm_proj is not None:
                    cross_attn_params += [p for p in model.refined_llm_proj.parameters() if p.requires_grad]
                param_groups = [
                    {'params': [p for p in model.llm.parameters() if p.requires_grad], 'lr': lr},
                    {'params': price_core_params, 'lr': price_lr},
                    {'params': cross_attn_params, 'lr': _cross_attn_lr},
                    {'params': [p for p in model.mlp.parameters() if p.requires_grad], 'lr': lr},
                ]
                print(f"[Optimizer] Cross-attn param group: lr={_cross_attn_lr} "
                      f"({len(cross_attn_params)} params, "
                      f"{sum(p.numel() for p in cross_attn_params)} elements)")
            else:
                param_groups = [
                    {'params': [p for p in model.llm.parameters() if p.requires_grad], 'lr': lr},
                    {'params': [p for p in model.price.parameters() if p.requires_grad], 'lr': price_lr},
                    {'params': [p for p in model.mlp.parameters() if p.requires_grad], 'lr': lr},
                ]
            # Drop empty param groups so the optimizer / scheduler match the
            # 3-group concat setup when cross-attn has no params (cx=0).
            param_groups = [g for g in param_groups if len(g['params']) > 0]
            optimizer = torch.optim.Adam(param_groups)
        else:
            optimizer = torch.optim.Adam(model.parameters(), lr=lr)
    if not scheduler:
        lr_schedule = getattr(args, 'lr_schedule', 'step')
        price_lr_schedule = getattr(args, 'price_lr_schedule', None) or lr_schedule
        warmup_epochs = getattr(args, 'warmup_epochs', 3)

        def make_lambda(schedule_type):
            """Create a lr_lambda function for a given schedule type."""
            if schedule_type == 'cosine':
                import math
                def fn(epoch):
                    return max(1e-7, 0.5 * (1 + math.cos(math.pi * epoch / epochs)))
                return fn
            elif schedule_type == 'warmup_cosine':
                import math
                def fn(epoch):
                    if epoch < warmup_epochs:
                        return (epoch + 1) / warmup_epochs
                    progress = (epoch - warmup_epochs) / max(1, epochs - warmup_epochs)
                    return max(1e-7, 0.5 * (1 + math.cos(math.pi * progress)))
                return fn
            else:  # step
                def fn(epoch):
                    return 0.9 ** (epoch // 20)
                return fn

        if args.algo == "llm_price_finetune" and getattr(args, 'price_random_init', False):
            # Random init: PRICE group uses 1e-3 base lr, drops to 2e-5 after warmup
            # Other groups (LLM, MLP, gate) use their regular schedule
            _raw_price_lr = getattr(args, 'price_warmup_lr', None)
            _price_lr_eff = _raw_price_lr if _raw_price_lr is not None else 1e-3
            _finetune_lr = 2e-5
            _price_warmup = getattr(args, 'price_warmup_epochs', 0)
            def _price_random_fn(epoch, _plr=_price_lr_eff, _flr=_finetune_lr, _pw=_price_warmup):
                if epoch < _pw:
                    return 1.0
                else:
                    return _flr / _plr
            regular_fn = make_lambda(lr_schedule)
            n_groups = len(optimizer.param_groups)
            # Apply the price-random schedule ONLY to PRICE_core (group 1).
            # cross_attn (group 2 when cx>0) follows the regular step-decay schedule
            # at base LR = `lr` (same as LLM/MLP). Earlier we tied cross_attn to
            # PRICE's warmup→2e-5 schedule but that under-trains cross_attn (a
            # constant 2e-5 instead of ~1e-4 step-decay).
            lambdas = [regular_fn, _price_random_fn] + [regular_fn] * (n_groups - 2)
            scheduler = torch.optim.lr_scheduler.LambdaLR(optimizer, lambdas)
            print(f"[Scheduler] Random init: PRICE lr={_price_lr_eff} for first {_price_warmup} epochs, then {_finetune_lr}, others={lr_schedule}")
        elif args.algo == "llm_price_finetune" and price_lr_schedule != lr_schedule:
            # Separate schedules: group 0=LLM, group 1=PRICE, group 2=MLP [, group 3=gate]
            llm_fn = make_lambda(lr_schedule)
            price_fn = make_lambda(price_lr_schedule)
            n_groups = len(optimizer.param_groups)
            lambdas = [llm_fn, price_fn] + [llm_fn] * (n_groups - 2)
            scheduler = torch.optim.lr_scheduler.LambdaLR(optimizer, lambdas)
            print(f"[Scheduler] Separate: LLM={lr_schedule}, PRICE={price_lr_schedule}, warmup={warmup_epochs if 'warmup' in lr_schedule or 'warmup' in price_lr_schedule else 'N/A'}")
        elif lr_schedule == 'cosine':
            scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=epochs, eta_min=1e-6)
            print(f"[Scheduler] CosineAnnealingLR: T_max={epochs}, eta_min=1e-6")
        elif lr_schedule == 'warmup_cosine':
            fn = make_lambda('warmup_cosine')
            scheduler = torch.optim.lr_scheduler.LambdaLR(optimizer, fn)
            print(f"[Scheduler] WarmupCosine: warmup={warmup_epochs}, T_max={epochs}")
        else:
            scheduler = torch.optim.lr_scheduler.StepLR(optimizer, 20, 0.9)
    if not crit:
        crit = torch.nn.MSELoss()

    t0 = time.time()

    # Record session tag + start time for print_qerror val annotations.
    # Use algo for non-LLM algorithms; use model_name for LLM-based ones.
    _algo = getattr(args, 'algo', 'Unknown')
    if 'llm' in _algo:
        _tag = getattr(args, 'model_name', None) or _algo
    else:
        _tag = _algo
    _TRAINING_SESSION['tag'] = _tag
    _TRAINING_SESSION['start_time'] = t0

    best_prev = 999999

    model.to(device)
    
    # Check if model is Sequential for embedding extraction
    is_sequential = isinstance(model, nn.Sequential)
    
    if start_epoch > 0:
        print(f"[Resume] Skipping to epoch {start_epoch} (of {epochs})")
    # Gradient accumulation setup
    grad_accum_steps = getattr(args, 'grad_accum_steps', 1)
    if grad_accum_steps > 1:
        print(f"[GradAccum] Accumulating gradients over {grad_accum_steps} micro-batches "
              f"(effective batch = {bs} * {grad_accum_steps} = {bs * grad_accum_steps})")

    # Staged unfreezing: freeze LLM for the first N epochs, only train the statistics encoder and cross-attn
    _freeze_llm_until = getattr(args, 'freeze_llm_until_epoch', 0)
    _llm_frozen = False
    if _freeze_llm_until > 0 and start_epoch < _freeze_llm_until:
        # Find LLM parameters — look for 'llm.' prefix or Sequential index '0.'
        _llm_params = []
        for name, p in model.named_parameters():
            if name.startswith('llm.') or name.startswith('0.'):
                if p.requires_grad:
                    _llm_params.append((name, p))
                    p.requires_grad = False
        _llm_frozen = True
        print(f"[StagedUnfreeze] Froze {len(_llm_params)} LLM params for epochs 0-{_freeze_llm_until-1}")

    for epoch in range(start_epoch, epochs):
        # Unfreeze LLM at the designated epoch
        if _llm_frozen and epoch >= _freeze_llm_until:
            for name, p in _llm_params:
                p.requires_grad = True
            _llm_frozen = False
            print(f"[StagedUnfreeze] Unfroze {len(_llm_params)} LLM params at epoch {epoch}")

        epoch_start = timer()
        model.train()
        losses = 0
        predss = np.empty(0)
        labels = np.empty(0)

        print(">", end="", flush=True)
        # measure data loading time: time from end of last iteration to when batch is available
        data_fetch_start = timer()
        n_batches = len(train_loader)
        log_interval = max(1, n_batches // 10)  # print ~10 times per epoch
        for batch_idx, batch in enumerate(train_loader, start=1):
            data_load_time = timer() - data_fetch_start
            args.main_logger.info(f"[Train] Epoch {epoch} Batch {batch_idx} DataLoad — {data_load_time*1000:.2f} ms")
            batch_start = timer()
            _bp_price_batch = None
            if getattr(model, 'is_baseline_price_joint', False):
                # --baseline_price_concat: batch is (base_batch, price_batch).
                # base_batch is the baseline collate's (base_x, y) tuple; the
                # joint model forwards (base_x, price_feats) -> Prediction.
                base_batch, _bp_price_batch = batch
                x, y = base_batch
                _bp_price_batch = _move_price_batch_to_device(_bp_price_batch, device)
            elif isinstance(batch, (list, tuple)) and len(batch) == 3:
                x, stats, y = batch
            else:
                x, y = batch
            if args.algo in ('llm_finetune', 'llm_price_finetune', 'price_finetune'):
                y = y.to(device)
                if batch_idx % log_interval == 0 or batch_idx == n_batches:
                    print(f" {batch_idx}/{n_batches}", end="", flush=True)
            else:
                x, y = x.to(device), y.to(device)
                print(".", end="", flush=True)

            # Only zero gradients at the start of an accumulation cycle
            if (batch_idx - 1) % grad_accum_steps == 0:
                optimizer.zero_grad()

            # Forward pass (handle Sequential models)
            if _bp_price_batch is not None:
                preds = model(x, _bp_price_batch)
            elif is_sequential:
                # For Sequential: extract embedding from first module, then pass to second
                embedding = model[0](x)
                # Convert embedding to float32 if needed (LLM may output float16/bfloat16)
                if embedding.dtype != torch.float32:
                    embedding = embedding.float()
                preds = model[1](embedding)
            else:
                preds = model(x)

            loss = crit(preds, y)

            # Scale loss by accumulation steps so that the averaged gradient
            # matches what a single large batch would produce
            if grad_accum_steps > 1:
                loss = loss / grad_accum_steps

            loss.backward()

            # Step optimizer only at the end of an accumulation cycle (or last batch)
            if batch_idx % grad_accum_steps == 0 or batch_idx == n_batches:
                torch.nn.utils.clip_grad_norm_(model.parameters(), 5)
                optimizer.step()

            # Track unscaled loss for logging
            losses += loss.item() * (grad_accum_steps if grad_accum_steps > 1 else 1)
            predss = np.append(predss, preds.detach().cpu().numpy())

            labels = np.append(labels, y.detach().cpu().numpy())

            if torch.cuda.is_available():
                torch.cuda.synchronize()
            batch_time = timer() - batch_start
            args.main_logger.info(f"[Train] Epoch {epoch} Batch {batch_idx} — {batch_time*1000:.2f} ms")
            # mark start of next data fetch timing
            data_fetch_start = timer()

            if args.algo in ("llm_finetune", "llm_price_finetune", "price_finetune") and record and (batch_idx % 200 == 0):
                if not args.card:
                    print_qerror(
                        ds_info.cost_norm.unnormalize_labels(predss),
                        ds_info.cost_norm.unnormalize_labels(labels),
                        data_sec="train"
                    )
                else:
                    print_qerror(
                        ds_info.card_norm.unnormalize_labels(predss),
                        ds_info.card_norm.unnormalize_labels(labels),
                        data_sec="train"
                    )
        epoch_time = timer() - epoch_start
        args.main_logger.info(f"[Train] Epoch {epoch} total — {epoch_time*1000:.2f} ms")
        print("")

        if epoch % 20 == 0 and prints:
            print('Epoch: {}  Avg Loss: {}, Time: {}'.format(epoch,losses/len(predss), time.time()-t0))
            if not args.card:
                print_qerror(ds_info.cost_norm.unnormalize_labels(predss), ds_info.cost_norm.unnormalize_labels(labels),data_sec = "train")
            else:
                print_qerror(ds_info.card_norm.unnormalize_labels(predss), ds_info.card_norm.unnormalize_labels(labels),data_sec = "train")
        ##############
        scheduler.step()

        # Save checkpoint if requested (before val evaluation to avoid OOM loss)
        ckpt_interval = getattr(args, 'checkpoint_interval', 0)
        if ckpt_interval > 0 and (epoch + 1) % ckpt_interval == 0:
            _subdir_tag = getattr(args, 'subdir_tag', '') or ''
            _sub_part = f"/{_subdir_tag}" if _subdir_tag else ""
            ckpt_dir = f"finetuned_models/{getattr(args, 'db', 'postgres')}/checkpoints{_sub_part}"
            os.makedirs(ckpt_dir, exist_ok=True)
            ckpt_prefix = getattr(args, 'checkpoint_prefix', 'ckpt')
            ckpt_path = os.path.join(ckpt_dir, f"{ckpt_prefix}_epoch{epoch+1}.pt")
            ckpt = {
                'epoch': epoch + 1,
                'model_state_dict': model.state_dict(),
                'optimizer_state_dict': optimizer.state_dict(),
                'scheduler_state_dict': scheduler.state_dict(),
            }
            torch.save(ckpt, ckpt_path)
            print(f"[Checkpoint] Saved epoch {epoch+1} to {ckpt_path}")

        ##############
        if record:
            if epoch >= 0:
                _TRAINING_SESSION['epoch'] = epoch + 1
                if not args.card:
                    val_qerrors, _, _, _ = evaluate(model, args, val_loader, ds_info.cost_norm, device, prints=True,data_sec = "val")
                else:
                    val_qerrors, _, _, _ = evaluate(model, args, val_loader, ds_info.card_norm, device, prints=True,data_sec = "val")

                # Per-epoch test evaluation alongside val. Mirrors val: same model
                # forward, same q-error metric. Useful to see how trained-MLP-head
                # test performance evolves and whether the model overfits the train
                # templates over time.
                if test_loader is not None:
                    if not args.card:
                        _ = evaluate(model, args, test_loader, ds_info.cost_norm, device, prints=True, data_sec="test")
                    else:
                        _ = evaluate(model, args, test_loader, ds_info.card_norm, device, prints=True, data_sec="test")

                # Early stopping based on val p90 Q-error
                _es_patience = getattr(args, 'early_stop_patience', 0)
                _es_after = getattr(args, 'early_stop_after_epoch', 0)
                if _es_patience > 0 and val_qerrors is not None and epoch >= _es_after:
                    val_p90 = val_qerrors.get('q_90', float('inf'))
                    if not hasattr(args, '_es_best_val_p90'):
                        args._es_best_val_p90 = float('inf')
                        args._es_wait = 0
                        args._es_best_epoch = epoch
                    if val_p90 < args._es_best_val_p90:
                        args._es_best_val_p90 = val_p90
                        args._es_wait = 0
                        args._es_best_epoch = epoch
                    else:
                        args._es_wait += 1
                    if args._es_wait >= _es_patience:
                        print(f"[EarlyStop] No improvement for {_es_patience} epochs "
                              f"(best val p90={args._es_best_val_p90:.4f} at epoch {args._es_best_epoch+1}). Stopping.")
                        return model

    return model


import torch.nn.init as init
def initialize_weights(m):
    if isinstance(m, nn.Linear):
        # Initialize Linear layers with Glorot/Xavier initialization
        init.xavier_uniform_(m.weight)
        if m.bias is not None:
            init.constant_(m.bias, 0)
    elif isinstance(m, nn.Embedding):
        # Initialize embeddings differently based on their role
        if m.padding_idx is None:
            # Non-padded embedding initialization
            init.uniform_(m.weight, -0.1, 0.1)
        else:
            # Padded embeddings might need zero for the padding index
            init.uniform_(m.weight, -0.1, 0.1)
            if m.padding_idx is not None:
                m.weight.data[m.padding_idx].zero_()
    elif isinstance(m, nn.LayerNorm):
        # Initialize Layer Normalization with constant weights and biases
        init.constant_(m.weight, 1)
        init.constant_(m.bias, 0)
    elif isinstance(m, nn.Dropout):
        # Dropout layers do not have weights and do not require initialization
        pass
    # Check if EncoderLayer or similar structures have parameters and initialize them
    elif hasattr(m, 'parameters'):
        for p in m.parameters():
            if p.dim() > 1: # Assume it's a weight matrix and not a bias vector
                init.xavier_uniform_(p)
    else:
        print("unknown model type")

# For checking NaN in model weights
def print_weights_and_check_nan(model, name="Model"):
    print(f"--- {name} Weights ---")
    for param_name, param in model.named_parameters():
        if param.requires_grad:
            print(f"{param_name}: Mean of weights = {param.data.mean().item()}")
            if torch.isnan(param.data).any():
                print(f"Warning: NaN values detected in {param_name}")
                return True
            else:
                print(f"{param_name} has no NaN values.")
                return False

# For checking NaN in data
def check_data_for_nans(loader, name):
    for i, (batch_data, labels) in enumerate(loader):
        if torch.isnan(batch_data.x).any():
            print(f"NaN detected in input features of {name} loader, batch {i}")
        if torch.isnan(labels).any():
            print(f"NaN detected in labels of {name} loader, batch {i}")

def check_batch_for_nans(batch):
    has_nan = False
    for attr in ['x', 'attn_bias', 'rel_pos', 'heights']:
        if hasattr(batch, attr):
            tensor = getattr(batch, attr)
            if torch.isnan(tensor).any():
                print(f"NaN detected in {attr}")
                has_nan = True
    return has_nan

def train_and_test_bao(train_roots, train_costs, test_roots, test_costs, args, device,
                       total_roots=None, total_costs=None, train_ids=None, test_ids=None,
                       plan_file_path=None, output_dir_qerror=None, dat_paths_train_list=None,
                       val_roots=None, val_costs=None,
                       price_embedder=None, train_price_feats=None,
                       val_price_feats=None, test_price_feats=None):
    """
    Train and test the BaoRegression model. Returns metrics and predictions.
    Optionally generates embeddings and verbose output if verbose_info is enabled.

    --baseline_price_concat joint path: when ``price_embedder`` is provided, bao
    becomes BaoNet (tree-conv -> 64) concat the mode-7 cx=0 PRICE embedding
    (512) -> Prediction head, trained jointly. ``*_price_feats`` are the per-query
    PRICE tuples aligned 1:1 to train/val/test roots (built in train.py via
    build_aligned_price_feats_for_splits, same split ids as the roots). When
    ``price_embedder`` is None this path is byte-for-byte the original plain-bao.
    """
    from algorithms.bao.model import BaoRegression
    from algorithms.bao.featurize import collate as bao_collate
    import time

    _joint_price = price_embedder is not None
    bao = BaoRegression(have_cache_data=True, verbose=True,
                        price_embedder=price_embedder,
                        hid_units=getattr(args, 'hid_units', 256))
    # Check for cached BAO model
    task_str = "card" if args.card else "time"
    _prefix = f"long_raw_{args.db}_"
    _data_names = []
    for _p in sorted(set(dat_paths_train_list)):
        _stem = os.path.splitext(os.path.basename(_p))[0]
        _data_names.append(_stem[len(_prefix):] if _stem.startswith(_prefix) else _stem)
    data_str = '-'.join(_data_names)
    cache_dir = f"finetuned_models/{args.db}/"
    # Joint (--baseline_price_concat) bao has a different architecture (extra head
    # + finetuned PRICE embedder), so tag its cache key so it never loads/overwrites
    # a plain-bao cache.
    _pc_tag = "_priceConcat" if _joint_price else ""
    cache_name = f"{data_str}_{task_str}_bao{_pc_tag}_{args.train_ratio}_b{args.batch_size}_h{args.hid_units}_seed{args.seed}_model"
    cache_path = os.path.join(cache_dir, cache_name)
    # Training
    if os.path.exists(cache_path):
        bao.load(cache_path)
        training_time = 0.0
        print(f"Loaded cached BAO model from {cache_path}")
        args.main_logger.info(f"[Train] Skipped training (loaded from cache)")
    else:
        training_start = time.time()
        bao.fit(train_roots, train_costs, args, val_X=val_roots, val_y=val_costs,
                price_feats=train_price_feats, val_price_feats=val_price_feats)
        training_time = time.time() - training_start
        args.main_logger.info(f"[Train] Training took {training_time*1000:.2f} ms")
        os.makedirs(cache_dir, exist_ok=True)
        bao.save(cache_path)
        print(f"Saved BAO model to {cache_path}")

    # Generate embeddings for verbose output if requested
    train_embeddings_for_knn = None
    test_embeddings = None
    embedding_file_path = None
    
    if getattr(args, 'verbose_info', False) and plan_file_path:
        print("Generating embeddings for BAO verbose output...")
        max_embedding_len = 5000  # Fixed size for variable-length embeddings

        def generate_embeddings_for_roots(roots, progress_label="samples"):
            embeddings_list = []
            total = len(roots)
            for idx, root in enumerate(roots):
                if idx % 100 == 0:
                    print(f"    {progress_label}: {idx}/{total}", end='\r')

                featurized = bao._BaoRegression__tree_transform.transform([root])
                batch, _ = bao_collate(list(zip(featurized, [0.0])))
                batch = batch.to(device)

                with torch.no_grad():
                    tree_conv_without_pooling = bao._BaoRegression__net.tree_conv[:-1]
                    tree_embedding = tree_conv_without_pooling((batch.trees, batch.idxes))

                    if isinstance(tree_embedding, tuple):
                        tree_feats = tree_embedding[0]
                    else:
                        tree_feats = tree_embedding

                    flat_embedding = tree_feats.cpu().numpy().flatten()
                    if len(flat_embedding) >= max_embedding_len:
                        embedding_vector = flat_embedding[:max_embedding_len]
                    else:
                        embedding_vector = np.zeros(max_embedding_len)
                        embedding_vector[:len(flat_embedding)] = flat_embedding

                    embeddings_list.append(embedding_vector)

            print(f"\n    Generated embeddings for {progress_label} ({len(embeddings_list)} samples)")
            return np.array(embeddings_list)

        workloads_train = getattr(args, 'workloads_train', [])
        workload_test = getattr(args, 'workload_test', None)
        seed = getattr(args, 'seed', 42)

        same_file = (
            dat_paths_train_list is not None
            and len(dat_paths_train_list) == 1
            and dat_paths_train_list[0] == plan_file_path
        )

        if same_file and total_roots is not None:
            removed_fields = getattr(args, 'removed_fields', None)
            embedding_file_path = get_embedding_file_path('bao', plan_file_path, workloads_train, workload_test, seed, removed_fields)
            if os.path.exists(embedding_file_path):
                print(f"  Existing BAO embeddings found at {embedding_file_path} - regenerating and overwriting.")

            all_embeddings = generate_embeddings_for_roots(total_roots, "all samples")
            save_non_llm_embeddings(all_embeddings, embedding_file_path)

            if train_ids is not None:
                train_embeddings_for_knn = all_embeddings[train_ids]
                print(f"  Training embeddings for KNN shape: {train_embeddings_for_knn.shape}")
        else:
            from evaluation.dataset_utils import df2nodes

            train_embeddings_chunks = []
            if dat_paths_train_list:
                for dat_path_train in dat_paths_train_list:
                    print(f"  Processing train file: {dat_path_train}")
                    if dat_path_train.endswith('.json'):
                        df_train = pd.read_json(dat_path_train)
                    else:
                        df_train = pd.read_csv(dat_path_train)

                    train_roots_file, _, _ = df2nodes(df_train)
                    train_embeddings = generate_embeddings_for_roots(
                        train_roots_file,
                        f"train file {os.path.basename(dat_path_train)}"
                    )

                    embedding_path_train = get_embedding_file_path(
                        'bao', dat_path_train, workloads_train, workload_test, seed
                    )
                    if os.path.exists(embedding_path_train):
                        print(f"  Existing BAO embeddings found at {embedding_path_train} - regenerating and overwriting.")

                    save_non_llm_embeddings(train_embeddings, embedding_path_train)
                    train_embeddings_chunks.append(train_embeddings)

            if train_embeddings_chunks:
                train_embeddings_for_knn = np.concatenate(train_embeddings_chunks, axis=0)
                print(f"  Training embeddings for KNN shape: {train_embeddings_for_knn.shape}")

            print(f"  Processing test file: {plan_file_path}")
            if plan_file_path.endswith('.json'):
                df_test = pd.read_json(plan_file_path)
            else:
                df_test = pd.read_csv(plan_file_path)

            test_roots_full, _, _ = df2nodes(df_test)

            removed_fields = getattr(args, 'removed_fields', None)
            embedding_file_path = get_embedding_file_path('bao', plan_file_path, workloads_train, workload_test, seed, removed_fields)
            if os.path.exists(embedding_file_path):
                print(f"  Existing BAO embeddings found at {embedding_file_path} - regenerating and overwriting.")

            test_embeddings_full = generate_embeddings_for_roots(
                test_roots_full,
                f"test file {os.path.basename(plan_file_path)}"
            )
            save_non_llm_embeddings(test_embeddings_full, embedding_file_path)

        if embedding_file_path:
            setattr(args, 'test_embedding_cache_path', embedding_file_path)

    # Testing
    test_start = time.time()
    preds_test = []
    test_embeddings_list = []
    max_embedding_len = 5000  # Must match training embedding size

    if _joint_price:
        # Joint forward: head(cat(BaoNet(trees), PRICEEmbedder(price))). predict()
        # returns the same (N,1) inverse-transformed shape/units as the plain path.
        _jp = bao.predict(test_roots, price_feats=test_price_feats)
        preds_test = [float(_jp[i, 0]) for i in range(len(test_roots))]
        test_time = time.time() - test_start
        args.main_logger.info(f"[Test] Testing took {test_time*1000:.2f} ms")
        # Also emit the canonical line the qf/aimai/e2e_cost path logs so the
        # baseline time-profiling harness picks up bao's inference time too.
        args.main_logger.info(f"[Test] Total evaluation time — {test_time*1000:.2f} ms")

        # Compute Q-error against actuals clamped through the SAME Normalizer the
        # qf/aimai/e2e_cost path uses (trainer.evaluate), so zero-latency queries
        # are floored at a small epsilon instead of producing inf.
        _test_costs_m = bao.clamp_actuals(test_costs)
        qerr = print_qerror(preds_test, _test_costs_m)
        abserr = get_abs_errors(preds_test, _test_costs_m)
        qerr_dist = get_qerror_distribution(preds_test, _test_costs_m)
        abserr_dist = get_abs_error_distribution(preds_test, _test_costs_m)
        return {
            'qerr': qerr,
            'abserr': abserr,
            'qerr_dist': qerr_dist,
            'abserr_dist': abserr_dist,
            'preds_test': preds_test,
            'training_time': training_time,
            'test_time': test_time,
        }

    for root in test_roots:
        featurized = bao._BaoRegression__tree_transform.transform([root])
        batch, _ = bao_collate(list(zip(featurized, [0.0])))
        batch = batch.to(device)
        with torch.no_grad():
            # Store embedding BEFORE pooling for verbose output if needed
            if getattr(args, 'verbose_info', False) and train_embeddings_for_knn is not None:
                # Get tree embedding before pooling
                # tree_conv includes DynamicPooling at the end, so use tree_conv[:-1]
                tree_conv_without_pooling = bao._BaoRegression__net.tree_conv[:-1]
                tree_embedding = tree_conv_without_pooling((batch.trees, batch.idxes))
                
                if isinstance(tree_embedding, tuple):
                    tree_feats = tree_embedding[0]
                else:
                    tree_feats = tree_embedding
                
                # Flatten and pad/truncate to fixed size
                flat_embedding = tree_feats.cpu().numpy().flatten()
                if len(flat_embedding) >= max_embedding_len:
                    embedding_vector = flat_embedding[:max_embedding_len]
                else:
                    embedding_vector = np.zeros(max_embedding_len)
                    embedding_vector[:len(flat_embedding)] = flat_embedding
                
                test_embeddings_list.append(embedding_vector)
            
            # Get prediction
            raw_pred = bao._BaoRegression__net(batch)
            raw_np   = raw_pred.cpu().numpy()
        final_pred = np.asarray(bao._BaoRegression__norm.unnormalize_labels(raw_np))
        preds_test.append(final_pred[0,0])
    test_time = time.time() - test_start
    args.main_logger.info(f"[Test] Testing took {test_time*1000:.2f} ms")
    # Also emit the canonical line the qf/aimai/e2e_cost path logs so the
    # baseline time-profiling harness picks up bao's inference time too.
    args.main_logger.info(f"[Test] Total evaluation time — {test_time*1000:.2f} ms")

    # Compute Q-error against actuals clamped through the SAME Normalizer the
    # qf/aimai/e2e_cost path uses (trainer.evaluate), so zero-latency queries
    # are floored at a small epsilon instead of producing inf.
    _test_costs_m = bao.clamp_actuals(test_costs)
    qerr = print_qerror(preds_test, _test_costs_m)
    abserr = get_abs_errors(preds_test, _test_costs_m)
    qerr_dist = get_qerror_distribution(preds_test, _test_costs_m)
    abserr_dist = get_abs_error_distribution(preds_test, _test_costs_m)
    
    # Generate verbose output if requested
    if getattr(args, 'verbose_info', False) and train_embeddings_for_knn is not None and len(test_embeddings_list) > 0:
        print("Generating verbose output for BAO...")
        test_embeddings = np.array(test_embeddings_list)
        
        # Find KNN
        k = getattr(args, 'knn_k', 5)
        knn_distances, knn_indices = find_knn_distances(test_embeddings, train_embeddings_for_knn, k)
        
        # Generate verbose output path
        verbose_output_path = get_verbose_output_path(output_dir_qerror if output_dir_qerror else args.output_dir_qerror)
        
        # Get index mapping (only set when train/test from same file)
        index_map = getattr(args, 'test_original_indices', None)
        
        # Save verbose output
        save_verbose_output(
            verbose_output_path,
            None,  # No test texts for BAO
            test_embeddings,
            test_costs,
            preds_test,
            qerr_dist,
            knn_distances,
            knn_indices,
            is_card=getattr(args, 'card', False),
            plan_file_path=plan_file_path,
            embedding_file_path=embedding_file_path,
            index_map=index_map
        )
    
    return {
        'qerr': qerr,
        'abserr': abserr,
        'qerr_dist': qerr_dist,
        'abserr_dist': abserr_dist,
        'preds_test': preds_test,
        'training_time': training_time,
        'test_time': test_time,
    }


def train_and_test_postgres(train_roots, train_costs, test_roots, test_costs, args, dat_paths_train_list=None):
    """
    Train and test the PostgresEstimator model. Returns metrics and predictions.
    """
    from algorithms.postgres import PostgresEstimator
    import time
    import joblib

    pg = PostgresEstimator()
    if args.card:
        preds = pg.predict_card(test_roots)
        true_vals = test_costs
        label_name = "cardinality"
    else:
        # Check for cached postgres model
        task_str = "time"
        _prefix = f"long_raw_{args.db}_"
        _data_names = []
        for _p in sorted(set(dat_paths_train_list)) if dat_paths_train_list else []:
            _stem = os.path.splitext(os.path.basename(_p))[0]
            _data_names.append(_stem[len(_prefix):] if _stem.startswith(_prefix) else _stem)
        data_str = '-'.join(_data_names) if _data_names else '-'.join(args.workloads_train)
        cache_dir = f"finetuned_models/{args.db}/"
        cache_name = f"{data_str}_{task_str}_postgres_{args.train_ratio}_seed{args.seed}_model.joblib"
        cache_path = os.path.join(cache_dir, cache_name)
        if os.path.exists(cache_path):
            pg._time_model = joblib.load(cache_path)
            print(f"Loaded cached postgres model from {cache_path}")
        else:
            pg.fit(train_roots, train_costs)
            os.makedirs(cache_dir, exist_ok=True)
            joblib.dump(pg._time_model, cache_path)
            print(f"Saved postgres model to {cache_path}")
        preds = pg.predict_time(test_roots)
        true_vals = test_costs
        label_name = "time"

    qerr = print_qerror(preds, true_vals, True, data_sec=f"test")
    abserr = get_abs_errors(preds, true_vals)
    qerr_dist = get_qerror_distribution(preds, true_vals)
    abserr_dist = get_abs_error_distribution(preds, true_vals)
    return {
        'qerr': qerr,
        'abserr': abserr,
        'qerr_dist': qerr_dist,
        'abserr_dist': abserr_dist,
        'preds': preds,
    }


def find_knn_distances(test_embeddings, train_embeddings, k=5):
    """
    Find K nearest neighbors in training set for each test embedding.
    
    Args:
        test_embeddings: numpy array of test embeddings [N_test, D]
        train_embeddings: numpy array of training embeddings [N_train, D]
        k: number of nearest neighbors to find
        
    Returns:
        distances: numpy array of distances to k nearest neighbors [N_test, k]
        indices: numpy array of indices of k nearest neighbors [N_test, k]
    """
    # Use sklearn's NearestNeighbors for efficient computation
    nn = NearestNeighbors(n_neighbors=k, metric='euclidean')
    nn.fit(train_embeddings)
    
    distances, indices = nn.kneighbors(test_embeddings)
    return distances, indices


def save_verbose_output(output_path, test_texts, test_embeddings, true_labels, pred_labels, 
                       q_errors, knn_distances, knn_indices, is_card=False, plan_file_path=None, embedding_file_path=None, index_map=None):
    """
    Save verbose output to file with lightweight references for test set.
    
    Args:
        output_path: path to save the verbose output file
        test_texts: list of test query plan texts (not saved; used for length)
        test_embeddings: numpy array of test embeddings (not saved; used for KNN)
        true_labels: numpy array of true labels (cost or cardinality)
        pred_labels: numpy array of predicted labels
        q_errors: numpy array of Q-errors
        knn_distances: numpy array of distances to k nearest neighbors
        knn_indices: numpy array of indices of k nearest neighbors
        is_card: whether this is cardinality estimation (True) or cost estimation (False)
        plan_file_path: optional path to the source data file containing plans
        embedding_file_path: optional path to the embedding cache file
        index_map: optional list/array mapping test row -> original plan/embedding index
    """
    # Create output directory
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    
    # Prepare data for saving
    k = knn_distances.shape[1]
    
    with open(output_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        
        # Write data header with single idx and file references as columns
        header = ['idx', 'true_label', 'est_label', 'q_error', 'avg_knn_distance',
                  'plan_file', 'embedding_file']
        writer.writerow(header)
        
        # Write data rows
        for i in range(len(true_labels)):
            # Calculate average KNN distance
            avg_knn_distance = np.mean(knn_distances[i, :])
            
            # Map to original index if provided
            orig_idx = int(index_map[i]) if index_map is not None else i
            
            # Only store file paths once (first row); leave empty afterwards
            plan_path_col = plan_file_path if i == 0 else ''
            embed_path_col = embedding_file_path if i == 0 else ''
            
            row = [
                orig_idx,  # single idx referencing both plan and embedding
                true_labels[i],  # true label
                pred_labels[i],  # estimated label
                q_errors[i],  # q_error
                avg_knn_distance,  # average KNN distance
                plan_path_col,
                embed_path_col,
            ]
            
            writer.writerow(row)
    
    print(f"Verbose output saved to: {output_path}")


def get_verbose_output_path(output_dir_qerror):
    """
    Transform output_dir_qerror path to verbose output path.
    
    Args:
        output_dir_qerror: original output path (e.g., "results/results_Train_tpcds_Test_tpcds_ours/qerror_cdf.csv")
        
    Returns:
        verbose_output_path: transformed path (e.g., "verbose/results_Train_tpcds_Test_tpcds_ours/qerror_verbose.csv")
    """
    # Check if path contains _rm- to determine which verbose directory to use
    use_rm_dir = "_rm-" in output_dir_qerror
    
    # Replace "results" or "results_rm" with "verbose" or "verbose_rm" and remove "cdf"
    if use_rm_dir:
        verbose_path = output_dir_qerror.replace("results_rm", "verbose_rm").replace("_cdf", "")
        # Also handle case where it's just "results" but filename has _rm-
        if "verbose_rm" not in verbose_path:
            verbose_path = verbose_path.replace("results", "verbose_rm")
    else:
        verbose_path = output_dir_qerror.replace("results", "verbose").replace("_cdf", "")
    
    # If no "results" found, try to construct from the directory structure
    if verbose_path == output_dir_qerror:
        dir_path = os.path.dirname(output_dir_qerror)
        filename = os.path.basename(output_dir_qerror)
        
        # Determine verbose directory name
        if use_rm_dir:
            verbose_dir_name = "verbose_rm"
        else:
            verbose_dir_name = "verbose"
        
        # Replace the directory name if it contains "results"
        if "results" in dir_path:
            if use_rm_dir:
                verbose_dir = dir_path.replace("results_rm", verbose_dir_name).replace("results", verbose_dir_name)
            else:
                verbose_dir = dir_path.replace("results", verbose_dir_name)
        else:
            # Create verbose directory at the same level
            verbose_dir = os.path.join(os.path.dirname(dir_path), verbose_dir_name, os.path.basename(dir_path))
        
        # Transform filename
        verbose_filename = filename.replace("_cdf", "")
        verbose_path = os.path.join(verbose_dir, verbose_filename)
    
    return verbose_path


def get_embedding_file_path(algo, plan_file_path, workloads_train, workload_test, seed, removed_fields=None):
    """
    Generate embedding file path for non-LLM algorithms.
    
    Args:
        algo: Algorithm name (aimai, qf, e2e_cost, bao)
        plan_file_path: Path to the plan file (e.g., "../queryPlans/tpch/postgres/long_raw_postgres_tpch.csv")
        workloads_train: List of training workloads
        workload_test: Test workload name
        seed: Random seed
        removed_fields: Optional comma-separated string of removed field categories (to detect _rm-)
    
    Returns:
        Embedding file path (e.g., "embeddings/non-llm/aimai_Train_tpch_Test_tpch_seed42_tpch.csv")
    """
    # Extract the dataset name from plan file path
    plan_basename = os.path.basename(plan_file_path)
    # Extract dataset identifier (e.g., "tpch", "imdb_job", etc.)
    dataset_id = plan_basename.replace("long_raw_postgres_", "").replace(".csv", "")
    
    # Determine embeddings directory based on whether _rm- is detected
    embeddings_base_dir = "embeddings"
    if removed_fields:
        # Check if removed_fields indicates field removal (non-empty means _rm- will be in filename)
        embeddings_base_dir = "embeddings_rm"
    
    # Build embedding file path
    train_str = '-'.join(workloads_train) if workloads_train else 'unknown'
    test_str = workload_test if workload_test else 'unknown'
    
    embedding_filename = f"{algo}_Train_{train_str}_Test_{test_str}_seed{seed}_{dataset_id}.csv"
    embedding_path = os.path.join(embeddings_base_dir, "non-llm", embedding_filename)
    
    return embedding_path


def save_non_llm_embeddings(embeddings, embedding_file_path):
    """
    Save non-LLM embeddings to CSV file.
    
    Args:
        embeddings: numpy array of embeddings [N, D]
        embedding_file_path: path to save embeddings
    """
    os.makedirs(os.path.dirname(embedding_file_path), exist_ok=True)
    df = pd.DataFrame(embeddings)
    df.to_csv(embedding_file_path, index=False)
    print(f"Saved {len(embeddings)} embeddings to: {embedding_file_path}")


def load_non_llm_embeddings(embedding_file_path):
    """
    Load non-LLM embeddings from CSV file.
    
    Args:
        embedding_file_path: path to load embeddings from
    
    Returns:
        numpy array of embeddings [N, D]
    """
    if os.path.exists(embedding_file_path):
        df = pd.read_csv(embedding_file_path)
        return df.values
    return None


def generate_and_save_embeddings_for_dataset(model, dataset, embedding_file_path, device, algo):
    """
    Generate embeddings for an entire dataset and save to file.
    For non-LLM algorithms with Sequential models, this extracts embeddings from model[0].
    
    Args:
        model: The trained model (Sequential for aimai/qf/e2e_cost)
        dataset: PyTorch Dataset containing all data
        embedding_file_path: Path to save embeddings
        device: torch device
        algo: Algorithm name
    
    Returns:
        numpy array of embeddings [N, D]
    """
    if os.path.exists(embedding_file_path):
        print(f"  Existing embeddings found at {embedding_file_path} - regenerating and overwriting.")
    
    print(f"  Generating embeddings for {len(dataset)} samples...")
    
    # Create a DataLoader with appropriate collate function
    if algo == 'e2e_cost':
        from algorithms.e2e_cost.e2e_dataset import collator as e2e_collator
        full_loader = DataLoader(dataset, batch_size=1, shuffle=False, collate_fn=e2e_collator)
    elif algo == 'qf':
        from algorithms.queryformer.dataset_utils import collator as qf_collator
        full_loader = DataLoader(dataset, batch_size=1, shuffle=False, collate_fn=qf_collator)
    else:
        full_loader = DataLoader(dataset, batch_size=1, shuffle=False)
    
    model.to(device)
    model.eval()
    
    embeddings_list = []
    
    # Check if model is Sequential
    is_sequential = isinstance(model, nn.Sequential)
    
    with torch.no_grad():
        for x, y in full_loader:
            # Handle different input types based on algorithm
            if algo in ['e2e_cost', 'qf']:
                # For e2e_cost and qf: x is a Batch object with .to() method
                x = x.to(device)
            elif isinstance(x, torch.Tensor):
                x = x.to(device)
            else:
                # Fallback: try to convert to tensor
                x = x.to(device) if hasattr(x, 'to') else torch.tensor(x, device=device)
            
            # Extract embedding
            if is_sequential:
                # For Sequential models: get output from first module (before MLP)
                embedding = model[0](x)
            else:
                # For non-Sequential models: use the input as embedding
                embedding = x
            
            embeddings_list.append(embedding.cpu().numpy())
    
    # Concatenate all embeddings
    embeddings = np.concatenate(embeddings_list, axis=0)
    
    # Save to file
    save_non_llm_embeddings(embeddings, embedding_file_path)
    
    return embeddings