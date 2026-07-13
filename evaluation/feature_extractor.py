import pandas as pd
import numpy as np
from utils import Normalizer, Bucketizer
from pyparsing import nestedExpr
from datetime import datetime
import time
import json

class TreeNode:

    def __init__(self, dictionary):
        self.level = 0 # root

        self.cost = None
        self.card = None

        self.cost_est = None
        self.card_est = None

        self.table = None
        self.alias = None
        self.index = None

        self.filters = None
        self.join = None

        self.nodeType = None
        self.nodeParallel = None ## for AIMeetsAI
        self.width = None

        self.children = []
        self.parent = None

        # added for bao
        self.buffers = None   
        
        # for plan cost
        self.hash = None
        self.parent_rel = None
        self.join_type = None
        self.sort_key = None
        self.sort_method = None
        self.strategy = None
        self.para_aware = None
        self.command = None
        self.subplan_name = None

        self.__dict__.update(dictionary)

    def update(self,dictionary):
        self.__dict__.update(dictionary)
        
    def __str__(self):
#        return TreeNode.print_nested(self)
        return '{} with {}, {}, {} children'.format(self.nodeType, self.filters, self.join, len(self.children))

    def __repr__(self):
        return self.__str__()

    def print_nested(self): 
        print('--'*self.level+ self.__str__())
        for k in self.children: 
            k.print_nested()


