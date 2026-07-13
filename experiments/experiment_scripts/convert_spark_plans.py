#!/usr/bin/env python3
"""
Convert Spark EXPLAIN ANALYZE .txt files to long_raw CSV format.

Self-contained parser — no external 'parsers' module dependency.
Produces PostgreSQL-style JSON plans compatible with the SICE pipeline.

Spark plan format:
    time cost: 231 ms
    actual cardinality: 133949
    query plan:
    Join Inner, (PostId#83 = Id#19)
    :- Filter (...)
    :  +- Relation spark_catalog.stats.table[cols] parquet
    +- Filter (...)
       +- Relation spark_catalog.stats.table[cols] parquet

    statsOutput:
    Join estimated row count: 4984, size in bytes: 378784
    ...

Usage:
    python convert_spark_plans.py \
        --input_folder /path/to/spark/results \
        --output_csv  queryPlans/stats/spark/long_raw_spark_stats.csv
"""

import argparse
import csv
import json
import os
import re
import sys
from collections import defaultdict

# ---------------------------------------------------------------------------
# Header parsing
# ---------------------------------------------------------------------------
_TIME_COST_RE = re.compile(r'time cost:\s*([\d.]+)\s*ms')
_ACTUAL_CARD_RE = re.compile(r'actual cardinality:\s*(\d+)')


def _parse_header(content):
    """Extract execution time (ms) and actual cardinality from file header."""
    time_m = _TIME_COST_RE.search(content)
    card_m = _ACTUAL_CARD_RE.search(content)
    time_ms = float(time_m.group(1)) if time_m else 0.0
    card = int(card_m.group(1)) if card_m else 0
    return time_ms, card


# ---------------------------------------------------------------------------
# statsOutput parsing
# ---------------------------------------------------------------------------
_STATS_RE = re.compile(
    r'(\w+)\s+estimated row count:\s*(\w+),\s*size in bytes:\s*(\d+)'
)


def _parse_stats(stats_text):
    """Parse statsOutput block into a list of dicts."""
    result = []
    for line in stats_text.strip().splitlines():
        m = _STATS_RE.search(line)
        if m:
            row_str = m.group(2)
            plan_rows = None if row_str == 'unknown' else int(row_str)
            result.append({
                'node_type': m.group(1),
                'plan_rows': plan_rows,
                'size_bytes': int(m.group(3)),
            })
    return result


# ---------------------------------------------------------------------------
# Spark plan tree parsing
# ---------------------------------------------------------------------------

def _get_indent_level(line):
    """Compute indentation level from Spark tree structure tokens.

    Spark uses:  +- for child,  :- for first child with siblings,
                 :  for vertical connector, spaces for depth.
    Each level = 3 characters of indentation.
    """
    # Count leading non-content characters: spaces, :, |, +, -
    i = 0
    while i < len(line) and line[i] in ' :|+-':
        i += 1
    # Each level is approximately 3 chars of indentation
    return i // 3


def _strip_tree_prefix(line):
    """Remove Spark tree indentation tokens, returning clean operator text."""
    return re.sub(r'^[\s:\+\-\|]+', '', line).strip()


