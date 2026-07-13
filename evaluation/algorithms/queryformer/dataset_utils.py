import torch
import logging
import time
from torch.utils.data import Dataset
import json
import pandas as pd
import numpy as np
import torch.nn as nn
import torch.nn.functional as F
from collections import deque

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

class Encoding:
    def __init__(self, ds_info):
        self.column_min_max_vals = ds_info.column_min_max_vals
        self.col2idx = {'NA':0}
        self.op2idx = {'>':0, '=':1, '<':2}
        self.type2idx = {'NA':0}
        self.join2idx = {'NA':0}
        self.table2idx = {'NA':0}
    
    def is_number(s):
        try:
            float(s)
            return True
        except ValueError:
            return False
        
    def normalize_val(self, column, val):
        if column not in self.column_min_max_vals or (not is_number(val)):
            # print('column {} not in col_min_max'.format(column))
            return 0.
        mini, maxi = self.column_min_max_vals[column]
        val_norm = 0.
        val = float(val)
        if maxi > mini:
            val_norm = (val-mini) / (maxi-mini)
        # print(f"In normalize_val(). val: {val}, val_norm: {val_norm}")
        return val_norm
    
    def encode_join(self, join):
        if join not in self.join2idx:
            self.join2idx[join] = len(self.join2idx)
        return self.join2idx[join]
    
    def encode_table(self, table):
        if table not in self.table2idx:
            self.table2idx[table] = len(self.table2idx)
        return self.table2idx[table]

    def encode_type(self, nodeType):
        if nodeType not in self.type2idx:
            self.type2idx[nodeType] = len(self.type2idx)
        return self.type2idx[nodeType]
    
    def encode_op(self, op):
        if op not in self.op2idx:
            self.op2idx[op] = len(self.op2idx)
        return self.op2idx[op]
    
    def encode_col(self, col):
        if col not in self.col2idx:
            self.col2idx[col] = len(self.col2idx)
        return self.col2idx[col]

# def node2feature(node, encoding, max_filters = 10):
#     num_filter = len(node.filters)
#     n = max(num_filter, 1)
#     pad = np.zeros((3, max_filters-n)) # leave at least 1 for convenience
#     if num_filter > 0:
#         filts = np.array(
#             [[encoding.encode_col(col), 
#               encoding.encode_op(op), 
#               encoding.normalize_val(col, val)] for col,op,val in node.filters]
#         ).T
#     else:
#         filts = np.array([[0.,0.,0.]]).T
#     ## max_filters x3, get back with reshape(3, max_filters)
#     filts = np.concatenate((filts, pad), axis=1)
#     filts = filts.flatten() 
#     mask = np.zeros(max_filters)
#     mask[:n] = 1
#     type_join = np.array([encoding.encode_type(node.nodeType), encoding.encode_join(node.join)])
#     table = np.array([encoding.encode_table(node.table)])
#     return np.concatenate((type_join, filts, mask, table))        