class DatasetInfo:
    
    def __init__(self, dictionary):
        self.max_card = -1
        self.min_card = 99999999
        self.max_cost = -1
        self.min_cost = 99999999
        self.max_cost_est = None
        self.min_cost_est = 0.01
        
        
        self.card_norm = None
        self.cost_norm = None
        self.cost_est_norm = None
        # for plan cost
        self.width_norm = None
        
        self.nodeTypes = []
        self.nodeParallels = []
        
        self.tables = []
        self.aliass = []
        self.indexes = []
        self.joins = []
        
        self.alias2table = {}
        self.table2alias = {}

        self.max_filters = 0
        
        self.column_min_max_vals = {}
        self.columns = []
        
        self.__dict__.update(dictionary)
    
    def update(self, dictionary):
        self.__dict__.update(dictionary)
    
    def get_columns(self, column_min_max_vals):
        self.column_min_max_vals = column_min_max_vals
        self.columns = list(column_min_max_vals.keys())
        # print(f"self.column_min_max_vals: {self.column_min_max_vals}")
        # print(f"self.columns: {self.columns}")
    
    def construct_from_plans(self, plans):
        # for plan cost
        max_card = max_cost = max_cost_est = max_width = 0
        min_card = min_cost = min_cost_est = min_width = 100
        max_filters = 0
  
        # initilize for input data that needs bucketize
        max_startup_cost = max_total_cost = max_plan_rows = max_plan_width = -np.inf
        min_startup_cost = min_total_cost = min_plan_rows = min_plan_width = np.inf

        for root in plans:

            toVisit = [root] #bfs
            while toVisit: 
                node = toVisit.pop(0)
                for child in node.children:
                    toVisit.append(child)

                if node.filters is not None:
                    max_filters = max(max_filters, len(node.filters))

                if node.card is None:
                    print(f"node:{node} does not have actual cardinality")
                    exit(1)
                node.card = float(node.card)
                node.card_est = float(node.card_est)    # plan_rows
                node.cost = float(node.cost)
                node.cost_est = float(node.cost_est)    # total cost

                # added for bucketizer initialization
                node.startup_cost = float(node.startup_cost)
                node.total_cost = float(node.cost_est)
                node.plan_rows = float(node.card_est)
                node.plan_width = float(node.width)


                max_card = max(max_card, node.card, node.card_est)

                # print(f"node.cost type: {type(node.cost)}, value: {node.cost}")
                # print(f"node.cost_est type: {type(node.cost_est)}, value: {node.cost_est}")

                max_cost = max(max_cost, node.cost)
                max_cost_est = max(max_cost_est, node.cost_est)

                max_startup_cost = max(max_startup_cost, node.startup_cost)
                max_total_cost = max(max_total_cost, node.total_cost)
                max_plan_rows = max(max_plan_rows, node.plan_rows)
                max_plan_width = max(max_plan_width, node.plan_width)

                min_card = min(min_card, node.card, node.card_est)
                min_cost = min(min_cost, node.cost)
                min_cost_est = min(min_cost_est, node.cost_est)

                min_startup_cost = min(min_startup_cost, node.startup_cost)
                min_total_cost = min(min_total_cost, node.total_cost)
                min_plan_rows = min(min_plan_rows, node.plan_rows)
                min_plan_width = min(min_plan_width, node.plan_width)

                if node.nodeType not in self.nodeTypes:
                    self.nodeTypes.append(node.nodeType)
                if node.nodeParallel not in self.nodeParallels:
                    self.nodeParallels.append(node.nodeParallel)
                
                
                if node.index is not None and node.index not in self.indexes:
                    self.indexes.append(node.index)
                if node.join is not None and node.join not in self.joins:
                    self.joins.append(node.join)
                if node.table is not None and node.table not in self.tables:
                    self.tables.append(node.table)
                if node.alias is not None and node.alias not in self.aliass: # may have problem for subquery
                    self.aliass.append(node.alias)
                    self.alias2table[node.alias] = node.table
                    self.table2alias[node.table] = node.alias

        # print(f"self.tables: {self.tables}")     
        # print(f"self.aliass: {self.aliass}")
        # print(f"self.indexes: {self.indexes}")
        # print(f"self.joins: {self.joins}")

        # print(f"self.alias2table: {self.alias2table}")
        # print(f"self.table2alias: {self.table2alias}")
        
        self.max_card, self.max_cost, self.max_cost_est = max_card, max_cost, max_cost_est
        self.min_card, self.min_cost, self.min_cost_est = min_card, min_cost, min_cost_est

        print(f"self.max_card:{self.max_card}, self.min_card: {self.min_card}")
        print(f"self.max_cost:{self.max_cost}, self.min_cost: {self.min_cost}")
        print(f"self.max_cost_est:{self.max_cost_est}, self.min_cost_est: {self.min_cost_est}")

        print("Bucketizer initialization:")
        print(f"self.max_startup_cost:{max_startup_cost}, self.min_startup_cost: {min_startup_cost}")
        print(f"self.max_total_cost:{max_total_cost}, self.min_total_cost: {min_total_cost}")
        print(f"self.max_plan_rows:{max_plan_rows}, self.min_plan_rows: {min_plan_rows}")
        print(f"self.max_plan_width:{max_plan_width}, self.min_plan_width: {min_plan_width}")
        print("Bucketizer initialization done.\n")
        
        self.card_norm = Normalizer(np.log(float(min_card) + 0.001), np.log(float(max_card) + 0.001))
        self.cost_norm = Normalizer(np.log(float(min_cost) + 0.001), np.log(float(max_cost) + 0.001))

        # james: 定义Bucketizer class并且initialize it, 之后有需要再用到
        # FINISHED

        self.startup_cost_bucketizer = Bucketizer(min_startup_cost, max_startup_cost, num_buckets=100)
        self.total_cost_bucketizer = Bucketizer(min_total_cost, max_total_cost, num_buckets=100)
        self.plan_rows_bucketizer = Bucketizer(min_plan_rows, max_plan_rows, num_buckets=100)
        self.plan_width_bucketizer = Bucketizer(min_plan_width, max_plan_width, num_buckets=100)

        
        min_cost_est = max(min_cost_est, 0.001)  # Avoid log(0)
        max_cost_est = max(max_cost_est, 0.001)  # Avoid log(0)

        self.cost_est_norm = Normalizer(np.log(float(min_cost_est) + 0.001), np.log(float(max_cost_est) + 0.001))
        print(f"self.card_norm.maxi:{self.card_norm.maxi}, self.card_norm.mini: {self.card_norm.mini}")
        print(f"self.cost_norm.maxi:{self.cost_norm.maxi}, self.cost_norm.mini: {self.cost_norm.mini}")
        print(f"self.cost_est_norm.maxi:{self.cost_est_norm.maxi}, self.cost_est_norm.mini: {self.cost_est_norm.mini}")

        print("\nBucketizer info:\n")
        print(f"self.startup_cost_bucketizer.min_val: {self.startup_cost_bucketizer.min_val}, self.startup_cost_bucketizer.max_val: {self.startup_cost_bucketizer.max_val}")
        print(f"self.total_cost_bucketizer.min_val: {self.total_cost_bucketizer.min_val}, self.total_cost_bucketizer.max_val: {self.total_cost_bucketizer.max_val}")
        print(f"self.plan_rows_bucketizer.min_val: {self.plan_rows_bucketizer.min_val}, self.plan_rows_bucketizer.max_val: {self.plan_rows_bucketizer.max_val}")
        print(f"self.plan_width_bucketizer.min_val: {self.plan_width_bucketizer.min_val}, self.plan_width_bucketizer.max_val: {self.plan_width_bucketizer.max_val}")

        # for plan cost
        # max_width disabled (no node.width values)

        # self.width_norm = Normalizer(np.log(float(min_width) + 0.001), np.log(float(max_width) + 0.001))
        # print(f"self.width_norm.maxi:{self.width_norm.maxi}, self.width_norm.mini: {self.width_norm.mini}")

        # print(f"min_cost {min_cost},max_cost {max_cost}")
        # print(f"min_cost_est {min_cost_est}, max_cost_est {max_cost_est}")
        # Note: min_width/max_width intentionally unchanged here.
        # print(f"min_width {min_width}, max_width {max_width}")

        self.max_filters = max_filters
        print(f"max_filters = {self.max_filters}")