def _parse_spark_operator(text):
    """Parse a single Spark operator line into a structured dict.

    Examples:
        "Join Inner, (PostId#83 = Id#19)"
        "Filter (isnotnull(Score#84) AND (Score#84 = 0))"
        "Relation spark_catalog.stats.comments[Id#82,...] parquet"
        "Project [col1, col2, ...]"
        "Aggregate [keys], [aggs]"
        "Sort [keys]"
    """
    info = {
        'operator': 'Unknown',
        'filter': None,
        'table': None,
        'columns': None,
        'join_type': None,
        'join_cond': None,
    }

    # Join: "Join Inner, (condition)"
    join_m = re.match(r'^Join\s+(\w+),?\s*\((.+)\)\s*$', text)
    if join_m:
        info['operator'] = 'Join'
        info['join_type'] = join_m.group(1)
        info['join_cond'] = join_m.group(2).strip()
        return info

    # Filter: "Filter (...)"
    filter_m = re.match(r'^Filter\s+(.+)', text)
    if filter_m:
        info['operator'] = 'Filter'
        info['filter'] = filter_m.group(1).strip()
        return info

    # Relation: "Relation spark_catalog.db.table[columns] format"
    rel_m = re.match(
        r'^Relation\s+\S+\.(\w+)\[([^\]]*)\]\s*(\w+)?', text
    )
    if rel_m:
        info['operator'] = 'Relation'
        info['table'] = rel_m.group(1)
        info['columns'] = rel_m.group(2)
        return info

    # Project: "Project [columns]"
    proj_m = re.match(r'^Project\s+\[(.+)\]', text)
    if proj_m:
        info['operator'] = 'Project'
        return info

    # Aggregate: "Aggregate [keys], [aggs]"
    agg_m = re.match(r'^Aggregate\s+', text)
    if agg_m:
        info['operator'] = 'Aggregate'
        return info

    # Sort: "Sort [keys]"
    sort_m = re.match(r'^Sort\s+', text)
    if sort_m:
        info['operator'] = 'Sort'
        return info

    # Fallback
    first_word = text.split()[0] if text.split() else 'Unknown'
    info['operator'] = first_word
    return info


def _build_spark_tree(plan_text):
    """Parse Spark plan text into a nested dict tree."""
    lines = plan_text.strip().splitlines()
    if not lines:
        return None

    nodes = []
    for line in lines:
        line_stripped = line.rstrip()
        if not line_stripped:
            continue

        indent = _get_indent_level(line_stripped)
        content = _strip_tree_prefix(line_stripped)
        if not content:
            continue

        parsed = _parse_spark_operator(content)
        parsed['children'] = []
        nodes.append((indent, parsed))

    if not nodes:
        return None

    # Build tree using a stack
    stack = []
    root = None

    for indent, node in nodes:
        # Pop items at >= current indent level
        while stack and stack[-1][0] >= indent:
            stack.pop()

        if stack:
            stack[-1][1]['children'].append(node)
        else:
            root = node

        stack.append((indent, node))

    return root


# ---------------------------------------------------------------------------
# Attach stats to tree
# ---------------------------------------------------------------------------
def _flatten_preorder(node):
    """Flatten tree in pre-order traversal."""
    result = [node]
    for child in node.get('children', []):
        result.extend(_flatten_preorder(child))
    return result


def _attach_stats(tree, stats_list):
    """Attach plan_rows from statsOutput to tree nodes (pre-order mapping)."""
    flat = _flatten_preorder(tree)
    for node, stats in zip(flat, stats_list):
        node['plan_rows'] = stats['plan_rows']
    # Nodes without stats get default
    for node in flat[len(stats_list):]:
        node.setdefault('plan_rows', None)


# ---------------------------------------------------------------------------
# Merge Filter into scan
# ---------------------------------------------------------------------------
def _merge_filter_into_scan(node):
    """Merge Filter nodes into their scan children."""
    children = node.get('children', [])
    for child in children:
        _merge_filter_into_scan(child)

    if node.get('operator') == 'Filter' and len(children) == 1:
        child = children[0]
        if child.get('operator') in ('Relation',):
            # Merge filter into relation
            child['filter'] = node.get('filter')
            child['plan_rows'] = node.get('plan_rows', child.get('plan_rows'))
            node.update(child)
        elif child.get('operator') in ('Join',):
            existing = child.get('filter', '')
            new_filter = node.get('filter', '')
            if existing and new_filter:
                child['filter'] = f"({existing}) AND ({new_filter})"
            else:
                child['filter'] = existing or new_filter
            node.update(child)