# max_filters = 3
def node2feature(node, encoding, max_filters = 23, hist_file = None, table_sample = None):
    
    #print(f"node.query_id = {node.query_id}, node.table = {node.table}")
    num_filter = len(node.filters)
    #print(f"num_filter:{num_filter}")
    #print(f"max_filters:{max_filters}")

    #n = max(num_filter, 1)
    #pad = np.zeros((3, max_filters-n)) # leave at least 1 for convenience
    node.filters = node.filters[:max_filters]
    #print(f"node.filters = {node.filters}")
    # with open('output_log.txt', 'a') as file:  # Open the file in append mode
    #     file.write(f"node.query_id = {node.query_id}, node.table = {node.table}\n")
    #     file.write(f"node.filters = {node.filters}\n")
    #     if node.table in table_sample[node.query_id]:
    #         sample = table_sample[node.query_id][node.table]
    #         file.write(f"sample = {sample}\n")
    #print(f"Len(node.filters) = {len(node.filters)}")
    n = max(len(node.filters), 1)
    pad_size = max(max_filters - n, 0)
    pad = np.zeros((3, pad_size))

    if num_filter > 0:
        filts = np.array(
            [[encoding.encode_col(col), 
              encoding.encode_op(op), 
              encoding.normalize_val(col, val)] for col,op,val in node.filters]
        ).T
    else:
        filts = np.array([[0.,0.,0.]]).T
    ## max_filters x3, get back with reshape(3, max_filters)
    # print(f"filts: {filts}")
    filts = np.concatenate((filts, pad), axis=1)
    filts = filts.flatten() 
    #print(f"filts.shape:{filts.shape}")

    mask = np.zeros(max_filters)
    mask[:n] = 1
    #print(f"mask.shape:{mask.shape}")


    type_join = np.array([encoding.encode_type(node.nodeType), encoding.encode_join(node.join)])
    #print(f"type_join.shape:{type_join.shape}")

    table = np.array([encoding.encode_table(node.table)])
    #print(f"table.shape:{table.shape}")

    ## add db stats
    cur_rep = np.concatenate((type_join, filts, mask, table)) 
    #print(f"Basic features cur_rep.shape: {cur_rep.shape}")

    if hist_file is not None:
        hists = filters2Hist(hist_file, node.filters, encoding, max_filters)
        #print(f"hists.shape: {hists.shape}")
        cur_rep = np.concatenate((cur_rep,hists))
    if table_sample is not None:
        if table_sample is not None and node.query_id < len(table_sample):
            sample = table_sample[node.query_id].get(node.table, np.zeros(1000))
        else:
            sample = np.zeros(1000)

        # if node.table in table_sample[node.query_id]:
        #     sample = table_sample[node.query_id][node.table]
        #     #print(f"sample = {sample}")
        #     #file.write(f"sample = {sample}\n")
        # else:
        #     sample = np.zeros(1000)

        cur_rep = np.concatenate((cur_rep,sample))
    # print(f"cur_rep.shape: {cur_rep.shape}") #2245
    # print(f"cur_rep: {cur_rep}") # all >= 0 integers
    return cur_rep

def filters2Hist(hist_file, filters, encoding, max_filters):
    buckets = len(hist_file['bins'][0]) 
    empty = np.zeros(buckets - 1)
    ress = np.zeros((max_filters, buckets-1))
    table_cols = set(hist_file['table_column'])
    for i,(col,op,val) in enumerate(filters):
        if not is_number(val): continue
        val = float(val)
        if (col == 'NA') or (col not in table_cols):
            ress[i] = empty
            continue
        bins = hist_file.loc[hist_file['table_column']==col,'bins'].item()
        
        left = 0
        right = len(bins)-1
        for j in range(len(bins)):
            if bins[j]<val:
                left = j
            if bins[j]>val:
                right = j
                break

        res = np.zeros(len(bins)-1)

        if op == '=':
            res[left:right] = 1
        elif op == '<':
            res[:left] = 1
        elif op == '>':
            res[right:] = 1
        ress[i] = res
    
    ress = ress.flatten()
    return ress   

def get_job_table_sample(workload_file_name):

    print(f"table_sample: {workload_file_name}_samples.npy")
    with open(workload_file_name + "_samples.npy",'rb') as f:
        table_sample = np.load(f,allow_pickle=True)
    
    #print(f"table_sample: {table_sample}")
    return table_sample


def get_hist_file(hist_path, bin_number = 50):
    hist_file = pd.read_csv(hist_path)
    # for i in range(len(hist_file)):
    #     freq = hist_file['freq'][i]
    #     freq_np = np.frombuffer(bytes.fromhex(freq), dtype=np.float)
    #     hist_file['freq'][i] = freq_np

    # table_column = []
    # for i in range(len(hist_file)):
    #     table = hist_file['table'][i]
    #     col = hist_file['column'][i]
    #     table_alias = ''.join([tok[0] for tok in table.split('_')])
    #     if table == 'movie_info_idx': table_alias = 'mi_idx'
    #     combine = '.'.join([table_alias,col])
    #     table_column.append(combine)
    # hist_file['table_column'] = table_column

    parsed_bins = [
        [float(i) for i in hist_file['bins'][rid][1:-1].split(' ') if len(i) > 0]
        for rid in range(len(hist_file))
    ]
    hist_file['bins'] = pd.Series(parsed_bins, dtype=object)

    # for rid in range(len(hist_file)):
    #     hist_file.loc[rid, 'bins'] = [float(i) for i in hist_file.loc[rid, 'bins'][1:-1].split(' ') if len(i) > 0]

    if bin_number != 50:
        raise "only 50 stored to save storage"
        # hist_file = re_bin(hist_file, bin_number)
    #print(f"hist_file: {hist_file}")
    return hist_file