import re
def getAlias(node):
    # For postgresql
    # alias = None
    # if 'Alias' in node:
    #     alias = node['Alias']
    # else:
    #     n = node
    #     while 'parent' in n:
    #         n = n['parent']
    #         if 'Alias' in n:
    #             alias = n['Alias']
    #             break
    # return alias
    
    alias = None
    if 'Relation Name' in node:  # some plan formats use 'Relation Name' for the table
        alias = node['Relation Name']
    elif 'Filter' in node:  # Sometimes may infer the alias from the filter
        filter_text = node['Filter']
        # Extract anything within parentheses using regex
        matches = re.findall(r'\(([^)]+)\)', filter_text)
        if matches:
            # Iterate over matches and extract possible table aliases (before the dot)
            for match in matches:
                if '.' in match:
                    alias = match.split('.')[0]  # Extract the table part before the dot
                    break
    if alias:
        alias = alias.replace('(', '').replace(')', '').strip()

    # If no alias is found, try checking the parent nodes
    if alias is None:
        n = node
        while 'parent' in n:
            n = n['parent']
            if 'Relation Name' in n:
                alias = n['Relation Name']
                break
            elif 'Filter' in n:
                filter_text = n['Filter']
                matches = re.findall(r'\(([^)]+)\)', filter_text)
                if matches:
                    for match in matches:
                        if '.' in match:
                            alias = match.split('.')[0]
                            break
                if alias:
                    break
    if alias:
        # alias = alias.replace('<temporary>','temporary').strip()
        alias = alias.replace('(', '').replace(')', '').replace('substr','').replace('sum','').strip()

    return alias


def extractNode(node):    
    # For PostgreSQL   
    # d = {
    #     'nodeType' : node['Node Type'],
    #     'card'     : node['Actual Rows'],
    #     'card_est' : node['Plan Rows'],
    #     'nodeParallel' : node['Node Type'] + '_' + str(node['Parallel Aware']),
    #     'width'    : node['Plan Width'],
    # }

    # Tolerate missing fields across plan formats
    d = {
        'nodeType' : node.get('Node Type','Unknown'),
        'card'     : node.get('Actual Rows',0),
        'card_est' : node.get('Plan Rows', 0),
        'nodeParallel' : node.get('Node Type','Unknown') + '_' + str(node.get('Parallel Aware', False)),
        'width': node.get('Plan Width', 0), 
    }
    
    
    alias = getAlias(node)

    # Initialize counters for 'None' and '<temporary>' aliases
    if not hasattr(extractNode, 'none_counter'):
        extractNode.none_counter = 0
    if not hasattr(extractNode, 'temporary_counter'):
        extractNode.temporary_counter = 0

    # Increment the respective counter based on alias value
    if alias is None:
        extractNode.none_counter += 1
    elif alias.strip() == 'None':
        extractNode.none_counter += 1
    elif alias.strip() == '<temporary>':
        extractNode.temporary_counter += 1

    # if alias not in ['customer','lineitem','part','partsupp','nation','region','orders','supplier']:
    #     print(F"alias: {alias}")

    d['alias'] = alias
    
    conds = get_conditions(node, alias)
    join, filters = conds['join'], conds['filters']

    d['filters'] = filters
    d['join'] = join

    # for postgres
    # d['cost'] = node['Actual Total Time']
    # d['cost_est'] = node['Total Cost']
    d['cost'] = node.get('Actual Total Time',0)
    d['cost_est']= node.get('Total Cost', 0)
    # james: 没有拿到startup cost,加一行
    # FINISHED
    d['startup_cost'] = node.get('Startup Cost', 0)
    
    if 'Index Name' in node:
        d['index'] = node['Index Name']
    
    if 'Relation Name' in node:
        d['table'] = node['Relation Name']

#     adding for bao
    if 'Buffers' in node:
        d['buffers'] = node['Buffers']
        
    # for plan cost
    if 'Hash Buckets' in node:
        d['hash'] = node['Hash Buckets']
        
    if 'Parent Relationship' in node:
        d['parent_rel'] = node['Parent Relationship'].lower()
        
    if 'Join Type' in node:
        d['join_type'] = node['Join Type'].lower()
        
    if 'Sort Key' in node:
        d['sort_key'] = node['Sort Key']
        
    if 'Sort Method' in node:
        d['sort_method'] = node['Sort Method'].lower()
        
    if 'Strategy' in node:
        d['strategy'] = node['Strategy'].lower()
        
    if 'Parallel Aware' in node:
        d['para_aware'] = node['Parallel Aware']
        
    if 'Command' in node:
        d['command'] = node['Command']
        
    if 'Subplan Name' in node:
        d['subplan_name'] = node['Subplan Name']
         
    return d

