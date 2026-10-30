import pandas as pd
import numpy as np

class Normalizer(): # in log scale
    def __init__(self, mini=None,maxi=None):
        # mini = -6.214608098422191
        # maxi = 10.66750438898755 (tpch 10g)
        self.mini = mini
        self.maxi = maxi
        
        
    def normalize_labels(self, labels, reset_min_max = False):
        # print(f"self.mini = {self.mini}")
        # print(f"self.maxi = {self.maxi}")

        ## added 0.001 for numerical stability
        labels = np.array([np.log(float(l) + 0.001) for l in labels])
        if self.mini is None or reset_min_max:
            self.mini = labels.min()
            print("min log(label): {}".format(self.mini))
        if self.maxi is None or reset_min_max:
            self.maxi = labels.max()
            print("max log(label): {}".format(self.maxi))
        labels_norm = (labels - self.mini) / (self.maxi - self.mini)
        # Threshold labels <-- but why...
        labels_norm = np.minimum(labels_norm, 1)
        labels_norm = np.maximum(labels_norm, 0.001)

        return labels_norm

    def normalize_label(self,label):
        label_norm = ((np.log(float(label)+0.001)) - self.mini) / (self.maxi - self.mini)
        label_norm = np.minimum(label_norm, 1)
        label_norm = np.maximum(label_norm, 0.001)        
        print(f"Label before normalization: {label}; after normalization: {label_norm}")
        return label_norm
    
    def unnormalize_labels(self, labels_norm):
        labels_norm = np.array(labels_norm, dtype=np.float32)
        labels = (labels_norm * (self.maxi - self.mini)) + self.mini
#       return np.array(np.round(np.exp(labels) - 0.001), dtype=np.int64)
        return np.array(np.exp(labels) - 0.001)

class Bucketizer():
    def __init__(self, min_val=None, max_val=None, num_buckets=100):
        self.min_val = min_val
        self.max_val = max_val
        self.num_buckets = num_buckets
        self.bucket_size = (self.max_val - self.min_val) / num_buckets

    def bucketize_labels(self, labels):
        arr = np.array(labels, dtype=np.float32)
        if self.min_val is None:
            self.min_val = min(labels)
        if self.max_val is None:
            self.max_val = max(labels)
        
        bucket_size = (self.max_val - self.min_val) / self.num_buckets
        indices = np.floor((arr - self.min_val) / bucket_size).astype(int)
        indices = np.clip(indices, 0, self.num_buckets - 1)
        return indices

    def bucketize_label(self, label):
        if self.min_val is None:
            self.min_val = label
        if self.max_val is None:
            self.max_val = label
        bucket_size = (self.max_val - self.min_val) / self.num_buckets
        index = int(np.floor((label - self.min_val) / bucket_size))
        index = np.clip(index, 0, self.num_buckets - 1)
        return index