def re_bin(hist_file, target_number):
    for i in range(len(hist_file)):
        freq = hist_file['freq'][i]
        bins = freq2bin(freq,target_number)
        hist_file['bins'][i] = bins
    return hist_file

def freq2bin(freqs, target_number):
    freq = freqs.copy()
    maxi = len(freq)-1
    
    step = 1. / target_number
    mini = 0
    while freq[mini+1]==0:
        mini+=1
    pointer = mini+1
    cur_sum = 0
    res_pos = [mini]
    residue = 0
    while pointer < maxi+1:
        cur_sum += freq[pointer]
        freq[pointer] = 0
        if cur_sum >= step:
            cur_sum -= step
            res_pos.append(pointer)
        else:
            pointer += 1
    
    if len(res_pos)==target_number: res_pos.append(maxi)
    
    return res_pos



class QueryFormerDataset(Dataset):
    #max_filters=3,10,or 23
    def __init__(self, nodes, labels, encoding, ds_info, additional_feature = None, max_filters=23, \
            max_node=26, rel_pos_max=10, hist_file=None, table_sample=None, query_ids=None, args=None):

        self.encoding = encoding
        self.hist_file = hist_file
        self.table_sample = table_sample
        self.max_filters = max_filters
        self.max_node = max_node 
        self.rel_pos_max = rel_pos_max
        self.args = args
        self.length = len(nodes)
        self.additional_feature = additional_feature  # For top model

        if query_ids is None:
            for i in range(len(nodes)):
                nodes[i].query_id = i
                # nodes[i]['query_id'] = i        
        else:
            for i in range(len(nodes)):
                nodes[i].query_id = query_ids[i]
                # nodes[i]['query_id'] = query_ids[i]

        self.nodes = nodes
        # print(f"self.nodes = {self.nodes[:1]}")
        self.ds_info = ds_info
        self.costs = labels
        if not self.args.card:
            self.cost_labels = torch.FloatTensor(np.array(ds_info.cost_norm.normalize_labels(labels))).reshape(-1,1)
        else:
            self.cost_labels = torch.FloatTensor(np.array(ds_info.card_norm.normalize_labels(labels))).reshape(-1,1)

        #original
        # self.collated_dicts = [self.pre_collate(self.node2dict(node)) for node in nodes]
        
        #self.collated_dicts = [self.js_node2dict(i,node) for i,node in zip(idxs, nodes)]

    def __len__(self):
        return self.length
    
    def __getitem__(self, idx):
        node = self.nodes[idx]
        # 1. turn TreeNode → raw dict
        t0 = time.perf_counter()
        raw = self.node2dict(node)
        t1 = time.perf_counter()
        # 2. collate into the little graph‐batch
        sample = self.pre_collate(raw)
        t2 = time.perf_counter()
        # 3. grab the label
        label = self.cost_labels[idx]
        t3 = time.perf_counter()

        # log step timings if main_logger is configured
        # TEMPORARILY DISABLED
        # try:
        #     main_logger = logging.getLogger("main_logger")
        #     if main_logger and main_logger.handlers:
        #         main_logger.info(f"[DataLoad] __getitem__ node2dict — {(t1-t0)*1000:.2f} ms")
        #         main_logger.info(f"[DataLoad] __getitem__ pre_collate — {(t2-t1)*1000:.2f} ms")
        #         main_logger.info(f"[DataLoad] __getitem__ fetch_label — {(t3-t2)*1000:.2f} ms")
        # except Exception:
        #     pass

        # # return self.collated_dicts[idx], self.cost_labels[idx]
        # sample = self.collated_dicts[idx]
        # label = self.cost_labels[idx]

        if self.additional_feature is not None:
            # Ensure additional feature is padded and matches expected shape
            additional_feature = torch.FloatTensor([self.additional_feature[idx]])
            sample['additional_feature'] = additional_feature

        return sample, label
      
    ## pre-process first half of old collator
    def pre_collate(self, the_dict):

        x = pad_2d_unsqueeze(the_dict['features'], self.max_node)
        # print("first_x",x.size())
        N = len(the_dict['features'])
        attn_bias = torch.zeros([N+1,N+1], dtype=torch.float)
        
        edge_index = the_dict['adjacency_list'].t()
        if len(edge_index) == 0:
            shortest_path_result = np.array([[0]])
            path = np.array([[0]])
            adj = torch.tensor([[0]]).bool()
        else:
            adj = torch.zeros([N,N], dtype=torch.bool)
            adj[edge_index[0,:], edge_index[1,:]] = True
            shortest_path_result = floyd_warshall_rewrite(adj.numpy())
        

        rel_pos = torch.from_numpy((shortest_path_result)).long()

        # Modifies the attention bias matrix to set -inf for pairs of nodes where 
        # the relative position exceeds a maximum allowable distance (self.rel_pos_max), effectively excluding them from attending to each other
        attn_bias[1:, 1:][rel_pos >= self.rel_pos_max] = float('-inf')
        
        attn_bias = pad_attn_bias_unsqueeze(attn_bias, self.max_node + 1)
        rel_pos = pad_rel_pos_unsqueeze(rel_pos, self.max_node)

        heights = pad_1d_unsqueeze(the_dict['heights'], self.max_node)
        # print('In pre-collate:')
        # print(f"shape of dict['features']:{the_dict['features'].shape}")
        # print(f"shape of feature tensor x:{x.shape}")

        # print(f"shape of adjacency list: {the_dict['adjacency_list'].shape}")

        # print(f"shape of attn_bias:{attn_bias.shape}")
        # print(f"shape of rel_pos: {rel_pos.shape}")
        # print(f"shape of heights: {heights.shape}")
        return {
            'x' : x,
            'attn_bias': attn_bias,
            'rel_pos': rel_pos,
            'heights': heights
        }

    # def js_node2dict(self, idx, node):
    #     treeNode = self.traversePlan(node, idx, self.encoding)
    #     _dict = self.node2dict(treeNode)
    #     collated_dict = self.pre_collate(_dict)
        
    #     self.treeNodes.clear()
    #     del self.treeNodes[:]

    #     return collated_dict

    def node2dict(self, node):
        # print(f"self.cost:{self.costs}")
        # print(f"self.cost_labels:{self.cost_labels}")
        adj_list, num_child, features = self.topo_sort(node)
        # print("Features type:", type(features[0]))
        # print("Sample feature data:", features[0])

        heights = self.calculate_height(adj_list, len(features))
        # print("Features shape:", np.array(features).shape)
        # print("heights shape:", np.array(heights).shape)
        # print("adj_list shape:", np.array(adj_list).shape)
        # print(f"features tensor {torch.FloatTensor(np.array(features))}")
        return {
            'features' : torch.FloatTensor(np.array(features)),
            'heights' : torch.LongTensor(np.array(heights)),
            'adjacency_list' : torch.LongTensor(np.array(adj_list)),          
        }
    
    def topo_sort(self, root_node):
        #print(f"In topo_sort")
        adj_list = [] #from parent to children
        num_child = []
        features = []
        toVisit = deque()
        toVisit.append((0,root_node))
        next_id = 1
        while toVisit:
            idx, node = toVisit.popleft()
            feature = node2feature(node, self.encoding, self.max_filters, \
                self.hist_file, self.table_sample)
            # print(f"curr feature = {feature}")
            features.append(feature)
            

            num_child.append(len(node.children))
            for child in node.children:
                child.query_id = node.query_id

                toVisit.append((next_id,child))
                adj_list.append((idx,next_id))
                next_id += 1

        # print(f"At end of topo_sort, len(features) {len(features)}")
        #print(f"num_child {num_child}")
        return adj_list, num_child, features

    def calculate_height(self, adj_list, tree_size):
        if tree_size == 1:
            return np.array([0])

        adj_list = np.array(adj_list)
        node_ids = np.arange(tree_size, dtype=int)
        node_order = np.zeros(tree_size, dtype=int)
        uneval_nodes = np.ones(tree_size, dtype=bool)
        parent_nodes = adj_list[:,0]
        child_nodes = adj_list[:,1]

        n = 0
        while uneval_nodes.any():
            uneval_mask = uneval_nodes[child_nodes]
            unready_parents = parent_nodes[uneval_mask]

            node2eval = uneval_nodes & ~np.isin(node_ids, unready_parents)
            node_order[node2eval] = n
            uneval_nodes[node2eval] = False
            n += 1
        return node_order 