def traversePlan(root, level=0):
    if 'Plan' in root:
        root = root['Plan']
    root_node = TreeNode(extractNode(root))

    root_node.level = level
    if 'Plans' in root:
        for child in root['Plans']:
            child['parent'] = root
            node = traversePlan(child, level+1)
            node.parent = root_node
            root_node.children.append(node)
    return root_node   

def get_conditions(json_node, table):
    conds = set()
    ####################################################################
    # join conds
    if 'Hash Cond' in json_node:
        conds.add(json_node['Hash Cond'])
    if 'Join Filter' in json_node:
        conds.add(json_node['Join Filter'])
    if 'Merge Cond' in json_node:
        conds.add(json_node['Merge Cond'])
    # scan conds
    if 'Index Cond' in json_node:
        conds.add(json_node['Index Cond'])
    if 'Filter' in json_node:
        conds.add(json_node['Filter'])
    if 'Recheck Cond' in json_node:
        conds.add(json_node['Recheck Cond'])
    ####################################################################
    joins = []
    filters = []
    for cond in conds:
        res = condPipeline(cond, table)
        if res['joins'] is not None:
            joins.append(res['joins'])
        if len(res['filters']) > 0:
            filters.extend(res['filters'])
    if len(joins) == 0:
        return {
            'join' : 'NA',
            'filters' : filters
        }
    else:
        return {
            'join' : joins[0],
            'filters' : filters
        }

def condPipeline(string, table):
    ll_rep = nestedExpr('(',')').parseString(string).asList()
    flat_rep = flattenConds(ll_rep)
    return formatConds(flat_rep, table)

def flattenConds(rep): # naive flattening
    cons = ['AND','OR']
    ops = ['=','!=','<','>','<=','>=','<>']
    ress = []
    def dfss(rep):
        for r in rep:
            if r in cons:
                continue
            if isinstance(r, list) and len(r)>1 and r[1] in ops:
                ress.append(r)
            elif isinstance(r, list) and len(r)>1:
                dfss(r)
    dfss(rep)
    return ress        

def formatConds(conds, table): # either filter or join
    filters = []
    joins = None
    for cond in conds:
#         print(cond)
        if isinstance(cond[0], list):
#             print(cond[0], cond[2])
############## debugged for tpcds #
            try:
                cond[0] = cond[0][1][0]
            except:
                cond[0] = cond[0][-1][0]
###################################
            if not  isinstance(cond[2],list):
                return {'joins' : None, 'filters' : []}

        # if len(cond) == 3  and not cond[2].isnumeric(): # join #modified
        if len(cond) == 3 and not isinstance(cond[2],list) and not cond[2].isnumeric(): # join
            twoCols = cond[0], cond[2]
            twoCols = [table + '.' + col 
                  if len(col.split('.')) == 1 else col for col in twoCols] 
            joins = ' = '.join(sorted(twoCols))
                
        elif len(cond) > 3 and cond[3] in ['::timestamp', '::date']:
#             print(cond)
#             d = datetime.strptime(cond[2][1:11], '%Y-%m-%d')
            if cond[3] == '::timestamp':
                d = datetime.strptime(cond[2].split("'")[1], '%Y-%m-%d %H:%M:%S')
            else:
                d = datetime.strptime(cond[2].split("'")[1], '%Y-%m-%d')
            filt = [cond[0], cond[1], d.timestamp()]

            filters.append(filt)
            
        elif is_number(cond[2]):
            filt = [cond[0], cond[1], float(cond[2])]
            filters.append(filt)
        
        elif not isinstance(cond[2],list) and cond[2][1:-1].isnumeric(): # filter
            filt = [cond[0], cond[1], int(cond[2][1:-1])]
            filters.append(filt)
        elif not isinstance(cond[2],list) and cond[-1] != '::numeric': # string predicate
            ## do later
            
            filt = [cond[0], cond[1], cond[2][1:-1]]
            filters.append(filt)
        
    for filt in filters:
        if len(filt[0].split('.'))==1:
            if table is None:
                table = "NA"
            filt[0] = f"{table}.{filt[0]}"
            # filt[0] = '.'.join((table, filt[0]))
#     print(filters, joins)
    return {
        'joins' : joins,
        'filters' : filters
    }

def is_number(s):
    try:
        float(s)
        return True
    except:
        return False


def flattenConds(rep):
    cons = ['AND','OR']
    ops = ['=','!=','<','>','<=','>=','<>']
    ress = []
    def dfss(rep):
        for r in rep:
            if r in cons:
                continue
            if isinstance(r, list) and len(r)>1 and r[1] in ops:
                ress.append(r)
            elif isinstance(r, list) and len(r)>1:
                dfss(r)
    dfss(rep)
    return ress


###############################################################################
# DuckDB plan traversal
###############################################################################