# ---------------------------------------------------------------------------
# Build column#id → table mapping
# ---------------------------------------------------------------------------
def _build_col_table_map(tree):
    """Build a mapping from Spark column hash IDs (e.g. 'PostId#83') to table names.

    Traverses all Relation nodes and extracts column definitions from
    their column list (e.g. "Id#82,PostId#83,Score#84,...").
    """
    col_map = {}  # col_hash -> table_name, e.g. "PostId#83" -> "comments"

    def _visit(node):
        if node.get('operator') == 'Relation' and node.get('table') and node.get('columns'):
            table = node['table']
            for col_def in node['columns'].split(','):
                col_def = col_def.strip()
                if col_def:
                    col_map[col_def] = table
                    # Also store without hash for fallback
                    col_name = re.sub(r'#\d+', '', col_def)
                    if col_name not in col_map:
                        col_map[col_name] = table
        for child in node.get('children', []):
            _visit(child)

    _visit(tree)
    return col_map


def _qualify_spark_cond(cond_text, col_map):
    """Qualify Spark join condition columns with table names.

    Converts "PostId#83 = Id#19" → "(comments.PostId = posts.Id)"
    """
    if not cond_text:
        return cond_text

    def _resolve(col_ref):
        col_ref = col_ref.strip()
        # Look up with hash ID
        if col_ref in col_map:
            table = col_map[col_ref]
            col_name = re.sub(r'#\d+', '', col_ref)
            return f'{table}.{col_name}'
        # Try without hash
        col_name = re.sub(r'#\d+', '', col_ref)
        if col_name in col_map:
            return f'{col_map[col_name]}.{col_name}'
        return col_name

    # Pattern: "col1 = col2" or "col1 op col2"
    m = re.match(r'^\(?\s*(\S+)\s*(=|!=|<>|<=|>=|<|>)\s*(\S+)\s*\)?$', cond_text)
    if m:
        left = _resolve(m.group(1))
        op = m.group(2)
        right = _resolve(m.group(3))
        return f'({left} {op} {right})'
    return cond_text


# ---------------------------------------------------------------------------
# Convert to PostgreSQL-style JSON
# ---------------------------------------------------------------------------
def _clean_spark_filter(filter_text):
    """Clean Spark filter expressions for compatibility.

    Ensures filter is wrapped in outer parentheses so that
    condPipeline (which uses nestedExpr('(',')')) can parse it.
    """
    if not filter_text:
        return None
    text = filter_text.strip()
    # Wrap in parens if not already wrapped
    if not text.startswith('('):
        text = f'({text})'
    return text


def _to_pg_json(node, exec_time_ms=0.0, actual_card=0, is_root=True, col_map=None):
    """Convert parsed Spark tree node to PostgreSQL-style JSON dict."""
    op = node.get('operator', 'Unknown')

    # Map Spark operators to more PostgreSQL-like names
    op_map = {
        'Relation': 'Seq Scan',
        'Join': 'Hash Join',
        'Filter': 'Filter',
        'Project': 'Projection',
        'Aggregate': 'Aggregate',
        'Sort': 'Sort',
    }
    pg_type = op_map.get(op, op)

    # For Join nodes, refine type
    if op == 'Join':
        jtype = node.get('join_type', 'Inner')
        if jtype == 'Inner':
            pg_type = 'Hash Join'
        elif jtype in ('LeftOuter', 'Left'):
            pg_type = 'Hash Left Join'
        elif jtype in ('RightOuter', 'Right'):
            pg_type = 'Hash Right Join'
        else:
            pg_type = f'Hash Join ({jtype})'

    plan_rows = node.get('plan_rows')
    if plan_rows is None:
        plan_rows = 1.0

    d = {
        'Node Type': pg_type,
        'Actual Startup Time': 0.0,
        # Root gets execution time; others get 0 (Spark has no per-op timing)
        'Actual Total Time': exec_time_ms if is_root else 0.0,
        # Root gets actual cardinality; others get estimated
        'Actual Rows': float(actual_card) if is_root else float(plan_rows),
        'Actual Loops': 1.0,
        'Total Cost': 0.0,  # Spark doesn't provide cost estimates
        'Plan Rows': float(plan_rows),
    }

    if node.get('filter'):
        cleaned = _clean_spark_filter(node['filter'])
        if cleaned:
            d['Filter'] = cleaned

    if node.get('table'):
        d['Relation Name'] = node['table']

    if node.get('join_cond'):
        cond = node['join_cond']
        # Qualify column references with table names
        if col_map:
            cond = _qualify_spark_cond(cond, col_map)
        elif not cond.startswith('('):
            cond = f'({cond})'
        d['Hash Cond'] = cond

    if node.get('join_type'):
        d['Join Type'] = node['join_type']

    children = node.get('children', [])
    if children:
        d['Plans'] = [_to_pg_json(c, exec_time_ms, actual_card, is_root=False,
                                  col_map=col_map) for c in children]

    return d