def floyd_warshall_rewrite(adjacency_matrix):
    (nrows, ncols) = adjacency_matrix.shape
    assert nrows == ncols
    M = adjacency_matrix.copy().astype('long')
    for i in range(nrows):
        for j in range(ncols):
            if i == j: 
                M[i][j] = 0
            elif M[i][j] == 0: 
                # M[i][j] = 510
                M[i][j] = 60
    
    for k in range(nrows):
        for i in range(nrows):
            for j in range(nrows):
                M[i][j] = min(M[i][j], M[i][k]+M[k][j])
    return M


def pad_1d_unsqueeze(x, padlen):
    x = x + 1 # pad id = 0
    xlen = x.size(0)
    if xlen < padlen:
        new_x = x.new_zeros([padlen], dtype=x.dtype)
        new_x[:xlen] = x
        x = new_x
    return x.unsqueeze(0)


def pad_2d_unsqueeze(x, padlen):
    # dont know why add 1, comment out first
    x = x + 1 # pad id = 0
    xlen, xdim = x.size()
    if xlen < padlen:
        new_x = x.new_zeros([padlen, xdim], dtype=x.dtype) + 1
        new_x[:xlen, :] = x
        x = new_x
    return x.unsqueeze(0)

def pad_rel_pos_unsqueeze(x, padlen):
    x = x + 1
    xlen = x.size(0)
    if xlen < padlen:
        new_x = x.new_zeros([padlen, padlen], dtype=x.dtype)
        new_x[:xlen, :xlen] = x
        x = new_x
    return x.unsqueeze(0)