DUCKDB_TO_PG_NODE_TYPE = {
    'SEQ_SCAN': 'Seq Scan',
    'INDEX_SCAN': 'Index Scan',
    'HASH_JOIN': 'Hash Join',
    'NESTED_LOOP_JOIN': 'Nested Loop',
    'MERGE_JOIN': 'Merge Join',
    'FILTER': 'Filter',
    'PROJECTION': 'Projection',
    'HASH_GROUP_BY': 'HashAggregate',
    'PERFECT_HASH_GROUP_BY': 'HashAggregate',
    'ORDER_BY': 'Sort',
    'UNGROUPED_AGGREGATE': 'Aggregate',
    'TOP_N': 'Limit',
    'CROSS_PRODUCT': 'Nested Loop',
    'PIECEWISE_MERGE_JOIN': 'Merge Join',
    'BLOCKWISE_NL_JOIN': 'Nested Loop',
}

_DUCKDB_COND_RE = re.compile(
    r'([\w.]+)\s*(!=|<>|<=|>=|=|<|>)\s*(.+)'
)

_DUCKDB_BETWEEN_RE = re.compile(
    r'([\w.]+)\s+BETWEEN\s+(\S+)\s+AND\s+(\S+)', re.IGNORECASE
)


def _parse_duckdb_predicate(pred_str, table):
    """Parse a single DuckDB predicate string into filters / join."""
    pred_str = pred_str.strip()
    filters = []
    join = None

    # Handle BETWEEN
    m_between = _DUCKDB_BETWEEN_RE.match(pred_str)
    if m_between:
        col, lo, hi = m_between.group(1), m_between.group(2), m_between.group(3)
        if '.' not in col and table:
            col = f"{table}.{col}"
        if is_number(lo):
            filters.append([col, '>=', float(lo)])
        if is_number(hi):
            filters.append([col, '<=', float(hi)])
        return {'join': None, 'filters': filters}

    m = _DUCKDB_COND_RE.match(pred_str)
    if not m:
        return {'join': None, 'filters': []}

    lhs, op, rhs = m.group(1).strip(), m.group(2).strip(), m.group(3).strip()

    # Determine if this is a join (rhs looks like a column name) or a filter
    rhs_is_col = (re.match(r'^[\w.]+$', rhs) is not None) and not is_number(rhs)

    if rhs_is_col:
        # Join predicate
        left = lhs if '.' in lhs else (f"{table}.{lhs}" if table else lhs)
        right = rhs if '.' in rhs else (f"{table}.{rhs}" if table else rhs)
        join = ' = '.join(sorted([left, right]))
    else:
        col = lhs if '.' in lhs else (f"{table}.{lhs}" if table else lhs)
        if is_number(rhs):
            filters.append([col, op, float(rhs)])
        else:
            # String value – strip quotes
            val = rhs.strip("'\"")
            filters.append([col, op, val])

    return {'join': join, 'filters': filters}


def _split_duckdb_predicates(raw):
    """Normalise a DuckDB predicate value (str or list) into a flat list of strings."""
    if isinstance(raw, list):
        parts = []
        for item in raw:
            parts.extend(_split_duckdb_predicates(item))
        return parts
    if isinstance(raw, str) and raw:
        return [p.strip() for p in raw.split(' AND ') if p.strip()]
    return []


def get_conditions_duckdb(extra_info, table):
    """Extract join and filter conditions from DuckDB extra_info dict."""
    joins = []
    filters = []

    # Parse Filters (scan predicates) – may be str or list
    for part in _split_duckdb_predicates(extra_info.get('Filters', '')):
        res = _parse_duckdb_predicate(part, table)
        if res['join']:
            joins.append(res['join'])
        filters.extend(res['filters'])

    # Parse Conditions (join predicates) – may be str or list
    for part in _split_duckdb_predicates(extra_info.get('Conditions', '')):
        res = _parse_duckdb_predicate(part, table)
        if res['join']:
            joins.append(res['join'])
        filters.extend(res['filters'])

    # Parse Expression (used by FILTER nodes)
    raw_expr = extra_info.get('Expression', '')
    if raw_expr and isinstance(raw_expr, str):
        expr = raw_expr.strip()
        if expr.startswith('(') and expr.endswith(')'):
            expr = expr[1:-1]
        for part in _split_duckdb_predicates(expr):
            res = _parse_duckdb_predicate(part, table)
            if res['join']:
                joins.append(res['join'])
            filters.extend(res['filters'])

    join_str = joins[0] if joins else 'NA'
    return {'join': join_str, 'filters': filters}