def _replace_none(obj):
    """Recursively replace None with 0.0."""
    if isinstance(obj, dict):
        return {k: _replace_none(v) for k, v in obj.items()}
    elif isinstance(obj, list):
        return [_replace_none(e) for e in obj]
    elif obj is None:
        return 0.0
    return obj


# ---------------------------------------------------------------------------
# Main conversion
# ---------------------------------------------------------------------------
def convert_one_file(filepath):
    """Convert a single Spark EXPLAIN ANALYZE .txt file to PG-style JSON."""
    with open(filepath, 'r') as f:
        content = f.read()

    if not content.strip():
        return []

    # Parse header
    exec_time_ms, actual_card = _parse_header(content)

    # Split into plan and stats sections
    if 'statsOutput:' not in content:
        return []
    parts = content.split('statsOutput:')
    plan_part = parts[0]
    stats_part = parts[1] if len(parts) > 1 else ''

    # Extract plan tree text (after "query plan:")
    if 'query plan:' not in plan_part:
        return []
    plan_text = plan_part.split('query plan:')[1].strip()

    if not plan_text:
        return []

    # Parse stats
    stats = _parse_stats(stats_part)

    # Build tree
    tree = _build_spark_tree(plan_text)
    if tree is None:
        return []

    # Attach stats (plan rows)
    _attach_stats(tree, stats)

    # Build column → table map for join condition qualification
    col_map = _build_col_table_map(tree)

    # Merge filter nodes into scans
    _merge_filter_into_scan(tree)

    # Convert to PG-style
    pg = _to_pg_json(tree, exec_time_ms, actual_card, col_map=col_map)
    pg = _replace_none(pg)

    return [pg]


def process_files(input_folder, output_csv, file_pattern=r'stats_(\d+)_run0\.txt'):
    """Process all matching .txt files and write CSV."""
    os.makedirs(os.path.dirname(output_csv) or '.', exist_ok=True)

    # Collect matching files sorted by numeric ID
    files = []
    for fname in os.listdir(input_folder):
        m = re.match(file_pattern, fname)
        if m:
            files.append((int(m.group(1)), fname))
    files.sort()

    id_counter = 1
    errors = 0
    empty = 0

    with open(output_csv, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['id', 'json'])

        for file_id, fname in files:
            fpath = os.path.join(input_folder, fname)
            try:
                plans = convert_one_file(fpath)
                if not plans:
                    empty += 1
                    continue
                for plan in plans:
                    writer.writerow([id_counter, json.dumps(plan)])
                    id_counter += 1
            except Exception as e:
                errors += 1
                print(f"Error processing {fname}: {e}")

    total = id_counter - 1
    print(f"\nSpark conversion complete:")
    print(f"  Output: {output_csv}")
    print(f"  Plans written: {total}")
    print(f"  Empty/skipped files: {empty}")
    print(f"  Errors: {errors}")

    return total


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Convert Spark EXPLAIN ANALYZE .txt to CSV')
    parser.add_argument('--input_folder', type=str, required=True,
                        help='Directory with stats_*_run0.txt files')
    parser.add_argument('--output_csv', type=str, required=True,
                        help='Output CSV path (e.g. queryPlans/stats/spark/long_raw_spark_stats.csv)')
    parser.add_argument('--file_pattern', type=str, default=r'stats_(\d+)_run0\.txt',
                        help='Regex pattern for input filenames')
    args = parser.parse_args()

    process_files(args.input_folder, args.output_csv, args.file_pattern)