def pad_attn_bias_unsqueeze(x, padlen):
    xlen = x.size(0)
    if xlen < padlen:
        new_x = x.new_zeros([padlen, padlen], dtype=x.dtype).fill_(float('-inf'))
        new_x[:xlen, :xlen] = x
        new_x[xlen:, :xlen] = 0
        x = new_x
    return x.unsqueeze(0)


class Batch():
    def __init__(self, attn_bias, rel_pos, heights, x, y, additional_feature=None):
        super(Batch, self).__init__()
        self.heights = heights
        self.x, self.y = x, y
        self.attn_bias = attn_bias
        self.rel_pos = rel_pos
        self.additional_feature = additional_feature  # Store additional feature

        
    def to(self, device):
        self.heights = self.heights.to(device)
        self.x = self.x.to(device)
        self.y = self.y.to(device)
        self.attn_bias, self.rel_pos = self.attn_bias.to(device), self.rel_pos.to(device)
        if self.additional_feature is not None:
            self.additional_feature = self.additional_feature.to(device)

        return self

    def __len__(self):
        return self.y.size(0)
    
    # added for printability
    def __repr__(self):
        return (f"Batch(x={self.x}, attn_bias={self.attn_bias}, "
                f"rel_pos={self.rel_pos}, heights={self.heights}, "
                f"additional_feature={self.additional_feature})")


def pad_to_target(tensor, target_size=20):
    current_size = tensor.size(1)
    if current_size > target_size:
        # Truncate if the current size is greater than the target size
        tensor = tensor[:, :target_size, :]
    elif current_size < target_size:
        # Pad if the current size is less than the target size
        padding_size = target_size - current_size
        padding = torch.zeros((tensor.size(0), padding_size, tensor.size(2)), dtype=tensor.dtype, device=tensor.device)
        tensor = torch.cat([tensor, padding], dim=1)

    return tensor