def extractNodeDuckDB(node):
    """Convert a DuckDB plan node dict into a TreeNode-compatible dict."""
    raw_name = node.get('operator_name', 'Unknown').strip()
    pg_name = DUCKDB_TO_PG_NODE_TYPE.get(raw_name, raw_name)

    extra = node.get('extra_info', {})
    card_est_str = extra.get('Estimated Cardinality', '0')
    try:
        card_est = float(card_est_str)
    except (ValueError, TypeError):
        card_est = 0.0

    table = extra.get('Table', None)
    alias = table  # DuckDB doesn't have a separate alias

    conds = get_conditions_duckdb(extra, table)

    # operator_timing is in seconds – convert to ms
    op_timing = node.get('operator_timing', 0) or 0
    cost_ms = float(op_timing) * 1000.0

    d = {
        'nodeType': pg_name,
        'card': node.get('operator_cardinality', 0),
        'card_est': card_est,
        'nodeParallel': pg_name + '_False',
        'width': 0,
        'alias': alias,
        'filters': conds['filters'],
        'join': conds['join'],
        'cost': cost_ms,
        'cost_est': 0,
        'startup_cost': 0,
        'table': table,
    }

    if table is not None:
        d['index'] = None

    # Join type from extra_info
    jt = extra.get('Join Type', None)
    if jt:
        d['join_type'] = jt.lower()

    return d


def traversePlanDuckDB(root, level=0):
    """Traverse a DuckDB profiling JSON and build a TreeNode tree.

    The root of a DuckDB profile has metadata fields (latency, rows_returned, …)
    plus a ``children`` list containing the actual operator tree.  The first call
    peels off this wrapper automatically.
    """
    # The top-level JSON object is a metadata wrapper.
    # The actual operator tree starts in root['children'].
    if 'operator_name' not in root and 'children' in root:
        children = root.get('children', [])
        if len(children) == 1:
            return traversePlanDuckDB(children[0], level)
        # Multiple top-level children – create a synthetic root
        synthetic = {
            'operator_name': 'RESULT',
            'operator_cardinality': root.get('rows_returned', 0),
            'operator_timing': 0,
            'extra_info': {},
            'children': children,
        }
        return traversePlanDuckDB(synthetic, level)

    root_node = TreeNode(extractNodeDuckDB(root))
    root_node.level = level

    for child in root.get('children', []):
        child_node = traversePlanDuckDB(child, level + 1)
        child_node.parent = root_node
        root_node.children.append(child_node)

    return root_node


# ────────────────────────────────────────────────────────────────────────
#  Spark plan parsing
# ────────────────────────────────────────────────────────────────────────
# Spark plan text format (first 2 lines = labels, stripped upstream):
#
#     time cost: <ms> ms
#     actual cardinality: <n>
#     query plan:
#     Join Inner, (UserId#118 = Id#0)
#     :- Filter isnotnull(UserId#118)
#     :  +- Relation spark_catalog.stats.badges[Id#117,UserId#118,Date#119] parquet
#     +- Filter ((isnotnull(UpVotes#4) AND (UpVotes#4 >= 0)) AND isnotnull(Id#0))
#        +- Relation spark_catalog.stats.users[Id#0,Reputation#1,CreationDate#2,Views#3,UpVotes#4,DownVotes#5] parquet
#
#     statsOutput:
#     Join estimated row count: 92306, size in bytes: 4799912
#     Filter estimated row count: 79851, size in bytes: 5552960
#     ...
#
# Tree structure uses 3-char-per-level indentation with ':- ' / '+- ' markers.
# statsOutput lines are in preorder traversal of the plan tree.


SPARK_TO_PG_NODE_TYPE = {
    # Joins
    'Join': 'Hash Join',
    'BroadcastHashJoin': 'Hash Join',
    'ShuffledHashJoin': 'Hash Join',
    'SortMergeJoin': 'Merge Join',
    'BroadcastNestedLoopJoin': 'Nested Loop',
    'CartesianProduct': 'Nested Loop',
    # Scans
    'Relation': 'Seq Scan',
    'LogicalRelation': 'Seq Scan',
    'FileScan': 'Seq Scan',
    'BatchScan': 'Seq Scan',
    # Filters / projects / aggs
    'Filter': 'Filter',
    'Project': 'Result',
    'Aggregate': 'Aggregate',
    'HashAggregate': 'HashAggregate',
    'SortAggregate': 'Aggregate',
    # Sort / limit / window
    'Sort': 'Sort',
    'Limit': 'Limit',
    'GlobalLimit': 'Limit',
    'LocalLimit': 'Limit',
    'Window': 'WindowAgg',
    'TakeOrderedAndProject': 'Sort',
    # Union / exchange
    'Union': 'Append',
    'Exchange': 'Gather',
    # Generator / subquery
    'Generate': 'Result',
}


def _parse_spark_operator_line(op_line):
    """Extract (operator_type, table, filters, join) from a Spark operator text line.

    op_line examples:
        "Join Inner, (UserId#118 = Id#0)"
        "Filter isnotnull(UserId#118)"
        "Relation spark_catalog.stats.badges[Id#117,UserId#118,Date#119] parquet"
        "Project [Id#0]"
        "Aggregate [Id#0], [count(1) AS cnt#100L]"
    """
    op_line = op_line.strip()
    if not op_line:
        return {'nodeType': 'Unknown', 'table': None, 'alias': None,
                'filters': '', 'join': '', 'join_type': None}

    first_word = op_line.split()[0]
    pg_name = SPARK_TO_PG_NODE_TYPE.get(first_word, first_word)

    table = None
    alias = None
    filters = ''
    join = ''
    join_type = None

    if first_word in ('Relation', 'LogicalRelation', 'FileScan', 'BatchScan'):
        # Extract table from "<Rel>  spark_catalog.db.table[cols] parquet"
        import re as _re
        m = _re.search(r'\b([\w_]+)\[', op_line)
        if m:
            full_name = m.group(1)
            # Strip catalog/db prefix if present (split by ".")
            # The captured group may be just the table; try the wider pattern too
            m2 = _re.search(r'(?:(?:\w+)\.)*([\w_]+)\s*\[', op_line)
            if m2:
                table = m2.group(1)
                alias = table
    elif first_word == 'Filter':
        filters = op_line[len('Filter'):].strip()
    elif first_word == 'Join' or first_word.endswith('Join'):
        # "Join Inner, (cond)" or "SortMergeJoin Inner, (cond)"
        # Simplify the full condition (possibly a boolean combination) into
        # a single "col = col" form for e2e_cost/qf compatibility; fall back to ''.
        import re as _re
        m = _re.match(r'\w+\s+(\w+)(?:,\s*(.*))?', op_line)
        if m:
            join_type = m.group(1).lower()
            raw_cond = (m.group(2) or '').strip()
            # Extract the first "(col#id = col#id)" pattern (strip col#id → col)
            m2 = _re.search(r'\(([A-Za-z_]\w*)#\d+\s*=\s*([A-Za-z_]\w*)#\d+\)', raw_cond)
            if m2:
                join = f"{m2.group(1)} = {m2.group(2)}"
            # else: leave as '' (will become 'NA' downstream)

    return {'nodeType': pg_name, 'table': table, 'alias': alias,
            'filters': filters, 'join': join, 'join_type': join_type}


def _parse_spark_stats_output(stats_lines):
    """Parse statsOutput lines into a list of {'estimated_rows', 'size_bytes'} in preorder."""
    import re as _re
    out = []
    for line in stats_lines:
        line = line.strip()
        if not line:
            continue
        m = _re.search(r'estimated row count:\s*([\d.]+),?\s*size in bytes:\s*([\d.]+)', line)
        if m:
            try:
                out.append({'estimated_rows': float(m.group(1)),
                            'size_bytes': float(m.group(2))})
            except ValueError:
                out.append({'estimated_rows': 0.0, 'size_bytes': 0.0})
        else:
            out.append({'estimated_rows': 0.0, 'size_bytes': 0.0})
    return out


def _parse_spark_plan_tree(plan_text):
    """Parse the indented Spark plan text into a nested dict tree.

    Returns dict with: {'op_line': str, 'children': [dict, ...]}
    or None on failure.
    """
    import re as _re
    lines = [l for l in plan_text.split('\n') if l.strip()]
    if not lines:
        return None

    root = {'op_line': lines[0].strip(), 'children': [], 'depth': 0}
    # Stack of (depth, node) from root (depth 0) downward.
    stack = [root]

    for line in lines[1:]:
        m = _re.search(r'[+:]-\s', line)
        if not m:
            continue
        marker_pos = m.start()
        depth = marker_pos // 3 + 1
        content = line[marker_pos + 3:].strip()

        node = {'op_line': content, 'children': [], 'depth': depth}

        # Pop the stack until we find a parent at depth-1.
        while stack and stack[-1]['depth'] >= depth:
            stack.pop()
        if not stack:
            break
        stack[-1]['children'].append(node)
        stack.append(node)

    return root


def _preorder_nodes(tree):
    """Yield nodes in preorder (parent, then children left-to-right)."""
    if tree is None:
        return
    yield tree
    for c in tree.get('children', []):
        yield from _preorder_nodes(c)


def _attach_spark_stats(tree, stats_list):
    """Attach stats_list entries to tree nodes in preorder."""
    if tree is None:
        return
    for node, stats in zip(_preorder_nodes(tree), stats_list):
        node['stats'] = stats
    # Nodes past the end of stats_list just get no stats.