def pad_to_max_size(tensor, max_height, max_width):

    current_height, current_width = tensor.size(1), tensor.size(2)  # Ensure it's 2D if it's not, adjust accordingly
    pad_height = max_height - current_height if current_height < max_height else 0
    pad_width = max_width - current_width if current_width < max_width else 0

     # Apply padding to height if necessary
    if pad_height > 0:
        # tensor has 3 dim: batch size, height, width
        height_padding = torch.zeros((tensor.size(0), pad_height, current_width), dtype=tensor.dtype, device=tensor.device)
        tensor = torch.cat([tensor, height_padding], dim=1)

    # Apply padding to width if necessary
    if pad_width > 0:
        width_padding = torch.zeros((tensor.size(0), max_height, pad_width), dtype=tensor.dtype, device=tensor.device)
        tensor = torch.cat([tensor, width_padding], dim=2)

    return tensor

def pad_to_max_height(tensor, max_height):
    current_height = tensor.size(1)
    if current_height < max_height:
        padding_size = max_height - current_height
        padding = torch.zeros((tensor.size(0), padding_size), dtype=tensor.dtype, device=tensor.device)
        tensor = torch.cat([tensor, padding], dim=1)
    return tensor


from torch.nn.utils.rnn import pad_sequence
# original collator
def collator(small_set):
    _t0 = time.perf_counter()
    y = [s[1] for s in small_set]
    xs = [s[0]['x'] for s in small_set]

    # Find the maximum size along the second dimension (number of nodes)
    max_len = max([x.size(1) for x in xs])
    # print("max_len", max_len)
    padded_xs = [torch.cat([x, torch.zeros(x.size(0), max_len - x.size(1), x.size(2))], dim=1) if x.size(1) < max_len else x for x in xs]
    x = torch.cat(padded_xs)
    y = torch.cat(y).view(-1,1)
    # print("len", x.size())
    attn_biases = [s[0]['attn_bias'] for s in small_set]
    max_attn_bias_len = max([ab.size(1) for ab in attn_biases])
    padded_attn_biases = [
        F.pad(ab, (0, max_attn_bias_len - ab.size(2), 0, max_attn_bias_len - ab.size(1)), value=-100.0)
        if ab.size(1) < max_attn_bias_len or ab.size(2) < max_attn_bias_len else ab
        for ab in attn_biases
    ]
    attn_bias = torch.cat(padded_attn_biases)

    rel_positions = [s[0]['rel_pos'] for s in small_set]
    max_rel_pos_len = max([rp.size(1) for rp in rel_positions])
    padded_rel_positions = [
        F.pad(rp, (0, max_rel_pos_len - rp.size(2), 0, max_rel_pos_len - rp.size(1)), value=0)
        if rp.size(1) < max_rel_pos_len or rp.size(2) < max_rel_pos_len else rp
        for rp in rel_positions
    ]
    rel_pos = torch.cat(padded_rel_positions)

    heights_list = [s[0]['heights'] for s in small_set]
    max_heights_len = max([h.size(1) for h in heights_list])
    padded_heights = [
        F.pad(h, (0, max_heights_len - h.size(1)), value=0)
        if h.size(1) < max_heights_len else h
        for h in heights_list
    ] 
    heights = torch.cat(padded_heights)

    if 'additional_feature' in small_set[0][0]:
        additional_features = [s[0]['additional_feature'] for s in small_set]
        # additional_feature = torch.cat(additional_features)
        additional_feature = torch.cat(additional_features).view(-1, additional_features[0].size(-1))
 
        # print(f"Additional Feature Shape: {additional_feature.shape}")  # Print shape for verification
    else:
        additional_feature = None
        # print("No additional feature found in batch.")

    # print(f"Final dimensions of attn_bias: {attn_bias.shape}")
    # print(f"Final dimensions of rel_pos: {rel_pos.shape}")
    # print(f"Final dimensions of heights: {heights.shape}")
    
    _t1 = time.perf_counter()
    # TEMPORARILY DISABLED
    # try:
    #     main_logger = logging.getLogger("main_logger")
    #     if main_logger and main_logger.handlers:
    #         main_logger.info(f"[DataLoad] collator total — {(_t1-_t0)*1000:.2f} ms")
    # except Exception:
    #     pass

    return Batch(attn_bias, rel_pos, heights, x, y, additional_feature), y