def _parse_spark_filter_to_tuples(raw_filter, raw_text=None):
    """Parse a Spark filter string into a list of [col, op, val] tuples.

    Spark filter examples:
        "isnotnull(col)"                    → skipped (unary)
        "(col = value)"                     → [['col', '=', value]]
        "(col > 2005)"                      → [['col', '>', 2005]]
        "((col1 >= 0) AND (col2 <= 10))"    → 2 filters
        "Contains(col, value)"              → skipped

    We strip Spark's col#<id> attribute refs and only keep simple binary ops.
    Returns [] for unsupported shapes so algorithms can treat them uniformly.
    """
    if not raw_filter:
        return []
    import re as _re
    out = []
    # Find binary comparisons inside parentheses. Spark uses col#<id> for refs.
    # We match patterns like `col#123 = 5`, `col#123 > 2005`, etc.
    for m in _re.finditer(
        r'\(\s*([A-Za-z_]\w*)#\d+\s*(=|!=|<>|<=|>=|<|>)\s*([^()]+?)\s*\)',
        raw_filter,
    ):
        col = m.group(1)
        op = m.group(2)
        val_raw = m.group(3).strip()
        # Try numeric value
        try:
            val = float(val_raw)
        except ValueError:
            # Strip common suffixes (e.g., "2014-09-04 23:10:09", strings)
            val = val_raw
        out.append([col, op, val])
    return out


def extractNodeSpark(node):
    """Convert a parsed Spark tree node dict into a TreeNode-compatible dict."""
    parsed = _parse_spark_operator_line(node['op_line'])
    stats = node.get('stats') or {}
    est_rows = stats.get('estimated_rows', 0.0)
    size_bytes = stats.get('size_bytes', 0.0)
    width = (size_bytes / est_rows) if est_rows > 0 else 0.0

    # Parse filter string into [col, op, val] tuples for QueryFormer/AIMAI compatibility.
    # Postgres's format is a list (possibly empty); Spark must match.
    filters_list = _parse_spark_filter_to_tuples(parsed['filters'])

    d = {
        'nodeType': parsed['nodeType'],
        'card': 0,            # Spark provides actual card at root only
        'card_est': est_rows,
        'nodeParallel': parsed['nodeType'] + '_False',
        'width': width,
        'alias': parsed['alias'],
        'filters': filters_list,
        'join': parsed['join'] if parsed['join'] else 'NA',
        'cost': 0,            # per-operator timing not exposed
        'cost_est': 0,
        'startup_cost': 0,
        'table': parsed['table'],
    }
    if parsed['table'] is not None:
        d['index'] = None
    if parsed['join_type']:
        d['join_type'] = parsed['join_type']
    return d


def parse_spark_plan(plan_text):
    """Top-level Spark plan parser. Takes the raw CSV cell text.

    Returns a synthetic node dict:
        {
          'time_cost_ms': float,       # actual total time (label)
          'actual_rows': float,        # actual rows returned (label)
          'tree': {op_line, stats, children[]}  # parsed tree with stats attached
        }
    """
    import re as _re
    text = plan_text.strip()
    lines = text.split('\n')

    # Line 1: time cost
    time_cost_ms = 0.0
    if lines:
        m = _re.search(r'time cost:\s*([\d.]+)\s*ms', lines[0])
        if m:
            time_cost_ms = float(m.group(1))

    # Line 2: actual cardinality
    actual_rows = 0.0
    if len(lines) > 1:
        m = _re.search(r'actual cardinality:\s*([\d.]+)', lines[1])
        if m:
            actual_rows = float(m.group(1))

    # Split into plan body and statsOutput.
    plan_body_lines = []
    stats_lines = []
    in_stats = False
    for line in lines[2:]:
        stripped = line.strip()
        if stripped.lower() == 'query plan:':
            continue
        if stripped.lower() == 'statsoutput:':
            in_stats = True
            continue
        if in_stats:
            stats_lines.append(line)
        else:
            plan_body_lines.append(line)

    tree = _parse_spark_plan_tree('\n'.join(plan_body_lines))
    stats_list = _parse_spark_stats_output(stats_lines)
    _attach_spark_stats(tree, stats_list)

    return {
        'time_cost_ms': time_cost_ms,
        'actual_rows': actual_rows,
        'tree': tree,
    }


def traversePlanSpark(root, level=0):
    """Build a TreeNode tree from a parsed Spark plan.

    `root` is the dict returned by parse_spark_plan() (top-level), OR a nested
    tree node dict during recursion.

    Spark only exposes actual cost/card at the QUERY level, not per-operator.
    On the top-level wrapper, we copy `time_cost_ms`/`actual_rows` into the root
    TreeNode's `cost`/`card` so that DatasetInfo's min/max sweep picks them up.
    """
    # Top-level wrapper
    if 'tree' in root and 'op_line' not in root:
        if root['tree'] is None:
            dummy = {'op_line': 'Unknown', 'children': [], 'depth': 0, 'stats': {}}
            tn = traversePlanSpark(dummy, level)
        else:
            tn = traversePlanSpark(root['tree'], level)
        # Attach query-level actuals to the root so DatasetInfo sees real values.
        tn.cost = float(root.get('time_cost_ms', 0.0) or 0.0)
        tn.card = float(root.get('actual_rows', 0.0) or 0.0)
        return tn

    d = extractNodeSpark(root)
    node = TreeNode(d)
    node.level = level
    for child in root.get('children', []):
        child_node = traversePlanSpark(child, level + 1)
        child_node.parent = node
        node.children.append(child_node)
    return node