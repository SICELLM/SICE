"""SICE library: models, statistics feature pipeline, and data plumbing.

This single module consolidates the former experiments/ helper modules:
  - field_categories / field_categories_duckdb  (plan-field ablation categories)
  - cross_workload_price_config                 (table-alias maps for statistics generation)
  - stats_features                              (statistics-token injection helpers)
  - models/baseline_price_model                 (baseline + Canon joint models)
  - models/llm_price_model                      (PRICEEmbedder, LLMPriceJointModel, cross-attn blocks)
  - price_embedder_factory                      (embedder construction)
  - price_data_utils                            (SQL -> Canon feature pipeline)
  - baseline_price_data                         (baseline-aligned feature datasets)

Sections below are marked with `===== section:` banners; each keeps its
original module docstring as a leading comment block.
"""

import os
import sys

# Make the repo root and experiments/ importable so the canon package
# (including the vendored PRICE code) and sibling modules resolve regardless
# of the caller's working directory.
_EXPERIMENTS_DIR = os.path.dirname(os.path.abspath(__file__))
REPO_ROOT = os.path.abspath(os.path.join(_EXPERIMENTS_DIR, ".."))
_EVALUATION_DIR = os.path.join(REPO_ROOT, "evaluation")
for _p in (REPO_ROOT, _EXPERIMENTS_DIR, _EVALUATION_DIR):
    if _p not in sys.path:
        sys.path.insert(0, _p)

import json
import re
from pathlib import Path
import pandas as pd
import numpy as np
import torch
from feature_extractor import traversePlan
import torch.nn as nn
import math
import torch.nn.functional as F
from canon.and_transformer import reshape_clauses
from canon.price.model.module import FeedForward
from canon.price.model.encoder import RegressionModel
import pickle
import logging
from torch.utils.data import Dataset


# ==========================================================================
# ===== section: field_categories.py (merged) =====
# ==========================================================================
# Field category definitions for PostgreSQL query plan ablation studies.
#
# This module defines how query plan fields are classified into 6 categories:
# - 5 user-selectable categories (for ablation studies)
# - 1 runtime category (always removed automatically)

# Field category definitions for PostgreSQL query plans
FIELD_CATEGORIES = {
    'operator_structure_and_config': {
        # Core operator information and node-specific configurations
        'Node Type',
        'Parent Relationship',
        # Scan node configurations
        'Relation Name',
        'Schema',
        'Alias',
        'Index Name',
        'Scan Direction',
        # CTE Scan node configurations
        'CTE Name',
        # Function Scan node configurations
        'Function Name',
        'Table Function Name',
        # Subplan node configurations
        'Subplan Name',
        # Join node configurations
        'Join Type',
        'Inner Unique',
        # Sort node configurations
        'Sort Key',
        'Presorted Key',
        # Hash node configurations (Hash Join, Hash Aggregate)
        'Hash Keys',
        # Insert node configurations
        'Conflict Resolution',
        'Conflict Arbiter Indexes',
        'Tuples Inserted',
        # Output projection (applies to most nodes)
        'Output',
        # Other node-specific configurations
        'Strategy',
        'Partial Mode',
    },
    'cost': {
        # Cost estimates (planned)
        'Startup Cost',
        'Total Cost',
        'Plan Width',  # Moved from cardinality - width is related to cost calculation
    },
    'cardinality': {
        # Row count estimates (planned)
        'Plan Rows',  # Only this field - the actual row count estimate
    },
    'conditions_and_filters': {
        # Query conditions and filters that affect cardinality
        'Filter',
        'Join Filter',
        'Index Cond',
        'Recheck Cond',
        'Hash Cond',
        'Merge Cond',
        'One-Time Filter',
        'TID Cond',
        'Group Key',
    },
    'metadata_and_config': {
        # Query-level and execution-level metadata (not node-specific)
        # Query-level metadata
        'Command',
        'Triggers',
        'Planning Time',
        # Execution capability and parallelism configuration
        'Parallel Aware',
        'Async Capable',
        'Workers Planned',
        'Single Copy',
    },
    'runtime': {
        # === ACTUAL EXECUTION STATISTICS ===
        # Timing and row counts
        'Actual Startup Time',
        'Actual Total Time',
        'Actual Rows',
        'Actual Loops',
        
        # === ROWS REMOVED / SELECTIVITY ===
        'Rows Removed by Filter',
        'Rows Removed by Index Recheck',
        'Rows Removed by Join Filter',
        
        # === MEMORY & DISK USAGE ===
        'Peak Memory Usage',
        'Sort Space Used',
        'Sort Space Type',
        'Work Mem Used',
        
        # === CACHE/BUFFER STATISTICS ===
        # Shared buffer statistics
        'Shared Hit Blocks',
        'Shared Read Blocks',
        'Shared Dirtied Blocks',
        'Shared Written Blocks',
        # Local buffer statistics
        'Local Hit Blocks',
        'Local Read Blocks',
        'Local Dirtied Blocks',
        'Local Written Blocks',
        # Temporary file statistics
        'Temp Read Blocks',
        'Temp Written Blocks',
        
        # === STORAGE ACCESS STATISTICS ===
        'I/O Read Time',
        'I/O Write Time',
        'Exact Heap Blocks',
        'Lossy Heap Blocks',
        'Heap Fetches',
        
        # === HASH EXECUTION DETAILS ===
        'Hash Buckets',
        'Hash Batches',
        'Original Hash Batches',
        
        # === PARALLELISM EXECUTION ===
        'Workers Launched',
        'Workers',
        'Worker Number',
        
        # === SORT EXECUTION DETAILS ===
        'Sort Method',
        
        # === INCREMENTAL SORT STATISTICS ===
        'Full-sort Groups',
        'Sort Groups Count',
        'Sort Methods Used',
        
        # === OTHER RUNTIME STATISTICS ===
        'Execution Time',
        'Subplan Calls',
        'WAL Records',
        'WAL FPI',
        'WAL Bytes',
    }
}


def get_fields_to_remove(removed_categories):
    """
    Given a list of category names, return the set of all fields to remove.
    
    Note: The 'runtime' category is ALWAYS removed automatically and should not be
    specified in removed_categories. Only the other 5 categories are valid options.
    
    Args:
        removed_categories: List of category names (e.g., ['cost', 'cardinality'])
                           Valid: operator_structure_and_config, cost, cardinality,
                                  conditions_and_filters, metadata_and_config
                           Invalid: runtime (always removed automatically)
    
    Returns:
        Set of field names to remove (excluding runtime fields, which are handled separately)
    """
    if not removed_categories:
        return set()
    
    # Valid categories for user selection (runtime is always removed, not user-selectable)
    valid_categories = {
        'operator_structure_and_config',
        'cost',
        'cardinality',
        'conditions_and_filters',
        'metadata_and_config'
    }
    
    fields_to_remove = set()
    for category in removed_categories:
        if category == 'runtime':
            print(f"Warning: 'runtime' category is always removed by default. No need to specify it.")
            continue
        if category == 'statsOutput':
            # Spark-only pseudo-category. The actual removal happens in
            # utilsLLM.get_llm_ds_from_csv's _is_spark branch (strip the
            # "statsOutput:" block from the plan text). No JSON fields to
            # remove here, so return nothing for this category.
            continue
        if category in valid_categories:
            fields_to_remove.update(FIELD_CATEGORIES[category])
        else:
            print(f"Warning: Unknown field category '{category}'. Valid categories: {sorted(valid_categories)}")

    return fields_to_remove


def get_category_summary():
    """
    Return a summary of field categories for documentation/debugging.
    
    Returns:
        Dictionary with category statistics
    """
    summary = {}
    for category, fields in FIELD_CATEGORIES.items():
        summary[category] = {
            'count': len(fields),
            'user_selectable': category != 'runtime',
            'fields': sorted(fields)
        }
    return summary


# ==========================================================================
# ===== section: field_categories_duckdb.py (merged) =====
# ==========================================================================
# Field category definitions for DuckDB query plan ablation studies.
#
# This module defines how DuckDB query plan fields are classified into 6 categories:
# - 5 user-selectable categories (for ablation studies)
# - 1 runtime category (always removed automatically)
#
# DuckDB plan structure:
#   Root: query-level metadata (latency, rows_returned, ...) + children (operator tree)
#   Nodes: operator_name, operator_type, extra_info{...}, children[...], timing/cardinality fields
#   extra_info: nested dict with Estimated Cardinality, Join Type, Conditions, Filters, Table, Projections, etc.

# Field category definitions for DuckDB query plans
DUCKDB_FIELD_CATEGORIES = {
    'operator_structure_and_config': {
        # Core operator identification
        'operator_name',
        'operator_type',
        # Join configuration (inside extra_info)
        'Join Type',
        # Scan configuration (inside extra_info)
        'Table',
        'Type',
        # Output projection (inside extra_info)
        'Projections',
        # Expressions (inside extra_info)
        'Expression',
    },
    'cost': {
        # DuckDB does not expose separate startup/total cost fields.
        # Estimated Cardinality is the planner's row estimate (closest to cost info).
        # Kept empty so cardinality category holds the estimate instead.
    },
    'cardinality': {
        # Planner's row count estimate (inside extra_info)
        'Estimated Cardinality',
    },
    'conditions_and_filters': {
        # Join and filter conditions (inside extra_info)
        'Conditions',
        'Filters',
    },
    'metadata_and_config': {
        # Query-level metadata
        'query_name',
        # extra_info container itself is structural, not removed
    },
    'runtime': {
        # === QUERY-LEVEL RUNTIME STATISTICS (root) ===
        'latency',
        'rows_returned',
        'result_set_size',
        'cpu_time',
        'blocked_thread_time',
        'system_peak_buffer_memory',
        'system_peak_temp_dir_size',
        'total_bytes_read',
        'total_bytes_written',

        # === OPERATOR-LEVEL RUNTIME STATISTICS (nodes) ===
        'operator_timing',
        'operator_cardinality',
        'operator_rows_scanned',
        'cumulative_cardinality',
        'cumulative_rows_scanned',
        # result_set_size, cpu_time, total_bytes_read, total_bytes_written
        # also appear at node level — already listed above
    }
}


def duckdb_get_fields_to_remove(removed_categories):
    """
    Given a list of category names, return the set of all fields to remove.

    Note: The 'runtime' category is ALWAYS removed automatically and should not be
    specified in removed_categories. Only the other 5 categories are valid options.

    Args:
        removed_categories: List of category names (e.g., ['cost', 'cardinality'])
                           Valid: operator_structure_and_config, cost, cardinality,
                                  conditions_and_filters, metadata_and_config
                           Invalid: runtime (always removed automatically)

    Returns:
        Set of field names to remove (excluding runtime fields, which are handled separately)
    """
    if not removed_categories:
        return set()

    valid_categories = {
        'operator_structure_and_config',
        'cost',
        'cardinality',
        'conditions_and_filters',
        'metadata_and_config'
    }

    fields_to_remove = set()
    for category in removed_categories:
        if category == 'runtime':
            print(f"Warning: 'runtime' category is always removed by default. No need to specify it.")
            continue
        if category in valid_categories:
            fields_to_remove.update(DUCKDB_FIELD_CATEGORIES[category])
        else:
            print(f"Warning: Unknown field category '{category}'. Valid categories: {sorted(valid_categories)}")

    return fields_to_remove


def duckdb_get_category_summary():
    """
    Return a summary of field categories for documentation/debugging.

    Returns:
        Dictionary with category statistics
    """
    summary = {}
    for category, fields in DUCKDB_FIELD_CATEGORIES.items():
        summary[category] = {
            'count': len(fields),
            'user_selectable': category != 'runtime',
            'fields': sorted(fields)
        }
    return summary


# ==========================================================================
# ===== section: cross_workload_price_config.py (merged) =====
# ==========================================================================
# Cross-workload PRICE alias configuration.
#
# Maps all 20 deepdb_augmented database names to {table_name: price_alias} dicts.
# Aliases are globally unique across all databases (different prefix per DB).
#
# For imdb and tpc_h, aliases match the existing PRICE statistics.

DEEPDB_BASE = str(__import__("pathlib").Path(__file__).resolve().parents[1] / "deepdb_augmented")  # optional, not shipped

# ---------------------------------------------------------------------------
# Static alias definitions
# ---------------------------------------------------------------------------

# IMDB: match existing PRICE aliases exactly
IMDB_ABBREV = {
    "aka_name": "imdb_an",
    "aka_title": "imdb_at",
    "cast_info": "imdb_ci",
    "char_name": "imdb_chn",
    "comp_cast_type": "imdb_cct",
    "company_name": "imdb_cpn",
    "company_type": "imdb_ct",
    "complete_cast": "imdb_cc",
    "info_type": "imdb_it",
    "keyword": "imdb_kw",
    "kind_type": "imdb_kt",
    "link_type": "imdb_lt",
    "movie_companies": "imdb_mc",
    "movie_info": "imdb_mi",
    "movie_info_idx": "imdb_mii",
    "movie_keyword": "imdb_mk",
    "movie_link": "imdb_ml",
    "name": "imdb_n",
    "person_info": "imdb_pi",
    "role_type": "imdb_rt",
    "title": "imdb_t",
}

# TPC-H: match existing PRICE aliases exactly
TPCH_ABBREV = {
    "customer": "tpch_c",
    "orders": "tpch_o",
    "lineitem": "tpch_l",
    "part": "tpch_p",
    "partsupp": "tpch_ps",
    "supplier": "tpch_s",
    "nation": "tpch_n",
    "region": "tpch_r",
}

# Stats: match existing PRICE aliases exactly
STATS_ABBREV = {
    "badges": "st_b",
    "comments": "st_c",
    "posthistory": "st_ph",
    "postlinks": "st_pl",
    "posts": "st_p",
    "tags": "st_t",
    "users": "st_u",
    "votes": "st_v",
}

# Accidents
ACCIDENTS_ABBREV = {
    "nesreca": "acc_nes",
    "oseba": "acc_ose",
    "upravna_enota": "acc_ue",
}

# Airline
AIRLINE_ABBREV = {
    "On_Time_On_Time_Performance_2016_1": "air_ot",
    "L_AIRLINE_ID": "air_lai",
    "L_AIRPORT": "air_la",
    "L_AIRPORT_ID": "air_laid",
    "L_AIRPORT_SEQ_ID": "air_lasid",
    "L_CANCELLATION": "air_lcan",
    "L_CITY_MARKET_ID": "air_lcmi",
    "L_DEPARRBLK": "air_ldab",
    "L_DISTANCE_GROUP_250": "air_ldg",
    "L_DIVERSIONS": "air_ldiv",
    "L_MONTHS": "air_lm",
    "L_ONTIME_DELAY_GROUPS": "air_lodg",
    "L_QUARTERS": "air_lq",
    "L_STATE_ABR_AVIATION": "air_lsaa",
    "L_STATE_FIPS": "air_lsf",
    "L_UNIQUE_CARRIERS": "air_luc",
    "L_WEEKDAYS": "air_lwd",
    "L_WORLD_AREA_CODES": "air_lwac",
    "L_YESNO_RESP": "air_lyn",
}

# Baseball
BASEBALL_ABBREV = {
    "allstarfull": "bb_asf",
    "appearances": "bb_app",
    "awardsmanagers": "bb_awm",
    "awardsplayers": "bb_awp",
    "awardssharemanagers": "bb_awsm",
    "awardsshareplayers": "bb_awsp",
    "batting": "bb_bat",
    "battingpost": "bb_batp",
    "els_teamnames": "bb_etn",
    "fielding": "bb_fld",
    "fieldingof": "bb_fldo",
    "fieldingpost": "bb_fldp",
    "halloffame": "bb_hof",
    "managers": "bb_mgr",
    "managershalf": "bb_mgrh",
    "pitching": "bb_pit",
    "pitchingpost": "bb_pitp",
    "players": "bb_ply",
    "salaries": "bb_sal",
    "schools": "bb_sch",
    "schoolsplayers": "bb_schp",
    "seriespost": "bb_sp",
    "teams": "bb_tm",
    "teamsfranchises": "bb_tmf",
    "teamshalf": "bb_tmh",
}

# Basketball
BASKETBALL_ABBREV = {
    "awards_coaches": "bk_awc",
    "awards_players": "bk_awp",
    "coaches": "bk_co",
    "draft": "bk_dr",
    "player_allstar": "bk_pas",
    "players": "bk_ply",
    "players_teams": "bk_pt",
    "series_post": "bk_sp",
    "teams": "bk_tm",
}

# Carcinogenesis
CARCINOGENESIS_ABBREV = {
    "atom": "car_a",
    "canc": "car_c",
    "sbond_1": "car_sb1",
    "sbond_2": "car_sb2",
    "sbond_3": "car_sb3",
    "sbond_7": "car_sb7",
}

# Consumer
CONSUMER_ABBREV = {
    "EXPENDITURES": "con_exp",
    "HOUSEHOLDS": "con_hh",
    "HOUSEHOLD_MEMBERS": "con_hhm",
}

# Credit
CREDIT_ABBREV = {
    "category": "cr_cat",
    "charge": "cr_chg",
    "corporation": "cr_corp",
    "member": "cr_mem",
    "payment": "cr_pay",
    "provider": "cr_prv",
    "region": "cr_reg",
    "statement": "cr_stm",
}

# Employee
EMPLOYEE_ABBREV = {
    "departments": "emp_dep",
    "dept_emp": "emp_de",
    "dept_manager": "emp_dm",
    "employees": "emp_e",
    "salaries": "emp_sal",
    "titles": "emp_ttl",
}

# FHNK
FHNK_ABBREV = {
    "pripady": "fh_pri",
    "vykony": "fh_vyk",
    "zup": "fh_zup",
}

# Financial
FINANCIAL_ABBREV = {
    "account": "fin_a",
    "card": "fin_cd",
    "client": "fin_cl",
    "disp": "fin_d",
    "district": "fin_dt",
    "loan": "fin_l",
    "order": "fin_o",
    "trans": "fin_t",
}

# Geneea
GENEEA_ABBREV = {
    "bod_schuze": "gen_bs",
    "bod_stav": "gen_bst",
    "funkce": "gen_fun",
    "hl_check": "gen_hch",
    "hl_hlasovani": "gen_hhl",
    "hl_poslanec": "gen_hpo",
    "hl_vazby": "gen_hva",
    "hl_zposlanec": "gen_hzp",
    "omluvy": "gen_oml",
    "organy": "gen_org",
    "osoby": "gen_oso",
    "pkgps": "gen_pkg",
    "poslanec": "gen_pos",
    "schuze": "gen_sch",
    "schuze_stav": "gen_sst",
    "typ_funkce": "gen_tf",
    "typ_organu": "gen_to",
    "zarazeni": "gen_zar",
    "zmatecne": "gen_zma",
}

# Genome
GENOME_ABBREV = {
    "ATT_CLASSES": "gno_ac",
    "IMG_OBJ": "gno_io",
    "IMG_OBJ_ATT": "gno_ioa",
    "IMG_REL": "gno_ir",
    "OBJ_CLASSES": "gno_oc",
    "PRED_CLASSES": "gno_pc",
}

# Hepatitis
HEPATITIS_ABBREV = {
    "Bio": "hep_bio",
    "dispat": "hep_dis",
    "indis": "hep_ind",
    "inf": "hep_inf",
    "rel11": "hep_r11",
    "rel12": "hep_r12",
    "rel13": "hep_r13",
}

# Movielens
MOVIELENS_ABBREV = {
    "actors": "ml_act",
    "directors": "ml_dir",
    "movies": "ml_mov",
    "movies2actors": "ml_m2a",
    "movies2directors": "ml_m2d",
    "u2base": "ml_u2b",
    "users": "ml_usr",
}

# Seznam
SEZNAM_ABBREV = {
    "client": "sz_cl",
    "dobito": "sz_dob",
    "probehnuto": "sz_pro",
    "probehnuto_mimo_penezenku": "sz_pmp",
}

# SSB
SSB_ABBREV = {
    "customer": "ssb_c",
    "lineorder": "ssb_lo",
    "part": "ssb_p",
    "supplier": "ssb_s",
}

# Tournament
TOURNAMENT_ABBREV = {
    "regular_season_compact_results": "tn_rscr",
    "regular_season_detailed_results": "tn_rsdr",
    "seasons": "tn_sea",
    "target": "tn_tgt",
    "teams": "tn_tm",
    "tourney_compact_results": "tn_tcr",
    "tourney_detailed_results": "tn_tdr",
    "tourney_seeds": "tn_tsd",
    "tourney_slots": "tn_tsl",
}

# Walmart
WALMART_ABBREV = {
    "key": "wm_k",
    "station": "wm_sta",
    "train": "wm_tr",
}

# ---------------------------------------------------------------------------
# Master mapping: db_name -> abbrev dict
# ---------------------------------------------------------------------------
CROSS_WORKLOAD_ABBREV = {
    "accidents": ACCIDENTS_ABBREV,
    "airline": AIRLINE_ABBREV,
    "baseball": BASEBALL_ABBREV,
    "basketball": BASKETBALL_ABBREV,
    "carcinogenesis": CARCINOGENESIS_ABBREV,
    "consumer": CONSUMER_ABBREV,
    "credit": CREDIT_ABBREV,
    "employee": EMPLOYEE_ABBREV,
    "fhnk": FHNK_ABBREV,
    "financial": FINANCIAL_ABBREV,
    "geneea": GENEEA_ABBREV,
    "genome": GENOME_ABBREV,
    "hepatitis": HEPATITIS_ABBREV,
    "imdb": IMDB_ABBREV,
    "movielens": MOVIELENS_ABBREV,
    "seznam": SEZNAM_ABBREV,
    "ssb": SSB_ABBREV,
    "tournament": TOURNAMENT_ABBREV,
    "tpc_h": TPCH_ABBREV,
    "walmart": WALMART_ABBREV,
}

# All 20 cross-workload database names
ALL_CROSS_WORKLOAD_DBS = sorted(CROSS_WORKLOAD_ABBREV.keys())


def get_abbrev_for_db(db_name):
    """Get the PRICE alias mapping for a cross-workload database."""
    if db_name not in CROSS_WORKLOAD_ABBREV:
        raise ValueError(f"Unknown cross-workload database: {db_name}")
    return CROSS_WORKLOAD_ABBREV[db_name]


def get_reverse_abbrev(db_name):
    """Get reverse mapping: price_alias -> table_name."""
    abbrev = get_abbrev_for_db(db_name)
    return {v: k for k, v in abbrev.items()}


def discover_used_tables_from_json(json_path):
    """Discover which tables are actually referenced in plan trees.

    Returns sorted list of table names that appear as scan nodes.
    """
    with open(json_path) as f:
        data = json.load(f)

    table_stats = data["database_stats"]["table_stats"]
    plans = data["parsed_plans"]

    used_indices = set()

    def traverse(node):
        pp = node.get("plan_parameters", {})
        if pp.get("table") is not None:
            used_indices.add(pp["table"])
        for child in node.get("children", []):
            traverse(child)

    for plan in plans:
        traverse(plan)

    return sorted(set(
        table_stats[i]["relname"]
        for i in used_indices
        if i < len(table_stats)
    ))


def get_json_paths_for_db(db_name):
    """Get all non-index JSON file paths for a database."""
    db_dir = os.path.join(DEEPDB_BASE, db_name)
    if not os.path.isdir(db_dir):
        raise FileNotFoundError(f"Database directory not found: {db_dir}")
    paths = []
    for f in sorted(os.listdir(db_dir)):
        if f.endswith(".json") and not f.startswith("index_"):
            paths.append(os.path.join(db_dir, f))
    return paths


def verify_aliases():
    """Verify all aliases are globally unique across databases."""
    all_aliases = {}
    for db_name, abbrev in CROSS_WORKLOAD_ABBREV.items():
        for table, alias in abbrev.items():
            if alias in all_aliases:
                prev_db, prev_table = all_aliases[alias]
                print(f"CONFLICT: alias '{alias}' used by "
                      f"{prev_db}.{prev_table} and {db_name}.{table}")
            all_aliases[alias] = (db_name, table)
    print(f"Total aliases: {len(all_aliases)}, all unique: "
          f"{len(all_aliases) == sum(len(a) for a in CROSS_WORKLOAD_ABBREV.values())}")


if __name__ == "__main__":
    verify_aliases()
    print()
    for db_name in ALL_CROSS_WORKLOAD_DBS:
        abbrev = CROSS_WORKLOAD_ABBREV[db_name]
        print(f"{db_name}: {len(abbrev)} tables")
        for table, alias in sorted(abbrev.items()):
            print(f"  {table} -> {alias}")


# ==========================================================================
# ===== section: stats_features.py (merged) =====
# ==========================================================================

# NOTE: train.py / utilsLLM.py add ../evaluation to sys.path, so import directly


def _default_stats_paths_for_workload(workload: str):
    """Pick stats source based on workload.

    - For IMDB-like workloads (job/job_full/syn/tpch/tpcds etc.), use imdb pg_stats.
    - For workload == 'stats', use stats pg_stats.

    Paths are relative to this repository checkout.
    """
    here = Path(__file__).resolve()
    repo_root = here.parents[1]
    base = (repo_root / "pg_distributions").resolve()
    if workload == "stats":
        return base / "stats" / "pg_stats.csv", base / "stats" / "table_sizes.csv"
    return base / "imdb" / "pg_stats.csv", base / "imdb" / "table_sizes.csv"


class StatsMemory:
    """Lightweight wrapper around Postgres pg_stats dumps.

    We only use portable, read-only features:
    - null_frac
    - n_distinct (ndv proxy)
    - most_common_freqs (for top-k mass/skew proxy)
    - histogram_bounds (for rough range/shape proxy)

    Notes:
    - pg_stats is sampled + capped by stats target; treat as noisy.
    - For n_distinct: negative values are Postgres heuristics (fraction of rows).
    """

    def __init__(self, pg_stats_csv: str, table_sizes_csv: str | None = None):
        self.pg_stats_csv = str(pg_stats_csv)
        self.table_sizes_csv = str(table_sizes_csv) if table_sizes_csv else None

        df = pd.read_csv(self.pg_stats_csv)
        # normalize column names
        df.columns = [c.strip() for c in df.columns]
        self.df = df

        # Build lookup: (table, col) -> row
        self._idx = {}
        for _, r in df.iterrows():
            t = str(r.get("tablename"))
            a = str(r.get("attname"))
            self._idx[(t, a)] = r

        self.table_sizes = None
        if self.table_sizes_csv and os.path.exists(self.table_sizes_csv):
            ts = pd.read_csv(self.table_sizes_csv)
            ts.columns = [c.strip() for c in ts.columns]
            self.table_sizes = {str(r["table"]): (float(r["est_rows"]), float(r["bytes_total"])) for _, r in ts.iterrows()}

    @staticmethod
    def _parse_pg_array(arr_str: str):
        if not isinstance(arr_str, str) or len(arr_str) < 2:
            return []
        # simplest: strip { } and split by comma; frequencies are numeric, histogram bounds can be quoted
        s = arr_str.strip()
        if not (s.startswith("{") and s.endswith("}")):
            return []
        inner = s[1:-1]
        if inner == "":
            return []
        out = []
        cur = ""
        in_quotes = False
        i = 0
        while i < len(inner):
            ch = inner[i]
            if ch == '"':
                in_quotes = not in_quotes
                i += 1
                continue
            if ch == "," and not in_quotes:
                out.append(cur)
                cur = ""
                i += 1
                continue
            cur += ch
            i += 1
        out.append(cur)
        return out

    def col_features(self, table: str, col: str, est_rows_for_table: float | None = None):
        """Return a small numeric feature vector for one column.

        Vector (float32):
        - log1p(ndv_proxy)
        - null_frac
        - top1_freq
        - top5_mass
        - hist_len_norm

        ndv_proxy:
        - if n_distinct < 0 and est_rows known: ndv = -n_distinct * est_rows
        - else ndv = n_distinct (clipped)
        """
        r = self._idx.get((table, col))
        if r is None:
            return None

        null_frac = float(r.get("null_frac", 0.0))
        n_distinct = float(r.get("n_distinct", 0.0))

        # NDV proxy handling
        if n_distinct < 0 and est_rows_for_table is not None:
            ndv = (-n_distinct) * float(est_rows_for_table)
        else:
            ndv = n_distinct
        ndv = max(0.0, float(ndv))

        mcf = r.get("most_common_freqs", None)
        freqs = []
        if isinstance(mcf, str):
            try:
                freqs = [float(x) for x in self._parse_pg_array(mcf) if x != ""]
            except Exception:
                freqs = []
        top1 = freqs[0] if len(freqs) >= 1 else 0.0
        top5 = float(sum(freqs[:5])) if len(freqs) else 0.0

        hb = r.get("histogram_bounds", None)
        hist_len = 0.0
        if isinstance(hb, str):
            try:
                hist_len = float(len(self._parse_pg_array(hb)))
            except Exception:
                hist_len = 0.0
        hist_len_norm = hist_len / 100.0  # rough scale

        return np.array([
            np.log1p(ndv),
            null_frac,
            top1,
            top5,
            hist_len_norm,
        ], dtype=np.float32)


def extract_referenced_columns_from_plan_json(plan_json: dict):
    """Extract referenced column strings from a plan JSON.

    Returns a set of strings like:
    - alias.col (from filters)
    - alias.col (from join equality)

    The feature_extractor already formats filters as ["alias.col", op, value].
    Joins are strings like "a.x = b.y".
    """
    root = traversePlan(plan_json)
    cols = set()
    q = [root]
    while q:
        n = q.pop(0)
        q.extend(getattr(n, "children", []) or [])
        # filters: list of [col, op, val]
        if getattr(n, "filters", None):
            for f in n.filters:
                if isinstance(f, (list, tuple)) and len(f) >= 1:
                    c = f[0]
                    if isinstance(c, str) and "." in c:
                        cols.add(c)
        # join: string "a.x = b.y"
        j = getattr(n, "join", None)
        if isinstance(j, str) and "=" in j:
            parts = [p.strip() for p in j.split("=")]
            for p in parts:
                if "." in p:
                    cols.add(p)
    return cols


def build_query_stats_vector(plan_json: dict, ds_info, stats_mem: StatsMemory, max_cols: int = 16):
    """Aggregate per-column features into a fixed-length vector.

    Strategy (best-effort, robust):
    - collect referenced columns from filters+joins
    - map alias -> table via ds_info.alias2table when possible
    - compute per-column feature vectors
    - aggregate with (mean, max) over columns

    Output dim: 2 * feat_dim (mean + max). If no cols resolved, zeros.
    """
    feat_dim = 5
    cols = extract_referenced_columns_from_plan_json(plan_json)

    feats = []
    for ac in sorted(cols):
        try:
            alias, col = ac.split(".", 1)
        except Exception:
            continue
        table = ds_info.alias2table.get(alias, alias) if hasattr(ds_info, "alias2table") else alias
        est_rows = None
        if stats_mem.table_sizes is not None and table in stats_mem.table_sizes:
            est_rows = stats_mem.table_sizes[table][0]
        f = stats_mem.col_features(table, col, est_rows_for_table=est_rows)
        if f is not None:
            feats.append(f)
        if len(feats) >= max_cols:
            break

    if not feats:
        return np.zeros((feat_dim * 2,), dtype=np.float32)

    M = np.stack(feats, axis=0)  # [k, feat_dim]
    mean = M.mean(axis=0)
    mx = M.max(axis=0)
    return np.concatenate([mean, mx], axis=0).astype(np.float32)


def build_stats_matrix_from_csv(dat_path: str, ds_info, stats_mem: StatsMemory, argsP=None):
    """Read a plan CSV and return stats feature matrix aligned to rows.

    Expects columns:
    - 'json' or 'Plan_dump'

    Returns: torch.FloatTensor [N, S]
    """
    df = pd.read_csv(dat_path)
    col = "json" if "json" in df.columns else "Plan_dump"
    stats_vecs = []
    for _, row in df.iterrows():
        js_str = row.get(col)
        if not isinstance(js_str, str) or js_str == "failed":
            # keep alignment by emitting zeros
            stats_vecs.append(np.zeros((10,), dtype=np.float32))
            continue
        try:
            plan_json = json.loads(js_str)
        except Exception:
            stats_vecs.append(np.zeros((10,), dtype=np.float32))
            continue
        v = build_query_stats_vector(plan_json, ds_info, stats_mem)
        stats_vecs.append(v)

    X = np.stack(stats_vecs, axis=0)
    return torch.from_numpy(X).float()


def load_stats_memory_for_args(argsP):
    pg_stats_path = getattr(argsP, "stats_pg_stats_path", None)
    table_sizes_path = getattr(argsP, "stats_table_sizes_path", None)
    if pg_stats_path is None:
        pg_stats_path, table_sizes_path = _default_stats_paths_for_workload(getattr(argsP, "workload_test", "imdb"))
    return StatsMemory(pg_stats_path, table_sizes_path)


def inject_stat_tokens_into_cleaned_plan(
    cleaned_root: dict,
    ds_info,
    stats_mem: StatsMemory,
    token_str: str = "[STAT]",
    token_mode: str = "per_column",
):
    """Attach [STAT] tokens next to predicate strings inside the cleaned Postgres plan JSON.

    The cleaned plan JSON uses keys like "Filter", "Index Cond", "Hash Cond", "Merge Cond", etc.
    We do NOT concatenate stats into the text; instead we insert a literal token string
    and separately return a list of numeric vectors (one per inserted token).

    token_mode:
      - "per_column": insert up to K tokens (currently 8), one per referenced column.
      - "avg": insert a single token per predicate with mean-pooled vector.

    At model time, the [STAT] token's embedding is replaced with a projection of the
    corresponding numeric stats vector.

    Returns:
      (augmented_root, stats_vecs)
        - augmented_root: JSON-serializable dict with extra sibling keys containing [STAT] tokens
        - stats_vecs: list[np.ndarray], each shape [5]
    """
    stats_vecs = []

    PRED_KEYS = {
        "Filter",
        "Index Cond",
        "Recheck Cond",
        "Hash Cond",
        "Merge Cond",
        "Join Filter",
    }

    # Best-effort alias->table resolution from the plan itself.
    def _collect_alias_map(obj, amap: dict):
        if isinstance(obj, dict):
            alias = obj.get("Alias", None)
            rel = obj.get("Relation Name", None) or obj.get("Relation", None) or obj.get("Table Name", None)
            if isinstance(alias, str) and isinstance(rel, str) and alias and rel:
                amap[alias] = rel
            for v in obj.values():
                _collect_alias_map(v, amap)
        elif isinstance(obj, list):
            for x in obj:
                _collect_alias_map(x, amap)

    alias_map = {}
    _collect_alias_map(cleaned_root, alias_map)

    def _alias_to_table(alias: str) -> str:
        if alias in alias_map:
            return alias_map[alias]
        if hasattr(ds_info, "alias2table") and isinstance(ds_info.alias2table, dict):
            return ds_info.alias2table.get(alias, alias)
        return alias

    def _col_vec(alias: str, col: str):
        table = _alias_to_table(alias)
        est_rows = None
        if stats_mem.table_sizes is not None and table in stats_mem.table_sizes:
            est_rows = stats_mem.table_sizes[table][0]
        return stats_mem.col_features(table, col, est_rows_for_table=est_rows)

    _alias_col_re = re.compile(r"([A-Za-z_][A-Za-z0-9_]*)\.([A-Za-z_][A-Za-z0-9_]*)")

    def _predicate_vecs(pred_str: str):
        if not isinstance(pred_str, str):
            return None
        matches = _alias_col_re.findall(pred_str)
        if not matches:
            return None
        vecs = []
        for alias, col in matches[:8]:
            v = _col_vec(alias, col)
            if v is not None:
                vecs.append((alias, col, v))
        if not vecs:
            return None
        return vecs

    def _recurse(obj):
        if isinstance(obj, dict):
            new = {}
            for k, v in obj.items():
                new[k] = _recurse(v)
                # After we copy the predicate string, append a sibling token key so JSON dump places it nearby.
                if k in PRED_KEYS and isinstance(v, str):
                    vecs = _predicate_vecs(v)
                    if vecs is not None:
                        if token_mode == "avg":
                            mean_vec = np.stack([vec for _, _, vec in vecs], axis=0).mean(axis=0).astype(np.float32)
                            new[f"{k}__stat_token"] = token_str
                            stats_vecs.append(mean_vec)
                        else:
                            for idx, (alias, col, vec) in enumerate(vecs):
                                new[f"{k}__statistics_token_{idx}_{alias}.{col}"] = token_str
                                stats_vecs.append(vec)
            return new
        elif isinstance(obj, list):
            return [_recurse(x) for x in obj]
        else:
            return obj

    return _recurse(cleaned_root), stats_vecs


class StatsVecNormalizer:
    """Simple per-dimension z-score normalization for stats vectors."""
    def __init__(self, eps: float = 1e-6):
        self.eps = eps
        self.mean = None
        self.std = None

    def fit(self, vecs: list[np.ndarray]):
        if not vecs:
            self.mean = None
            self.std = None
            return
        X = np.stack(vecs, axis=0).astype(np.float32)
        self.mean = X.mean(axis=0)
        self.std = X.std(axis=0)

    def transform(self, vecs: list[np.ndarray]) -> list[np.ndarray]:
        if self.mean is None or self.std is None:
            return vecs
        out = []
        denom = self.std + self.eps
        for v in vecs:
            out.append(((v - self.mean) / denom).astype(np.float32))
        return out


def normalize_stats_vecs(train_list, val_list, test_list):
    """Fit normalizer on train stats vectors; apply to train/val/test."""
    # Flatten per-plan lists
    train_flat = [v for per in train_list for v in per] if train_list else []
    val_flat = [v for per in val_list for v in per] if val_list else []
    test_flat = [v for per in test_list for v in per] if test_list else []

    norm = StatsVecNormalizer()
    norm.fit(train_flat)

    def _apply(per_plan_list):
        if not per_plan_list:
            return per_plan_list
        return [norm.transform(per) for per in per_plan_list]

    return _apply(train_list), _apply(val_list), _apply(test_list)


# ==========================================================================
# ===== section: models/baseline_price_model.py (merged) =====
# ==========================================================================
# Baseline (qf/aimai/e2e_cost) + PRICE concat, analogous to mode 7's
# LLMPriceJointModel: concat(base_encoder(x), price_embedder(price_feats)) -> MLP.

class BaselinePriceJointModel(nn.Module):
    def __init__(self, base_encoder, price_embedder, base_emb_dim, hid_units,
                 price_emb_dim=512):
        super().__init__()
        from trainer import Prediction
        self.base_encoder = base_encoder        # nn.Identity() for aimai
        self.price = price_embedder
        self.mlp = Prediction(base_emb_dim + price_emb_dim, hid_units)

    def forward(self, base_input, price_feats):
        base_emb = self.base_encoder(base_input)
        # PRICEEmbedder.forward(x, padding_mask, n_join_col, n_fanout, n_table, n_filter_col,
        #                       llm_hidden_states=None, llm_attention_mask=None, num_clauses=None, ...)
        # Under --price_n_or the collate appends num_clauses as a 7th element. It is
        # the 9th *positional* param of forward (after the two llm_* slots), so it
        # MUST be passed by keyword — exactly as mode 7's LLMPriceJointModel does
        # (self.price(..., num_clauses=num_clauses)). Passing it positionally would
        # leak it into llm_hidden_states and silently skip the OR-Transformer
        # aggregation, leaving query_output at (batch*max_clauses) rows.
        price_feats = list(price_feats)
        num_clauses = price_feats.pop() if len(price_feats) == 7 else None
        price_emb, _, _ = self.price(*price_feats, num_clauses=num_clauses)
        return self.mlp(torch.cat([base_emb, price_emb], dim=1))


class BaselinePriceCrossAttnModel(nn.Module):
    """qf + Canon via one-directional cross-attention (the cross-attn analog of
    BaselinePriceJointModel). The QueryFormer token sequence (super-token + nodes)
    attends to the projected 512-d statistics token through the embedder's cx
    blocks, exactly like LLMPriceJointModel but with qf tokens replacing the LLM
    tokens. Final embedding: cat([refined-qf super-token, stats]) -> MLP.

    base_encoder must accept forward(x, return_sequence=True) -> (tokens[B,S,H], mask[B,S]).
    price_embedder is a cx>0 PRICEEmbedder built with llm_hidden_dim == base_emb_dim.
    """
    def __init__(self, base_encoder, price_embedder, base_emb_dim, hid_units,
                 price_emb_dim=512):
        super().__init__()
        from trainer import Prediction
        self.base_encoder = base_encoder
        self.price = price_embedder
        self.mlp = Prediction(base_emb_dim + price_emb_dim, hid_units)

    def forward(self, base_input, price_feats):
        # qf token sequence + node validity mask (the LLM-hidden-states analog).
        qf_tokens, qf_mask = self.base_encoder(base_input, return_sequence=True)
        qf_tokens = qf_tokens.float()
        # See BaselinePriceJointModel: num_clauses (the optional 7th price-feat) MUST
        # be passed as a keyword, else it leaks into the llm_hidden_states slot.
        price_feats = list(price_feats)
        num_clauses = price_feats.pop() if len(price_feats) == 7 else None
        price_emb, updated_qf, _ = self.price(
            *price_feats, llm_hidden_states=qf_tokens, llm_attention_mask=qf_mask,
            num_clauses=num_clauses)
        # Refined qf super-token (index 0). updated_qf is [B,S,H] when the odd
        # (qf<-PRICE) blocks are active; falls back to the pre-cross-attn super-token
        # if cross-attn produced nothing (e.g. all blocks frozen-at-zero).
        if updated_qf is not None and updated_qf.dim() == 3:
            qf_emb = updated_qf[:, 0, :]
        else:
            qf_emb = qf_tokens[:, 0, :]
        return self.mlp(torch.cat([qf_emb, price_emb], dim=1))


# ==========================================================================
# ===== section: models/llm_price_model.py (merged) =====
# ==========================================================================
# Joint LLM + Canon (statistics) model for query cost prediction.
#
# Architecture (SICE):
#   Query Plan Text --> LLM --> plan tokens --[one-directional cross-attn]--+
#                                                                           +--> Concat --> MLP --> Prediction
#   SQL + Stats --> predicate canonicalization layer --> 512-d embedding ---+
#
# The statistics embedding is ALWAYS 512-d. For cross-attention fusion it is
# additionally projected to the LLM hidden dim (stat_proj, the paper's W_s) to
# serve as the length-1 attention context; the projected token is context only
# -- the 512-d embedding entering the final concat is never altered by the plan.

# Repo root on sys.path so the canon package (incl. vendored PRICE) resolves.



def _segment_mean(rows, win_owner, B):
    """Mean of rows [Nw, D] grouped by win_owner [Nw] (text id per window) → [B, D].
    Used by the unified per-window pooling: averages each text's window rows. Equals
    a plain .mean() over each text's windows (index_add_ visits win_owner in its given
    non-decreasing order)."""
    D = rows.size(1)
    sums = torch.zeros(B, D, device=rows.device, dtype=rows.dtype)
    sums.index_add_(0, win_owner, rows)
    counts = torch.zeros(B, device=rows.device, dtype=rows.dtype)
    counts.index_add_(0, win_owner, torch.ones(win_owner.size(0), device=rows.device, dtype=rows.dtype))
    return sums / counts.clamp(min=1).unsqueeze(1)


def _load_price_n_state_dict(model, ckpt_sd):
    """Load a PRICE pretrained state dict into a PRICE_N-shaped RegressionModel.

    Performs:
      1. Best-effort load_state_dict(strict=False) for matching keys.
         Keys with shape mismatches are excluded from this call to avoid
         RuntimeError (PyTorch 2.7+ raises even under strict=False for shape
         mismatches on the same key).
      2. Partial-copy of filter_embedding.weight[:, :ckpt_dim] when target is wider.
      3. Partial-copy of fanout_embeddings.weight[:, :ckpt_dim] when target is wider.
      4. type_embed first 4 rows copied if target has 5.
      5. pairwise_intra_embedding fully random-init (no copy).

    Returns a dict {loaded, partial_copied, missing} for logging.
    """
    summary = {"loaded": [], "partial_copied": [], "missing": []}
    target_sd = model.state_dict()

    # Build a filtered checkpoint that only contains keys whose shapes match
    # the target model — load_state_dict(strict=False) in PyTorch 2.7 still
    # raises RuntimeError for shape mismatches, so we exclude them here and
    # handle them manually in the partial-copy step below.
    shape_matched = {
        k: v for k, v in ckpt_sd.items()
        if k in target_sd and v.shape == target_sd[k].shape
    }

    # Step 1: load matching shapes with strict=False (handles truly missing keys gracefully)
    missing, unexpected = model.load_state_dict(shape_matched, strict=False)
    summary["loaded"] = list(shape_matched.keys())

    # Step 2 + 3: partial-copy mismatched 2-D Linear weights/biases.
    for key in [
        "filter_embedding.filter_embeddings.weight",
        "filter_embedding.filter_embeddings.bias",
        "scale_embedding.fanout_embeddings.weight",
        "scale_embedding.fanout_embeddings.bias",
    ]:
        if key not in ckpt_sd or key not in target_sd:
            continue
        src = ckpt_sd[key]
        tgt = target_sd[key]
        if src.shape == tgt.shape:
            continue                          # already loaded by strict=False
        if src.dim() == 2 and src.shape[0] == tgt.shape[0] and src.shape[1] < tgt.shape[1]:
            with torch.no_grad():
                tgt.zero_()
                tgt[:, :src.shape[1]].copy_(src)
            summary["partial_copied"].append(key)
        elif src.dim() == 1 and src.shape[0] <= tgt.shape[0]:
            with torch.no_grad():
                tgt.zero_()
                tgt[:src.shape[0]].copy_(src)
            summary["partial_copied"].append(key)

    summary["missing"] = list(missing)
    return summary


# ─── Cross-attention building blocks ─────────────────────────────────────


class CrossAttentionHead(nn.Module):
    """Single cross-attention head: Q from query_tokens, K/V from kv_tokens."""

    def __init__(self, head_size, n_embd, dropout_rate):
        super().__init__()
        self.Query = nn.Linear(n_embd, head_size)
        self.Key = nn.Linear(n_embd, head_size)
        self.Value = nn.Linear(n_embd, head_size)
        self.dropout_rate = dropout_rate

    def forward(self, query_tokens, kv_tokens, kv_mask=None):
        """
        Args:
            query_tokens: [B, T_q, D]
            kv_tokens:    [B, T_kv, D]
            kv_mask:      [B, T_kv] attention mask (1=attend, 0=pad)
        Returns:
            out: [B, T_q, head_size]
        """
        q = self.Query(query_tokens)   # [B, T_q, head_size]
        k = self.Key(kv_tokens)        # [B, T_kv, head_size]
        v = self.Value(kv_tokens)      # [B, T_kv, head_size]

        scores = torch.matmul(q, k.transpose(-1, -2)) / math.sqrt(k.size(-1))  # [B, T_q, T_kv]

        if kv_mask is not None:
            # kv_mask: [B, T_kv] -> [B, 1, T_kv] for broadcasting over T_q
            scores = scores.masked_fill(kv_mask.unsqueeze(1) == 0, -1e9)

        weights = F.softmax(scores, dim=-1)
        weights = F.dropout(weights, p=self.dropout_rate, training=self.training)
        return torch.matmul(weights, v)


class MultiHeadCrossAttention(nn.Module):
    """Multi-head cross-attention with linear projection."""

    def __init__(self, n_heads, head_size, n_embd, dropout_rate):
        super().__init__()
        self.heads = nn.ModuleList([
            CrossAttentionHead(head_size, n_embd, dropout_rate) for _ in range(n_heads)
        ])
        self.projection = nn.Linear(n_heads * head_size, n_embd)

    def forward(self, query_tokens, kv_tokens, kv_mask=None):
        head_outputs = [h(query_tokens, kv_tokens, kv_mask) for h in self.heads]
        return self.projection(torch.cat(head_outputs, dim=-1))


class CrossAttentionBlock(nn.Module):
    """Pre-norm cross-attention + pre-norm FFN with residual connections
    (PRICE-native FeedForward), operating at the statistics encoder width."""

    def __init__(self, n_embd, n_heads, dropout_rate):
        super().__init__()
        self.norm1 = nn.LayerNorm(n_embd)
        self.cross_attn = MultiHeadCrossAttention(
            n_heads, n_embd // n_heads, n_embd, dropout_rate
        )
        self.norm2 = nn.LayerNorm(n_embd)
        self.feed_forward = FeedForward(n_embd)
        self.dropout_rate = dropout_rate

    def forward(self, query_tokens, kv_tokens, kv_mask=None):
        normed = self.norm1(query_tokens)
        attn_out = self.cross_attn(normed, kv_tokens, kv_mask)
        attn_out = F.dropout(attn_out, p=self.dropout_rate, training=self.training)
        x = query_tokens + attn_out

        normed = self.norm2(x)
        ff_out = self.feed_forward(normed)
        ff_out = F.dropout(ff_out, p=self.dropout_rate, training=self.training)
        return x + ff_out


class PlanCrossAttentionBlock(nn.Module):
    """Pre-norm cross-attention + pre-norm FFN at the LLM hidden dim.

    Used for the plan-side fusion blocks: query_tokens are plan tokens and
    kv_tokens is the (projected) statistics context. Residual structure means
    that when the output projections are zero-initialised the block is a pure
    pass-through at init, so adding fusion never starts worse than LLM-only.
    """

    def __init__(self, llm_dim, n_heads, dropout_rate):
        super().__init__()
        self.norm1 = nn.LayerNorm(llm_dim)
        self.cross_attn = MultiHeadCrossAttention(
            n_heads, llm_dim // n_heads, llm_dim, dropout_rate
        )
        self.norm2 = nn.LayerNorm(llm_dim)
        self.feed_forward = nn.Sequential(
            nn.Linear(llm_dim, llm_dim * 4),
            nn.GELU(),
            nn.Linear(llm_dim * 4, llm_dim),
        )
        self.dropout_rate = dropout_rate

    def forward(self, query_tokens, kv_tokens, kv_mask=None):
        normed = self.norm1(query_tokens)
        attn_out = self.cross_attn(normed, kv_tokens, kv_mask)
        attn_out = F.dropout(attn_out, p=self.dropout_rate, training=self.training)
        x = query_tokens + attn_out

        normed = self.norm2(x)
        ff_out = self.feed_forward(normed)
        ff_out = F.dropout(ff_out, p=self.dropout_rate, training=self.training)
        return x + ff_out


# Backwards-compatible alias: checkpoints and older code refer to the plan-side
# block by this name.
ReverseCrossAttentionBlock = PlanCrossAttentionBlock


def _zero_init_block(block):
    """Zero the residual injections (attention output projection + last FFN
    linear) so the block computes the identity at init (soft warmup)."""
    nn.init.zeros_(block.cross_attn.projection.weight)
    nn.init.zeros_(block.cross_attn.projection.bias)
    nn.init.zeros_(block.feed_forward[-1].weight)
    nn.init.zeros_(block.feed_forward[-1].bias)


# ─── Statistics (Canon) embedder ─────────────────────────────────────────


class PRICEEmbedder(nn.Module):
    """
    The predicate-canonicalization (Canon) statistics embedder, optionally
    fused with the LLM plan tokens through cross-attention.

    Base pipeline (always runs; produces the 512-d statistics embedding):
      scale_emb -> filter_emb -> per-clause CLS(256) -> [OR-transformer over
      clauses] -> +len(16) -> linear(272→512) -> ELU -> dropout

    With n_cross_layers > 0 the 512-d embedding is projected to the LLM hidden
    dim (stat_proj) and used as a length-1 attention context:

      cross_attn_direction='one' (default; the paper design):
        every block updates the PLAN tokens by attending to the statistics
        context. The statistics embedding is never altered by the plan; the
        512-d embedding is what enters the final concat.

      cross_attn_direction='bi' (ablation):
        blocks alternate direction — even blocks update the statistics context
        from the plan tokens, odd blocks update the plan tokens from the
        statistics context. The plan-updated statistics token (at LLM dim)
        enters the final concat.

    Returns:
      (price_emb, updated_llm, llm_attention_mask)
        - price_emb: [B, 512] ('one' or cx=0), [B, llm_hidden_dim] ('bi')
        - updated_llm: None at cx=0; refined plan tokens (or, under
          unified_window_pool, the already-pooled [B, D] plan embedding —
          detected downstream by dim()==2)
        - llm_attention_mask: passed through
    """

    def __init__(self, regression_model, n_cross_layers=2, llm_hidden_dim=None,
                 n_heads=8, dropout_rate=0.1, cross_attn_direction='one',
                 unified_window_pool=False):
        super().__init__()
        assert cross_attn_direction in ('one', 'bi'), cross_attn_direction
        self.cross_attn_direction = cross_attn_direction
        # Unified per-window cross-attn pooling: the fusion runs on each sliding
        # window separately, then segment-means over the text's windows
        # (the cx=0 pooled embedding is the identity-blocks special case).
        self.unified_window_pool = bool(unified_window_pool)
        self.n_join_col = regression_model.n_join_col
        self.n_fanout = regression_model.n_fanout
        self.n_table = regression_model.n_table
        self.n_filter_col = regression_model.n_filter_col
        self.hist_dim = regression_model.hist_dim
        self.table_dim = regression_model.table_dim
        self.dropout_rate = regression_model.dropout_rate

        # Canon core layers (shared with the concat/mode-7 path).
        self.scale_embedding = regression_model.scale_embedding
        self.filter_embedding = regression_model.filter_embedding
        self.scale_encoder = regression_model.scale_encoder
        self.filter_encoder = regression_model.filter_encoder
        self.len_net = regression_model.len_net
        self.elu = regression_model.elu
        # OR-Transformer: aggregates per-AND-clause CLS tokens for multi-clause DNF.
        # Constructed by RegressionModel when any PRICE_N flag is on
        # (`use_or_transformer=True`), left as None otherwise. forward() calls it
        # when `num_clauses` is provided (i.e., the dataset emitted per-clause
        # features under --price_n_or). For K=1 (single-clause), the
        # OR-Transformer runs degenerately on a length-1 sequence.
        self.or_transformer = getattr(regression_model, 'or_transformer', None)

        self.n_cross_layers = int(n_cross_layers)
        # Always reuse regression_model.linear (272 → 512). The statistics
        # embedding is 512-d in every configuration, so pretrained PRICE
        # weights load without shape surgery.
        self.linear = regression_model.linear
        self.price_output_dim = self.linear.out_features

        self.stat_proj = None
        self.cross_attn_blocks = nn.ModuleList([])
        if self.n_cross_layers > 0:
            assert llm_hidden_dim is not None, "llm_hidden_dim required for cross-attn"
            # The paper's W_s: map the 512-d statistics embedding to the LLM
            # hidden dim so it can serve as cross-attention context.
            self.stat_proj = nn.Linear(self.linear.out_features, llm_hidden_dim)
            self.cross_attn_blocks = nn.ModuleList([
                PlanCrossAttentionBlock(llm_hidden_dim, n_heads, dropout_rate)
                for _ in range(self.n_cross_layers)
            ])
            for i, block in enumerate(self.cross_attn_blocks):
                if self.cross_attn_direction == 'one':
                    # Every block updates the plan tokens; zero-init all of them
                    # so fusion starts as an exact identity (soft warmup).
                    _zero_init_block(block)
                elif i % 2 == 1:
                    # 'bi': only the plan-updating (odd) blocks start as identity.
                    _zero_init_block(block)
            if self.cross_attn_direction == 'bi':
                # The plan-updated statistics token (at LLM dim) is concatenated.
                self.price_output_dim = llm_hidden_dim

    def cross_attn_parameters(self):
        """Parameters of the fusion (stat_proj + all cross-attn blocks)."""
        if self.stat_proj is not None:
            yield from self.stat_proj.parameters()
        yield from self.cross_attn_blocks.parameters()

    def price_core_parameters(self):
        """Canon-core parameters (everything except the fusion)."""
        cross_attn_ids = {id(p) for p in self.cross_attn_parameters()}
        for p in self.parameters():
            if id(p) not in cross_attn_ids:
                yield p

    def forward(self, x, padding_mask, n_join_col, n_fanout, n_table, n_filter_col,
                llm_hidden_states=None, llm_attention_mask=None, num_clauses=None,
                per_window=None):
        # Canon pipeline (always). When num_clauses is provided, x has shape
        # (batch * max_clauses, flat_features); we run scale+filter per clause,
        # then OR-Transformer aggregates the per-clause CLS tokens into a single
        # query-level embedding. When num_clauses is None, behavior is unchanged
        # (single-clause path, OR-Transformer not invoked).
        scale_features = self.scale_embedding(x)
        masks1 = padding_mask[:, :1 + self.n_join_col + self.n_fanout] if padding_mask is not None else None
        scaling_output = self.scale_encoder(scale_features, masks1)
        filter_features = self.filter_embedding(scaling_output, x)
        masks2 = padding_mask[:, :] if padding_mask is not None else None
        filtering_output = self.filter_encoder(filter_features, masks2)
        per_clause_emb = filtering_output[:, 0, :]

        if num_clauses is not None and self.or_transformer is not None:
            # Multi-clause: unfold the clause axis, build the clause padding
            # mask, run OR-Transformer, take CLS-only output.
            per_clause_emb, clause_mask = reshape_clauses(per_clause_emb, num_clauses)
            query_output = self.or_transformer(per_clause_emb, clause_mask)
        else:
            query_output = per_clause_emb

        len_features = torch.cat([n_join_col, n_fanout, n_table, n_filter_col], dim=1)
        len_features = self.len_net(len_features)

        stat_512 = self.linear(torch.cat([query_output, len_features], dim=1))
        stat_512 = self.elu(stat_512)
        stat_512 = F.dropout(stat_512, p=self.dropout_rate, training=self.training)

        if self.n_cross_layers == 0:
            return stat_512, None, None

        # Project to LLM dim; length-1 context token for the plan tokens.
        stat_ctx = self.stat_proj(stat_512).unsqueeze(1)   # [B, 1, D_llm]
        stat_mask = torch.ones(stat_ctx.size(0), 1, device=stat_ctx.device, dtype=torch.long)

        # UNIFIED per-window fusion: run the fusion on EACH sliding window
        # separately (batched over windows), then segment-mean over each text's
        # windows. The LLM half is F.normalize'd per window BEFORE the mean, so
        # identity blocks reduce exactly to the cx=0 pooled embedding.
        if self.unified_window_pool and per_window is not None:
            all_hs, all_masks, win_owner, B = per_window
            ctx_w = stat_ctx[win_owner]                    # [Nw, 1, D_llm]
            cmask_w = torch.ones(ctx_w.size(0), 1, device=ctx_w.device, dtype=torch.long)
            llm_w = all_hs.float()                         # [Nw, T_pad, D_llm]
            if self.cross_attn_direction == 'one':
                for block in self.cross_attn_blocks:
                    llm_w = block(llm_w, ctx_w, cmask_w)
            else:
                for i, block in enumerate(self.cross_attn_blocks):
                    if i % 2 == 0:   # statistics context attends to this window's plan tokens
                        ctx_w = block(ctx_w, llm_w, all_masks)
                    else:            # plan tokens attend to the statistics context
                        llm_w = block(llm_w, ctx_w, cmask_w)
            llm_emb = _segment_mean(F.normalize(llm_w[:, 0, :], p=2, dim=1), win_owner, B)
            if self.cross_attn_direction == 'one':
                price_emb = stat_512                       # never altered by the plan
            else:
                price_emb = _segment_mean(ctx_w[:, 0, :], win_owner, B)
            return price_emb, llm_emb, None

        updated_llm = None
        if llm_hidden_states is not None:
            llm_tokens = llm_hidden_states.float()
            if self.cross_attn_direction == 'one':
                for block in self.cross_attn_blocks:
                    llm_tokens = block(llm_tokens, stat_ctx, stat_mask)
                updated_llm = llm_tokens
            else:
                ctx = stat_ctx
                any_llm_update = False
                for i, block in enumerate(self.cross_attn_blocks):
                    if i % 2 == 0:
                        ctx = block(ctx, llm_tokens, llm_attention_mask)
                    else:
                        llm_tokens = block(llm_tokens, ctx, stat_mask)
                        any_llm_update = True
                if any_llm_update:
                    updated_llm = llm_tokens
                stat_ctx = ctx

        if self.cross_attn_direction == 'one':
            price_output = stat_512                        # never altered by the plan
        else:
            price_output = stat_ctx[:, 0, :]
        return price_output, updated_llm, llm_attention_mask


# ─── Joint model ─────────────────────────────────────────────────────────


class LLMPriceJointModel(nn.Module):
    """
    Joint model: LLM plan embedding + Canon statistics embedding --> MLP.

    The forward method receives a tuple:
      (texts, price_features, padding_mask, n_join_col, n_fanout, n_table, n_filter_col)
    plus an optional trailing num_clauses tensor (under --price_n_or).
    """

    def __init__(self, llm, price_embedder, llm_embed_size, price_embed_size, hid_units):
        """
        Args:
            llm: QueryPlanPredictor (with LoRA) that takes text and returns embeddings
            price_embedder: PRICEEmbedder instance (may have cross-attn enabled)
            llm_embed_size: LLM hidden dim
            price_embed_size: legacy default; ignored if price_embedder.price_output_dim is set
            hid_units: MLP hidden dimension
        """
        super().__init__()
        self.llm = llm
        self.price = price_embedder
        _pod = getattr(price_embedder, 'price_output_dim', price_embed_size)
        combined_dim = llm_embed_size + _pod
        from trainer import Prediction
        self.mlp = Prediction(combined_dim, hid_units)
        # Convenience flag: does the embedder do cross-attention (need LLM hidden states)?
        self.uses_cross_attn = getattr(price_embedder, 'n_cross_layers', 0) > 0

    def _select_llm_emb(self, pooled_emb, updated_llm):
        """LLM half fed to the joint MLP. Shared by forward() and
        forward_embeddings() so both stay consistent.

        --unified_window_pool returns the refined-and-window-meaned [B, D]
        plan embedding as `updated_llm` (dim==2) — detected here and used
        directly. Otherwise the refined CLS token is pooled the same way the
        cx=0 LLM forward pools (CLS + L2 normalize), keeping the embedding in
        the same space as the concat/mode-7 path."""
        if updated_llm is None:
            return pooled_emb
        if updated_llm.dim() == 2:
            # unified per-window path already returns the segment-mean-pooled [B,D]
            return updated_llm
        return F.normalize(updated_llm[:, 0, :], p=2, dim=1)

    def _llm_forward(self, texts):
        """Run the LLM. Returns (pooled_emb, hidden_states, attn_mask, per_window).
        Shared by forward() and forward_embeddings() so they stay consistent.
        - unified per-window: per_window=(all_hs, all_masks, win_owner, B); pooled_emb =
          segment-mean of per-window pooled (== legacy pooled_emb).
        - plain cross-attn: stitched hidden_states/attn_mask (per_window=None).
        - cx=0 / concat: cheap pooled forward."""
        if self.uses_cross_attn and getattr(self.price, 'unified_window_pool', False):
            all_pooled, all_hs, all_masks, win_owner, B = self.llm.forward_per_window(texts)
            pooled_emb = _segment_mean(all_pooled, win_owner, B)
            return pooled_emb, None, None, (all_hs, all_masks, win_owner, B)
        if self.uses_cross_attn:
            pooled_emb, hidden_states, attn_mask = self.llm.forward_with_sequence(texts)
            return pooled_emb, hidden_states, attn_mask, None
        return self.llm(texts), None, None, None

    def _unpack(self, x):
        """Unpack the collate tuple: base 7 elements + optional num_clauses."""
        num_clauses = None
        x = list(x)
        if len(x) == 8:
            num_clauses = x.pop()
        texts, price_features, padding_mask, n_join_col, n_fanout, n_table, n_filter_col = x
        return texts, price_features, padding_mask, n_join_col, n_fanout, n_table, n_filter_col, num_clauses

    def _forward_parts(self, x):
        texts, price_features, padding_mask, njc, nfo, ntb, nfc, num_clauses = self._unpack(x)

        pooled_emb, hidden_states, attn_mask, per_window = self._llm_forward(texts)
        if pooled_emb.dtype != torch.float32:
            pooled_emb = pooled_emb.float()

        price_emb, updated_llm, _ = self.price(
            price_features, padding_mask, njc, nfo, ntb, nfc,
            llm_hidden_states=hidden_states, llm_attention_mask=attn_mask,
            num_clauses=num_clauses, per_window=per_window,
        )
        llm_emb = self._select_llm_emb(pooled_emb, updated_llm)
        return llm_emb, price_emb

    def forward(self, x):
        llm_emb, price_emb = self._forward_parts(x)
        combined = torch.cat([llm_emb, price_emb], dim=1)
        return self.mlp(combined)

    @torch.no_grad()
    def forward_embeddings(self, x):
        """Return concat([llm_emb, price_emb]) without the final MLP head.
        Used by the retrain-MLP inference flow to cache features."""
        llm_emb, price_emb = self._forward_parts(x)
        return torch.cat([llm_emb, price_emb], dim=1)


class PRICEFinetunWrapper(nn.Module):
    """
    Wrapper for finetuning PRICE's RegressionModel on cardinality estimation.

    Accepts a tuple (price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs)
    or (price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs, num_clauses)
    and unpacks it for RegressionModel.forward().
    """

    def __init__(self, regression_model):
        super().__init__()
        self.model = regression_model

    def forward(self, x):
        if len(x) == 8:
            price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs, num_clauses = x
            return self.model(price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs,
                              num_clauses=num_clauses)
        price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs = x
        return self.model(price_feats, pg_est_cards, pad_masks, njcs, nfos, ntbs, nfcs)


# ==========================================================================
# ===== section: price_embedder_factory.py (merged) =====
# ==========================================================================
# Build mode-7's cx=0 PRICEEmbedder. Extracted from train.py so the LLM path
# and the baselines (--baseline_price_concat) construct the identical embedder.

# Make the repo root importable so the PRICE and canon packages resolve,
# regardless of whether this module is imported from experiments/ or the
# repo root.



def _price_dims(argsP, bin_size):
    """Return (filter_dim, fanout_dim, pairwise_intra_dim) per active flags.

    NOTE: Sql2FeatureN always emits 75-dim filter and 42-dim fanout tokens
    regardless of which PRICE_N sub-flag is set. So if any PRICE_N flag is
    on, both dims must use Sql2FeatureN's shape — the sub-flags only gate
    which atoms are populated, not the token shape.

    (Copy of train.py:_price_dims, kept here to avoid importing train.py — which
    runs the whole training script at import time. Must stay logic-identical.)
    """
    use_price_n = any([
        getattr(argsP, "price_n_filter", False),
        getattr(argsP, "price_n_fanout", False),
        getattr(argsP, "price_n_pairwise", False),
        getattr(argsP, "price_n_parsing", False),
    ])
    if use_price_n:
        filter_dim = bin_size + 3 * 11 + 2          # 75
        fanout_dim = bin_size + 2                   # 42
    else:
        filter_dim = bin_size + 3                   # 43 (PRICE_S or base PRICE)
        fanout_dim = bin_size                       # 40

    pairwise_intra_dim = (64 + 2 * 3) if getattr(argsP, "price_n_pairwise", False) else 0   # 70
    return filter_dim, fanout_dim, pairwise_intra_dim



def build_price_embedder(argsP, device, return_price_model=False):
    """Return (price_embedder, price_output_dim). cx=0 -> price_output_dim == 512
    (or argsP.price_output_dim override). Reuses --price_model_path /
    --price_bin_size / --price_n* / --price_random_init exactly like mode 7.

    With return_price_model=True, returns (price_embedder, price_output_dim,
    price_model) instead. train.py's llm_price_finetune block needs the same
    RegressionModel instance to seed its cross-attn embedders, so it uses this
    form; the byte-identical (price_model, price_embedder) pair it gets is the
    same one the original inline code produced."""
    # Load pretrained PRICE model (skip if random init)
    price_state_dict = None
    if not getattr(argsP, 'price_random_init', False):
      price_state_dict = torch.load(argsP.price_model_path, map_location=device)
      # Strip DataParallel 'module.' prefix
      price_state_dict = {k.replace('module.', ''): v for k, v in price_state_dict.items()}

    # Build PRICE RegressionModel with correct dimensions
    max_njc = argsP.price_max_n_join_col
    max_nfo = argsP.price_max_n_fanout
    max_ntb = argsP.price_max_n_table
    max_nfc = argsP.price_max_n_filter_col
    bin_size = getattr(argsP, 'price_bin_size', 40)
    table_dim = 4
    filter_dim, fanout_dim, pairwise_intra_dim = _price_dims(argsP, bin_size)

    _price_n_embd = getattr(argsP, 'price_n_embd', 256)
    _price_n_heads = getattr(argsP, 'price_n_heads', 8)
    _price_ffn_ratio = getattr(argsP, 'price_ffn_ratio', 4.0)
    _use_or_transformer = any([
        getattr(argsP, "price_n_pairwise", False),
        getattr(argsP, "price_n_filter", False),
        getattr(argsP, "price_n_fanout", False),
        getattr(argsP, "price_n_parsing", False),
    ]) and not getattr(argsP, "no_or_transformer", False)
    # Pick query_hidden_dim so PRICEEmbedder can always reuse regression_model.linear
    # (no spurious nn.Linear in PRICEEmbedder.__init__, which would shift RNG state).
    # The statistics embedding is ALWAYS 512-d; cross-attention variants project it
    # to the LLM hidden dim inside PRICEEmbedder (stat_proj, the paper's W_s).
    _pod = int(getattr(argsP, 'price_output_dim', 0) or 0)
    _query_hidden_dim = _pod if _pod > 0 else 512
    price_model = RegressionModel(
        n_join_col=max_njc, n_fanout=max_nfo, n_table=max_ntb, n_filter_col=max_nfc,
        n_pairwise_intra=getattr(argsP, "price_max_n_pairwise_intra", 8)
                          if getattr(argsP, "price_n_pairwise", False) else 0,
        hist_dim=bin_size, table_dim=table_dim, filter_dim=filter_dim,
        fanout_dim=fanout_dim, pairwise_intra_dim=pairwise_intra_dim,
        query_hidden_dim=_query_hidden_dim, final_hidden_dim=1024, output_dim=1,
        n_embd=_price_n_embd, n_layers=getattr(argsP, 'price_n_layers', 6), n_heads=_price_n_heads,
        dropout_rate=0.1, ffn_ratio=_price_ffn_ratio,
        use_or_transformer=_use_or_transformer,
        or_n_layers=getattr(argsP, "or_n_layers", 1),
        or_n_heads=getattr(argsP, "or_n_heads", 4),
        or_ffn_ratio=getattr(argsP, "or_ffn_ratio", 1.0),
    )
    # Load weights with partial init for dimension-extended variants (histogram bins shared, operator dims differ)
    def _load_price_sd(model, ckpt_sd, label=""):
        """Load checkpoint into PRICE model with partial init for size-mismatched weights.
        For filter_embeddings.weight [n_embd,43]->[n_embd,61], copies the first min(43,61)
        columns (histogram bins) and leaves the rest randomly initialized."""
        model_sd = model.state_dict()
        for k, v in ckpt_sd.items():
            if k not in model_sd:
                continue
            if model_sd[k].shape == v.shape:
                model_sd[k] = v
            elif model_sd[k].dim() == v.dim():
                slices = tuple(slice(0, min(ms, vs)) for ms, vs in zip(model_sd[k].shape, v.shape))
                model_sd[k][slices] = v[slices]
                print(f"  Partial init {k}: copied {[s.stop for s in slices]} of {list(model_sd[k].shape)} from checkpoint {list(v.shape)}")
        model.load_state_dict(model_sd)
        if label:
            print(label)

    if getattr(argsP, 'price_random_init', False):
      print("[PRICE] Random initialization (skipping pretrained weights)")
    else:
      _load_price_sd(price_model, price_state_dict, f"Loaded PRICE weights from {argsP.price_model_path}")

    price_embedder = PRICEEmbedder(price_model, n_cross_layers=0)
    price_embedder.to(device)
    price_output_dim = getattr(price_embedder, 'price_output_dim', 512)
    if return_price_model:
        return price_embedder, price_output_dim, price_model
    return price_embedder, price_output_dim


# ==========================================================================
# ===== section: price_data_utils.py (merged) =====
# ==========================================================================
# PRICE data pipeline utilities for Joint LLM+PRICE finetuning.
#
# Handles:
# - Extracting raw SQL from queries/ workload SQL files
# - Transforming SQL to PRICE-compatible alias format
# - Flattening CTEs, VIEWs, and subqueries for PRICE compatibility
# - Extracting pg_est_card from query plan JSON
# - Generating PRICE features (Sql2Feature)
# - Padding and caching features

try:
    import sqlglot
    from sqlglot import exp as sqlglot_exp
    HAS_SQLGLOT = True
except ImportError:
    HAS_SQLGLOT = False

# Make the repo root importable (canon + PRICE packages),
# (bundled with the repository).
# Make the repo root importable so the PRICE and canon packages resolve.

def _get_stats_dir(db_name: str) -> str:
    """Return the statistics directory for a given database. The per-workload
    statistics ship in-repo under canon/statistics/ (the layout both the
    Canon and vendored PRICE feature extractors read from)."""
    return os.path.join(REPO_ROOT, "canon", "statistics", db_name)

logger = logging.getLogger("main_logger")

# Column prefix → table name for bare column resolution in TPC-H/DS queries
# Sorted by prefix length (longest first) to avoid partial matches
_TPCH_COL_PREFIX = [
    ('ps_', 'partsupp'),
    ('c_', 'customer'),
    ('o_', 'orders'),
    ('l_', 'lineitem'),
    ('p_', 'part'),
    ('s_', 'supplier'),
    ('n_', 'nation'),
    ('r_', 'region'),
]

_TPCDS_COL_PREFIX = [
    ('inv_', 'inventory'),
    ('web_', 'web_site'),
    ('ss_', 'store_sales'),
    ('sr_', 'store_returns'),
    ('cs_', 'catalog_sales'),
    ('cr_', 'catalog_returns'),
    ('ws_', 'web_sales'),
    ('wr_', 'web_returns'),
    ('ca_', 'customer_address'),
    ('cd_', 'customer_demographics'),
    ('hd_', 'household_demographics'),
    ('wp_', 'web_page'),
    ('cp_', 'catalog_page'),
    ('cc_', 'call_center'),
    ('ib_', 'income_band'),
    ('sm_', 'ship_mode'),
    ('c_', 'customer'),
    ('d_', 'date_dim'),
    ('t_', 'time_dim'),
    ('i_', 'item'),
    ('s_', 'store'),
    ('w_', 'warehouse'),
    ('p_', 'promotion'),
    ('r_', 'reason'),
]


def extract_residual_sql_n(sql):
    """Extract SQL fragments that Sql2FeatureN cannot encode into stat-core.

    Returns a string concatenating residual predicates (and other opaque
    fragments) with ' AND '. Returns '' if nothing is residual.

    Residual = LIKE / ILIKE (and negations), EXISTS / NOT EXISTS,
    IN (subquery), scalar subqueries, and any other expression the AST
    walker can't tag as a stat-core atom (custom functions, regex, CAST
    on the right side, etc.).

    Heuristic helper that isolates the SQL fragments the statistics
    interfaces cannot ground (the LLM still reads them from the plan text).
    False negatives degrade quietly; false positives are harmless.
    """
    try:
        import sqlglot
        from sqlglot import expressions as exp
    except ImportError:
        return ''
    try:
        ast = sqlglot.parse_one(sql, read='postgres')
    except Exception:
        return ''
    if ast is None:
        return ''
    wh = ast.find(exp.Where)
    if wh is None:
        return ''

    out_parts = []

    def _is_residual(node):
        if isinstance(node, (exp.Like, exp.ILike)):
            return True
        if isinstance(node, exp.Exists):
            return True
        if isinstance(node, exp.In):
            # IN-subquery
            q = node.args.get('query')
            if q is not None:
                return True
        if isinstance(node, exp.Not):
            inner = node.this
            if isinstance(inner, (exp.Like, exp.ILike, exp.Exists)):
                return True
            if isinstance(inner, exp.In) and inner.args.get('query') is not None:
                return True
        # Comparison with scalar subquery on either side
        if isinstance(node, (exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE)):
            for key in ('this', 'expression'):
                child = node.args.get(key)
                if isinstance(child, exp.Subquery):
                    return True
        return False

    def _walk(node):
        if node is None:
            return
        if _is_residual(node):
            out_parts.append(node.sql(dialect='postgres'))
            return
        for k, child in node.args.items():
            if isinstance(child, list):
                for c in child:
                    if hasattr(c, 'args'):
                        _walk(c)
            elif hasattr(child, 'args'):
                _walk(child)

    _walk(wh.this)
    # Dedup while preserving order.
    seen = set()
    uniq = []
    for p in out_parts:
        if p not in seen:
            seen.add(p)
            uniq.append(p)
    return ' AND '.join(uniq)


def compute_residual_texts(sql_list):
    """Vectorised wrapper around extract_residual_sql_n. Returns one residual
    string per SQL (empty string when nothing residual)."""
    return [extract_residual_sql_n(sql) for sql in sql_list]


def extract_raw_sql(sql_file):
    """
    Parse queries/{workload}.sql and extract raw SQL strings.

    Handles three formats:
      Format A (2-line): EXPLAIN ... \\n SELECT ... ;  -- label: <value>
      Format B (1-line): EXPLAIN ... SELECT ... ;
      Format C (multiline): EXPLAIN ... \\n select\\n  col,\\n  ...\\nfrom\\n  ...;

    Returns list of raw SQL strings (without EXPLAIN prefix).
    """
    EXPLAIN_PREFIX = "EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)"

    with open(sql_file, "r") as f:
        content = f.read()

    # Extract CREATE VIEW revenue0 definitions with date filters (TPC-H Q15).
    # Each Q15 instance has: drop view revenue0; create or replace view revenue0 ...
    #   l_shipdate >= date 'YYYY-MM-DD' ... ; EXPLAIN (...) select ... from supplier, revenue0 ...
    # We capture the start date from each CREATE VIEW to attach to the following query.
    revenue0_views = []  # list of (position_in_content, start_date_str)
    for vm in re.finditer(
        r"create\s+or\s+replace\s+view\s+revenue0\b[^;]*?"
        r"l_shipdate\s*>=\s*date\s+'(\d{4}-\d{2}-\d{2})'",
        content, re.IGNORECASE
    ):
        revenue0_views.append((vm.start(), vm.group(1)))

    # Split on EXPLAIN prefix to get each query block
    parts = re.split(r'(?=EXPLAIN\s*\(FORMAT\s+JSON)', content, flags=re.IGNORECASE)

    # Track character positions of each part for matching to CREATE VIEW positions
    part_starts = []
    pos = 0
    for part in parts:
        part_starts.append(pos)
        pos += len(part)

    sql_list = []
    for i, part in enumerate(parts):
        part = part.strip()
        if not part.upper().startswith("EXPLAIN"):
            continue

        # Remove EXPLAIN prefix
        m = re.match(r'EXPLAIN\s*\(FORMAT\s+JSON[^)]*\)\s*', part, re.IGNORECASE)
        if not m:
            continue
        sql_text = part[m.end():]

        # Find end of SQL: first semicolon at a non-quoted position
        depth = 0
        in_quote = False
        end_pos = len(sql_text)
        for j, ch in enumerate(sql_text):
            if in_quote:
                if ch == "'":
                    in_quote = False
            else:
                if ch == "'":
                    in_quote = True
                elif ch == ';':
                    end_pos = j
                    break

        sql_text = sql_text[:end_pos].strip()

        # Remove trailing comment "-- label: ..."
        # Only strip if it's at the end (not inside the SQL)
        lines = sql_text.split('\n')
        if lines and '--' in lines[-1]:
            lines[-1] = lines[-1][:lines[-1].rfind('--')].strip()
        sql_text = ' '.join(l.strip() for l in lines if l.strip())

        # Attach revenue0 date filters from preceding CREATE VIEW (Q15)
        if sql_text and 'revenue0' in sql_text.lower() and revenue0_views:
            cur_pos = part_starts[i]
            # Find the latest CREATE VIEW before this EXPLAIN
            best_date = None
            for vpos, vdate in revenue0_views:
                if vpos < cur_pos:
                    best_date = vdate
            if best_date:
                # Compute end date = start + 3 months
                y, mo, d = int(best_date[:4]), int(best_date[5:7]), int(best_date[8:10])
                mo += 3
                if mo > 12:
                    mo -= 12
                    y += 1
                end_date = f"{y:04d}-{mo:02d}-{d:02d}"
                sql_text = f"-- REVENUE0_DATES: {best_date} {end_date}\n{sql_text}"

        if sql_text:
            sql_list.append(sql_text)

    return sql_list


def _load_abbrev_mapping(db_name, bin_size=40):
    """
    Load the abbreviation mapping from PRICE statistics.
    Returns dict: {full_table_name: price_alias} e.g. {'title': 'imdb_t'}
    """
    stats_dir = _get_stats_dir(db_name)
    abbrev_path = os.path.join(stats_dir, "abbrev_col_type.pkl")
    with open(abbrev_path, "rb") as f:
        data = pickle.load(f)
    return data["abbrev"]  # e.g. {'title': 'imdb_t', 'movie_info': 'imdb_mi', ...}


# --- Statistics cache for scalar subquery estimation ---
_histogram_cache = {}


def _load_histogram_stats(db_name):
    """Load histogram statistics for aggregate estimation."""
    if db_name in _histogram_cache:
        return _histogram_cache[db_name]
    stats_dir = _get_stats_dir(db_name)
    hist_path = os.path.join(stats_dir, "histogram40.pkl")
    if os.path.exists(hist_path):
        with open(hist_path, "rb") as f:
            hist = pickle.load(f)
        _histogram_cache[db_name] = hist
        return hist
    _histogram_cache[db_name] = {}
    return {}


def _estimate_aggregate_value(db_name, col_name, agg_func):
    """
    Estimate the result of an aggregate function using histogram statistics.

    For SUM, estimates per-group value (suitable for correlated subqueries)
    using histogram mean * estimated group size.

    Returns estimated float value, or None if column not found.
    """
    hist = _load_histogram_stats(db_name)
    col_lower = col_name.lower()

    # Search all tables for this column
    for table_alias, cols in hist.items():
        if col_lower in cols:
            col_stats = cols[col_lower]
            min_val = float(col_stats.get('min_value', 0))
            max_val = float(col_stats.get('max_value', 0))
            total_rows = float(col_stats.get('len', 1))

            # Compute mean from histogram if available
            hist_arr = col_stats.get('hist', None)
            edges = col_stats.get('bin_edges', None)
            if hist_arr is not None and edges is not None and len(hist_arr) > 0 and len(edges) > 1:
                bin_centers = [(float(edges[i]) + float(edges[i+1])) / 2 for i in range(len(hist_arr))]
                hist_total = sum(hist_arr)
                mean = sum(c * h for c, h in zip(bin_centers, hist_arr)) / hist_total if hist_total > 0 else (min_val + max_val) / 2.0
            else:
                mean = (min_val + max_val) / 2.0

            if agg_func == 'MIN':
                return min_val
            elif agg_func == 'MAX':
                return max_val
            elif agg_func == 'AVG':
                return mean
            elif agg_func == 'COUNT':
                return total_rows
            elif agg_func == 'SUM':
                # Estimate per-group SUM for correlated subqueries
                # group_size heuristic: total_rows^0.25 (geometric mean of 1 and sqrt)
                group_size = max(1.0, total_rows ** 0.25)
                return mean * group_size
    return None


def _convert_timestamps_to_epoch(sql):
    """
    Convert PostgreSQL timestamp/date literals to epoch seconds so PRICE can parse them as floats.

    Handles formats like:
    - '2014-09-04 23:10:09'::timestamp
    - CAST('2014-09-04 23:10:09' AS TIMESTAMP)
    - date '1995-03-17'
    - date '1993-01-01' + interval '1 year'
    - date '1998-12-01' - interval '68 days'
    """
    from datetime import datetime, timedelta
    import calendar

    def _ts_to_epoch(match):
        ts_str = match.group(1)
        try:
            dt = datetime.strptime(ts_str, "%Y-%m-%d %H:%M:%S")
            return str(int(dt.timestamp()))
        except ValueError:
            try:
                dt = datetime.strptime(ts_str, "%Y-%m-%d")
                return str(int(dt.timestamp()))
            except ValueError:
                return match.group(0)  # Can't parse, keep original

    def _add_interval(dt, num, unit):
        """Add an interval to a datetime, handling months/years."""
        unit = unit.lower().rstrip('s')
        if unit == 'day':
            return dt + timedelta(days=num)
        elif unit == 'month':
            month = dt.month + num
            year = dt.year + (month - 1) // 12
            month = (month - 1) % 12 + 1
            max_day = calendar.monthrange(year, month)[1]
            return dt.replace(year=year, month=month, day=min(dt.day, max_day))
        elif unit == 'year':
            try:
                return dt.replace(year=dt.year + num)
            except ValueError:
                return dt.replace(year=dt.year + num, day=28)
        return dt

    def _date_interval_to_epoch(match):
        date_str = match.group(1)
        op = match.group(2)
        num = int(match.group(3))
        unit = match.group(4)
        try:
            dt = datetime.strptime(date_str, "%Y-%m-%d")
            if op == '-':
                num = -num
            result = _add_interval(dt, num, unit)
            return str(int(result.timestamp()))
        except (ValueError, OverflowError):
            return match.group(0)

    # Match '...'::timestamp (PostgreSQL cast syntax)
    sql = re.sub(r"'(\d{4}-\d{2}-\d{2}[\s\d:]*)'::timestamp", _ts_to_epoch, sql, flags=re.IGNORECASE)
    # Match CAST('...' AS TIMESTAMP)
    sql = re.sub(r"CAST\('(\d{4}-\d{2}-\d{2}[\s\d:]*)'\s+AS\s+TIMESTAMP\)", _ts_to_epoch, sql, flags=re.IGNORECASE)
    # Match date '...' +/- interval '...' (MUST be before standalone date pattern)
    sql = re.sub(
        r"date\s+'(\d{4}-\d{2}-\d{2})'\s*([+-])\s*interval\s+'(\d+)\s+(\w+)'",
        _date_interval_to_epoch, sql, flags=re.IGNORECASE
    )

    # Match CAST('...' AS DATE) +/- N (TPC-DS pattern: integer days added to date)
    def _cast_date_plus_int(match):
        date_str = match.group(1)
        op = match.group(2)
        days = int(match.group(3))
        try:
            dt = datetime.strptime(date_str, "%Y-%m-%d")
            if op == '-':
                days = -days
            result = dt + timedelta(days=days)
            return str(int(result.timestamp()))
        except (ValueError, OverflowError):
            return match.group(0)

    # [BISECTION REVERT] Reverted to the unbalanced-paren regex.
    sql = re.sub(
        r"\(?cast\s*\(\s*'(\d{4}-\d{1,2}-\d{1,2})'\s+as\s+date\s*\)\s*\)?\s*([+-])\s*(\d+)",
        _cast_date_plus_int, sql, flags=re.IGNORECASE
    )

    # Match standalone CAST('...' AS DATE) without arithmetic
    def _cast_date_to_epoch(match):
        date_str = match.group(1)
        try:
            dt = datetime.strptime(date_str, "%Y-%m-%d")
            return str(int(dt.timestamp()))
        except ValueError:
            return match.group(0)

    sql = re.sub(
        r"cast\s*\(\s*'(\d{4}-\d{1,2}-\d{1,2})'\s+as\s+date\s*\)",
        _cast_date_to_epoch, sql, flags=re.IGNORECASE
    )

    # Match standalone date '...' (TPC-H/DS style date literals)
    sql = re.sub(r"\bdate\s+'(\d{4}-\d{2}-\d{2})'", _ts_to_epoch, sql, flags=re.IGNORECASE)
    return sql


def _strip_trailing_clauses(where_clause):
    """Strip GROUP BY, ORDER BY, LIMIT, HAVING from end of WHERE clause (top-level only)."""
    keywords = ['group by', 'order by', 'limit ', 'having ']
    lower = where_clause.lower()
    depth = 0
    for i, char in enumerate(where_clause):
        if char == '(':
            depth += 1
        elif char == ')':
            depth -= 1
        elif depth == 0:
            for kw in keywords:
                if lower[i:i + len(kw)] == kw:
                    # Check word boundary: not preceded by alphanumeric
                    if i > 0 and lower[i - 1].isalnum():
                        continue
                    return where_clause[:i].strip()
    return where_clause


# ============================================================================
# SQL FLATTENING: CTEs, VIEWs, subqueries-in-FROM → flat PRICE SQL
# ============================================================================

# TPC-H Q15: VIEW revenue0 reference body (for documentation only).
# Dates are now extracted from CREATE VIEW statements by extract_raw_sql()
# and attached as -- REVENUE0_DATES comments, then used by _flatten_revenue0_query().


def _flatten_and(node, results):
    """Recursively flatten nested AND / Paren nodes into a flat list."""
    if isinstance(node, sqlglot_exp.Paren):
        _flatten_and(node.this, results)
    elif isinstance(node, sqlglot_exp.And):
        _flatten_and(node.left, results)
        _flatten_and(node.right, results)
    else:
        results.append(node)


def _date_to_epoch_days(date_str):
    """Parse 'YYYY-MM-DD' to days since 1970-01-01."""
    import datetime
    try:
        d = datetime.date.fromisoformat(date_str)
        return (d - datetime.date(1970, 1, 1)).days
    except Exception:
        return None


def _normalize_date_literals(ast):
    """Replace DATE/TIMESTAMP literals (and DATE +/- INTERVAL N DAY) on the
    RHS of comparisons with the integer days-since-epoch they represent.

    Mutates the AST in place.
    """
    if not HAS_SQLGLOT:
        return

    def _date_value_of(node):
        """Return integer days, or None if the node isn't a recognized date."""
        # DATE 'YYYY-MM-DD' literal — sqlglot wraps in Cast(to=DataType(DATE))
        if isinstance(node, sqlglot_exp.Cast) and \
           isinstance(node.to, sqlglot_exp.DataType) and \
           node.to.this.value.upper() in ("DATE", "TIMESTAMP"):
            inner = node.this
            if isinstance(inner, sqlglot_exp.Literal) and inner.is_string:
                return _date_to_epoch_days(str(inner.name))
        # Bare string literal fallback
        if isinstance(node, sqlglot_exp.Literal) and node.is_string:
            return _date_to_epoch_days(str(node.name))
        return None

    def _interval_days(node):
        """Return integer days for `INTERVAL 'N' DAY`-style nodes, else None."""
        if isinstance(node, sqlglot_exp.Interval):
            try:
                n = int(str(node.this.name) if hasattr(node.this, "name")
                        else str(node.this))
                unit = str(node.unit).upper() if node.unit else ""
                if unit.startswith("DAY"):
                    return n
            except Exception:
                return None
        return None

    for cmp_cls in (sqlglot_exp.EQ, sqlglot_exp.NEQ,
                    sqlglot_exp.LT, sqlglot_exp.LTE,
                    sqlglot_exp.GT, sqlglot_exp.GTE):
        for cmp in list(ast.find_all(cmp_cls)):
            rhs = cmp.expression
            replaced = None
            v = _date_value_of(rhs)
            if v is not None:
                replaced = v
            elif isinstance(rhs, (sqlglot_exp.Sub, sqlglot_exp.Add)):
                base = _date_value_of(rhs.this)
                offset = _interval_days(rhs.expression)
                if base is not None and offset is not None:
                    replaced = base + (offset if isinstance(rhs, sqlglot_exp.Add)
                                       else -offset)
            if replaced is not None:
                cmp.set("expression", sqlglot_exp.Literal.number(replaced))


def _push_not_to_nnf(ast):
    """Rewrite the AST so every Not wraps a leaf. De Morgan + operator flip.

    Mutates the AST in place. Returns nothing.

    Handles:
      - NOT (a AND b) → (NOT a) OR (NOT b)
      - NOT (a OR b)  → (NOT a) AND (NOT b)
      - NOT NOT x      → x
      - NOT (x op y)   → flipped operator (= ↔ !=, < ↔ >=, etc.)
      - NOT (x IS NULL) → x IS NOT NULL
      - NOT (x IS NOT NULL) → x IS NULL
      - NOT (col BETWEEN low AND high) → col < low OR col > high
      - NOT col IN (v1, v2, ...) → col != v1 AND col != v2 AND ...
        (value-list IN only; subquery IN is preserved as residual)
      - NOT (x LIKE p), NOT (x IN(subquery)) → preserved.
    """
    if not HAS_SQLGLOT:
        return
    _OP_FLIP = {
        sqlglot_exp.EQ:  sqlglot_exp.NEQ,
        sqlglot_exp.NEQ: sqlglot_exp.EQ,
        sqlglot_exp.LT:  sqlglot_exp.GTE,
        sqlglot_exp.LTE: sqlglot_exp.GT,
        sqlglot_exp.GT:  sqlglot_exp.LTE,
        sqlglot_exp.GTE: sqlglot_exp.LT,
    }
    def _unwrap_paren(node):
        """Recursively strip Paren wrappers."""
        while isinstance(node, sqlglot_exp.Paren):
            node = node.this
        return node

    changed = True
    while changed:
        changed = False
        for not_node in list(ast.find_all(sqlglot_exp.Not)):
            child = _unwrap_paren(not_node.this)
            if child is None:
                continue
            if isinstance(child, sqlglot_exp.Not):
                not_node.replace(child.this.copy())
                changed = True
                continue
            if isinstance(child, sqlglot_exp.And):
                lhs = sqlglot_exp.Not(this=child.this.copy())
                rhs = sqlglot_exp.Not(this=child.expression.copy())
                not_node.replace(sqlglot_exp.Or(this=lhs, expression=rhs))
                changed = True
                continue
            if isinstance(child, sqlglot_exp.Or):
                lhs = sqlglot_exp.Not(this=child.this.copy())
                rhs = sqlglot_exp.Not(this=child.expression.copy())
                not_node.replace(sqlglot_exp.And(this=lhs, expression=rhs))
                changed = True
                continue
            cls = type(child)
            if cls in _OP_FLIP:
                flipped = _OP_FLIP[cls](
                    this=child.this.copy(),
                    expression=child.expression.copy())
                not_node.replace(flipped)
                changed = True
                continue
            if isinstance(child, sqlglot_exp.Is):
                # IS NULL / IS NOT NULL are represented as Is(Null) / Is(Not Null)
                inner = child.expression
                if isinstance(inner, sqlglot_exp.Null):
                    not_node.replace(sqlglot_exp.Is(
                        this=child.this.copy(),
                        expression=sqlglot_exp.Not(this=sqlglot_exp.Null())))
                    changed = True
                    continue
                if isinstance(inner, sqlglot_exp.Not) and isinstance(inner.this, sqlglot_exp.Null):
                    not_node.replace(sqlglot_exp.Is(
                        this=child.this.copy(),
                        expression=sqlglot_exp.Null()))
                    changed = True
                    continue
            # NOT (col BETWEEN low AND high) → col < low OR col > high
            if isinstance(child, sqlglot_exp.Between):
                col = child.this
                low = child.args.get('low')
                high = child.args.get('high')
                if col is not None and low is not None and high is not None:
                    lt = sqlglot_exp.LT(this=col.copy(), expression=low.copy())
                    gt = sqlglot_exp.GT(this=col.copy(), expression=high.copy())
                    not_node.replace(sqlglot_exp.Or(this=lt, expression=gt))
                    changed = True
                    continue

            # NOT col IN (v1, v2, ...) → col != v1 AND col != v2 AND ...
            # Only expand value-list IN; subquery IN is residual.
            if isinstance(child, sqlglot_exp.In) and child.args.get('query') is None:
                col = child.this
                values = child.expressions
                if col is not None and values:
                    atoms = [sqlglot_exp.NEQ(this=col.copy(), expression=v.copy())
                             for v in values]
                    result = atoms[0]
                    for a in atoms[1:]:
                        result = sqlglot_exp.And(this=result, expression=a)
                    not_node.replace(sqlglot_exp.Paren(this=result))
                    changed = True
                    continue

            # NOT LIKE / NOT IN(subquery): leave as-is for the filter
            # encoder / residual handler.


def _flatten_or(node):
    """Flatten chained ORs into a list of leaf nodes (module-level helper).

    Strips Paren wrappers at each level so that `(a) OR (b)` is treated
    the same as `a OR b`.
    """
    while isinstance(node, sqlglot_exp.Paren):
        node = node.this
    if isinstance(node, sqlglot_exp.Or):
        return _flatten_or(node.this) + _flatten_or(node.expression)
    return [node]


def _rewrite_disjoint_or_to_in(ast):
    """Collapse `(c=v1) OR (c=v2) OR ... OR (c=vk)` into `c IN (v1, ..., vk)`.

    Only collapses chains where every leaf is an EQ on the same fully-qualified
    column reference. Walks bottom-up so nested chains collapse iteratively.
    """
    if not HAS_SQLGLOT:
        return

    def _strip_paren(node):
        while isinstance(node, sqlglot_exp.Paren):
            node = node.this
        return node

    def _leaf_to_col_and_values(node):
        """Return (col_str, [Literal values], col_node) if leaf is an EQ or
        IN-list on a single fully-qualified column, else None.

        Treats `c = v` as a 1-element value list and `c IN (v1, v2, …)` as
        a multi-element value list. This lets the OR-collapse pass merge
        mixed `IN + EQ + IN` chains into one IN-list (rather than dropping
        the entire OR — which produces an incorrect empty region when the
        downstream atom extractor mixes `eq_values` and `in_values`
        semantically).
        """
        node = _strip_paren(node)
        if isinstance(node, sqlglot_exp.EQ):
            col = node.this
            rhs = node.expression
            if not isinstance(col, sqlglot_exp.Column):
                return None
            if isinstance(rhs, sqlglot_exp.Column):
                return None  # join, not filter
            return (str(col), [rhs], col)
        if isinstance(node, sqlglot_exp.In) and node.args.get("query") is None:
            col = node.this
            if not isinstance(col, sqlglot_exp.Column):
                return None
            return (str(col), list(node.expressions), col)
        return None

    changed = True
    while changed:
        changed = False
        for or_node in list(ast.find_all(sqlglot_exp.Or)):
            # Already replaced by a previous iteration?
            if or_node.parent is None:
                continue
            leaves = _flatten_or(or_node)
            decoded = [_leaf_to_col_and_values(leaf) for leaf in leaves]
            if any(d is None for d in decoded):
                continue
            cols = {d[0] for d in decoded}
            if len(cols) != 1:
                continue
            # All leaves share the same column → rewrite to a single IN.
            col_node = decoded[0][2].copy()
            values = []
            for _, vals, _ in decoded:
                for v in vals:
                    values.append(v.copy())
            in_node = sqlglot_exp.In(this=col_node, expressions=values)
            or_node.replace(sqlglot_exp.Paren(this=in_node))
            changed = True
            break  # restart iteration since the AST mutated


# ---------------------------------------------------------------------------
# Rule d: per-column filter atom extraction
# ---------------------------------------------------------------------------

def _column_str(node):
    """'table.column' for a sqlglot Column node, else str(node)."""
    if hasattr(node, 'table') and getattr(node, 'table', None):
        return f"{node.table}.{node.name}"
    return str(node)


def _literal_value(node):
    """Best-effort native-Python value from a Literal/Number/etc.

    `Neg(Literal(N))` is how sqlglot represents `-N` literals (e.g. in
    `col >= -2`). Without the Neg arm, the sign was silently dropped and
    PRICE_N's atoms parser left `range_low=None`, causing dim40 mismatches
    against PRICE_S/B (whose `get_filter_ranges` reads `str(expression)`
    and correctly sees `-2`).
    """
    if isinstance(node, sqlglot_exp.Neg):
        inner = _literal_value(node.this)
        if inner is None:
            return None
        try:
            return -inner
        except TypeError:
            return None
    if isinstance(node, sqlglot_exp.Literal):
        try:
            return int(str(node.name))
        except (TypeError, ValueError):
            try:
                return float(str(node.name))
            except (TypeError, ValueError):
                return str(node.name)
    return None


def _is_inside_subquery(node):
    """True if node has any Subquery or Exists ancestor above it (not counting itself).

    Used to skip atoms that originate inside non-inlined subqueries — those
    subqueries become LLM residuals and their atoms should not be extracted.
    """
    p = node.parent
    while p is not None:
        if isinstance(p, (sqlglot_exp.Subquery, sqlglot_exp.Exists)):
            return True
        p = p.parent
    return False


def _expand_to_dnf(where_ast, max_clauses=16):
    """Distribute the WHERE expression to DNF (a flat list of conjunctive clauses).

    Returns a list of clauses. Each clause is a list of leaf atoms (the
    conjunction of the leaves IS the clause). The number of clauses is
    bounded by max_clauses; if expansion would produce more, returns None
    to signal "too complex, treat as residual."

    Assumes the WHERE is already in NNF (no compound NOTs). Distribution
    walks AND/OR nodes recursively:
      - DNF(AND(a, b)) = [c1 + c2 for c1 in DNF(a) for c2 in DNF(b)]
      - DNF(OR(a, b)) = DNF(a) + DNF(b)
      - DNF(leaf) = [[leaf]]
    """
    def _expand(node):
        # Strip Paren
        while isinstance(node, sqlglot_exp.Paren):
            node = node.this
        if isinstance(node, sqlglot_exp.And):
            left = _expand(node.this)
            right = _expand(node.expression)
            if left is None or right is None:
                return None
            out = []
            for c1 in left:
                for c2 in right:
                    out.append(c1 + c2)
                    if len(out) > max_clauses:
                        return None
            return out
        if isinstance(node, sqlglot_exp.Or):
            left = _expand(node.this)
            right = _expand(node.expression)
            if left is None or right is None:
                return None
            combined = left + right
            if len(combined) > max_clauses:
                return None
            return combined
        # Leaf
        return [[node]]
    return _expand(where_ast)


def _extract_atoms_per_clause(ast, max_clauses=16):
    """Extract per-clause atoms_meta dicts via DNF expansion.

    Returns a list of atoms_meta dicts, one per DNF clause. If DNF expansion
    blows up beyond max_clauses, returns a single-element list with a
    special marker so the caller can fall back to OR-residual handling.

    Each atoms_meta dict has the same shape as today's single-clause output
    (filter_atoms, pairwise_atoms, join_sides), but covers only its clause's
    leaf atoms. Tables / joins / join-sides are query-level and computed
    once, not per clause.
    """
    if not HAS_SQLGLOT:
        return [_empty_atoms_meta()]

    where = ast.args.get("where")
    if where is None:
        return [_empty_atoms_meta()]

    alias_map = _build_alias_map(ast)   # resolve aliases to physical table names

    expanded = _expand_to_dnf(where.this, max_clauses=max_clauses)
    if expanded is None:
        # Blowup → single clause containing all atoms; OR block becomes residual.
        return [None]   # sentinel: "fall back to single-clause non-DNF extraction"

    out = []
    for leaves in expanded:
        meta = _build_atoms_meta_from_leaves(leaves, alias_map=alias_map)
        out.append(meta)
    return out


def _empty_atoms_meta():
    return {"filter_atoms": {}, "pairwise_atoms": [], "join_sides": {}}


def _build_atoms_meta_from_leaves(leaves, alias_map=None):
    """Walk a clause's leaf nodes and populate an atoms_meta dict.

    `leaves` is a list of AST nodes (the conjunctive atoms of one DNF clause).
    Reuses the per-node logic from _extract_filter_atoms / _extract_pairwise_intra_atoms
    / _extract_xtab_nonequi_atoms but operates on a flat leaf list instead of
    a WHERE subtree.

    `alias_map` maps SQL alias → physical table name (from _build_alias_map).
    When provided, pairwise atom tuples use physical names to match stats pkl keys.
    """
    meta = _empty_atoms_meta()
    filter_atoms = meta["filter_atoms"]
    pairwise_atoms = meta["pairwise_atoms"]

    def _ensure(col):
        return filter_atoms.setdefault(col, {
            "eq_values": [], "in_values": [], "not_in_values": [],
            "range_low": None, "range_high": None,
            "is_null": False, "is_not_null": False,
            "or_atoms": [],
        })

    for leaf in leaves:
        # Strip Paren
        while isinstance(leaf, sqlglot_exp.Paren):
            leaf = leaf.this

        # IN
        if isinstance(leaf, sqlglot_exp.In) and leaf.args.get("query") is None:
            col = _column_str(leaf.this)
            for v in leaf.expressions:
                val = _literal_value(v)
                if val is not None:
                    _ensure(col)["in_values"].append(val)
            continue

        # EQ
        if isinstance(leaf, sqlglot_exp.EQ):
            if isinstance(leaf.expression, sqlglot_exp.Column):
                continue   # join condition, handled at query level
            col = _column_str(leaf.this)
            v = _literal_value(leaf.expression)
            if v is not None:
                _ensure(col)["eq_values"].append(v)
            continue

        # NEQ
        if isinstance(leaf, sqlglot_exp.NEQ):
            if isinstance(leaf.expression, sqlglot_exp.Column):
                # cross-column NEQ → pairwise atom on same-table or xtab
                lt_raw = getattr(leaf.this, "table", None)
                rt_raw = getattr(leaf.expression, "table", None)
                lt = alias_map.get(lt_raw, lt_raw) if alias_map else lt_raw
                rt = alias_map.get(rt_raw, rt_raw) if alias_map else rt_raw
                if lt and rt and lt == rt:
                    pairwise_atoms.append(
                        (lt, str(leaf.this.name), str(leaf.expression.name), "!=", None, None))
                continue
            col = _column_str(leaf.this)
            v = _literal_value(leaf.expression)
            if v is not None:
                _ensure(col)["not_in_values"].append(v)
            continue

        # Range comparisons (LT, LTE, GT, GTE) — same handling as before
        matched_range = False
        for cmp_cls, side in [
            (sqlglot_exp.GTE, "low"), (sqlglot_exp.GT, "low"),
            (sqlglot_exp.LTE, "high"), (sqlglot_exp.LT, "high"),
        ]:
            if isinstance(leaf, cmp_cls):
                if isinstance(leaf.expression, sqlglot_exp.Column):
                    # cross-column → pairwise atom (same-table or xtab whitelist)
                    lt_raw = getattr(leaf.this, "table", None)
                    rt_raw = getattr(leaf.expression, "table", None)
                    lt = alias_map.get(lt_raw, lt_raw) if alias_map else lt_raw
                    rt = alias_map.get(rt_raw, rt_raw) if alias_map else rt_raw
                    op = {sqlglot_exp.GTE: ">=", sqlglot_exp.GT: ">",
                          sqlglot_exp.LTE: "<=", sqlglot_exp.LT: "<"}[cmp_cls]
                    if lt and rt and lt == rt:
                        # Same-table pairwise (rule j) — atom uses physical name.
                        pairwise_atoms.append((lt, str(leaf.this.name),
                                               str(leaf.expression.name), op, None, None))
                    elif lt and rt:
                        # Different tables — check xtab whitelist (rule h).
                        # alias_map already resolved aliases to physical names,
                        # so the whitelist key lookup is consistent.
                        key = (lt, str(leaf.this.name), rt, str(leaf.expression.name))
                        if key in _XTAB_NONEQUI_WHITELIST:
                            pairwise_atoms.append((lt, str(leaf.this.name),
                                                   str(leaf.expression.name), op,
                                                   rt, str(leaf.expression.name)))
                    matched_range = True
                    break
                col = _column_str(leaf.this)
                v = _literal_value(leaf.expression)
                if v is None:
                    matched_range = True
                    break
                # Match PRICE_S's strict/non-strict ε convention:
                #   > v   → range_low = v + 1e-5  (exclude v)
                #   >= v  → range_low = v        (include v)
                #   < v   → range_high = v       (exclude v)
                #   <= v  → range_high = v + 1e-5 (include v)
                # Bake the ε into the atom value here so downstream
                # _range_to_region_continuous doesn't need extra cases.
                if cmp_cls is sqlglot_exp.GT:
                    v_adj = v + 1e-5
                elif cmp_cls is sqlglot_exp.LTE:
                    v_adj = v + 1e-5
                else:
                    v_adj = v
                entry = _ensure(col)
                if side == "low":
                    entry["range_low"] = v_adj if entry["range_low"] is None \
                                         else max(entry["range_low"], v_adj)
                else:
                    entry["range_high"] = v_adj if entry["range_high"] is None \
                                          else min(entry["range_high"], v_adj)
                matched_range = True
                break
        if matched_range:
            continue

        # IS NULL / IS NOT NULL
        if isinstance(leaf, sqlglot_exp.Is):
            col = _column_str(leaf.this)
            rhs = leaf.expression
            if isinstance(rhs, sqlglot_exp.Null):
                _ensure(col)["is_null"] = True
            continue

        # NOT (Is(NULL)) — IS NOT NULL representation
        if isinstance(leaf, sqlglot_exp.Not):
            child = leaf.this
            if isinstance(child, sqlglot_exp.Is) and isinstance(child.expression, sqlglot_exp.Null):
                col = _column_str(child.this)
                _ensure(col)["is_not_null"] = True
            continue

        # Between
        if isinstance(leaf, sqlglot_exp.Between):
            col = _column_str(leaf.this)
            low = _literal_value(leaf.args.get("low"))
            high = _literal_value(leaf.args.get("high"))
            if low is not None and high is not None:
                entry = _ensure(col)
                entry["range_low"] = low if entry["range_low"] is None \
                                     else max(entry["range_low"], low)
                entry["range_high"] = high if entry["range_high"] is None \
                                      else min(entry["range_high"], high)
            continue

    return meta


def _extract_filter_atoms(ast):
    """Walk WHERE and collect per-column atoms for the PRICE_N filter token.

    Returns dict[full_col -> dict] using the schema from
    Sql2FeatureN.EMPTY_ATOMS.

    Nodes that are descendants of a Subquery or Exists node are skipped —
    they belong to non-inlined subqueries that go to LLM residual.
    """
    if not HAS_SQLGLOT:
        return {}
    where = ast.args.get("where")
    if where is None:
        return {}
    atoms = {}

    def _ensure(col):
        return atoms.setdefault(col, {
            "eq_values": [], "in_values": [], "not_in_values": [],
            "range_low": None, "range_high": None,
            "is_null": False, "is_not_null": False, "like_keys": [],
            "or_atoms": [],   # list of (op, value) for same-column disjunctions
        })

    # --- Pass 0: Collect same-column OR chains into or_atoms ---
    # Walk every top-level Or block. If all leaves are predicates on the
    # *same* column with literal RHS, collapse them to or_atoms (DNF).
    # Nodes consumed here are tracked so the per-kind loops below don't
    # double-count them.
    _consumed_nodes = set()
    _CMP_OP_MAP = {
        sqlglot_exp.EQ:  "=",
        sqlglot_exp.LT:  "<",
        sqlglot_exp.LTE: "<=",
        sqlglot_exp.GT:  ">",
        sqlglot_exp.GTE: ">=",
    }
    for or_node in list(where.find_all(sqlglot_exp.Or)):
        if _is_inside_subquery(or_node):
            continue
        # Skip if an ancestor Or already subsumed this node
        if id(or_node) in _consumed_nodes:
            continue
        leaves = _flatten_or(or_node)
        single_col = None
        all_same_col = True
        col_atoms = []
        for leaf in leaves:
            stripped = leaf
            while isinstance(stripped, sqlglot_exp.Paren):
                stripped = stripped.this
            # Between leaf in OR: treat as ("between", low, high) 3-tuple atom
            if isinstance(stripped, sqlglot_exp.Between):
                col_node = stripped.this
                low_node = stripped.args.get('low')
                high_node = stripped.args.get('high')
                if not isinstance(col_node, sqlglot_exp.Column):
                    all_same_col = False
                    break
                low_v = _literal_value(low_node) if low_node is not None else None
                high_v = _literal_value(high_node) if high_node is not None else None
                if low_v is None or high_v is None:
                    all_same_col = False
                    break
                c = _column_str(col_node)
                if single_col is None:
                    single_col = c
                elif c != single_col:
                    all_same_col = False
                    break
                col_atoms.append(("between", low_v, high_v, stripped))
                continue
            op = _CMP_OP_MAP.get(type(stripped))
            if op is None:
                all_same_col = False
                break
            col_node = stripped.args.get("this")
            rhs = stripped.args.get("expression")
            if not isinstance(col_node, sqlglot_exp.Column):
                all_same_col = False
                break
            if isinstance(rhs, sqlglot_exp.Column):
                all_same_col = False
                break
            v = _literal_value(rhs)
            if v is None:
                all_same_col = False
                break
            c = _column_str(col_node)
            if single_col is None:
                single_col = c
            elif c != single_col:
                all_same_col = False
                break
            col_atoms.append((op, v, stripped))
        if all_same_col and single_col is not None and col_atoms:
            entry = _ensure(single_col)
            for atom_tuple in col_atoms:
                if atom_tuple[0] == "between":
                    _, low_v, high_v, node = atom_tuple
                    entry["or_atoms"].append(("between", low_v, high_v))
                    _consumed_nodes.add(id(node))
                else:
                    op, v, node = atom_tuple
                    entry["or_atoms"].append((op, v))
                    _consumed_nodes.add(id(node))

    # --- Per-atom-kind passes (skip nodes consumed by the Or pass) ---

    for in_node in where.find_all(sqlglot_exp.In):
        if _is_inside_subquery(in_node):
            continue
        col = _column_str(in_node.this)
        for v in in_node.expressions:
            val = _literal_value(v)
            if val is not None:
                _ensure(col)["in_values"].append(val)
    for eq in where.find_all(sqlglot_exp.EQ):
        if id(eq) in _consumed_nodes:
            continue
        if _is_inside_subquery(eq):
            continue
        if isinstance(eq.expression, sqlglot_exp.Column):
            continue
        col = _column_str(eq.this)
        v = _literal_value(eq.expression)
        if v is not None:
            _ensure(col)["eq_values"].append(v)
    # NEQ: col != X → range-pair encoding (rule a extension)
    for neq in where.find_all(sqlglot_exp.NEQ):
        if _is_inside_subquery(neq):
            continue
        if isinstance(neq.expression, sqlglot_exp.Column):
            continue   # col-op-col, handled by pairwise extractors
        if isinstance(neq.expression, sqlglot_exp.Subquery):
            continue   # scalar subquery; residual
        col = _column_str(neq.this)
        v = _literal_value(neq.expression)
        if v is not None:
            _ensure(col)["not_in_values"].append(v)
    for cmp_cls, side in [
        (sqlglot_exp.GTE, "low"), (sqlglot_exp.GT, "low"),
        (sqlglot_exp.LTE, "high"), (sqlglot_exp.LT, "high"),
    ]:
        for cmp in where.find_all(cmp_cls):
            if id(cmp) in _consumed_nodes:
                continue
            if _is_inside_subquery(cmp):
                continue
            if isinstance(cmp.expression, sqlglot_exp.Column):
                continue
            col = _column_str(cmp.this)
            v = _literal_value(cmp.expression)
            if v is None:
                continue
            # Match PRICE_S's strict/non-strict ε convention (see comments in
            # _build_atoms_meta_from_leaves above): bake +1e-5 for `> v` and
            # `<= v` so _range_to_region_continuous needs no extra cases.
            if cmp_cls is sqlglot_exp.GT or cmp_cls is sqlglot_exp.LTE:
                v_adj = v + 1e-5
            else:
                v_adj = v
            entry = _ensure(col)
            if side == "low":
                entry["range_low"] = v_adj if entry["range_low"] is None \
                                     else max(entry["range_low"], v_adj)
            else:
                entry["range_high"] = v_adj if entry["range_high"] is None \
                                      else min(entry["range_high"], v_adj)
    # Between conjunctive extraction: col BETWEEN low AND high → range_low / range_high.
    # Only Between nodes NOT already consumed by the Or pass are handled here.
    for between in where.find_all(sqlglot_exp.Between):
        if id(between) in _consumed_nodes:
            continue
        if _is_inside_subquery(between):
            continue
        col_node = between.this
        low_node = between.args.get('low')
        high_node = between.args.get('high')
        if not isinstance(col_node, sqlglot_exp.Column):
            continue
        low = _literal_value(low_node) if low_node is not None else None
        high = _literal_value(high_node) if high_node is not None else None
        if low is None or high is None:
            continue
        col = _column_str(col_node)
        entry = _ensure(col)
        # BETWEEN is inclusive on both sides → match PRICE_S's `<=`-style
        # ε on the high bound (`+1e-5`). Low bound is `>=` semantics, no ε.
        high_adj = high + 1e-5
        # Conjunctive intersection (AND context)
        entry["range_low"] = low if entry["range_low"] is None \
                             else max(entry["range_low"], low)
        entry["range_high"] = high_adj if entry["range_high"] is None \
                              else min(entry["range_high"], high_adj)
    for is_node in where.find_all(sqlglot_exp.Is):
        if _is_inside_subquery(is_node):
            continue
        col = _column_str(is_node.this)
        rhs = is_node.expression
        if isinstance(rhs, sqlglot_exp.Null):
            # Check if this Is node is wrapped in a Not (IS NOT NULL pattern)
            parent = is_node.parent
            if isinstance(parent, sqlglot_exp.Not):
                _ensure(col)["is_not_null"] = True
            else:
                _ensure(col)["is_null"] = True
        elif isinstance(rhs, sqlglot_exp.Not) and isinstance(rhs.this, sqlglot_exp.Null):
            # sqlglot might represent IS NOT NULL as Is(col, Not(Null())) in some versions
            _ensure(col)["is_not_null"] = True
    return atoms


# ---------------------------------------------------------------------------
# Rule h: intra-table column-vs-column predicate extraction
# ---------------------------------------------------------------------------

def _build_alias_map(ast):
    """Map alias → physical table name from the AST's FROM clause.

    Used by pairwise / xtab atom extractors to ensure atom tuples use
    physical table names (matching the stats pkl keys).
    """
    if not HAS_SQLGLOT:
        return {}
    alias_map = {}
    for tbl in ast.find_all(sqlglot_exp.Table):
        if tbl.alias:
            alias_map[tbl.alias] = str(tbl.name)
        else:
            alias_map[str(tbl.name)] = str(tbl.name)
    return alias_map


_PAIRWISE_OPS = {
    sqlglot_exp.LT: "<",   sqlglot_exp.LTE: "<=",
    sqlglot_exp.EQ: "=",   sqlglot_exp.NEQ: "!=",
    sqlglot_exp.GT: ">",   sqlglot_exp.GTE: ">=",
}


def _extract_pairwise_intra_atoms(ast):
    """Find `A.x op A.y` predicates where both sides are columns of the same
    physical table alias.

    Returns list of (left_table, col_x, col_y, op, None, None).

    Atom tuples use the **physical** table name (not the SQL alias), so they
    match the stats pkl keys which are keyed by physical name.

    Nodes inside Subquery/Exists ancestors are skipped (they are LLM residuals).
    """
    if not HAS_SQLGLOT:
        return []
    where = ast.args.get("where")
    if where is None:
        return []
    alias_map = _build_alias_map(ast)
    out = []
    for cmp_cls, op_str in _PAIRWISE_OPS.items():
        for cmp in where.find_all(cmp_cls):
            if _is_inside_subquery(cmp):
                continue
            lhs, rhs = cmp.this, cmp.expression
            if not (isinstance(lhs, sqlglot_exp.Column)
                    and isinstance(rhs, sqlglot_exp.Column)):
                continue
            lt_raw = getattr(lhs, "table", None)
            rt_raw = getattr(rhs, "table", None)
            lt = alias_map.get(lt_raw, lt_raw)
            rt = alias_map.get(rt_raw, rt_raw)
            if lt and rt and lt == rt:
                out.append((lt, str(lhs.name), str(rhs.name), op_str, None, None))
    return out


# ---------------------------------------------------------------------------
# Rule j: cross-table non-equi predicate extraction (whitelisted pairs only)
# ---------------------------------------------------------------------------

# (table, col, table, col) tuples whose cross-table inequalities get a
# pairwise token. Currently the single TPC-DS exception.
_XTAB_NONEQUI_WHITELIST = {
    ("inventory", "inv_quantity_on_hand",
     "catalog_sales", "cs_quantity"),
    ("catalog_sales", "cs_quantity",
     "inventory", "inv_quantity_on_hand"),  # symmetric direction
}


def _extract_xtab_nonequi_atoms(ast):
    """Find whitelisted cross-table non-equi predicates.

    Resolves table aliases to physical table names before checking the
    whitelist, so `FROM inventory inv, catalog_sales cs WHERE inv.x < cs.y`
    is correctly identified.

    Returns list of (L_table, L_col, op, R_table, R_col, None) — note the
    op is in slot 2 unlike _extract_pairwise_intra_atoms; the call site
    rewraps to a uniform 6-tuple.
    """
    if not HAS_SQLGLOT:
        return []
    where = ast.args.get("where")
    if where is None:
        return []
    alias_map = _build_alias_map(ast)
    out = []
    for cmp_cls, op_str in _PAIRWISE_OPS.items():
        for cmp in where.find_all(cmp_cls):
            if _is_inside_subquery(cmp):
                continue
            lhs, rhs = cmp.this, cmp.expression
            if not (isinstance(lhs, sqlglot_exp.Column)
                    and isinstance(rhs, sqlglot_exp.Column)):
                continue
            raw_lt = getattr(lhs, "table", None)
            raw_rt = getattr(rhs, "table", None)
            lt = alias_map.get(raw_lt) if raw_lt else None
            rt = alias_map.get(raw_rt) if raw_rt else None
            if not (lt and rt) or lt == rt:
                continue
            key = (lt, str(lhs.name), rt, str(rhs.name))
            if key in _XTAB_NONEQUI_WHITELIST:
                out.append((lt, str(lhs.name), op_str, rt, str(rhs.name), None))
    return out


# ---------------------------------------------------------------------------
# Rule g: join-side-preserving SQL flattener
# ---------------------------------------------------------------------------

def _flatten_join_with_side(sql):
    """Like flatten_sql_for_price() but also returns
    `joins_with_side: list[tuple[str, str, side]]`.

    Each entry: ('A.k', 'B.k', side) where side is one of
    {INNER, LEFT, RIGHT, FULL}.
    Returns (flat_sql, joins_with_side) or (sql, []) on failure.
    """
    if not HAS_SQLGLOT:
        return sql, []
    try:
        ast = sqlglot.parse_one(sql)
    except Exception:
        return sql, []
    sides = []
    # Walk the join tree extracting side annotations BEFORE rewriting.
    for j in list(ast.find_all(sqlglot_exp.Join)):
        on = j.args.get("on")
        side = (j.args.get("side") or "INNER").upper()
        if on is None or not isinstance(on, sqlglot_exp.EQ):
            continue
        if not (isinstance(on.this, sqlglot_exp.Column)
                and isinstance(on.expression, sqlglot_exp.Column)):
            continue
        sides.append((_column_str(on.this), _column_str(on.expression), side))
    # NOTE: we deliberately do NOT call flatten_sql_for_price() here. That
    # helper strips table-alias prefixes from column refs (e.g. `b.userid` →
    # `userid`) which is fine for tpcds/tpch (column prefixes uniquely identify
    # the table) but corrupts non-tpc workloads like stats where the same
    # column name lives on multiple tables (e.g., `userid` on badges, comments,
    # posthistory, posts, users). Sql2FeatureN.parse_sql then can't resolve
    # which table each column belongs to and silently zero-fills the features.
    # The downstream alias rewriter in transform_sql_for_price (lines 3585+)
    # already converts `b.X` → `st_b.X` when it sees the input alias, so we
    # just return the SQL unchanged and rely on that.
    return sql, sides


def _is_constant(node):
    """Check if expression has no Column or Subquery refs (is a literal/constant)."""
    if isinstance(node, sqlglot_exp.Column):
        return False
    if isinstance(node, sqlglot_exp.Subquery):
        return False
    for child in node.iter_expressions():
        if not _is_constant(child):
            return False
    return True


def _get_from_sources(select_node):
    """Get (source_node, alias_or_name) pairs from a SELECT's FROM + JOINs."""
    sources = []
    from_clause = select_node.args.get('from_')
    if from_clause:
        src = from_clause.this
        alias = src.alias or (src.name if isinstance(src, sqlglot_exp.Table) else '')
        sources.append((src, alias))
    for join in select_node.args.get('joins') or []:
        src = join.this
        alias = src.alias or (src.name if isinstance(src, sqlglot_exp.Table) else '')
        sources.append((src, alias))
        # Also collect ON conditions as part of the WHERE (for JOIN...ON syntax)
        on_cond = join.args.get('on')
        if on_cond:
            sources.append(('__on__', on_cond.this))
    return sources


_SIMPLE_OPS = (
    sqlglot_exp.EQ, sqlglot_exp.NEQ,
    sqlglot_exp.GT, sqlglot_exp.GTE,
    sqlglot_exp.LT, sqlglot_exp.LTE,
)
_OP_STR = {
    sqlglot_exp.EQ: '=', sqlglot_exp.NEQ: '!=',
    sqlglot_exp.GT: '>', sqlglot_exp.GTE: '>=',
    sqlglot_exp.LT: '<', sqlglot_exp.LTE: '<=',
}


def _classify_condition(cond):
    """
    Classify a single WHERE condition.

    Returns:
      ('join', left_col_sql, right_col_sql)          - equi-join
      ('filter', col_sql, op_str, value_sql)          - simple comparison filter
      ('skip', reason)                                 - unsupported (OR, LIKE, IN, subquery, etc.)
    """
    if isinstance(cond, sqlglot_exp.Paren):
        return _classify_condition(cond.this)

    # OR → unsupported
    if isinstance(cond, sqlglot_exp.Or):
        return ('skip', 'OR')

    # Column = Column → equi-join
    if isinstance(cond, sqlglot_exp.EQ):
        left, right = cond.left, cond.right
        if isinstance(left, sqlglot_exp.Column) and isinstance(right, sqlglot_exp.Column):
            return ('join', left.sql(), right.sql())

    # Simple comparison: Column op constant
    if type(cond) in _SIMPLE_OPS:
        left, right = cond.left, cond.right
        op_str = _OP_STR[type(cond)]
        if isinstance(left, sqlglot_exp.Column) and _is_constant(right):
            return ('filter', left.sql(), op_str, right.sql())
        if isinstance(right, sqlglot_exp.Column) and _is_constant(left):
            # Flip: constant op column → column op' constant
            flip = {'=': '=', '!=': '!=', '>': '<', '>=': '<=', '<': '>', '<=': '>='}
            return ('filter', right.sql(), flip[op_str], left.sql())

    # BETWEEN → two filters
    if isinstance(cond, sqlglot_exp.Between):
        col = cond.this
        if isinstance(col, sqlglot_exp.Column):
            low = cond.args['low'].sql()
            high = cond.args['high'].sql()
            return ('between', col.sql(), low, high)

    # IN (value list) → range envelope (numeric) or representative equality (string)
    if isinstance(cond, sqlglot_exp.In):
        col = cond.this
        values = cond.expressions  # empty for IN-subquery
        if isinstance(col, sqlglot_exp.Column) and values:
            # Check if all values are numeric literals
            nums = []
            for v in values:
                if isinstance(v, sqlglot_exp.Literal) and not v.is_string:
                    try:
                        nums.append(float(v.this))
                    except (ValueError, TypeError):
                        break
                elif isinstance(v, sqlglot_exp.Neg) and isinstance(v.this, sqlglot_exp.Literal):
                    try:
                        nums.append(-float(v.this.this))
                    except (ValueError, TypeError):
                        break
                else:
                    break
            if len(nums) == len(values) and nums:
                # All numeric → range envelope
                return ('between', col.sql(), str(min(nums)), str(max(nums)))
            # Check if all values are string literals
            strs = []
            for v in values:
                if isinstance(v, sqlglot_exp.Literal) and v.is_string:
                    strs.append(v.sql())  # includes quotes
                else:
                    break
            if len(strs) == len(values) and strs:
                # All strings → use first as representative equality
                return ('filter', col.sql(), '=', strs[0])

    # Everything else (LIKE, NOT, EXISTS, subquery comparisons) → skip
    return ('skip', type(cond).__name__)


def _collect_union_branches(node, branches):
    """Recursively collect all SELECT branches from a UNION ALL chain."""
    if isinstance(node, sqlglot_exp.Union):
        _collect_union_branches(node.left, branches)
        _collect_union_branches(node.right, branches)
    elif isinstance(node, sqlglot_exp.Subquery):
        _collect_union_branches(node.this, branches)
    elif isinstance(node, sqlglot_exp.Select):
        branches.append(node)


def _extract_branch_info(branch_sel):
    """Extract alias_map, tables, tbl_aliases, joins, filters from a single SELECT branch."""
    alias_map = {}
    for sel_expr in branch_sel.expressions:
        if isinstance(sel_expr, sqlglot_exp.Alias):
            underlying = sel_expr.this
            if isinstance(underlying, sqlglot_exp.Column):
                alias_map[sel_expr.alias.lower()] = underlying.name.lower()
            else:
                alias_map[sel_expr.alias.lower()] = None  # aggregate/expr
        elif isinstance(sel_expr, sqlglot_exp.Column):
            alias_map[sel_expr.name.lower()] = sel_expr.name.lower()

    tables = set()
    tbl_aliases = {}
    for src, alias in _get_from_sources(branch_sel):
        if src == '__on__':
            continue
        if isinstance(src, sqlglot_exp.Table):
            tables.add(src.name.lower())
            a = (src.alias or src.name).lower()
            tbl_aliases[a] = src.name.lower()

    joins, filters = [], []
    where = branch_sel.args.get('where')
    if where:
        conditions = []
        _flatten_and(where.this, conditions)
        for c in conditions:
            cl = _classify_condition(c)
            if cl[0] == 'join':
                joins.append((cl[1], cl[2]))
            elif cl[0] == 'filter':
                filters.append((cl[1], cl[2], cl[3]))
            elif cl[0] == 'between':
                filters.append((cl[1], '>=', cl[2]))
                filters.append((cl[1], '<=', cl[3]))

    for src, alias in _get_from_sources(branch_sel):
        if src == '__on__' and alias is not None:
            on_conds = []
            _flatten_and(alias, on_conds)
            for c in on_conds:
                cl = _classify_condition(c)
                if cl[0] == 'join':
                    joins.append((cl[1], cl[2]))
                elif cl[0] == 'filter':
                    filters.append((cl[1], cl[2], cl[3]))

    return alias_map, tables, tbl_aliases, joins, filters


def _build_cte_info(ast):
    """Extract CTE metadata: alias maps, base tables, joins, filters."""
    info = {
        'names': set(),
        'alias_maps': {},          # cte_name → {cte_col: base_col_name} (first branch)
        'all_branch_maps': {},     # cte_name → [{cte_col: base_col}, ...] (all branches)
        'base_tables': {},         # cte_name → set of base table names
        'table_aliases': {},       # cte_name → {alias_in_cte: real_table_name}
        'joins': {},               # cte_name → [(left_sql, right_sql), ...]
        'filters': {},             # cte_name → [(col_sql, op, val), ...]
    }
    with_clause = ast.args.get('with_')
    if not with_clause:
        return info

    for cte in with_clause.find_all(sqlglot_exp.CTE):
        name = cte.alias
        info['names'].add(name)
        inner_sel = cte.this

        if isinstance(inner_sel, sqlglot_exp.Union):
            # UNION ALL CTE: process ALL branches
            branches = []
            _collect_union_branches(inner_sel, branches)

            all_alias_maps = []
            all_tables = set()
            all_tbl_aliases = {}
            all_joins = []
            all_filters = []

            for branch in branches:
                alias_map, tables, tbl_aliases, joins, filters = _extract_branch_info(branch)
                all_alias_maps.append(alias_map)
                all_tables.update(tables)
                all_tbl_aliases.update(tbl_aliases)
                all_joins.extend(joins)
                all_filters.extend(filters)

            info['alias_maps'][name] = all_alias_maps[0] if all_alias_maps else {}
            info['all_branch_maps'][name] = all_alias_maps
            info['base_tables'][name] = all_tables
            info['table_aliases'][name] = all_tbl_aliases
            info['joins'][name] = all_joins
            info['filters'][name] = all_filters
        else:
            # Normal CTE: single SELECT
            alias_map, tables, tbl_aliases, joins, filters = _extract_branch_info(inner_sel)
            info['alias_maps'][name] = alias_map
            info['all_branch_maps'][name] = [alias_map]
            info['base_tables'][name] = tables
            info['table_aliases'][name] = tbl_aliases
            info['joins'][name] = joins
            info['filters'][name] = filters

    return info


def _resolve_col_through_cte(col_sql, alias_to_cte, cte_info):
    """
    Resolve a column reference that goes through a CTE alias.

    Returns a list of resolved column names (one per UNION branch).
    For non-CTE columns, returns [col_sql].
    For unresolvable (aggregate) columns, returns [None].

    e.g. 'ctr1.ctr_store_sk' where ctr1 → CTE 'customer_total_return'
    and ctr_store_sk → sr_store_sk → returns ['sr_store_sk']

    For UNION ALL CTEs: 'wscs.sold_date_sk' → ['ws_sold_date_sk', 'cs_sold_date_sk']
    """
    parts = col_sql.split('.')
    if len(parts) == 2:
        table_alias, col_name = parts[0].lower(), parts[1].lower()
        if table_alias not in alias_to_cte:
            return [col_sql]  # Not a CTE reference

        cte_name = alias_to_cte[table_alias]
        # Check multi-branch maps (UNION ALL CTEs)
        all_maps = cte_info.get('all_branch_maps', {}).get(cte_name, [])
        if len(all_maps) > 1:
            results = []
            for branch_map in all_maps:
                base_col = branch_map.get(col_name)
                if base_col is not None:
                    results.append(base_col)
            return results if results else [None]
        # Single branch
        amap = cte_info['alias_maps'].get(cte_name, {})
        base_col = amap.get(col_name)
        return [base_col] if base_col is not None else [None]

    # Unqualified column: check if it matches any CTE's alias map
    col_name = parts[0].lower()
    for cte_alias, cte_name in alias_to_cte.items():
        all_maps = cte_info.get('all_branch_maps', {}).get(cte_name, [])
        if len(all_maps) > 1:
            results = []
            for branch_map in all_maps:
                base_col = branch_map.get(col_name)
                if base_col is not None:
                    results.append(base_col)
            if results:
                return results
        else:
            amap = cte_info['alias_maps'].get(cte_name, {})
            base_col = amap.get(col_name)
            if base_col is not None:
                return [base_col]

    return [col_sql]  # Can't resolve through CTE, return as-is


def _unwrap_from_subquery(sel):
    """If the FROM clause is a subquery, recurse to get the inner SELECT."""
    from_clause = sel.args.get('from_')
    if from_clause and isinstance(from_clause.this, sqlglot_exp.Subquery):
        inner = from_clause.this.this
        if isinstance(inner, sqlglot_exp.Select):
            return _unwrap_from_subquery(inner)
    return sel


def flatten_sql_for_price(sql, db_name):
    """
    Flatten complex SQL (CTEs, subqueries-in-FROM, VIEWs) into a simple
    SELECT COUNT(*) FROM t1, t2, ... WHERE join1 AND join2 AND filter1 ...

    Returns flattened SQL string, or None if flattening fails.

    PRICE requires:
    - Comma-separated FROM (no JOIN...ON)
    - WHERE clause with equi-joins and simple comparison filters
    - N-1 equi-joins for N tables (tree topology)
    - All columns as table.column format
    """
    if not HAS_SQLGLOT:
        return None

    # --- Extract revenue0 date filters from comment (injected by extract_raw_sql) ---
    revenue0_start, revenue0_end = None, None
    clean_sql = sql
    date_m = re.match(r'--\s*REVENUE0_DATES:\s*(\S+)\s+(\S+)\s*\n?', sql)
    if date_m:
        revenue0_start, revenue0_end = date_m.group(1), date_m.group(2)
        clean_sql = sql[date_m.end():]

    try:
        ast = sqlglot.parse_one(clean_sql)
    except Exception:
        return None

    # --- Handle TPC-H Q15 VIEW: expand revenue0 inline ---
    if db_name == 'tpch':
        has_revenue0 = False
        for t in ast.find_all(sqlglot_exp.Table):
            if t.name.lower() == 'revenue0':
                has_revenue0 = True
                break
        if has_revenue0:
            return _flatten_revenue0_query(revenue0_start, revenue0_end)

    # --- Build CTE info ---
    cte_info = _build_cte_info(ast)

    # --- Unwrap subquery-in-FROM ---
    main_sel = _unwrap_from_subquery(ast)

    # --- Collect base tables ---
    base_tables = set()          # set of real table names
    table_aliases = {}           # alias → real_table_name (for non-CTE tables)
    alias_to_cte = {}            # alias → CTE name (for CTE references in main query)

    for src, alias in _get_from_sources(main_sel):
        if src == '__on__':
            continue
        if isinstance(src, sqlglot_exp.Table):
            tname = src.name.lower()
            a = alias.lower() if alias else tname
            if tname in cte_info['names']:
                alias_to_cte[a] = tname
                base_tables.update(cte_info['base_tables'].get(tname, set()))
            else:
                base_tables.add(tname)
                table_aliases[a] = tname

    if not base_tables:
        return None

    # --- Collect conditions from main SELECT ---
    main_joins = []
    main_filters = []
    where = main_sel.args.get('where')
    if where:
        conditions = []
        _flatten_and(where.this, conditions)
        for c in conditions:
            cl = _classify_condition(c)
            if cl[0] == 'join':
                main_joins.append((cl[1], cl[2]))
            elif cl[0] == 'filter':
                main_filters.append((cl[1], cl[2], cl[3]))
            elif cl[0] == 'between':
                main_filters.append((cl[1], '>=', cl[2]))
                main_filters.append((cl[1], '<=', cl[3]))

    # Also collect ON conditions from JOINs in main query
    for src, alias in _get_from_sources(main_sel):
        if src == '__on__' and alias is not None:
            on_conds = []
            _flatten_and(alias, on_conds)
            for c in on_conds:
                cl = _classify_condition(c)
                if cl[0] == 'join':
                    main_joins.append((cl[1], cl[2]))
                elif cl[0] == 'filter':
                    main_filters.append((cl[1], cl[2], cl[3]))

    # --- Helper: strip table alias prefix, leaving bare column name ---
    # Build combined alias→table mapping from main query + all CTE internals
    all_tbl_aliases = dict(table_aliases)  # alias→real_table from main query
    for cte_name in cte_info.get('table_aliases', {}):
        all_tbl_aliases.update(cte_info['table_aliases'][cte_name])

    def _strip_alias(col_sql):
        """Strip table alias prefix, returning bare column name.
        'n1.n_nationkey' → 'n_nationkey', 'sr_store_sk' → 'sr_store_sk'"""
        if '.' in col_sql:
            parts = col_sql.split('.', 1)
            return parts[1]
        return col_sql

    # Aliases we can resolve back to a real base table. A column qualified by
    # a prefix outside this set (e.g. `sc.ss_store_sk` where `sc` is an opaque
    # subquery-in-FROM derived table) refers to a scope that won't survive
    # flattening. Stripping the prefix would leak the underlying physical
    # column into the outer WHERE without adding its base table to FROM,
    # producing a dangling reference. Drop such predicates instead.
    in_scope_aliases = set(table_aliases) | set(alias_to_cte)

    def _col_in_scope(col_sql):
        """True iff col_sql is bare (no prefix) or its prefix maps to a
        known base table / CTE in the outer query's scope."""
        if '.' not in col_sql:
            return True
        return col_sql.split('.', 1)[0].lower() in in_scope_aliases

    # --- Merge CTE joins/filters ---
    all_joins = []
    all_filters = []

    # Add CTE-internal conditions for referenced CTEs
    referenced_ctes = set(alias_to_cte.values())
    for cte_name in referenced_ctes:
        for left, right in cte_info['joins'].get(cte_name, []):
            all_joins.append((_strip_alias(left), _strip_alias(right)))
        for col, op, val in cte_info['filters'].get(cte_name, []):
            all_filters.append((_strip_alias(col), op, val))

    # Resolve CTE column aliases in main-level conditions
    # _resolve_col_through_cte returns a list (one per UNION branch)
    for left_sql, right_sql in main_joins:
        if not (_col_in_scope(left_sql) and _col_in_scope(right_sql)):
            continue  # dangling: one side qualified by an opaque derived-table alias
        resolved_lefts = _resolve_col_through_cte(left_sql, alias_to_cte, cte_info)
        resolved_rights = _resolve_col_through_cte(right_sql, alias_to_cte, cte_info)
        for rl in resolved_lefts:
            for rr in resolved_rights:
                if rl is not None and rr is not None:
                    all_joins.append((_strip_alias(rl), _strip_alias(rr)))

    for col_sql, op, val in main_filters:
        if not _col_in_scope(col_sql):
            continue
        resolveds = _resolve_col_through_cte(col_sql, alias_to_cte, cte_info)
        for resolved in resolveds:
            if resolved is not None:
                all_filters.append((_strip_alias(resolved), op, val))

    if not all_joins and not all_filters:
        return None  # Nothing useful extracted

    # --- Deduplicate joins (same pair can come from CTE + main) ---
    seen_joins = set()
    deduped_joins = []
    for left, right in all_joins:
        key = (left.lower(), right.lower())
        rev_key = (right.lower(), left.lower())
        if key not in seen_joins and rev_key not in seen_joins:
            seen_joins.add(key)
            deduped_joins.append((left, right))
    all_joins = deduped_joins

    # --- Reconstruct flat SQL ---
    from_parts = sorted(base_tables)
    where_parts = []
    for left, right in all_joins:
        where_parts.append(f"{left} = {right}")
    for col, op, val in all_filters:
        where_parts.append(f"{col} {op} {val}")

    if not where_parts:
        return None

    flat_sql = f"SELECT COUNT(*) FROM {', '.join(from_parts)} WHERE {' AND '.join(where_parts)}"
    return flat_sql


def _flatten_revenue0_query(start_date=None, end_date=None):
    """
    Flatten TPC-H Q15 which references the VIEW revenue0.

    Expands to: SELECT COUNT(*) FROM supplier, lineitem
                WHERE s_suppkey = l_suppkey AND l_shipdate >= ... AND l_shipdate < ...

    The date filters come from the CREATE VIEW statement that precedes each Q15
    instance in tpch.sql, extracted by extract_raw_sql().
    """
    flat = "SELECT COUNT(*) FROM supplier, lineitem WHERE s_suppkey = l_suppkey"
    if start_date and end_date:
        flat += f" AND l_shipdate >= date '{start_date}' AND l_shipdate < date '{end_date}'"
    return flat


# --- PRICE_N CTE simple-body check and selective flattener ---


def _check_cte_body_simple(node):
    """Returns True iff node is a flat SELECT body suitable for lossless inlining.

    A body is 'simple' iff it is a single SELECT over base relations with:
    - No GROUP BY
    - No HAVING
    - No DISTINCT
    - No window functions
    - No ORDER BY+LIMIT combination (ORDER BY alone is allowed without LIMIT)
    - Not itself a UNION/INTERSECT/EXCEPT
    - No aggregate function calls in projections
    """
    if isinstance(node, (sqlglot_exp.Union, sqlglot_exp.Intersect, sqlglot_exp.Except)):
        return False
    if not isinstance(node, sqlglot_exp.Select):
        return False
    if node.args.get("group"):
        return False
    if node.args.get("having"):
        return False
    if node.args.get("distinct"):
        return False
    if node.args.get("limit") and node.args.get("order"):
        return False
    if any(node.find_all(sqlglot_exp.Window)):
        return False
    AGGS = (sqlglot_exp.Sum, sqlglot_exp.Avg, sqlglot_exp.Min,
            sqlglot_exp.Max, sqlglot_exp.Count)
    for expr in node.expressions:
        e = expr.this if isinstance(expr, sqlglot_exp.Alias) else expr
        if isinstance(e, AGGS):
            return False
        if any(e.find_all(AGGS)):
            return False
    return True


def flatten_sql_for_price_n(sql, db_name=None):
    """PRICE_N variant of flatten_sql_for_price: only inline CTEs/derived tables
    whose body passes the simple-body check. Returns the SQL with simple CTEs
    inlined; non-simple CTEs are left in place and become residuals downstream.

    If the SQL has no WITH clause, delegates to flatten_sql_for_price.
    If all CTEs are non-simple, returns sql unchanged.
    If WITH RECURSIVE is detected, returns sql unchanged (everything residual).
    """
    if not HAS_SQLGLOT:
        return sql
    try:
        ast = sqlglot.parse_one(sql)
    except Exception:
        return sql

    # sqlglot 28+: the WITH clause lives under the "with_" key of a Select node.
    # Older versions used "with". Use find() which works across all versions.
    with_node = ast.find(sqlglot_exp.With)
    if with_node is None:
        # No CTEs to gate; behave like flatten_sql_for_price.
        return flatten_sql_for_price(sql, db_name)

    # Detect WITH RECURSIVE
    if with_node.args.get("recursive"):
        return sql  # Don't inline anything; leave as residual.

    # Partition CTEs into simple (inline) vs non-simple (keep).
    simple_ctes = []
    non_simple_ctes = []
    for cte in with_node.expressions:
        body = cte.this
        if isinstance(body, sqlglot_exp.Subquery):
            body = body.this
        if _check_cte_body_simple(body):
            simple_ctes.append(cte)
        else:
            non_simple_ctes.append(cte)

    if not simple_ctes:
        return sql  # Nothing to inline; everything stays as residual.

    # Build an intermediate SQL with only simple CTEs, then run the standard flattener.
    # Use the version-correct key name: "with_" (sqlglot 28+) or "with" (older).
    with_key = "with_" if "with_" in ast.args else "with"
    new_with = with_node.copy()
    new_with.set("expressions", [c.copy() for c in simple_ctes])
    ast.set(with_key, new_with)
    intermediate_sql = ast.sql()

    # Call the standard flattener on the simplified-CTE SQL.
    flattened = flatten_sql_for_price(intermediate_sql, db_name)
    if flattened is None:
        # Flattening failed (e.g., CTE body contains a nested subquery that
        # flatten_sql_for_price can't reduce to base tables). Return None so
        # the caller falls through to _ast_collect_predicates, which has
        # broader heuristic coverage for complex CTE structures.
        return None

    # Non-simple CTEs are detected by the residual collector via the original AST,
    # not the post-transform parse, so we just return the flattened result.
    return flattened


# --- Subquery handling helpers ---


def _inline_exists_subqueries(ast, new_from_tables, tautology):
    """Inline EXISTS/NOT EXISTS subqueries: add inner tables to FROM, replace with join conditions."""

    def _process_exists(exists_node):
        """Extract tables and conditions from EXISTS subquery, return replacement expression."""
        inner_sel = exists_node.this
        if isinstance(inner_sel, sqlglot_exp.Subquery):
            inner_sel = inner_sel.this
        if not isinstance(inner_sel, sqlglot_exp.Select):
            return tautology.copy()

        # Collect inner FROM tables
        for tbl in inner_sel.find_all(sqlglot_exp.Table):
            new_from_tables.append(tbl.sql())

        # Collect conditions from inner WHERE
        inner_where = inner_sel.args.get('where')
        if not inner_where:
            return tautology.copy()

        conditions = []
        _flatten_and(inner_where.this, conditions)

        # Keep equi-join conditions and simple filters, drop non-equi (NEQ, LIKE, etc.)
        keep = []
        for cond in conditions:
            if isinstance(cond, sqlglot_exp.EQ):
                keep.append(cond.copy())
            elif isinstance(cond, (sqlglot_exp.GT, sqlglot_exp.GTE,
                                   sqlglot_exp.LT, sqlglot_exp.LTE)):
                keep.append(cond.copy())
            # Drop NEQ, LIKE, NOT, complex expressions

        if not keep:
            return tautology.copy()

        result = keep[0]
        for c in keep[1:]:
            result = sqlglot_exp.And(this=result, expression=c)
        return sqlglot_exp.Paren(this=result) if len(keep) > 1 else result

    # Handle NOT EXISTS: Not(Exists(...))
    for not_node in list(ast.find_all(sqlglot_exp.Not)):
        if isinstance(not_node.this, sqlglot_exp.Exists):
            replacement = _process_exists(not_node.this)
            not_node.replace(replacement)

    # Handle EXISTS
    for exists_node in list(ast.find_all(sqlglot_exp.Exists)):
        replacement = _process_exists(exists_node)
        exists_node.replace(replacement)


def _inline_in_subqueries(ast, new_from_tables, tautology):
    """Inline IN/NOT IN (subquery): add inner tables to FROM, replace with join condition."""

    def _process_in_subquery(in_node):
        """Process an IN node with a subquery. Returns replacement expression, or None if not a subquery IN."""
        subquery = in_node.args.get('query')
        if subquery is None:
            return None  # Value list IN, not subquery — skip

        col = in_node.this  # The outer column
        inner_sel = subquery.this if isinstance(subquery, sqlglot_exp.Subquery) else subquery
        if not isinstance(inner_sel, sqlglot_exp.Select):
            return tautology.copy()

        # Get the column returned by the subquery
        inner_exprs = inner_sel.expressions
        if not inner_exprs:
            return tautology.copy()

        inner_col_expr = inner_exprs[0]
        if isinstance(inner_col_expr, sqlglot_exp.Alias):
            inner_col_expr = inner_col_expr.this

        # Add inner tables to FROM
        for tbl in inner_sel.find_all(sqlglot_exp.Table):
            new_from_tables.append(tbl.sql())

        # Create equi-join: outer_col = inner_col
        join_cond = sqlglot_exp.EQ(this=col.copy(), expression=inner_col_expr.copy())

        # Collect inner WHERE conditions
        keep = [join_cond]
        inner_where = inner_sel.args.get('where')
        if inner_where:
            conditions = []
            _flatten_and(inner_where.this, conditions)
            for cond in conditions:
                if isinstance(cond, (sqlglot_exp.EQ, sqlglot_exp.GT, sqlglot_exp.GTE,
                                     sqlglot_exp.LT, sqlglot_exp.LTE)):
                    keep.append(cond.copy())

        result = keep[0]
        for c in keep[1:]:
            result = sqlglot_exp.And(this=result, expression=c)
        return sqlglot_exp.Paren(this=result) if len(keep) > 1 else result

    # Handle NOT IN (subquery): Not(In(...))
    for not_node in list(ast.find_all(sqlglot_exp.Not)):
        if isinstance(not_node.this, sqlglot_exp.In):
            replacement = _process_in_subquery(not_node.this)
            if replacement is not None:
                not_node.replace(replacement)

    # Handle IN (subquery)
    for in_node in list(ast.find_all(sqlglot_exp.In)):
        replacement = _process_in_subquery(in_node)
        if replacement is not None:
            in_node.replace(replacement)


def _estimate_scalar_subqueries(ast, db_name, tautology, new_from_tables=None, new_conditions=None):
    """Replace scalar subqueries in comparisons with estimated values from statistics.

    If new_from_tables/new_conditions are provided, also inlines the subquery's
    tables and correlated join conditions into the outer query.
    """

    def _extract_agg_info(select_node):
        """Extract (multiplier, agg_func_name, col_name) from a scalar subquery SELECT."""
        exprs = select_node.expressions
        if len(exprs) != 1:
            return None

        expr = exprs[0]
        if isinstance(expr, sqlglot_exp.Alias):
            expr = expr.this

        multiplier = 1.0

        # Handle multiplier: 0.2 * AGG(col) or AGG(col) * 0.2
        if isinstance(expr, sqlglot_exp.Mul):
            left, right = expr.this, expr.expression
            if isinstance(left, sqlglot_exp.Literal) and left.is_number:
                multiplier = float(left.this)
                expr = right
            elif isinstance(right, sqlglot_exp.Literal) and right.is_number:
                multiplier = float(right.this)
                expr = left

        # Check for aggregate function
        agg_map = {
            sqlglot_exp.Min: 'MIN',
            sqlglot_exp.Max: 'MAX',
            sqlglot_exp.Avg: 'AVG',
            sqlglot_exp.Sum: 'SUM',
            sqlglot_exp.Count: 'COUNT',
        }

        for agg_type, agg_name in agg_map.items():
            if isinstance(expr, agg_type):
                inner = expr.this
                if isinstance(inner, sqlglot_exp.Column):
                    return (multiplier, agg_name, inner.name.lower())
                return None

        return None

    # Find comparisons with subqueries
    for cmp_type in (sqlglot_exp.EQ, sqlglot_exp.LT, sqlglot_exp.GT,
                     sqlglot_exp.LTE, sqlglot_exp.GTE, sqlglot_exp.NEQ):
        for node in list(ast.find_all(cmp_type)):
            left = node.args.get('this')
            right = node.args.get('expression')

            subquery = None
            if isinstance(right, sqlglot_exp.Subquery):
                subquery = right
            elif isinstance(left, sqlglot_exp.Subquery):
                subquery = left

            if subquery is None:
                continue

            inner_sel = subquery.this
            if not isinstance(inner_sel, sqlglot_exp.Select):
                node.replace(tautology.copy())
                continue

            info = _extract_agg_info(inner_sel)
            if info is None:
                # Can't estimate aggregate, drop the filter
                node.replace(tautology.copy())
                continue

            multiplier, agg_func, col_name = info
            estimated = _estimate_aggregate_value(db_name, col_name, agg_func)
            if estimated is None:
                node.replace(tautology.copy())
                continue

            result_val = multiplier * estimated
            # Replace the subquery with the estimated literal
            if result_val == int(result_val):
                replacement_literal = sqlglot_exp.Literal.number(int(result_val))
            else:
                replacement_literal = sqlglot_exp.Literal.number(round(result_val, 4))
            subquery.replace(replacement_literal)

            # Inline subquery's tables and correlated conditions into outer query
            if new_from_tables is not None:
                for tbl in inner_sel.find_all(sqlglot_exp.Table):
                    tbl_sql = tbl.sql()
                    if tbl_sql:
                        new_from_tables.append(tbl_sql)

            if new_conditions is not None:
                inner_where = inner_sel.args.get('where')
                if inner_where:
                    inner_conds = []
                    _flatten_and(inner_where.this, inner_conds)
                    for cond in inner_conds:
                        if isinstance(cond, (sqlglot_exp.EQ, sqlglot_exp.GT, sqlglot_exp.GTE,
                                             sqlglot_exp.LT, sqlglot_exp.LTE,
                                             sqlglot_exp.Between)):
                            new_conditions.append(cond.sql())


def _eval_constant_arithmetic(ast):
    """Evaluate constant arithmetic expressions: 6 + 10 → 16, 1220 + 11 → 1231."""
    changed = True
    while changed:
        changed = False
        for node in list(ast.walk()):
            if not isinstance(node, (sqlglot_exp.Add, sqlglot_exp.Sub,
                                     sqlglot_exp.Mul, sqlglot_exp.Div)):
                continue
            left = node.this
            right = node.expression
            if not (isinstance(left, sqlglot_exp.Literal) and left.is_number and
                    isinstance(right, sqlglot_exp.Literal) and right.is_number):
                continue
            l_val = float(left.this)
            r_val = float(right.this)
            if isinstance(node, sqlglot_exp.Add):
                result = l_val + r_val
            elif isinstance(node, sqlglot_exp.Sub):
                result = l_val - r_val
            elif isinstance(node, sqlglot_exp.Mul):
                result = l_val * r_val
            elif isinstance(node, sqlglot_exp.Div):
                if r_val == 0:
                    continue
                result = l_val / r_val
            else:
                continue
            if result == int(result):
                node.replace(sqlglot_exp.Literal.number(int(result)))
            else:
                node.replace(sqlglot_exp.Literal.number(round(result, 6)))
            changed = True


def _add_tables_to_from(sql, new_tables):
    """Add tables to the FROM clause of a SQL query via string insertion."""
    from_match = re.search(r'\bFROM\b\s+', sql, re.IGNORECASE)
    if from_match:
        insert_pos = from_match.end()
        new_tables_str = ', '.join(new_tables) + ', '
        sql = sql[:insert_pos] + new_tables_str + sql[insert_pos:]
    return sql


def _add_conditions_to_where(sql, conditions):
    """Add extra AND conditions to the WHERE clause of a SQL query."""
    where_match = re.search(r'\bWHERE\b\s+', sql, re.IGNORECASE)
    if where_match:
        insert_pos = where_match.end()
        conditions_str = ' AND '.join(conditions) + ' AND '
        sql = sql[:insert_pos] + conditions_str + sql[insert_pos:]
    return sql


def _preprocess_predicates(sql, db_name=None,
                           price_n_parsing=False, price_n_filter=False,
                           price_n_fanout=False, price_n_pairwise=False):
    """
    Preprocess SQL predicates before PRICE transformation.

    Phase 0 — NNF / OR → IN rewrite (when price_n_parsing=True):
      - Push NOT to leaf atoms via De Morgan / operator flip (NNF)
      - Rewrite disjoint OR-of-EQ chains to IN (val, ...) for same column
      - Normalize date literals to epoch-day integers

    Phase 1 — Subquery handling:
      - EXISTS/NOT EXISTS → inline inner tables and correlated join conditions
      - IN/NOT IN (subquery) → inline inner tables and join condition
      - Scalar subqueries (col op (SELECT AGG(...))) → estimate value from statistics

    Phase 2 — Predicate simplification:
      - BETWEEN → >= AND <=
      - IN (value list) → OR equalities
      - Drop LIKE / NOT LIKE           
      - Drop non-EQ string comparisons

    Phase 3 — Arithmetic evaluation:
      - Constant expressions like 6 + 10 → 16

    Args:
        price_n_parsing: When True, apply NNF push-down, disjoint-OR→IN rewrite,
            and date literal normalisation before Phase 1 subquery handling.
        price_n_filter: Reserved for Phase-N filter encoding (unused here).
        price_n_fanout: Reserved for Phase-N fanout side tracking (unused here).
        price_n_pairwise: Reserved for Phase-N pairwise encoding (unused here).
    """
    if not HAS_SQLGLOT:
        return sql

    try:
        ast = sqlglot.parse_one(sql)
    except Exception:
        return sql

    new_from_tables = []  # tables to add to FROM clause
    new_conditions = []   # conditions to add to WHERE clause (from scalar subquery inlining)
    tautology = sqlglot_exp.EQ(
        this=sqlglot_exp.Literal.number(1),
        expression=sqlglot_exp.Literal.number(1)
    )

    # --- Phase 1: Subquery handling ---
    # Under PRICE_N, EXISTS/IN(subquery)/scalar subqueries go to LLM residual
    # instead of being inlined (avoids semantic-loss approximations).
    if not price_n_parsing:
        _inline_exists_subqueries(ast, new_from_tables, tautology)
    if not price_n_parsing:
        _inline_in_subqueries(ast, new_from_tables, tautology)
    if db_name and not price_n_parsing:
        _estimate_scalar_subqueries(ast, db_name, tautology, new_from_tables, new_conditions)

    # --- Phase 1.5: PRICE_N NNF / OR→IN / date normalisation ---
    # Runs AFTER subquery inlining so that inline-expanded predicates are also
    # rewritten, but BEFORE Phase 2 so the BETWEEN / IN / LIKE simplification
    # operates on the already-normalised tree.
    if price_n_parsing:
        _push_not_to_nnf(ast)
        _rewrite_disjoint_or_to_in(ast)
        _normalize_date_literals(ast)

    # --- Phase 2: Predicate simplification ---

    # BETWEEN → >= AND <= (PRICE_S / base PRICE only).
    # Under PRICE_N the filter token's slot format encodes range bounds
    # natively, so the BETWEEN node survives to _extract_filter_atoms.
    if not price_n_parsing:
        for node in list(ast.find_all(sqlglot_exp.Between)):
            col = node.this
            low = node.args.get('low')
            high = node.args.get('high')
            if col and low and high:
                gte = sqlglot_exp.GTE(this=col.copy(), expression=low.copy())
                lte = sqlglot_exp.LTE(this=col.copy(), expression=high.copy())
                and_expr = sqlglot_exp.And(this=gte, expression=lte)
                node.replace(sqlglot_exp.Paren(this=and_expr))

    # IN (value list) → OR equalities (subquery INs already handled in Phase 1)
    # PRICE_S: preserve IN as-is for SpaceSaving encoding.
    # PRICE_N: also preserve IN — `_extract_filter_atoms` walks `In` nodes
    # natively (line ~1125) and populates `in_values`. Expanding to OR would
    # round-trip through `_rewrite_disjoint_or_to_in` at best, or fragment
    # into separate DNF clauses at worst under --price_n_or.
    if not price_n_parsing:
        for node in list(ast.find_all(sqlglot_exp.In)):
            col = node.this
            values = node.expressions
            if col and values:
                or_expr = None
                for val in values:
                    eq = sqlglot_exp.EQ(this=col.copy(), expression=val.copy())
                    if or_expr is None:
                        or_expr = eq
                    else:
                        or_expr = sqlglot_exp.Or(this=or_expr, expression=eq)
                if or_expr is not None:
                    node.replace(sqlglot_exp.Paren(this=or_expr))

    # LIKE / NOT LIKE / ILIKE / NOT ILIKE handling:
    #   - PRICE_S: preserve in the SQL; the feature extractor matches
    #     the pattern against SpaceSaving keys and encodes as IN-list-style.
    #   - Base PRICE / PRICE_N: drop to 1=1; under PRICE_N the predicate is
    #     classified as LLM residual by analyze_query_for_price_n's
    #     _collect_llm_residuals (which inspects the original AST).
    if True:
        for node in list(ast.find_all(sqlglot_exp.Like)):
            node.replace(tautology.copy())
        for node in list(ast.find_all(sqlglot_exp.ILike)):
            node.replace(tautology.copy())
        for not_node in list(ast.find_all(sqlglot_exp.Not)):
            child = not_node.this
            if isinstance(child, (sqlglot_exp.Like, sqlglot_exp.ILike)):
                not_node.replace(tautology.copy())

    # Drop non-EQ comparisons on string literals.
    # PRICE_N preserves them: its lex-sorted SpaceSaving summary maps
    # `col < 'M'` etc. to a contiguous bin range with a real selectivity
    # via _atom_to_slot. PRICE_S/PRICE_B's frequency-sorted bins can't
    # encode `col op 'string'` meaningfully, so the drop stays for them.
    if not price_n_parsing:
        for cmp_type in (sqlglot_exp.GT, sqlglot_exp.GTE, sqlglot_exp.LT,
                         sqlglot_exp.LTE, sqlglot_exp.NEQ):
            for node in list(ast.find_all(cmp_type)):
                rhs = node.args.get("expression")
                if rhs and isinstance(rhs, sqlglot_exp.Literal) and rhs.is_string:
                    node.replace(tautology.copy())
        for node in list(ast.find_all(sqlglot_exp.Not)):
            child = node.this
            if isinstance(child, sqlglot_exp.EQ):
                rhs = child.args.get("expression")
                if rhs and isinstance(rhs, sqlglot_exp.Literal) and rhs.is_string:
                    node.replace(tautology.copy())

    # --- Phase 3: Arithmetic evaluation ---
    _eval_constant_arithmetic(ast)

    # Generate result
    result = ast.sql()

    # Add inlined tables to FROM clause
    if new_from_tables:
        result = _add_tables_to_from(result, new_from_tables)

    # Add inlined conditions to WHERE clause (from scalar subquery inlining)
    if new_conditions:
        result = _add_conditions_to_where(result, new_conditions)

    return result


def _add_missing_from_tables(sql, db_name):
    """
    If WHERE references aliases not in FROM that map to known PRICE tables,
    add those tables to the FROM clause.

    Example: FROM item tpcds_i, store tpcds_s WHERE tpcds_ss.ss_store_sk = ...
    → adds "store_sales tpcds_ss" to FROM.
    """
    from_match = re.search(
        r'\bSELECT\s+COUNT\(\*\)\s+FROM\s+(.*?)\s+WHERE\s+(.*)',
        sql, re.IGNORECASE | re.DOTALL
    )
    if not from_match:
        return sql

    from_str = from_match.group(1)
    where_str = from_match.group(2)

    # Parse existing FROM aliases
    from_aliases = set()
    for part in from_str.split(','):
        tokens = part.strip().split()
        if len(tokens) >= 2:
            from_aliases.add(tokens[-1].lower())
        elif tokens:
            from_aliases.add(tokens[0].lower())

    # Find all aliases referenced in WHERE
    where_aliases = set()
    for m in re.finditer(r'(\w+)\.\w+', where_str):
        where_aliases.add(m.group(1).lower())

    missing = where_aliases - from_aliases
    if not missing:
        return sql

    # Build reverse mapping: PRICE alias → table name
    abbrev = _load_abbrev_mapping(db_name)
    alias_to_table = {v: k for k, v in abbrev.items()}

    additions = []
    for alias in sorted(missing):
        if alias in alias_to_table:
            table_name = alias_to_table[alias]
            additions.append(f"{table_name} {alias}")

    if not additions:
        return sql

    new_from = from_str + ", " + ", ".join(additions)
    return f"SELECT COUNT(*) FROM {new_from} WHERE {where_str}"


def _convert_between_to_range(sql):
    """Convert BETWEEN conditions to >= AND <= range comparisons.

    Clean numeric BETWEENs (col BETWEEN N1 AND N2) become col >= N1 AND col <= N2.
    Mixed BETWEENs (col BETWEEN 'str' AND N) become col <= N (keep numeric bound).
    BETWEENs with arithmetic (col BETWEEN N AND N + M) are stripped (can't convert).
    String-only BETWEENs are stripped (PRICE can't use string comparisons).

    Must run BEFORE _split_where_on_and is called, since BETWEEN's internal AND
    confuses the AND-splitter.
    """
    # Helper: evaluate simple constant arithmetic like "22 + 30" → 52
    def _eval_arith(expr):
        """Safely evaluate numeric arithmetic (only +, -, *, / with numeric literals)."""
        expr = expr.strip()
        if not re.match(r'^[\d\.\s+\-*/]+$', expr):
            return None  # Not pure numeric arithmetic
        try:
            val = float(eval(expr))  # Safe: validated to only contain digits and operators
            return str(int(val)) if val == int(val) else str(val)
        except Exception:
            return None

    # 1. Numeric BETWEEN (possibly with arithmetic in bounds):
    #    col between 22 and 22 + 30 → col >= 22 AND col <= 52
    #    col between 100 and 500 → col >= 100 AND col <= 500
    def _numeric_between_replacer(m):
        col = m.group(1)
        lo_expr = m.group(2)
        hi_expr = m.group(3)
        lo = _eval_arith(lo_expr)
        hi = _eval_arith(hi_expr)
        if lo is None or hi is None:
            return ''  # Can't evaluate — strip
        return f"{col} >= {lo} AND {col} <= {hi}"

    sql = re.sub(
        r"\b(\w+(?:\.\w+)?)\s+between\s+(\d+(?:\.\d+)?(?:\s*[+\-*/]\s*\d+(?:\.\d+)?)*)\s+and\s+"
        r"(\d+(?:\.\d+)?(?:\s*[+\-*/]\s*\d+(?:\.\d+)?)*)",
        _numeric_between_replacer,
        sql, flags=re.IGNORECASE
    )
    # 2. String-first BETWEEN with numeric upper bound (possibly arithmetic):
    #    col between 'str' and 123 + 30 → col <= 153
    def _string_first_between_replacer(m):
        col = m.group(1)
        hi_expr = m.group(2)
        hi = _eval_arith(hi_expr)
        if hi is None:
            return ''  # Can't evaluate — strip
        return f"{col} <= {hi} "

    sql = re.sub(
        r"\b(\w+(?:\.\w+)?)\s+between\s+'[^']*'\s+and\s+"
        r"(\d+(?:\.\d+)?(?:\s*[+\-*/]\s*\d+(?:\.\d+)?)*)\s*\)?\s*",
        _string_first_between_replacer,
        sql, flags=re.IGNORECASE
    )
    # 3. String-only BETWEEN: col between 'str1' and 'str2' → strip
    sql = re.sub(
        r"\b\w+(?:\.\w+)?\s+between\s+'[^']*'\s+and\s+'[^']*'\s*\)?\s*",
        '', sql, flags=re.IGNORECASE
    )
    # 4. Any remaining BETWEEN (edge cases) — strip as safety net
    sql = re.sub(
        r"\b\w+(?:\.\w+)?\s+between\s+'[^']*'\s+and\s+\S+\s*\)?\s*",
        '', sql, flags=re.IGNORECASE
    )
    # Clean up AND artifacts from stripping
    sql = re.sub(r'\bWHERE\s+AND\s+', 'WHERE ', sql, flags=re.IGNORECASE)
    sql = re.sub(r'\s+AND\s+AND\s+', ' AND ', sql, flags=re.IGNORECASE)
    sql = re.sub(r'\s+AND\s*$', '', sql, flags=re.IGNORECASE)
    return sql


def _strip_same_table_conditions(sql):
    """
    Remove WHERE conditions where both sides reference the same table alias.

    After self-join collapse (e.g., tpcds_dd2 → tpcds_dd), join conditions like
    tpcds_dd.d_week_seq = tpcds_dd.d_week_seq become tautological same-table
    conditions. PRICE's parse_sql counts these as joins, violating the tree
    constraint. Strip them here.

    Also strips dangling references: conditions referencing aliases not in FROM.
    """
    from_match = re.search(
        r'\bSELECT\s+COUNT\(\*\)\s+FROM\s+(.*?)\s+WHERE\s+(.*)',
        sql, re.IGNORECASE | re.DOTALL
    )
    if not from_match:
        return sql

    from_str = from_match.group(1)
    where_str = from_match.group(2)

    # Note: BETWEEN patterns are already converted to >= / <= by _convert_between_to_range
    # which runs before this function in the pipeline.

    # Parse FROM aliases
    from_aliases = set()
    for part in from_str.split(','):
        tokens = part.strip().split()
        if tokens:
            from_aliases.add(tokens[-1].lower())

    raw_conditions = _split_where_on_and(where_str)

    # Unwrap parenthesized compound conditions: "(A and B)" → "A", "B"
    conditions = []
    for cond in raw_conditions:
        stripped = cond.strip()
        # Check if entire condition is wrapped in outer parens with AND inside
        if stripped.startswith('(') and stripped.endswith(')'):
            inner = stripped[1:-1].strip()
            # Only unwrap if inner has balanced parens and contains AND
            depth = 0
            balanced = True
            for ch in inner:
                if ch == '(':
                    depth += 1
                elif ch == ')':
                    depth -= 1
                    if depth < 0:
                        balanced = False
                        break
            if balanced and depth == 0 and ' and ' in inner.lower():
                sub_parts = _split_where_on_and(inner)
                conditions.extend(sub_parts)
                continue
        conditions.append(cond)

    new_conditions = []
    for cond in conditions:
        cond_stripped = cond.strip()

        # Strip tautologies: "1 = 1", "1 = 1 = 1", etc.
        if re.match(r'^1\s*=\s*1(\s*=\s*1)*$', cond_stripped):
            continue

        # Check for same-table conditions: alias.col = alias.col
        m = re.match(r'\s*(\w+)\.(\w+)\s*=\s*(\w+)\.(\w+)\s*$', cond_stripped)
        if m:
            lt, rt = m.group(1).lower(), m.group(3).lower()
            if lt == rt:
                continue  # Skip tautological same-table condition

        # Check for equi-join with bare (unqualified) column on one side
        # e.g., "sold_item_sk = tpcds_i.i_item_sk" — bare column from UNION alias
        # But NOT filter conditions like "tpcds_i.i_manager_id = 1"
        eq_match = re.match(r'\s*(\S+)\s*=\s*(\S+)\s*$', cond_stripped)
        if eq_match:
            lhs, rhs = eq_match.group(1), eq_match.group(2)
            if ('.' in lhs) != ('.' in rhs):
                # Check that the unqualified side looks like a column name, not a literal
                bare_side = lhs if '.' not in lhs else rhs
                if re.match(r'^[a-z_]\w*$', bare_side, re.IGNORECASE):
                    continue  # Bare column join — strip

        # Check for bare column in non-join condition (e.g., "ranking <= 5")
        # If no table qualifier at all in condition, strip it
        if not re.search(r'\w+\.\w+', cond_stripped):
            # No qualified column reference — this is a bare expression
            # Only strip if it looks like a comparison (has an operator)
            if re.search(r'[<>=!]', cond_stripped):
                continue

        # Check for dangling references (aliases in condition not in FROM)
        cond_aliases = set()
        for alias_match in re.finditer(r'(\w+)\.\w+', cond):
            cond_aliases.add(alias_match.group(1).lower())
        if cond_aliases and not cond_aliases.issubset(from_aliases):
            continue  # Skip condition with dangling references

        new_conditions.append(cond)

    if not new_conditions:
        return sql  # Don't remove everything

    return f"SELECT COUNT(*) FROM {from_str} WHERE {' AND '.join(new_conditions)}"


def _hoist_joins_from_or_blocks(sql):
    """
    Handle WHERE clauses that are entirely OR blocks (no top-level AND joins).

    TPC-H Q19 has: WHERE (join AND filters) OR (join AND filters) OR ...
    PRICE needs the join at top level. This function:
    1. Detects when WHERE is a single OR expression (no top-level ANDs)
    2. Scans inside each OR branch for equi-join conditions (alias.col = alias.col)
    3. Hoists the join to top level and keeps the simplest filter conditions
    """
    from_match = re.search(
        r'\bSELECT\s+COUNT\(\*\)\s+FROM\s+(.*?)\s+WHERE\s+(.*)',
        sql, re.IGNORECASE | re.DOTALL
    )
    if not from_match:
        return sql

    from_str = from_match.group(1)
    where_str = from_match.group(2)

    # Check if there are top-level ANDs — if so, this function doesn't apply
    top_level_conditions = _split_where_on_and(where_str)
    if len(top_level_conditions) > 1:
        return sql  # Already has top-level ANDs

    # Check for top-level OR pattern
    if ' or ' not in where_str.lower():
        return sql

    # Parse FROM aliases to identify join patterns
    from_aliases = set()
    for part in from_str.split(','):
        tokens = part.strip().split()
        if len(tokens) >= 2:
            from_aliases.add(tokens[-1].lower())

    # Scan entire WHERE for equi-join conditions (alias.col = alias.col)
    found_joins = []
    for m in re.finditer(r'(\w+)\.(\w+)\s*=\s*(\w+)\.(\w+)', where_str):
        lt, lc = m.group(1).lower(), m.group(2).lower()
        rt, rc = m.group(3).lower(), m.group(4).lower()
        if lt in from_aliases and rt in from_aliases and lt != rt:
            join_str = f"{lt}.{lc} = {rt}.{rc}"
            if join_str not in found_joins:
                found_joins.append(join_str)

    if not found_joins:
        return sql  # No joins found inside OR blocks

    # Scan for simple filter conditions (alias.col op literal)
    # Collect all, then deduplicate by keeping the envelope (widest range)
    # since OR semantics mean any row matching ANY branch is included.
    raw_filters = []
    for m in re.finditer(r'(\w+\.\w+)\s*(>=|<=|>|<|=)\s*(\d+(?:\.\d+)?)\b', where_str):
        col, op, val = m.group(1).lower(), m.group(2), float(m.group(3))
        raw_filters.append((col, op, val))

    # Deduplicate: OR envelope = widest range covering all branches
    #   For <=/<: keep LARGEST value (widest upper bound)
    #   For >=/> : keep SMALLEST value (widest lower bound)
    best = {}  # (col, op) → envelope value
    for col, op, val in raw_filters:
        key = (col, op)
        if key not in best:
            best[key] = val
        elif op in ('<=', '<'):
            best[key] = max(best[key], val)  # Widest upper bound
        elif op in ('>=', '>'):
            best[key] = min(best[key], val)  # Widest lower bound
        # For '=', keep first occurrence

    found_filters = []
    for (col, op), val in sorted(best.items()):
        val_str = str(int(val)) if val == int(val) else str(val)
        found_filters.append(f"{col} {op} {val_str}")

    # Build new WHERE: joins AND deduplicated filters
    new_parts = list(found_joins)

    # Add deduplicated filters (limited to avoid selectivity issues)
    for filt in found_filters:
        new_parts.append(filt)
        if len(new_parts) >= len(found_joins) + 4:
            break  # Limit filter count to avoid selectivity issues

    return f"SELECT COUNT(*) FROM {from_str} WHERE {' AND '.join(new_parts)}"


def _clean_sql_artifacts(sql, price_n_parsing=False):
    """
    Clean up SQL artifacts left by incomplete CTE/subquery flattening.

    Args:
        price_n_parsing: When True, preserve BETWEEN conditions. PRICE_N's
            atom extractor walks `Between` nodes natively and encodes their
            bounds via the slot format. Non-PRICE_N paths already decompose
            BETWEEN to `>=/<=` upstream, so a surviving BETWEEN here is a
            sign of incomplete handling and is safe to strip.

    Handles:
    - Trailing GROUP BY, ORDER BY, LIMIT, HAVING after WHERE clause
    - Excess closing parentheses from partial subquery removal
    - CASE/WHEN/END fragments (e.g., ") else (select ..." or "end as ...")
    - substring() function calls → strip entire condition
    """
    # Only process SELECT COUNT(*) FROM ... WHERE ... queries
    from_match = re.search(
        r'\bSELECT\s+COUNT\(\*\)\s+FROM\s+(.*?)\s+WHERE\s+(.*)',
        sql, re.IGNORECASE | re.DOTALL
    )
    if not from_match:
        return sql

    from_str = from_match.group(1)
    where_str = from_match.group(2)

    # Strip trailing GROUP BY / ORDER BY / LIMIT / HAVING at any paren depth
    # Find the earliest top-level or near-top-level occurrence
    lower = where_str.lower()
    depth = 0
    cut_pos = len(where_str)
    for i, ch in enumerate(where_str):
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
            # Excess closing paren (depth < 0) → cut here
            if depth < 0:
                # Check if everything before this is meaningful
                before = where_str[:i].strip()
                if before:
                    cut_pos = i
                    break
                depth = 0  # Reset and continue
        elif depth <= 0:
            for kw in ['group by', 'order by', 'limit ', 'having ']:
                if lower[i:i+len(kw)] == kw:
                    if i > 0 and not lower[i-1].isalnum():
                        cut_pos = i
                        break
            if cut_pos != len(where_str):
                break

    where_str = where_str[:cut_pos].strip()

    # Remove trailing excess closing parens
    while where_str.endswith(')'):
        depth = 0
        for ch in where_str:
            if ch == '(':
                depth += 1
            elif ch == ')':
                depth -= 1
        if depth < 0:
            where_str = where_str[:-1].strip()
        else:
            break

    # Strip CASE/WHEN/END fragments: ") else ..." or "end as ..."
    # These come from partially extracted CASE expressions
    for pattern in [r'\)\s*else\s*\(.*', r'\bend\s+as\s+\w+.*']:
        where_str = re.sub(pattern, '', where_str, flags=re.IGNORECASE | re.DOTALL).strip()

    # Note: BETWEEN patterns are already converted to >= / <= by _convert_between_to_range
    # which runs before this function in the pipeline.

    # Strip conditions PRICE can't handle
    conditions = _split_where_on_and(where_str)
    cleaned_conditions = []
    for cond in conditions:
        cond_lower = cond.lower().strip()
        if 'substring(' in cond_lower:
            continue  # Drop substring conditions
        if ' between ' in cond_lower and not price_n_parsing:
            continue  # Drop BETWEEN (mixed type dates, etc.) — PRICE_N
                      # natively encodes BETWEEN via its slot format, so
                      # only drop on non-PRICE_N paths.
        if 'exists' in cond_lower:
            continue  # Drop EXISTS subqueries
        cleaned_conditions.append(cond)

    if cleaned_conditions:
        where_str = ' AND '.join(cleaned_conditions)
    else:
        where_str = where_str  # Keep original if all stripped

    # Clean up trailing AND
    where_str = re.sub(r'\s+AND\s*$', '', where_str, flags=re.IGNORECASE).strip()

    if not where_str:
        return sql  # Don't produce empty WHERE

    return f"SELECT COUNT(*) FROM {from_str} WHERE {where_str}"


def _prune_redundant_joins(sql):
    """
    Remove redundant join conditions to satisfy PRICE's tree constraint:
    len(tables) == len(joins) + 1.

    Job_full queries often have cyclic joins (e.g., t.id = ci.movie_id AND
    t.id = mc.movie_id AND ci.movie_id = mc.movie_id). We keep a spanning
    tree of joins using union-find to detect cycles.

    Uses sqlglot AST manipulation to remove redundant EQ nodes from WHERE.
    """
    if not HAS_SQLGLOT:
        return sql

    try:
        ast = sqlglot.parse_one(sql)
    except Exception:
        return sql

    where = ast.args.get("where")
    if where is None:
        return sql

    # Collect all EQ nodes that are joins (both sides are Column references)
    join_eqs = []
    filter_eqs = []
    for eq in where.find_all(sqlglot_exp.EQ):
        left = eq.args.get("this")
        right = eq.args.get("expression")
        if isinstance(left, sqlglot_exp.Column) and isinstance(right, sqlglot_exp.Column):
            # Extract table alias from column reference
            left_table = left.table if left.table else ""
            right_table = right.table if right.table else ""
            if left_table and right_table and left_table != right_table:
                join_eqs.append((eq, left_table, right_table))

    if not join_eqs:
        return sql

    # Count tables from FROM clause
    tables = set()
    for table in ast.find_all(sqlglot_exp.Table):
        tables.add(table.alias_or_name)

    n_tables = len(tables)
    n_needed = n_tables - 1

    if len(join_eqs) <= n_needed:
        return sql  # Already satisfies or under constraint

    # Union-Find to build spanning tree
    parent = {}

    def find(x):
        while parent.get(x, x) != x:
            parent[x] = parent.get(parent[x], parent[x])
            x = parent[x]
        return x

    def union(x, y):
        rx, ry = find(x), find(y)
        if rx == ry:
            return False  # Cycle detected
        parent[rx] = ry
        return True

    # Keep joins that don't create cycles
    keep = []
    remove = []
    for eq, lt, rt in join_eqs:
        if union(lt, rt):
            keep.append(eq)
        else:
            remove.append(eq)

    if not remove:
        return sql

    # Remove redundant join EQ nodes from the WHERE clause
    # Replace them with TRUE (1 = 1) to avoid breaking AND chains
    tautology = sqlglot_exp.EQ(
        this=sqlglot_exp.Literal.number(1),
        expression=sqlglot_exp.Literal.number(1)
    )
    for eq in remove:
        eq.replace(tautology.copy())

    return ast.sql()


def _strip_tautologies(sql):
    """Remove 1 = 1 tautologies from WHERE clause.

    _prune_redundant_joins replaces cyclic joins with 1 = 1 tautologies.
    This function cleans them up afterward.
    """
    from_match = re.search(
        r'\bSELECT\s+COUNT\(\*\)\s+FROM\s+(.*?)\s+WHERE\s+(.*)',
        sql, re.IGNORECASE | re.DOTALL
    )
    if not from_match:
        return sql

    from_str = from_match.group(1)
    where_str = from_match.group(2)
    conditions = _split_where_on_and(where_str)
    filtered = [c for c in conditions
                if not re.match(r'^\s*1\s*=\s*1(\s*=\s*1)*\s*$', c.strip())]

    if not filtered:
        return sql  # Don't remove everything

    return f"SELECT COUNT(*) FROM {from_str} WHERE {' AND '.join(filtered)}"


def _split_where_on_and(where_str):
    """Split WHERE clause string on top-level AND, respecting parentheses."""
    parts = []
    depth = 0
    current = []
    i = 0
    where_lower = where_str.lower()
    while i < len(where_str):
        if where_str[i] == '(':
            depth += 1
            current.append(where_str[i])
        elif where_str[i] == ')':
            depth -= 1
            current.append(where_str[i])
        elif depth == 0 and where_lower[i:i+5] == ' and ' and i > 0:
            parts.append(''.join(current).strip())
            current = []
            i += 5
            continue
        else:
            current.append(where_str[i])
        i += 1
    if current:
        parts.append(''.join(current).strip())
    return [p for p in parts if p]


def _collapse_self_joins(sql):
    """
    Collapse numbered self-join aliases (e.g., tpcds_dd2 → tpcds_dd) when the
    numbered alias only joins to its base alias via tautological self-joins.

    After collapsing, the tautological join (tpcds_dd.col = tpcds_dd.col) will
    be cleaned up by _prune_redundant_joins.
    """
    from_match = re.search(
        r'\bSELECT\s+COUNT\(\*\)\s+FROM\s+(.*?)\s+WHERE\s+(.*)',
        sql, re.IGNORECASE | re.DOTALL
    )
    if not from_match:
        return sql

    from_str = from_match.group(1)
    where_str = from_match.group(2)

    # Parse tables: "table alias, table alias, ..."
    table_entries = []
    for part in from_str.split(','):
        part = part.strip()
        if not part:
            continue
        tokens = part.split()
        alias = tokens[-1].lower() if len(tokens) >= 2 else tokens[0].lower()
        table_entries.append((alias, part))

    alias_set = {e[0] for e in table_entries}
    if len(alias_set) <= 1:
        return sql

    # Identify numbered aliases: match pattern base_alias + digit(s)
    numbered_aliases = {}  # numbered_alias → base_alias
    for alias in sorted(alias_set):
        m = re.match(r'^(.+?)(\d+)$', alias)
        if m and m.group(1) in alias_set:
            numbered_aliases[alias] = m.group(1)

    if not numbered_aliases:
        return sql

    # Check which numbered aliases can be collapsed:
    # Collapse if ALL join partners are the base alias (or no joins at all)
    can_collapse = {}
    for numbered, base in numbered_aliases.items():
        join_partners = set()
        for m_join in re.finditer(r'(\w+)\.(\w+)\s*=\s*(\w+)\.(\w+)', where_str, re.IGNORECASE):
            lt, rt = m_join.group(1).lower(), m_join.group(3).lower()
            if lt == numbered:
                join_partners.add(rt)
            elif rt == numbered:
                join_partners.add(lt)
        if join_partners <= {base}:
            can_collapse[numbered] = base

    if not can_collapse:
        return sql

    # Perform collapse: replace numbered alias → base in WHERE, remove from FROM
    new_from_parts = [entry for alias, entry in table_entries if alias not in can_collapse]
    new_where = where_str
    for numbered, base in sorted(can_collapse.items(), key=lambda x: -len(x[0])):
        new_where = re.sub(r'\b' + re.escape(numbered) + r'\.', base + '.', new_where)

    return f"SELECT COUNT(*) FROM {', '.join(new_from_parts)} WHERE {new_where}"


def _prune_disconnected_tables(sql):
    """
    Remove tables from FROM that have no join conditions linking them to
    any other table. Keeps the largest connected component.
    """
    from_match = re.search(
        r'\bSELECT\s+COUNT\(\*\)\s+FROM\s+(.*?)\s+WHERE\s+(.*)',
        sql, re.IGNORECASE | re.DOTALL
    )
    if not from_match:
        return sql

    from_str = from_match.group(1)
    where_str = from_match.group(2)

    # Parse tables
    table_entries = []
    for part in from_str.split(','):
        part = part.strip()
        if not part:
            continue
        tokens = part.split()
        alias = tokens[-1].lower() if len(tokens) >= 2 else tokens[0].lower()
        table_entries.append((alias, part))

    aliases = {e[0] for e in table_entries}
    if len(aliases) <= 1:
        return sql

    # Build adjacency from join conditions
    adj = {a: set() for a in aliases}
    for m_join in re.finditer(r'(\w+)\.(\w+)\s*=\s*(\w+)\.(\w+)', where_str, re.IGNORECASE):
        lt = m_join.group(1).lower()
        rt = m_join.group(3).lower()
        if lt in aliases and rt in aliases and lt != rt:
            adj[lt].add(rt)
            adj[rt].add(lt)

    # Find largest connected component via BFS
    visited = set()
    components = []
    for start in sorted(aliases):
        if start in visited:
            continue
        component = set()
        queue = [start]
        while queue:
            node = queue.pop(0)
            if node in visited:
                continue
            visited.add(node)
            component.add(node)
            for neighbor in adj.get(node, set()):
                if neighbor not in visited:
                    queue.append(neighbor)
        components.append(component)

    if not components:
        return sql

    # If multiple components have same size, prefer the one with more filter conditions
    def _component_score(comp):
        # Primary: size. Secondary: number of filter conditions referencing this component
        filter_count = 0
        for cond in _split_where_on_and(where_str):
            for alias in comp:
                if re.search(r'\b' + re.escape(alias) + r'\.', cond, re.IGNORECASE):
                    filter_count += 1
                    break
        return (len(comp), filter_count)

    largest = max(components, key=_component_score)

    if len(largest) == len(aliases):
        return sql  # All connected

    removed = aliases - largest

    # Filter FROM entries
    new_from_parts = [entry for alias, entry in table_entries if alias in largest]

    # Filter WHERE conditions: remove any referencing removed aliases
    conditions = _split_where_on_and(where_str)
    new_conditions = []
    for cond in conditions:
        cond_lower = cond.lower()
        references_removed = False
        for removed_alias in removed:
            if re.search(r'\b' + re.escape(removed_alias) + r'\.', cond_lower):
                references_removed = True
                break
        if not references_removed:
            new_conditions.append(cond)

    if not new_conditions:
        return sql  # Don't remove everything

    return f"SELECT COUNT(*) FROM {', '.join(new_from_parts)} WHERE {' AND '.join(new_conditions)}"


def _ast_collect_predicates(sql, db_name):
    """
    Last-resort predicate collection: walk entire SQL AST to extract all tables,
    equi-joins, and filters from every level (CTEs, UNION branches, subqueries).

    Used when CTE flattening fails. Builds the largest connected component and
    constructs a synthetic flat SQL for PRICE.

    Returns flat SQL string, or None if extraction fails.
    """
    if not HAS_SQLGLOT:
        return None

    try:
        ast = sqlglot.parse_one(sql)
    except Exception:
        return None

    # Identify CTE names (to exclude from table list)
    cte_names = set()
    with_clause = ast.args.get('with_')
    if with_clause:
        for cte in with_clause.find_all(sqlglot_exp.CTE):
            cte_names.add(cte.alias.lower())

    # Collect ALL real tables from every level
    tables = set()
    for tbl in ast.find_all(sqlglot_exp.Table):
        name = tbl.name.lower()
        if name and name not in cte_names:
            tables.add(name)

    if not tables:
        return None

    # Collect ALL equi-join conditions (Column = Column) from every level
    joins = []
    for eq in ast.find_all(sqlglot_exp.EQ):
        left = eq.args.get("this")
        right = eq.args.get("expression")
        if isinstance(left, sqlglot_exp.Column) and isinstance(right, sqlglot_exp.Column):
            left_col = left.name.lower()
            right_col = right.name.lower()
            if left_col != right_col:  # Skip tautological self-joins
                joins.append((left_col, right_col))

    # Collect simple filter conditions from every level
    filters = []
    for cmp_type, op_str in [(sqlglot_exp.GT, '>'), (sqlglot_exp.GTE, '>='),
                              (sqlglot_exp.LT, '<'), (sqlglot_exp.LTE, '<='),
                              (sqlglot_exp.EQ, '=')]:
        for node in ast.find_all(cmp_type):
            left = node.args.get("this")
            right = node.args.get("expression")
            if isinstance(left, sqlglot_exp.Column) and not isinstance(right, sqlglot_exp.Column):
                if isinstance(right, (sqlglot_exp.Literal, sqlglot_exp.Neg)):
                    filters.append((left.name.lower(), op_str, right.sql()))
            elif isinstance(right, sqlglot_exp.Column) and not isinstance(left, sqlglot_exp.Column):
                if isinstance(left, (sqlglot_exp.Literal, sqlglot_exp.Neg)):
                    flip = {'=': '=', '>': '<', '>=': '<=', '<': '>', '<=': '>='}
                    filters.append((right.name.lower(), flip[op_str], left.sql()))

    # Collect BETWEEN conditions
    for node in ast.find_all(sqlglot_exp.Between):
        col = node.this
        if isinstance(col, sqlglot_exp.Column):
            low = node.args.get('low')
            high = node.args.get('high')
            if low and high:
                filters.append((col.name.lower(), '>=', low.sql()))
                filters.append((col.name.lower(), '<=', high.sql()))

    # Deduplicate joins
    seen = set()
    unique_joins = []
    for left, right in joins:
        key = tuple(sorted([left, right]))
        if key not in seen:
            seen.add(key)
            unique_joins.append((left, right))

    # Build adjacency graph for tables using column prefix mapping
    col_prefixes = _TPCH_COL_PREFIX if db_name == 'tpch' else _TPCDS_COL_PREFIX if db_name == 'tpcds' else []

    def _col_to_table(col_name):
        for prefix, tbl in col_prefixes:
            if col_name.startswith(prefix):
                return tbl
        return None

    # Collect IN (value list) conditions
    for node in ast.find_all(sqlglot_exp.In):
        col = node.this
        values = node.expressions
        if isinstance(col, sqlglot_exp.Column) and values:
            col_name = col.name.lower()
            ct = _col_to_table(col_name)
            if not ct:
                continue
            # Numeric values → range
            nums = []
            for v in values:
                if isinstance(v, sqlglot_exp.Literal) and not v.is_string:
                    try:
                        nums.append(float(v.this))
                    except (ValueError, TypeError):
                        break
                elif isinstance(v, sqlglot_exp.Neg) and isinstance(v.this, sqlglot_exp.Literal):
                    try:
                        nums.append(-float(v.this.this))
                    except (ValueError, TypeError):
                        break
                else:
                    break
            if len(nums) == len(values) and nums:
                filters.append((col_name, '>=', str(min(nums))))
                filters.append((col_name, '<=', str(max(nums))))
                continue
            # String values → representative equality
            if values and isinstance(values[0], sqlglot_exp.Literal) and values[0].is_string:
                filters.append((col_name, '=', values[0].sql()))

    # Find connected component: map joins to table pairs
    table_adj = {t: set() for t in tables}
    valid_joins = []
    for left, right in unique_joins:
        lt = _col_to_table(left)
        rt = _col_to_table(right)
        if lt and rt and lt != rt and lt in tables and rt in tables:
            table_adj[lt].add(rt)
            table_adj[rt].add(lt)
            valid_joins.append((left, right))

    # Find largest connected component via BFS
    visited = set()
    components = []
    for start in sorted(tables):
        if start in visited:
            continue
        component = set()
        queue = [start]
        while queue:
            node = queue.pop(0)
            if node in visited:
                continue
            visited.add(node)
            component.add(node)
            for neighbor in table_adj.get(node, set()):
                if neighbor not in visited:
                    queue.append(neighbor)
        components.append(component)

    if not components:
        return None
    largest = max(components, key=len)

    # Build flat SQL with tables in largest component
    from_parts = sorted(largest)
    where_parts = []

    for left, right in valid_joins:
        lt = _col_to_table(left)
        rt = _col_to_table(right)
        if lt in largest and rt in largest:
            where_parts.append(f"{left} = {right}")

    for col, op, val in filters:
        ct = _col_to_table(col)
        if ct and ct in largest:
            where_parts.append(f"{col} {op} {val}")

    if not where_parts:
        return None

    return f"SELECT COUNT(*) FROM {', '.join(from_parts)} WHERE {' AND '.join(where_parts)}"


def _regex_collect_predicates(sql, db_name):
    """
    Regex-based fallback predicate collector for when sqlglot can't parse the SQL.

    Scans the raw SQL text for:
    - Known table names (from abbrev mapping)
    - Equi-join conditions (col = col where columns belong to different tables)
    - Simple filter conditions (col op literal)

    Returns flat SQL string, or None if insufficient predicates found.
    """
    col_prefixes = _TPCH_COL_PREFIX if db_name == 'tpch' else _TPCDS_COL_PREFIX if db_name == 'tpcds' else []
    abbrev = _load_abbrev_mapping(db_name)

    def _col_to_table(col_name):
        for prefix, tbl in col_prefixes:
            if col_name.startswith(prefix):
                return tbl
        return None

    sql_lower = sql.lower()

    # Find all table names from the abbreviation mapping that appear in the SQL
    tables = set()
    for table_name in abbrev:
        if re.search(r'\b' + re.escape(table_name) + r'\b', sql_lower):
            tables.add(table_name)

    if not tables:
        return None

    # Find all equi-join conditions: col1 = col2 (both are column-like identifiers)
    joins = []
    seen_joins = set()
    for m in re.finditer(r'(\w+)\s*=\s*(\w+)', sql_lower):
        left, right = m.group(1), m.group(2)
        lt = _col_to_table(left)
        rt = _col_to_table(right)
        if lt and rt and lt != rt and lt in tables and rt in tables:
            key = tuple(sorted([left, right]))
            if key not in seen_joins:
                seen_joins.add(key)
                joins.append((left, right))

    # Also check alias.col = alias.col patterns
    for m in re.finditer(r'(\w+)\.(\w+)\s*=\s*(\w+)\.(\w+)', sql_lower):
        left_col, right_col = m.group(2), m.group(4)
        lt = _col_to_table(left_col)
        rt = _col_to_table(right_col)
        if lt and rt and lt != rt and lt in tables and rt in tables:
            key = tuple(sorted([left_col, right_col]))
            if key not in seen_joins:
                seen_joins.add(key)
                joins.append((left_col, right_col))

    # Find simple filter conditions: col op literal
    filters = []
    for m in re.finditer(r'(\w+)\s*(>=|<=|>|<|=)\s*(\d+(?:\.\d+)?)\b', sql_lower):
        col, op, val = m.group(1), m.group(2), m.group(3)
        ct = _col_to_table(col)
        if ct and ct in tables:
            filters.append((col, op, val))

    # Also find alias.col op literal
    for m in re.finditer(r'(\w+)\.(\w+)\s*(>=|<=|>|<|=)\s*(\d+(?:\.\d+)?)\b', sql_lower):
        col, op, val = m.group(2), m.group(3), m.group(4)
        ct = _col_to_table(col)
        if ct and ct in tables:
            filters.append((col, op, val))

    # String literal filters: col = 'value'
    for m in re.finditer(r"(\w+)\.(\w+)\s*(>=|<=|>|<|=)\s*'([^']*)'", sql_lower):
        col, op, val = m.group(2), m.group(3), f"'{m.group(4)}'"
        ct = _col_to_table(col)
        if ct and ct in tables:
            filters.append((col, op, val))

    # IN-list filters: alias.col IN (val1, val2, ...)
    for m in re.finditer(r'(\w+)\.(\w+)\s+in\s*\(([^)]+)\)', sql_lower):
        col = m.group(2)
        ct = _col_to_table(col)
        if ct and ct in tables:
            vals_str = m.group(3)
            # Try numeric (no quotes present)
            nums = []
            for v in re.findall(r'-?\d+(?:\.\d+)?', vals_str):
                try:
                    nums.append(float(v))
                except ValueError:
                    pass
            if nums and len(re.findall(r"'", vals_str)) == 0:
                filters.append((col, '>=', str(min(nums))))
                filters.append((col, '<=', str(max(nums))))
            else:
                # String IN-list: pick first quoted value
                str_match = re.search(r"'([^']*)'", vals_str)
                if str_match:
                    filters.append((col, '=', f"'{str_match.group(1)}'"))

    # Also bare column IN-lists (no table prefix)
    seen_in_filters = set()
    for m in re.finditer(r'\b(\w+)\s+in\s*\(([^)]+)\)', sql_lower):
        col = m.group(1)
        ct = _col_to_table(col)
        if ct and ct in tables:
            vals_str = m.group(2)
            nums = []
            for v in re.findall(r'-?\d+(?:\.\d+)?', vals_str):
                try:
                    nums.append(float(v))
                except ValueError:
                    pass
            if nums and len(re.findall(r"'", vals_str)) == 0:
                key = (col, '>=', str(min(nums)))
                if key not in seen_in_filters:
                    seen_in_filters.add(key)
                    filters.append(key)
                key2 = (col, '<=', str(max(nums)))
                if key2 not in seen_in_filters:
                    seen_in_filters.add(key2)
                    filters.append(key2)
            else:
                str_match = re.search(r"'([^']*)'", vals_str)
                if str_match:
                    key = (col, '=', f"'{str_match.group(1)}'")
                    if key not in seen_in_filters:
                        seen_in_filters.add(key)
                        filters.append(key)

    if not joins:
        return None

    # Build adjacency graph for connected component
    table_adj = {t: set() for t in tables}
    valid_joins = []
    for left, right in joins:
        lt = _col_to_table(left)
        rt = _col_to_table(right)
        table_adj[lt].add(rt)
        table_adj[rt].add(lt)
        valid_joins.append((left, right))

    # Find largest connected component
    visited = set()
    components = []
    for start in sorted(tables):
        if start in visited:
            continue
        component = set()
        queue = [start]
        while queue:
            node = queue.pop(0)
            if node in visited:
                continue
            visited.add(node)
            component.add(node)
            for neighbor in table_adj.get(node, set()):
                if neighbor not in visited:
                    queue.append(neighbor)
        components.append(component)

    largest = max(components, key=len) if components else set()

    # Build flat SQL
    from_parts = sorted(largest)
    where_parts = []

    for left, right in valid_joins:
        lt = _col_to_table(left)
        rt = _col_to_table(right)
        if lt in largest and rt in largest:
            where_parts.append(f"{left} = {right}")

    # Deduplicate filters
    seen_filters = set()
    for col, op, val in filters:
        ct = _col_to_table(col)
        if ct and ct in largest:
            filt = f"{col} {op} {val}"
            if filt not in seen_filters:
                seen_filters.add(filt)
                where_parts.append(filt)

    if not where_parts:
        return None

    return f"SELECT COUNT(*) FROM {', '.join(from_parts)} WHERE {' AND '.join(where_parts)}"


def _build_partial_outer_sql(sql, db_name):
    """Extract the representable structure of the OUTER SELECT.

    Used as the partial-encoding fallback when transform_sql_for_price would
    otherwise return the `dummy_table` sentinel. The idea: when a query has
    non-representable parts (non-simple CTEs, scalar subqueries in projections,
    UNION-ALL derived tables), the OUTER query still typically has some
    base tables and direct filters that PRICE_N CAN encode. Encoding those
    gives stat-core a real signal instead of all zeros.

    Strategy:
      - Walk the OUTER SELECT only (do not recurse into Subquery/Exists/CTE).
      - Collect FROM sources that are physical Tables (skip Subqueries/CTE
        references — those are residual).
      - Collect outer-WHERE conjuncts (not inside a Subquery/Exists).
      - Keep a conjunct only if every column reference in it resolves to an
        in-scope alias (an alias we kept above). Bare unqualified columns
        are accepted (downstream column-prefix mapping handles them).

    Returns a flat `SELECT COUNT(*) FROM t1, t2 WHERE ...` string suitable to
    feed back into the rest of transform_sql_for_price, or None when nothing
    representable remains.
    """
    if not HAS_SQLGLOT:
        return None
    try:
        ast = sqlglot.parse_one(sql)
    except Exception:
        return None
    if not isinstance(ast, sqlglot_exp.Select):
        return None

    # CTE names from the WITH clause — `Table` nodes in FROM that reference
    # these aren't physical tables, they're CTE refs and must not enter scope.
    cte_names = set()
    with_node = ast.find(sqlglot_exp.With)
    if with_node is not None:
        for cte in with_node.expressions:
            if cte.alias:
                cte_names.add(cte.alias.lower())
            elif hasattr(cte, "name") and cte.name:
                cte_names.add(cte.name.lower())

    # Outer FROM: collect PHYSICAL base tables and the aliases they introduce.
    # Skip CTE references and Subquery sources — those go to residual.
    in_scope_aliases = set()
    base_table_parts = []
    from_node = ast.args.get("from_")
    if from_node is None:
        return None
    primary = from_node.this
    if isinstance(primary, sqlglot_exp.Table) and primary.name.lower() not in cte_names:
        in_scope_aliases.add(primary.alias_or_name.lower())
        base_table_parts.append(primary.sql())
    for join in (ast.args.get("joins") or []):
        src = join.this
        if isinstance(src, sqlglot_exp.Table) and src.name.lower() not in cte_names:
            in_scope_aliases.add(src.alias_or_name.lower())
            base_table_parts.append(src.sql())

    if not base_table_parts:
        return None

    # Build a bare-column → table-alias resolver for tpcds/tpch using the
    # column-prefix mapping. Lets us reject `sold_item_sk = i_item_sk` where
    # `sold_item_sk` isn't a column of any in-scope table.
    col_prefix_to_table = None
    if db_name in ("tpcds", "tpch"):
        prefixes = _TPCDS_COL_PREFIX if db_name == "tpcds" else _TPCH_COL_PREFIX
        # Build the set of in-scope physical table names (resolve aliases back
        # via the FROM clause we just parsed).
        in_scope_physical = set()
        if isinstance(primary, sqlglot_exp.Table) and primary.name.lower() not in cte_names:
            in_scope_physical.add(primary.name.lower())
        for join in (ast.args.get("joins") or []):
            src = join.this
            if isinstance(src, sqlglot_exp.Table) and src.name.lower() not in cte_names:
                in_scope_physical.add(src.name.lower())
        col_prefix_to_table = [(p, t) for p, t in prefixes if t in in_scope_physical]

    def _bare_col_in_scope(col_name):
        if col_prefix_to_table is None:
            return True  # Unknown workload — don't reject.
        lc = col_name.lower()
        # Sort by prefix length descending so `ws_` wins over `w_` for `ws_item_sk`.
        for prefix, _table in sorted(col_prefix_to_table, key=lambda x: -len(x[0])):
            if lc.startswith(prefix):
                return True
        return False

    # Outer WHERE: collect top-level conjuncts, drop those that reference
    # any alias not in scope.
    where_node = ast.args.get("where")
    kept_conjuncts = []
    if where_node is not None:
        conjuncts = []
        _flatten_and(where_node.this, conjuncts)
        for cond in conjuncts:
            # Skip the entire predicate if it lives inside a Subquery/Exists
            # (shouldn't happen for top-level WHERE conjuncts, but be safe).
            if _is_inside_subquery(cond):
                continue
            # Reject conjuncts that mention an out-of-scope alias on any column,
            # or a bare column whose name doesn't match any in-scope table's
            # column-prefix (catches `sold_item_sk` from a dropped UNION-ALL
            # derived table when the outer FROM only has `item, time_dim`).
            ok = True
            for col in cond.find_all(sqlglot_exp.Column):
                if _is_inside_subquery(col):
                    ok = False
                    break
                if col.table:
                    if col.table.lower() not in in_scope_aliases:
                        ok = False
                        break
                else:
                    if not _bare_col_in_scope(col.name or ""):
                        ok = False
                        break
            if not ok:
                continue
            # Also reject conjuncts that themselves contain a Subquery
            # (e.g. `col > (SELECT AVG(x) FROM ...)`).
            if cond.find(sqlglot_exp.Subquery) is not None:
                continue
            # Wrap in parens so OR-groups don't bleed into the surrounding
            # AND chain — `... AND (a OR b) AND c` is correct; without parens
            # we'd emit `... AND a OR b AND c` which mis-parses by precedence.
            kept_conjuncts.append(f"({cond.sql()})")

    if not kept_conjuncts:
        # No representable predicates. A bare `FROM t1, t2 WHERE 1=1` would
        # encode the table sizes but no joins/filters — still better than
        # all-zero, but PRICE_N's downstream guards may reject it. Emit a
        # tautology so the downstream alias rewriter + cleanup paths kick in.
        return f"SELECT COUNT(*) FROM {', '.join(base_table_parts)} WHERE 1 = 1"

    return (f"SELECT COUNT(*) FROM {', '.join(base_table_parts)} "
            f"WHERE {' AND '.join(kept_conjuncts)}")


def _build_price_b_sql(sql, db_name):
    """PRICE_B encoder: keep only equi-join and col-op-literal predicates.

    Original-PRICE semantics:
      - Equi-join:        `t1.col = t2.col`
      - col-op-literal:   `col op literal` where op ∈ {=, <, <=, >, >=, !=}

    Everything else is DROPPED (not decomposed, not approximated):
      - BETWEEN, IN-list, LIKE, IS NULL / IS NOT NULL, NOT, OR
      - EXISTS / IN-subquery / scalar subquery

    The function never returns the `dummy_table` sentinel. When no
    predicates survive, it emits `WHERE 1 = 1` so downstream alias-rewriting
    still runs on the FROM clause.

    Returns a flat SELECT COUNT(*) string suitable to substitute into the
    rest of transform_sql_for_price.
    """
    if not HAS_SQLGLOT:
        return None
    # Normalize epoch dates before parsing so `date '...'` doesn't become
    # an opaque sub-expression that we can't classify.
    sql = _convert_timestamps_to_epoch(sql)
    try:
        ast = sqlglot.parse_one(sql)
    except Exception:
        return None
    if not isinstance(ast, sqlglot_exp.Select):
        return None

    # Skip CTE references (treat as residual).
    cte_names = set()
    with_node = ast.find(sqlglot_exp.With)
    if with_node is not None:
        for cte in with_node.expressions:
            if cte.alias:
                cte_names.add(cte.alias.lower())
            elif hasattr(cte, "name") and cte.name:
                cte_names.add(cte.name.lower())

    in_scope_aliases = set()
    base_table_parts = []
    from_node = ast.args.get("from_")
    if from_node is None:
        return None
    primary = from_node.this
    if isinstance(primary, sqlglot_exp.Table) and primary.name.lower() not in cte_names:
        in_scope_aliases.add(primary.alias_or_name.lower())
        base_table_parts.append(primary.sql())
    for join in (ast.args.get("joins") or []):
        src = join.this
        if isinstance(src, sqlglot_exp.Table) and src.name.lower() not in cte_names:
            in_scope_aliases.add(src.alias_or_name.lower())
            base_table_parts.append(src.sql())

    if not base_table_parts:
        return None

    # Allowed atom shapes per PRICE_B rules.
    _SIMPLE_OPS = (sqlglot_exp.EQ, sqlglot_exp.NEQ,
                   sqlglot_exp.GT, sqlglot_exp.GTE,
                   sqlglot_exp.LT, sqlglot_exp.LTE)

    # Bare-column → in-scope check via TPC-{H,DS} column-prefix mapping.
    # Catches columns from dropped derived-table projections (e.g. a UNION-ALL
    # subquery's `ws_item_sk AS sold_item_sk` leaving `sold_item_sk` as a
    # bare ref in outer WHERE — it doesn't match any in-scope table's prefix).
    _col_prefix_to_table = None
    if db_name in ("tpcds", "tpch"):
        _prefixes = _TPCDS_COL_PREFIX if db_name == "tpcds" else _TPCH_COL_PREFIX
        _in_scope_phys = set()
        if isinstance(primary, sqlglot_exp.Table) and primary.name.lower() not in cte_names:
            _in_scope_phys.add(primary.name.lower())
        for join in (ast.args.get("joins") or []):
            src = join.this
            if isinstance(src, sqlglot_exp.Table) and src.name.lower() not in cte_names:
                _in_scope_phys.add(src.name.lower())
        _col_prefix_to_table = [(p, t) for p, t in _prefixes if t in _in_scope_phys]

    def _bare_col_in_scope(col_name):
        if _col_prefix_to_table is None:
            return True  # unknown workload — don't reject
        lc = col_name.lower()
        for prefix, _t in sorted(_col_prefix_to_table, key=lambda x: -len(x[0])):
            if lc.startswith(prefix):
                return True
        return False

    def _is_in_scope(col):
        if col.table:
            return col.table.lower() in in_scope_aliases
        return _bare_col_in_scope(col.name or "")

    def _is_allowed_atom(node):
        """True iff node is an equi-join (col = col) or col-op-literal."""
        if not isinstance(node, _SIMPLE_OPS):
            return False
        lhs, rhs = node.left, node.right
        # col = col (equi-join), only for EQ.
        if (isinstance(node, sqlglot_exp.EQ)
                and isinstance(lhs, sqlglot_exp.Column)
                and isinstance(rhs, sqlglot_exp.Column)
                and _is_in_scope(lhs) and _is_in_scope(rhs)):
            return True
        # col op literal (any of the 6 simple ops).
        if isinstance(lhs, sqlglot_exp.Column) and _is_in_scope(lhs) and _is_constant(rhs):
            return True
        if isinstance(rhs, sqlglot_exp.Column) and _is_in_scope(rhs) and _is_constant(lhs):
            return True
        return False

    kept = []
    where_node = ast.args.get("where")
    if where_node is not None:
        # Top-level conjuncts only. _flatten_and respects And and stops at Or,
        # so any conjunct that's itself an Or-block (mixed-column disjunction)
        # becomes a single non-allowed atom that we drop wholesale.
        conjuncts = []
        _flatten_and(where_node.this, conjuncts)
        for cond in conjuncts:
            if _is_inside_subquery(cond):
                continue
            # Strip a paren wrapper for classification.
            target = cond.this if isinstance(cond, sqlglot_exp.Paren) else cond
            # Reject anything containing a subquery (correlated or otherwise).
            if target.find(sqlglot_exp.Subquery) is not None:
                continue
            if not _is_allowed_atom(target):
                continue
            kept.append(target.sql())

    where_part = " AND ".join(kept) if kept else "1 = 1"
    return (f"SELECT COUNT(*) FROM {', '.join(base_table_parts)} "
            f"WHERE {where_part}")


def transform_sql_for_price(sql, db_name,
                            price_n_parsing=False, price_n_filter=False,
                            price_n_fanout=False, price_n_pairwise=False,
                            price_b=False):
    """
    Transform a standard SQL query into PRICE-compatible format.

    PRICE expects:
    - Table aliases in the format `database_abbreviation` (e.g., `imdb_t` for `title`)
    - Column references use these aliases (e.g., `imdb_t.id`)
    - SELECT COUNT(*) FROM ... WHERE ... (no GROUP BY/ORDER BY/LIMIT)

    For TPC-H/DS, also handles:
    - Bare column names (c_custkey → tpch_c.c_custkey) via prefix mapping
    - Self-joins (nation n1, nation n2 → nation tpch_n, nation tpch_n2)
    - CTE/VIEW/subquery-in-FROM flattening via sqlglot
    - Date literal conversion (date '...' + interval '...')

    Args:
        price_n_parsing: When True, apply NNF push-down, disjoint-OR→IN rewrite,
            and date literal normalisation inside _preprocess_predicates.
        price_n_filter: Reserved for PRICE_N filter encoding (forwarded to
            _preprocess_predicates for future use).
        price_n_fanout: When True, call _flatten_join_with_side to collect
            outer-join side info and stash it in _PRICE_N_SIDE_CACHE.
        price_n_pairwise: Reserved for PRICE_N pairwise encoding (forwarded
            to _preprocess_predicates for future use).
        price_b: When True, use original-PRICE semantics — keep only
            equi-join (`t1.col = t2.col`) and `col op literal` predicates
            (op ∈ {=, <, <=, >, >=, !=}). Drop everything else (BETWEEN,
            IN, LIKE, NULL, NOT, OR, subqueries) without decomposition or
            approximation. Never returns the dummy_table sentinel.
    """
    # --- PRICE_B: original-PRICE-only encoding ---
    # Skip the rest of the pipeline (preprocess_predicates etc.) — _build_price_b_sql
    # has already produced a flat SELECT COUNT(*) with the surviving predicates.
    # Just run the standard alias-rewrite on it.
    if price_b:
        prepared = _build_price_b_sql(sql, db_name)
        if prepared is None:
            return "SELECT COUNT(*) FROM dummy_table WHERE 1 = 1"
        sql = prepared
        # Fall through to alias-rewrite block below.
    # --- PRICE_N early bail-out for non-simple CTEs ---
    # When price_n_parsing is active, the pipeline only inlines CTEs whose bodies
    # pass _check_cte_body_simple (no GROUP BY / aggregates / UNION / window fns).
    # If the input SQL has non-simple CTEs, all downstream text-level rewriters
    # (including _flatten_join_with_side which calls flatten_sql_for_price) would
    # either produce mangled SQL or silently discard aggregation context.
    # Detect this case early and return a safe sentinel so the PRICE_N residual
    # collector can harvest CTEs / UNION / aggregates from the original AST.
    # When PRICE_N parsing can't faithfully represent the whole query
    # (non-simple CTEs, scalar subqueries in projections, UNION-ALL derived
    # tables), don't give up — encode the OUTER SELECT's representable parts
    # and let LLM-residual cover the rest. The partial SQL is substituted
    # into `sql` so the rest of the pipeline (alias rewriting, bare-column
    # prefix injection, etc.) processes it normally. Fall back to the
    # dummy_table sentinel only when nothing useful remains in outer scope.
    def _maybe_partial_or_dummy(orig_sql):
        # [BISECTION REVERT] Partial-outer-encoding disabled — always return
        # the dummy_table sentinel so PRICE_N's stat-core contributes nothing
        # for non-simple-CTE / scalar-subq-in-projection / UNION-ALL-derived
        # queries, matching the pre-partial-encoder behavior.
        return "SELECT COUNT(*) FROM dummy_table WHERE 1 = 1"

    if price_n_parsing and HAS_SQLGLOT:
        _bailed = False
        try:
            _ast_input = sqlglot.parse_one(sql)
            _with_input = _ast_input.find(sqlglot_exp.With)
            if _with_input is not None:
                _has_non_simple_input = any(
                    not _check_cte_body_simple(
                        cte.this.this if isinstance(cte.this, sqlglot_exp.Subquery)
                        else cte.this
                    )
                    for cte in _with_input.expressions
                )
                if _has_non_simple_input:
                    _bailed = True
            # [BISECTION REVERT] q9 and q71 early-bailout disabled.
        except Exception:
            _bailed = False

        if _bailed:
            replacement = _maybe_partial_or_dummy(sql)
            if "dummy_table" in replacement:
                return replacement
            sql = replacement
            # Fall through: process partial SQL through the rest of the pipeline
            # (alias rewriting, prefix injection, etc.).

    sides_collected = []
    if price_n_fanout:
        sql, sides_collected = _flatten_join_with_side(sql)
    # Convert timestamps/dates to epoch before any other transformation
    sql = _convert_timestamps_to_epoch(sql)

    is_tpc = db_name in ('tpch', 'tpcds')

    # For TPC-H/DS: try sqlglot-based flattening for complex SQL
    # (CTEs, subqueries-in-FROM, VIEWs, queries with no top-level WHERE)
    needs_flattening = False
    if is_tpc:
        sql_lower = sql.strip().lower()
        if sql_lower.startswith('with '):
            needs_flattening = True
        elif 'revenue0' in sql_lower:
            needs_flattening = True
        else:
            # [BISECTION REVERT] Restored \s+ after from (was \s* in fix).
            from_match_check = re.search(r'\bfrom\b\s+(.*?)\s+\bwhere\b', sql, re.IGNORECASE | re.DOTALL)
            if not from_match_check:
                needs_flattening = True
            elif '(' in (from_match_check.group(1) if from_match_check else ''):
                # FROM clause contains subquery
                needs_flattening = True

    if needs_flattening:
        if price_n_parsing:
            flattened = flatten_sql_for_price_n(sql, db_name)
            # Bail-out guard: if the result still has non-simple CTEs the outer
            # query is structurally a WITH…SELECT — not a flat SELECT…FROM…WHERE.
            # Applying the text-level alias rewriter below would grab the FIRST
            # CTE body's FROM…WHERE (not the outer query's), producing mangled SQL.
            # Return a safe sentinel instead; the PRICE_N residual collector will
            # harvest all CTEs / UNION / GroupBy / etc. from the original AST.
            if HAS_SQLGLOT and flattened is not None:
                try:
                    _ast_check = sqlglot.parse_one(flattened)
                    # Use find() — compatible with sqlglot 28+ (key is "with_" not "with").
                    _with_node = _ast_check.find(sqlglot_exp.With)
                    if _with_node is not None:
                        _has_non_simple = any(
                            not _check_cte_body_simple(
                                cte.this.this if isinstance(cte.this, sqlglot_exp.Subquery)
                                else cte.this
                            )
                            for cte in _with_node.expressions
                        )
                        if _has_non_simple:
                            return _maybe_partial_or_dummy(sql)
                except Exception:
                    pass
        else:
            flattened = flatten_sql_for_price(sql, db_name)
        use_flattened = False
        if flattened is not None:
            # Verify flattened SQL has real table names (not CTE names like v1, wscs)
            _abbrev = _load_abbrev_mapping(db_name)
            fm = re.search(r'\bfrom\b\s+(.*?)\s+\bwhere\b', flattened, re.IGNORECASE | re.DOTALL)
            if fm:
                from_tables = [t.strip().split()[0].lower() for t in fm.group(1).split(',') if t.strip()]
                all_real = all(t in _abbrev for t in from_tables) if from_tables else False
                use_flattened = all_real
            else:
                use_flattened = False

        if use_flattened:
            sql = flattened
        else:
            # Try AST-based predicate collection from entire query tree
            collected = _ast_collect_predicates(sql, db_name)
            if collected is not None:
                sql = collected
            else:
                # Last resort: regex-based predicate collection (no sqlglot)
                regex_collected = _regex_collect_predicates(sql, db_name)
                if regex_collected is not None:
                    sql = regex_collected
                elif flattened is not None:
                    sql = flattened  # Use partial flattening as fallback
                else:
                    return sql  # Can't process at all

    # Preprocess predicates AFTER flattening: subquery inlining, IN → OR, BETWEEN → range,
    # LIKE → drop, scalar subquery estimation, arithmetic evaluation.
    # Must be after CTE flattening because sqlglot round-trip can alter CTE format.
    # PRICE_S: preserves IN and LIKE for SpaceSaving encoding.
    sql = _preprocess_predicates(sql, db_name,
                                price_n_parsing=price_n_parsing,
                                price_n_filter=price_n_filter,
                                price_n_fanout=price_n_fanout,
                                price_n_pairwise=price_n_pairwise)

    abbrev = _load_abbrev_mapping(db_name)

    # Extract FROM clause content (between FROM and WHERE)
    from_match = re.search(r'\bfrom\b\s+(.*?)\s+\bwhere\b', sql, re.IGNORECASE | re.DOTALL)
    if not from_match:
        return sql  # Can't parse, return as-is

    from_clause = from_match.group(1)
    where_and_after = sql[from_match.end():]

    # Parse table references from FROM clause
    alias_to_price = {}  # old_alias -> price_alias
    table_parts = []
    table_count = {}  # table_name -> occurrence count (for self-join numbering)

    for part in from_clause.split(","):
        part = part.strip()
        if not part:
            continue
        # Match: table_name [AS] alias
        m = re.match(r'(\w+)\s+(?:AS\s+)?(\w+)', part, re.IGNORECASE)
        if m:
            table_name = m.group(1).lower()
            old_alias = m.group(2)
            if table_name in abbrev:
                base_alias = abbrev[table_name]
                count = table_count.get(table_name, 0) + 1
                table_count[table_name] = count
                if count == 1:
                    price_alias = base_alias
                else:
                    # Self-join: use numbered alias (tpch_l2, tpch_l3, etc.)
                    price_alias = f"{base_alias}{count}"
                alias_to_price[old_alias] = price_alias
                table_parts.append(f"{table_name} {price_alias}")
            else:
                table_parts.append(part)
        else:
            # Just a table name without alias — collapse duplicates
            # (bare column names can only reference one instance via prefix mapping)
            table_name = part.strip().lower()
            if table_name in abbrev:
                base_alias = abbrev[table_name]
                if table_name not in table_count:
                    table_count[table_name] = 1
                    alias_to_price[table_name] = base_alias
                    table_parts.append(f"{table_name} {base_alias}")
                # else: duplicate bare table, collapse to first instance
            else:
                table_parts.append(part)

    if not alias_to_price:
        return sql  # No mappings found, return as-is

    new_from = ", ".join(table_parts)

    # Replace alias references in WHERE clause (and subqueries)
    # Sort aliases by length (longest first) to avoid partial replacements
    new_where = where_and_after
    for old_alias, price_alias in sorted(alias_to_price.items(), key=lambda x: -len(x[0])):
        new_where = re.sub(
            r'\b' + re.escape(old_alias) + r'\.',
            price_alias + '.',
            new_where
        )

    # For TPC-H/DS: also replace bare table names in subquery FROM clauses
    # (e.g., "from lineitem where" → "from lineitem tpch_l where")
    # BUT NOT when already aliased (e.g., "from lineitem l2" should keep l2)
    if is_tpc:
        for table_name, price_alias in sorted(abbrev.items(), key=lambda x: -len(x[0])):
            # Only match table name followed by WHERE or comma (i.e., no existing alias)
            new_where = re.sub(
                r'(\bfrom\b\s+)' + re.escape(table_name) + r'(?=\s+(?:where\b|,))',
                r'\g<1>' + table_name + ' ' + price_alias,
                new_where,
                flags=re.IGNORECASE
            )
            # Also handle: "from table_name)" at end of subquery
            new_where = re.sub(
                r'(\bfrom\b\s+)' + re.escape(table_name) + r'(?=\s*\))',
                r'\g<1>' + table_name + ' ' + price_alias,
                new_where,
                flags=re.IGNORECASE
            )

    # For TPC-H/DS: prefix bare column names with PRICE aliases using column prefix mapping
    if is_tpc:
        col_prefixes = _TPCH_COL_PREFIX if db_name == 'tpch' else _TPCDS_COL_PREFIX
        # Build prefix → price_alias mapping
        prefix_to_price = []
        for prefix, table_name in col_prefixes:
            if table_name in abbrev:
                prefix_to_price.append((prefix, abbrev[table_name]))

        for prefix, price_alias in prefix_to_price:
            # [BISECTION REVERT] Removed the AS-alias negative lookbehind.
            new_where = re.sub(
                r'(?<!\w)(?<!\.)(' + re.escape(prefix) + r'\w+)\b',
                price_alias + r'.\1',
                new_where
            )

        # Strip GROUP BY, ORDER BY, LIMIT, HAVING
        new_where = _strip_trailing_clauses(new_where)

    # Rebuild full SQL with SELECT COUNT(*)
    # Always use SELECT COUNT(*) to avoid column refs with old aliases in SELECT
    select_part = 'SELECT COUNT(*)'

    result = f"{select_part} FROM {new_from} WHERE {new_where}"

    if price_n_fanout and sides_collected:
        _PRICE_N_SIDE_CACHE[result] = sides_collected

    return result


# Module-level scratchpad: SQL → list[(L, R, side)] from Phase 7.
# Populated by transform_sql_for_price when price_n_fanout=True; consumed
# by generate_price_features → Sql2FeatureN.create_sql_features.
_PRICE_N_SIDE_CACHE = {}


def extract_pg_est_card_from_plan(plan_json):
    """
    Extract root node's 'Plan Rows' from query plan JSON.
    plan_json can be a dict or a JSON string.
    """
    if isinstance(plan_json, str):
        plan_json = json.loads(plan_json)

    # Navigate to root Plan node
    if isinstance(plan_json, list):
        plan_json = plan_json[0]
    if "Plan" in plan_json:
        root = plan_json["Plan"]
    elif "plan" in plan_json:
        root = plan_json["plan"]
    else:
        root = plan_json

    return float(root.get("Plan Rows", 1.0))


def _is_single_table_query(sql):
    """Check if SQL is a single-table query (no joins in FROM clause)."""
    from_match = re.search(r'\bfrom\b\s+(.*?)\s+\bwhere\b', sql, re.IGNORECASE | re.DOTALL)
    if not from_match:
        return False
    from_clause = from_match.group(1)
    return "," not in from_clause and " join " not in from_clause.lower()


def _create_single_table_features(sql2feat, sql, bin_size):
    """
    Generate PRICE-style features for single-table queries.

    PRICE doesn't support single-table queries (no joins → empty torch.cat crash).
    We generate features using PRICE's internal methods:
    - join_hist: 1 placeholder of zeros (padded later)
    - fanout: 2 placeholders of zeros (padded later)
    - table: proper table features (log_size, avi, minsel, ebo)
    - filter: proper filter features from histogram/summary
    """
    columns, tables, joins, ref_to_tables = sql2feat.parse_sql(sql)

    if len(tables) != 1 or len(joins) != 0:
        return None  # Not actually single-table, let normal path handle it

    table = tables[0]

    # All columns are filter columns (no joins)
    filter_columns = columns

    # Compute filter features and selectivities
    table_sels = []
    filter_column_features = []
    for filter_column in filter_columns:
        col_name = filter_column.split('.')[-1]
        col_table = filter_column.split('.')[0]
        if col_name in sql2feat.information_coltype['col_type'][col_table]['dsct']:
            keys, values = sql2feat.space_saving_summary(filter_column)
            filter_column_histogram = torch.tensor(values) / sql2feat.get_table_size(col_table)
            summary = sql2feat.get_summary_ranges(sql, filter_column, keys)
            if summary is not None:
                filter_column_ranges = torch.tensor(summary)
                location = sql2feat.get_summary_location(sql, filter_column)
                selectivity = torch.tensor([sql2feat.calculate_summary_selectivity(keys, values, location) / sql2feat.get_table_size(col_table)])
                table_sels.append(selectivity.item())
            else:
                filter_column_histogram = torch.tensor(sql2feat.get_column_histograms(filter_column))
                filter_column_ranges = torch.tensor(sql2feat.get_filter_norm_range(sql, filter_column, sql2feat.columns_bin_edges[filter_column]))
                range_low, range_high = sql2feat.get_filter_ranges(sql, filter_column)
                distribution = sql2feat.columns_distributions[filter_column]
                bin_edges = sql2feat.columns_bin_edges[filter_column]
                selectivity = torch.tensor([sql2feat.calculate_hist_selectivity(distribution, bin_edges, range_low, range_high) / sql2feat.get_table_size(col_table)])
                table_sels.append(selectivity.item())
        else:
            filter_column_histogram = torch.tensor(sql2feat.get_column_histograms(filter_column))
            filter_column_ranges = torch.tensor(sql2feat.get_filter_norm_range(sql, filter_column, sql2feat.columns_bin_edges[filter_column]))
            range_low, range_high = sql2feat.get_filter_ranges(sql, filter_column)
            distribution = sql2feat.columns_distributions[filter_column]
            bin_edges = sql2feat.columns_bin_edges[filter_column]
            selectivity = torch.tensor([sql2feat.calculate_hist_selectivity(distribution, bin_edges, range_low, range_high) / sql2feat.get_table_size(col_table)])
            table_sels.append(selectivity.item())

        filter_column_features.append(torch.cat([filter_column_histogram, filter_column_ranges, selectivity]))

    # Table features: log_size, avi, minsel, ebo
    table_size = sql2feat.get_table_size(table)
    if len(table_sels) == 0:
        avi, minsel, ebo = 1.0, 1.0, 1.0
    else:
        avi = float(torch.prod(torch.tensor(table_sels)).item())
        minsel = float(torch.min(torch.tensor(table_sels)).item())
        sorted_sels = sorted(table_sels, reverse=True)
        ebo = 1.0
        for i in range(min(len(sorted_sels), 4)):
            ebo *= sorted_sels[i] ** (1 / (2 ** i))
    table_feat = torch.tensor([np.log(table_size), avi, minsel, ebo])

    # For single-table: use 1 zero join col and 2 zero fanout as placeholders
    # These will be padded by features_padding anyway
    zero_join = torch.zeros(bin_size)
    zero_fanout = torch.zeros(bin_size * 2)

    if len(filter_column_features) > 0:
        filter_feat = torch.cat(filter_column_features)
    else:
        filter_feat = torch.zeros(bin_size + 3)

    n_jc = 1  # placeholder
    n_fo = 2  # placeholder
    n_tb = 1
    n_fc = max(len(filter_columns), 1)

    return (zero_join, zero_fanout, table_feat, filter_feat), n_jc, n_fo, n_tb, n_fc


def _patch_self_join_stats(sql2feat, max_copies=4):
    """
    Add self-join alias entries (e.g., tpch_l2, tpch_l3) to PRICE statistics.

    When self-joins appear (lineitem l1, lineitem l2), transform_sql_for_price
    creates distinct aliases (tpch_l, tpch_l2). PRICE needs statistics for each
    alias. We copy base alias stats to numbered variants.
    """
    base_aliases = list(sql2feat.information_size.keys())

    for base in base_aliases:
        for i in range(2, 2 + max_copies):
            new_alias = f"{base}{i}"
            # Copy histogram
            if base in sql2feat.information_histogram:
                sql2feat.information_histogram[new_alias] = sql2feat.information_histogram[base]
            # Copy summary
            if base in sql2feat.information_summary:
                sql2feat.information_summary[new_alias] = sql2feat.information_summary[base]
            # Copy size
            sql2feat.information_size[new_alias] = sql2feat.information_size[base]
            # Copy col_type
            col_type = sql2feat.information_coltype.get('col_type', {})
            if base in col_type:
                col_type[new_alias] = col_type[base]

    # Add fanout entries for numbered aliases
    existing_keys = list(sql2feat.information_fanout.keys())
    for key in existing_keys:
        # Skip PRICE_N sentinel keys (e.g., "__orphan__") that aren't (col, col) tuples.
        if not isinstance(key, tuple) or len(key) != 2:
            continue
        left_col, right_col = key
        lt = left_col.split('.')[0]
        lc = left_col.split('.')[1]
        rt = right_col.split('.')[0]
        rc = right_col.split('.')[1]

        for i in range(2, 2 + max_copies):
            # numbered_left.col ↔ right.col
            nk = (f"{lt}{i}.{lc}", right_col)
            if nk not in sql2feat.information_fanout:
                sql2feat.information_fanout[nk] = sql2feat.information_fanout[key]
            nk_rev = (right_col, f"{lt}{i}.{lc}")
            if nk_rev not in sql2feat.information_fanout:
                # Reverse the fanout arrays
                sql2feat.information_fanout[nk_rev] = [sql2feat.information_fanout[key][1], sql2feat.information_fanout[key][0]]

            # left.col ↔ numbered_right.col
            nk = (left_col, f"{rt}{i}.{rc}")
            if nk not in sql2feat.information_fanout:
                sql2feat.information_fanout[nk] = sql2feat.information_fanout[key]
            nk_rev = (f"{rt}{i}.{rc}", left_col)
            if nk_rev not in sql2feat.information_fanout:
                sql2feat.information_fanout[nk_rev] = [sql2feat.information_fanout[key][1], sql2feat.information_fanout[key][0]]

    # Add self-join fanout (base.col ↔ baseN.col on same column)
    for base in base_aliases:
        if base not in sql2feat.information_histogram:
            continue
        for col_name in sql2feat.information_histogram[base]:
            # Estimate self-join fanout: use uniform array of 1.0
            # (each row matches ~1 row on average — reasonable for PRICE features)
            uniform_fanout = list(np.ones(sql2feat.bin_size))
            for i in range(2, 2 + max_copies):
                new_alias = f"{base}{i}"
                self_key = (f"{base}.{col_name}", f"{new_alias}.{col_name}")
                rev_key = (f"{new_alias}.{col_name}", f"{base}.{col_name}")
                if self_key not in sql2feat.information_fanout:
                    sql2feat.information_fanout[self_key] = [uniform_fanout, uniform_fanout]
                if rev_key not in sql2feat.information_fanout:
                    sql2feat.information_fanout[rev_key] = [uniform_fanout, uniform_fanout]

            # Cross-numbered-alias fanout (baseN ↔ baseM, e.g., tpch_l2 ↔ tpch_l3)
            for i in range(2, 2 + max_copies):
                for j in range(i + 1, 2 + max_copies):
                    key_ij = (f"{base}{i}.{col_name}", f"{base}{j}.{col_name}")
                    key_ji = (f"{base}{j}.{col_name}", f"{base}{i}.{col_name}")
                    if key_ij not in sql2feat.information_fanout:
                        sql2feat.information_fanout[key_ij] = [uniform_fanout, uniform_fanout]
                    if key_ji not in sql2feat.information_fanout:
                        sql2feat.information_fanout[key_ji] = [uniform_fanout, uniform_fanout]


def _try_create_features(sql2feat, sql):
    """
    Try to create PRICE features. On selectivity=0 error, strip filter conditions
    one at a time and retry. On missing column KeyError, strip that column's
    conditions and retry.
    """
    try:
        return sql2feat.create_sql_features(sql)
    except (AssertionError, ValueError) as e:
        if 'selectivity should not be 0' not in str(e):
            raise
    except (KeyError, IndexError):
        pass  # Missing column or unqualified column — fall through to retry

    # Retry: strip filter conditions one at a time
    from_match = re.search(
        r'\bselect\s+count\(\*\)\s+from\s+(.*?)\s+where\s+(.*)',
        sql, re.IGNORECASE | re.DOTALL
    )
    if not from_match:
        return None

    from_str = from_match.group(1)
    where_str = from_match.group(2)
    conditions = _split_where_on_and(where_str)

    # Separate joins from filters
    joins = []
    filters = []
    for cond in conditions:
        m = re.match(r'\s*(\w+)\.(\w+)\s*=\s*(\w+)\.(\w+)\s*$', cond.strip())
        if m:
            joins.append(cond)
        else:
            filters.append(cond)

    # Try dropping filters one at a time (from end, typically the problematic ones)
    for i in range(len(filters)):
        remaining = joins + filters[:len(filters) - 1 - i]
        if not remaining:
            break
        retry_sql = f"select count(*) from {from_str} where {' and '.join(remaining)}"
        try:
            result = sql2feat.create_sql_features(retry_sql)
            if result is not None:
                return result
        except (AssertionError, ValueError, KeyError, IndexError):
            continue

    return None


def generate_price_features(workload, sql_list, db_name, bin_size=40,
                            price_n_parsing=False, price_n_filter=False,
                            price_n_fanout=False, price_n_pairwise=False,
                            already_price_format=False,
                            price_n_or=False, price_n_or_max_clauses=16,
                            price_b=False):
    """
    Generate PRICE features for each SQL query using Sql2Feature (or Sql2FeatureS/N).

    Transforms SQL to PRICE-compatible format before feature extraction.
    Handles single-table queries (no joins) with a dedicated feature generator.

    Args:
        workload: Workload name (for logging)
        sql_list: List of raw SQL strings
        db_name: Database name for PRICE statistics (e.g., 'imdb', 'stats')
        bin_size: Histogram bin size (default 40)
        price_n_parsing: When True, apply PRICE_N NNF/OR→IN/date-normalisation transforms.
        price_n_filter: When True, use 75-dim PRICE_N filter encoding.
        price_n_fanout: When True, use 42-dim extended fanout tokens with outer-join flags.
        price_n_pairwise: When True, collect pairwise intra/xtab atoms and return 6-tuple.
        already_price_format: When True, SQL is already in PRICE alias format
            (from cross-workload plan reconstruction). Skip transform_sql_for_price()
            and most cleanup functions.
        price_n_or: When True, expand mixed-column OR blocks into per-clause
            atoms_meta lists and call create_sql_features in list mode.
            Returns multi_clause_data list instead of data_features list.
        price_n_or_max_clauses: Maximum DNF clauses per query (default 16).

    Returns:
        When price_n_or=False and price_n_pairwise=False (default):
            data_features, n_join_cols, n_fanouts, n_tables, n_filter_cols
        When price_n_or=False and price_n_pairwise=True:
            data_features, n_join_cols, n_fanouts, n_tables, n_filter_cols, n_pairwise_intras
        When price_n_or=True:
            multi_clause_data (list[list[6-tuple]]), n_join_cols, n_fanouts,
            n_tables, n_filter_cols, n_pairwise_intras
        data_features is a list of 4-tuples (join_hist, fanout, table, filter) for
        non-PRICE_N modes, or 5-tuples (join_hist, fanout, table, filter, pairwise) under
        PRICE_N.
    """
    parts = []
    if price_b:           parts.append("b")
    if price_n_filter:    parts.append("nflt")
    if price_n_fanout:    parts.append("nfan")
    if price_n_pairwise:  parts.append("npw")
    if price_n_parsing:   parts.append("nprs")
    if price_n_or:        parts.append("nor")
    mode_tag = ("_" + "_".join(parts)) if parts else ""
    xwl_tag = "_xwl" if already_price_format else ""
    cache_dir = os.path.join(os.path.dirname(__file__), "price_feature_cache")
    cache_key = f"{db_name}_bin{bin_size}{mode_tag}{xwl_tag}_{workload}_n{len(sql_list)}.pkl"
    cache_path = os.path.join(cache_dir, cache_key)

    if os.path.exists(cache_path):
        print(f"[PRICE{mode_tag.upper()}] Loading cached raw features from {cache_path} ({len(sql_list)} queries)")
        with open(cache_path, "rb") as f:
            cached = pickle.load(f)
        if price_n_or and "multi_clause_data" in cached:
            return (cached["multi_clause_data"], cached["n_join_cols"],
                    cached["n_fanouts"], cached["n_tables"], cached["n_filter_cols"],
                    cached["n_pairwise_intras"])
        if price_n_pairwise and "n_pairwise_intras" in cached:
            return (cached["data_features"], cached["n_join_cols"],
                    cached["n_fanouts"], cached["n_tables"], cached["n_filter_cols"],
                    cached["n_pairwise_intras"])
        return (cached["data_features"], cached["n_join_cols"],
                cached["n_fanouts"], cached["n_tables"], cached["n_filter_cols"])

    use_price_n = any([price_n_parsing, price_n_filter, price_n_fanout, price_n_pairwise])
    if use_price_n:
        if REPO_ROOT not in sys.path:
            sys.path.insert(0, REPO_ROOT)
        from canon.features_tool import Sql2FeatureN
        sql2feat = Sql2FeatureN(db_name, bin_size, "finetune")
        # Sql2FeatureN ALWAYS emits 75-dim filter and 42-dim fanout tokens
        # regardless of which sub-flags are set, because the encoder doesn't
        # branch on flags. Use those dims uniformly so data and model agree.
        # The sub-flags control which *atoms* are populated (e.g. pairwise
        # only when price_n_pairwise), not the token shape.
        filter_dim = sql2feat.filter_dim_n
        fanout_dim = sql2feat.fanout_dim_n
        pairwise_dim = sql2feat.pairwise_dim_n if price_n_pairwise else 0
    elif price_b:
        # PRICE_B: original PRICE design, but with the spanning-tree assertion
        # relaxed so real workloads (JOB et al.) with cyclic join graphs
        # don't get rejected with None.
        from canon.price.setup.features_tool_b import Sql2FeatureB
        sql2feat = Sql2FeatureB(db_name, bin_size, "finetune")
        filter_dim = bin_size + 3
        fanout_dim = bin_size
        pairwise_dim = 0
    else:
        from canon.price.setup.features_tool import Sql2Feature
        sql2feat = Sql2Feature(db_name, bin_size, "finetune")
        filter_dim = bin_size + 3
        fanout_dim = bin_size
        pairwise_dim = 0
    _patch_self_join_stats(sql2feat)

    data_features = []
    n_join_cols = []
    n_fanouts = []
    n_tables = []
    n_filter_cols = []
    n_pairwise_intras = []
    success_count = 0
    single_table_count = 0
    fail_count = 0

    total = len(sql_list)
    log_interval = max(1, total // 20)  # ~5% increments

    for idx, sql in enumerate(sql_list):
        if idx % log_interval == 0:
            print(f"[PRICE{mode_tag.upper()}] Generating features: {idx}/{total} ({100*idx//total}%)", flush=True)
        try:
            if already_price_format:
                # SQL is already in PRICE alias format (from cross-workload reconstruction)
                # Just apply lowercasing for safety
                transformed_sql = _lower_except_quotes(sql)
            else:
                # Transform SQL to PRICE format (PRICE_N/M/S preserves appropriate predicates)
                transformed_sql = transform_sql_for_price(
                    sql, db_name,
                    price_n_parsing=price_n_parsing,
                    price_n_filter=price_n_filter,
                    price_n_fanout=price_n_fanout,
                    price_n_pairwise=price_n_pairwise,
                    price_b=price_b)
                # PRICE expects lowercase (except inside quotes)
                transformed_sql = _lower_except_quotes(transformed_sql)
                # Collapse self-join aliases (tpcds_dd2 → tpcds_dd) where only tautological joins
                transformed_sql = _collapse_self_joins(transformed_sql)
                # Add missing tables to FROM when WHERE references known aliases not in FROM
                transformed_sql = _add_missing_from_tables(transformed_sql, db_name)
                # Convert BETWEEN to >= / <= range comparisons (before any AND-splitting).
                # Skipped under PRICE_N: _extract_filter_atoms reads Between nodes natively.
                if not price_n_parsing:
                    transformed_sql = _convert_between_to_range(transformed_sql)
                # Strip same-table conditions and dangling references
                transformed_sql = _strip_same_table_conditions(transformed_sql)
                # Clean trailing SQL artifacts (GROUP BY, unbalanced parens, CASE, substring)
                transformed_sql = _clean_sql_artifacts(transformed_sql,
                                                       price_n_parsing=price_n_parsing)
                # Hoist joins from inside OR blocks to top level (e.g., TPC-H Q19)
                transformed_sql = _hoist_joins_from_or_blocks(transformed_sql)
                # Remove disconnected tables (islands from subquery inlining)
                transformed_sql = _prune_disconnected_tables(transformed_sql)
                # Prune redundant joins to satisfy PRICE's tree constraint
                transformed_sql = _prune_redundant_joins(transformed_sql)
                # Clean up 1 = 1 tautologies left by _prune_redundant_joins
                transformed_sql = _strip_tautologies(transformed_sql)

            # Handle single-table queries specially (PRICE doesn't support them)
            # PRICE_S/B/N handle single-table internally and apply the
            # numeric-vs-string-discrete refined-rule histogram branch — keep
            # them out of the helper, which still uses the legacy "always
            # SpaceSaving for any discrete column" path.
            if _is_single_table_query(transformed_sql) and not price_b and not use_price_n:
                result = _create_single_table_features(sql2feat, transformed_sql, bin_size)
                if result is None:
                    raise ValueError("single-table feature generation returned None")
                feats, n_jc, n_fo, n_tb, n_fc = result
                data_features.append(feats)
                n_join_cols.append(n_jc)
                n_fanouts.append(n_fo)
                n_tables.append(n_tb)
                n_filter_cols.append(n_fc)
                n_pairwise_intras.append(0)
                single_table_count += 1
                success_count += 1
                continue

            if use_price_n and price_n_or:
                # --- Multi-clause DNF path ---
                try:
                    import sqlglot as _sqlglot
                    ast = _sqlglot.parse_one(transformed_sql)
                except Exception:
                    ast = None

                # Query-level join_sides (shared across all clauses)
                qlevel_sides = dict(
                    ((l, r), s)
                    for l, r, s in _PRICE_N_SIDE_CACHE.get(transformed_sql, [])
                ) if price_n_fanout else {}

                if ast is not None:
                    meta_list = _extract_atoms_per_clause(
                        ast, max_clauses=price_n_or_max_clauses)
                else:
                    meta_list = [None]

                # Attach join_sides (query-level, FROM clause is shared across
                # all DNF clauses) to each clause.  Pairwise atoms are NOT
                # attached here — they are WHERE-clause leaf predicates and are
                # already populated per-clause by _build_atoms_meta_from_leaves.
                for meta in meta_list:
                    if meta is None:
                        continue
                    meta["join_sides"] = qlevel_sides

                result = sql2feat.create_sql_features(transformed_sql, atoms_meta=meta_list)

                if result is None:
                    raise ValueError(f"create_sql_features returned None for query {idx}")

                # result is either a list of 6-tuples (multi-clause) or a single 6-tuple
                if isinstance(result, list):
                    clause_list = result
                else:
                    clause_list = [result]

                data_features.append(clause_list)
                # Use first clause counts as query-level representatives
                _, n_jc, n_fo, n_tb, n_fc, n_pi = clause_list[0]
                n_join_cols.append(n_jc)
                n_fanouts.append(n_fo)
                n_tables.append(n_tb)
                n_filter_cols.append(n_fc)
                n_pairwise_intras.append(n_pi)
                success_count += 1

            elif use_price_n:
                try:
                    import sqlglot as _sqlglot
                    ast = _sqlglot.parse_one(transformed_sql)
                except Exception:
                    ast = None
                atoms_meta = {
                    "filter_atoms": _extract_filter_atoms(ast) if (ast and price_n_filter) else {},
                    "pairwise_atoms": (
                        _extract_pairwise_intra_atoms(ast) +
                        [(a[0], a[1], a[1], a[2], a[3], a[4])
                         for a in _extract_xtab_nonequi_atoms(ast)]
                    ) if (ast and price_n_pairwise) else [],
                    "join_sides": dict(
                        ((l, r), s)
                        for l, r, s in _PRICE_N_SIDE_CACHE.get(transformed_sql, [])
                    ) if price_n_fanout else {},
                }
                result = sql2feat.create_sql_features(transformed_sql, atoms_meta=atoms_meta)

                if result is None:
                    raise ValueError(f"create_sql_features returned None for query {idx}")

                feats, n_jc, n_fo, n_tb, n_fc, n_pi = result
                n_pairwise_intras.append(n_pi)
                data_features.append(feats)
                n_join_cols.append(n_jc)
                n_fanouts.append(n_fo)
                n_tables.append(n_tb)
                n_filter_cols.append(n_fc)
                success_count += 1
            else:
                result = _try_create_features(sql2feat, transformed_sql)

                if result is None:
                    raise ValueError(f"create_sql_features returned None for query {idx}")

                feats, n_jc, n_fo, n_tb, n_fc = result
                n_pairwise_intras.append(0)
                data_features.append(feats)
                n_join_cols.append(n_jc)
                n_fanouts.append(n_fo)
                n_tables.append(n_tb)
                n_filter_cols.append(n_fc)
                success_count += 1
        except Exception as e:
            if fail_count < 5:
                print(f"[PRICE{mode_tag.upper()}] Warning: Failed to generate features for query {idx}: {e}")
            elif fail_count == 5:
                print(f"[PRICE{mode_tag.upper()}] Suppressing further warnings...")
            fail_count += 1
            # Use zero-feature placeholder with proper empty tensors.
            # Use the mode-resolved fanout_dim/filter_dim so PRICE_N's 42-dim
            # fanout (and 75-dim filter) match successful queries in the same
            # batch.  bin_size * 2 here would force 80-dim fanout and break
            # collation against PRICE_N's 84-dim fanout.
            zero_join = torch.zeros(bin_size)  # 1 join col placeholder
            zero_fanout = torch.zeros(fanout_dim * 2)  # 2 fanout placeholder
            zero_table = torch.zeros(4)  # 1 table with 4 features
            zero_filter = torch.zeros(filter_dim)  # 1 filter placeholder
            if use_price_n and price_n_or:
                zero_pairwise = torch.zeros(0)
                zero_clause = [(
                    (zero_join, zero_fanout, zero_table, zero_filter, zero_pairwise),
                    1, 2, 1, 1, 0
                )]
                data_features.append(zero_clause)
            elif use_price_n:
                zero_pairwise = torch.zeros(0)
                data_features.append((zero_join, zero_fanout, zero_table, zero_filter, zero_pairwise))
            else:
                data_features.append((zero_join, zero_fanout, zero_table, zero_filter))
            n_join_cols.append(1)
            n_fanouts.append(2)
            n_tables.append(1)
            n_filter_cols.append(1)
            n_pairwise_intras.append(0)

    print(f"[PRICE{mode_tag.upper()}] Feature generation: {success_count} succeeded ({single_table_count} single-table), {fail_count} failed out of {len(sql_list)}")

    os.makedirs(cache_dir, exist_ok=True)
    cache_dict = {
        "data_features": data_features,
        "n_join_cols": n_join_cols,
        "n_fanouts": n_fanouts,
        "n_tables": n_tables,
        "n_filter_cols": n_filter_cols,
    }
    if price_n_or:
        cache_dict["multi_clause_data"] = data_features
        cache_dict["n_pairwise_intras"] = n_pairwise_intras
    elif price_n_pairwise:
        cache_dict["n_pairwise_intras"] = n_pairwise_intras
    with open(cache_path, "wb") as f:
        pickle.dump(cache_dict, f)
    print(f"[PRICE{mode_tag.upper()}] Cached raw features to {cache_path}")

    if price_n_or:
        return (data_features, n_join_cols, n_fanouts, n_tables,
                n_filter_cols, n_pairwise_intras)
    if price_n_pairwise:
        return (data_features, n_join_cols, n_fanouts, n_tables,
                n_filter_cols, n_pairwise_intras)
    return data_features, n_join_cols, n_fanouts, n_tables, n_filter_cols


def _lower_except_quotes(sql):
    """Lowercase SQL except for text inside quotes (matching PRICE's preprocessing)."""
    result = []
    in_quote = False
    quote_char = None
    for char in sql:
        if in_quote:
            result.append(char)
            if char == quote_char:
                in_quote = False
        else:
            if char in ("'", '"'):
                in_quote = True
                quote_char = char
                result.append(char)
            else:
                result.append(char.lower())
    return ''.join(result)


def pad_and_cache_features(data_features, n_join_cols, n_fanouts, n_tables,
                           n_filter_cols, n_pairwise_intras=None,
                           bin_size=40, table_dim=4, filter_dim=43,
                           fanout_dim=None, pairwise_intra_dim=None,
                           cache_path=None,
                           price_n_pairwise=False,
                           multi_clause_data=None):
    """
    Pad variable-length features to uniform size and optionally cache.

    Args:
        data_features: list of tuples from generate_price_features.
            Under PRICE_N pairwise mode, each tuple is a 5-tuple:
            (join_hist, fanout, table, filter, pairwise_intra).
            Otherwise a 4-tuple.
        n_join_cols, n_fanouts, n_tables, n_filter_cols: per-query counts
        n_pairwise_intras: per-query pairwise token counts (only used when
            price_n_pairwise=True)
        bin_size: histogram bin size
        table_dim: table feature dimension (default 4: log_size, avi, minsel, ebo)
        filter_dim: filter feature dimension (default bin_size+3 = 43, or
            or 75 for PRICE_N)
        fanout_dim: fanout token dimension (default bin_size for non-N, 42 for N)
        pairwise_intra_dim: pairwise token dimension (default 70 for PRICE_N (anti-diagonal range-slot format))
        cache_path: if set, save/load from this pickle path
        price_n_pairwise: if True, handle 5-tuple input and pad the pairwise
            axis; return 7-tuple instead of 6-tuple.

    Returns:
        When price_n_pairwise=False (default):
            (padded_features, padding_masks,
             max_n_join_col, max_n_fanout, max_n_table, max_n_filter_col)
        When price_n_pairwise=True:
            (padded_features, padding_masks,
             max_n_join_col, max_n_fanout, max_n_table, max_n_filter_col,
             max_n_pairwise_intra)
        When multi_clause_data is not None:
            dict with keys: padded_features, padding_masks, max_n_join_col,
            max_n_fanout, max_n_table, max_n_filter_col, max_n_pairwise_intra,
            num_clauses (tensor of shape (batch,)), max_n_clauses (int).
            padded_features has shape (batch * max_n_clauses, flat_size) for
            direct use with RegressionModel.forward(num_clauses=...).
    """
    # ----------------------------------------------------------------
    # Multi-clause DNF path (--price_n_or)
    # multi_clause_data: list[list[6-tuple]] — per-query list of per-clause
    # feature tuples from Sql2FeatureN.create_sql_features in list mode.
    # ----------------------------------------------------------------
    if multi_clause_data is not None:
        # Resolve dims
        effective_fanout_dim = fanout_dim if fanout_dim is not None else bin_size
        if pairwise_intra_dim is None:
            pairwise_intra_dim = 70

        # Gather all counts across all queries and all clauses to compute
        # per-batch maxima.
        all_n_jc, all_n_fo, all_n_tb, all_n_fc, all_n_pi = [], [], [], [], []
        for clause_list in multi_clause_data:
            for (feats, n_jc, n_fo, n_tb, n_fc, n_pi) in clause_list:
                all_n_jc.append(n_jc)
                all_n_fo.append(n_fo)
                all_n_tb.append(n_tb)
                all_n_fc.append(n_fc)
                all_n_pi.append(n_pi)

        max_n_jc = max(all_n_jc) if all_n_jc else 0
        max_n_fo = max(all_n_fo) if all_n_fo else 0
        max_n_tb = max(all_n_tb) if all_n_tb else 0
        max_n_fc = max(all_n_fc) if all_n_fc else 0
        max_n_pi = max(all_n_pi) if all_n_pi else 0
        max_n_clauses = max(len(cl) for cl in multi_clause_data) if multi_clause_data else 1

        padding_value = -1e3

        def _pad_single_clause(feats, n_jc, n_fo, n_tb, n_fc, n_pi):
            """Pad one clause's features to the batch-level maxima."""
            join_hist, fanout_ext, table_feats, filter_feats, pairwise_feats = feats

            if n_jc < max_n_jc:
                pad = torch.full(((max_n_jc - n_jc) * bin_size,), padding_value)
                join_hist = torch.cat([join_hist, pad])
            if n_fo < max_n_fo:
                pad = torch.full(((max_n_fo - n_fo) * effective_fanout_dim,), padding_value)
                fanout_ext = torch.cat([fanout_ext, pad])
            if n_tb < max_n_tb:
                for _ in range(max_n_tb - n_tb):
                    tok = torch.cat([torch.zeros(1),
                                     torch.full((table_dim - 1,), padding_value)])
                    table_feats = torch.cat([table_feats, tok])
            if n_fc < max_n_fc:
                pad = torch.full(((max_n_fc - n_fc) * filter_dim,), padding_value)
                if filter_feats is not None and filter_feats.numel() > 0:
                    filter_feats = torch.cat([filter_feats, pad])
                else:
                    filter_feats = pad
            if n_pi < max_n_pi:
                pad = torch.full(((max_n_pi - n_pi) * pairwise_intra_dim,), padding_value)
                if pairwise_feats is not None and pairwise_feats.numel() > 0:
                    pairwise_feats = torch.cat([pairwise_feats, pad])
                else:
                    pairwise_feats = pad

            mask = (
                [1]
                + [1] * n_jc + [0] * (max_n_jc - n_jc)
                + [1] * n_fo + [0] * (max_n_fo - n_fo)
                + [1] * n_tb + [0] * (max_n_tb - n_tb)
                + [1] * n_fc + [0] * (max_n_fc - n_fc)
                + [1] * n_pi + [0] * (max_n_pi - n_pi)
            )

            parts = [join_hist, fanout_ext, table_feats]
            if filter_feats is not None and filter_feats.numel() > 0:
                parts.append(filter_feats)
            if pairwise_feats is not None and pairwise_feats.numel() > 0:
                parts.append(pairwise_feats)
            flat = torch.cat(parts)
            return flat, torch.tensor(mask)

        # Determine the flat size from the first clause of the first query
        first_feats, first_n_jc, first_n_fo, first_n_tb, first_n_fc, first_n_pi = (
            multi_clause_data[0][0])
        _dummy, _dummy_mask = _pad_single_clause(
            first_feats, first_n_jc, first_n_fo, first_n_tb, first_n_fc, first_n_pi)
        flat_size = _dummy.shape[0]
        mask_size = _dummy_mask.shape[0]

        # Build (batch * max_n_clauses, flat_size) padded features tensor list.
        # Also build padding masks (batch * max_n_clauses, mask_size).
        padded_features_mc = []
        padding_masks_mc = []
        num_clauses_list = []

        for clause_list in multi_clause_data:
            n_valid = len(clause_list)
            num_clauses_list.append(n_valid)
            # Pad valid clauses
            for (feats, n_jc, n_fo, n_tb, n_fc, n_pi) in clause_list:
                flat, mask = _pad_single_clause(feats, n_jc, n_fo, n_tb, n_fc, n_pi)
                padded_features_mc.append(flat)
                padding_masks_mc.append(mask)
            # Zero-pad missing clauses
            for _ in range(max_n_clauses - n_valid):
                padded_features_mc.append(torch.zeros(flat_size))
                padding_masks_mc.append(torch.zeros(mask_size, dtype=torch.long))

        num_clauses_tensor = torch.tensor(num_clauses_list, dtype=torch.long)

        return {
            "padded_features": padded_features_mc,
            "padding_masks": padding_masks_mc,
            "max_n_join_col": max_n_jc,
            "max_n_fanout": max_n_fo,
            "max_n_table": max_n_tb,
            "max_n_filter_col": max_n_fc,
            "max_n_pairwise_intra": max_n_pi,
            "num_clauses": num_clauses_tensor,
            "max_n_clauses": max_n_clauses,
        }

    # Auto-detect 5-tuple shape: Sql2FeatureN always outputs 5-tuples even
    # when price_n_pairwise=False.  When the input data is 5-tuples we must
    # use the PRICE_N padding path (which knows how to unpack 5-tuples).
    # If n_pairwise_intras is not provided we zero-fill it so the pairwise
    # axis has width 0 (no pairwise embedding layer is exercised but the
    # unpacking is consistent).
    has_5tuple = bool(data_features) and len(data_features[0]) == 5
    use_n_path = price_n_pairwise or has_5tuple
    if use_n_path and n_pairwise_intras is None:
        n_pairwise_intras = [0] * len(data_features)

    if cache_path and os.path.exists(cache_path):
        print(f"[PRICE] Loading cached features from {cache_path}")
        with open(cache_path, "rb") as f:
            cached = pickle.load(f)
        if use_n_path and "max_n_pairwise_intra" in cached:
            return (cached["padded_features"], cached["padding_masks"],
                    cached["max_n_join_col"], cached["max_n_fanout"],
                    cached["max_n_table"], cached["max_n_filter_col"],
                    cached["max_n_pairwise_intra"])
        return (cached["padded_features"], cached["padding_masks"],
                cached["max_n_join_col"], cached["max_n_fanout"],
                cached["max_n_table"], cached["max_n_filter_col"])

    # Resolve fanout_dim: PRICE_N uses extended 42-dim fanout tokens; default
    # (non-N) uses bin_size-dim tokens.
    effective_fanout_dim = fanout_dim if fanout_dim is not None else bin_size

    if use_n_path:
        # ----------------------------------------------------------------
        # PRICE_N pairwise path: 5-tuple input, manual padding.
        # We replicate the same pattern as features_padding but handle the
        # extended fanout_dim and the new pairwise axis ourselves.
        # ----------------------------------------------------------------
        if pairwise_intra_dim is None:
            pairwise_intra_dim = 70
        if n_pairwise_intras is None:
            n_pairwise_intras = [0] * len(data_features)

        max_n_join_col = max(n_join_cols) if n_join_cols else 0
        max_n_fanout = max(n_fanouts) if n_fanouts else 0
        max_n_table = max(n_tables) if n_tables else 0
        max_n_filter_col = max(n_filter_cols) if n_filter_cols else 0
        max_n_pairwise_intra = max(n_pairwise_intras) if n_pairwise_intras else 0

        padding_value = -1e3
        padded_features = []
        padding_masks = []

        for i, (n_jc, n_fo, n_tb, n_fc, n_pi) in enumerate(zip(
                n_join_cols, n_fanouts, n_tables, n_filter_cols, n_pairwise_intras)):

            join_hist, fanout_ext, table_feats, filter_feats, pairwise_feats = data_features[i]

            # --- pad join histogram axis ---
            if n_jc < max_n_join_col:
                pad = torch.full(((max_n_join_col - n_jc) * bin_size,), padding_value)
                join_hist = torch.cat([join_hist, pad])

            # --- pad fanout axis ---
            if n_fo < max_n_fanout:
                pad = torch.full(((max_n_fanout - n_fo) * effective_fanout_dim,), padding_value)
                fanout_ext = torch.cat([fanout_ext, pad])

            # --- pad table axis ---
            if n_tb < max_n_table:
                for _ in range(max_n_table - n_tb):
                    tok = torch.cat([torch.zeros(1),
                                     torch.full((table_dim - 1,), padding_value)])
                    table_feats = torch.cat([table_feats, tok])

            # --- pad filter axis ---
            if n_fc < max_n_filter_col:
                pad = torch.full(((max_n_filter_col - n_fc) * filter_dim,), padding_value)
                if filter_feats is not None and filter_feats.numel() > 0:
                    filter_feats = torch.cat([filter_feats, pad])
                else:
                    filter_feats = pad

            # --- pad pairwise axis ---
            if n_pi < max_n_pairwise_intra:
                pad = torch.full(((max_n_pairwise_intra - n_pi) * pairwise_intra_dim,),
                                 padding_value)
                if pairwise_feats is not None and pairwise_feats.numel() > 0:
                    pairwise_feats = torch.cat([pairwise_feats, pad])
                else:
                    pairwise_feats = pad

            # Build padding mask:
            # token order: [CLS, join×max_n_join_col, fanout×max_n_fanout,
            #               table×max_n_table, filter×max_n_filter_col,
            #               pairwise×max_n_pairwise_intra]
            mask = (
                [1]
                + [1] * n_jc + [0] * (max_n_join_col - n_jc)
                + [1] * n_fo + [0] * (max_n_fanout - n_fo)
                + [1] * n_tb + [0] * (max_n_table - n_tb)
                + [1] * n_fc + [0] * (max_n_filter_col - n_fc)
                + [1] * n_pi + [0] * (max_n_pairwise_intra - n_pi)
            )
            padding_masks.append(torch.tensor(mask))

            # Concatenate all axes into a single flat tensor
            parts = [join_hist, fanout_ext, table_feats]
            if filter_feats is not None and filter_feats.numel() > 0:
                parts.append(filter_feats)
            if pairwise_feats is not None and pairwise_feats.numel() > 0:
                parts.append(pairwise_feats)
            padded_features.append(torch.cat(parts))

        if cache_path:
            os.makedirs(os.path.dirname(cache_path), exist_ok=True)
            print(f"[PRICE] Caching features to {cache_path}")
            with open(cache_path, "wb") as f:
                pickle.dump({
                    "padded_features": padded_features,
                    "padding_masks": padding_masks,
                    "max_n_join_col": max_n_join_col,
                    "max_n_fanout": max_n_fanout,
                    "max_n_table": max_n_table,
                    "max_n_filter_col": max_n_filter_col,
                    "max_n_pairwise_intra": max_n_pairwise_intra,
                }, f)

        if price_n_pairwise:
            return (padded_features, padding_masks,
                    max_n_join_col, max_n_fanout, max_n_table, max_n_filter_col,
                    max_n_pairwise_intra)
        # has_5tuple=True but price_n_pairwise=False: return 6-tuple (pairwise
        # counts were all 0, so max_n_pairwise_intra=0 and no caller needs it)
        return (padded_features, padding_masks,
                max_n_join_col, max_n_fanout, max_n_table, max_n_filter_col)

    # ----------------------------------------------------------------
    # Original path (non-pairwise): delegate to PRICE's features_padding.
    # ----------------------------------------------------------------
    # Import from PRICE's utils.model.padding (avoid name conflict with other 'utils' packages)
    import importlib.util as _ilu
    _spec = _ilu.spec_from_file_location("price_padding", os.path.join(REPO_ROOT, "canon", "price", "utils", "model", "padding.py"))
    _padding_mod = _ilu.module_from_spec(_spec)
    _spec.loader.exec_module(_padding_mod)
    features_padding = _padding_mod.features_padding

    padded_features, padding_masks = features_padding(
        bin_size, table_dim, filter_dim,
        list(data_features),  # make a copy since padding modifies in-place
        n_join_cols, n_fanouts, n_tables, n_filter_cols
    )

    max_n_join_col = max(n_join_cols) if n_join_cols else 0
    max_n_fanout = max(n_fanouts) if n_fanouts else 0
    max_n_table = max(n_tables) if n_tables else 0
    max_n_filter_col = max(n_filter_cols) if n_filter_cols else 0

    if cache_path:
        os.makedirs(os.path.dirname(cache_path), exist_ok=True)
        print(f"[PRICE] Caching features to {cache_path}")
        with open(cache_path, "wb") as f:
            pickle.dump({
                "padded_features": padded_features,
                "padding_masks": padding_masks,
                "max_n_join_col": max_n_join_col,
                "max_n_fanout": max_n_fanout,
                "max_n_table": max_n_table,
                "max_n_filter_col": max_n_filter_col,
            }, f)

    return (padded_features, padding_masks,
            max_n_join_col, max_n_fanout, max_n_table, max_n_filter_col)


def get_db_name_for_workload(workload):
    """Map SICE workload name to PRICE database name."""
    if workload in ("syn", "job", "job_full", "jobm", "imdb", "imdb_job", "imdb_jobm"):
        return "imdb"
    elif workload == "stats":
        return "stats"
    elif workload == "tpch":
        return "tpch"
    elif workload == "tpcds":
        return "tpcds"
    else:
        return workload


# Cross-workload database names (matches cross_workload_price_config.py)
_CROSS_WORKLOAD_DBS = {
    "accidents", "airline", "baseball", "basketball", "carcinogenesis",
    "consumer", "credit", "employee", "fhnk", "financial",
    "geneea", "genome", "hepatitis", "imdb", "movielens",
    "seznam", "ssb", "tournament", "tpc_h", "walmart",
}


def is_cross_workload_db(db_name):
    """Check if a database is one of the 20 cross-workload databases."""
    return db_name in _CROSS_WORKLOAD_DBS


def get_sql_for_cross_workload_plans(json_path, db_name):
    """Reconstruct PRICE-format SQL from a deepdb_augmented JSON plan file.

    Returns a list of SQL strings (one per plan, None if reconstruction fails).
    """
    raise NotImplementedError(
        "Cross-workload plan reconstruction (deepdb_augmented datasets) is not "
        "included in this release; the shipped workloads (tpch, tpcds, imdb, stats) "
        "use the queries/ SQL files directly."
    )


def get_db_name_from_json_path(json_path):
    """Extract cross-workload database name from a deepdb_augmented JSON path.

    E.g., '../deepdb_augmented/financial/workload_100k_s1_c8220.json' -> 'financial'
    """
    return os.path.basename(os.path.dirname(json_path))


def get_sql_file_for_workload(workload, card=False, for_training=False):
    """
    Get the path to the queries/ SQL file for a given workload.
    Must match the CSV file used for query plans.

    Args:
        workload: Workload name (e.g., 'job', 'syn', 'stats')
        card: If True, return the cardinality sub-plan SQL file
        for_training: If True, return the SQL file matching the *training* CSV
                      (e.g., full imdb.sql for job/syn, full stats.sql for stats).
                      If False, return the SQL file matching the *test* CSV.
    """
    base_dir = os.path.join(os.path.dirname(__file__), "..", "queries")
    base_dir = os.path.abspath(base_dir)

    if card:
        # Cardinality uses _sub variants (match *_sub.csv plans)
        if workload == "syn":
            return os.path.join(base_dir, "imdb_syn_sub.sql")
        elif workload == "job":
            return os.path.join(base_dir, "imdb_job_sub.sql")
        elif workload == "job_full":
            return os.path.join(base_dir, "imdb_job_sub.sql")
        elif workload == "stats":
            return os.path.join(base_dir, "stats_statsCEB_sub.sql")
    elif for_training:
        # Training CSV: long_raw_postgres_imdb.csv (syn/job/job_full)
        #               long_raw_postgres_stats.csv (stats)
        if workload in ("syn", "job", "job_full", "jobm"):
            return os.path.join(base_dir, "imdb.sql")           # 100k queries → 100k plans
        elif workload == "stats":
            return os.path.join(base_dir, "stats.sql")          # 67962 queries → 67962 plans
        elif workload == "tpch":
            return os.path.join(base_dir, "tpch.sql")           # 2200 queries
        elif workload == "tpcds":
            return os.path.join(base_dir, "tpcds.sql")          # 9900 queries
    else:
        # Test CSV: long_raw_postgres_imdb_{workload}.csv
        if workload == "syn":
            return os.path.join(base_dir, "imdb_syn.sql")       # 5000 queries → 5000 plans
        elif workload in ("job", "imdb_job"):
            return os.path.join(base_dir, "imdb_job.sql")       # 69 queries → 69 plans
        elif workload == "job_full":
            return os.path.join(base_dir, "imdb_job_full.sql")  # 113 queries → 113 plans (JOB-full)
        elif workload in ("jobm", "imdb_jobm"):
            return os.path.join(base_dir, "imdb_jobm.sql")      # 113 queries → 113 plans
        elif workload == "stats":
            return os.path.join(base_dir, "stats_statsCEB.sql") # 141 queries → 141 plans
        elif workload == "tpch":
            return os.path.join(base_dir, "tpch.sql")
        elif workload == "tpcds":
            return os.path.join(base_dir, "tpcds.sql")

    # Fallback
    return os.path.join(base_dir, f"{workload}.sql")


# ==========================================================================
# ===== section: baseline_price_data.py (merged) =====
# ==========================================================================
# Per-query PRICE features for baselines, aligned 1:1 to the baseline queries
# (same workload files the LLM path uses).
#
# This module is the Task-3 PRICE-feature provider for the baseline-concat feature
# (qf / aimai / e2e_cost / bao).  It wraps PRICE feature extraction exactly the way
# mode 7 (`--algo llm_price_finetune` / `price_finetune`) does, so the batched
# ``price_batch`` tuple this module produces is interchangeable with what mode 7
# feeds ``PRICEEmbedder.forward(x, padding_mask, n_join_col, n_fanout, n_table,
# n_filter_col, ..., num_clauses=...)``.
#
# Two reproduction anchors (both in ``experiments/train.py``):
#
#   * single-clause (``--price_n`` without ``--price_n_or``): the per-item tuple
#     and the batch stacking mirror ``price_only_collate`` (train.py ~474-490) and
#     the LLM-path ``llm_price_collate`` (train.py ~408-433).  The ``pg_est_card``
#     that ``price_only_collate`` additionally carries is **not** consumed by
#     ``PRICEEmbedder.forward`` (it feeds the standalone PriceOnly regression head),
#     so it is intentionally omitted here.
#
#   * multi-clause DNF (``--price_n_or``): the per-item packed tensors and the
#     batch stacking + reshape mirror ``price_or_collate`` (train.py ~493-510) and
#     the LLM-path ``llm_price_or_collate`` (train.py ~436-472).  Because
#     ``PRICEEmbedder.forward`` expects ``x`` already flattened to
#     ``(batch * max_clauses, flat_size)`` (it re-derives ``max_c`` from
#     ``per_clause_emb.size(0) // bsz``), we reproduce the
#     ``llm_price_or_collate`` 3D->2D reshape (train.py ~463-468) here, so the
#     returned ``price_batch`` is directly forward-ready.
#
# Alignment contract: ``load_price_feats`` returns a list indexed ``0..N-1`` in
# the SAME order as ``sql_list``.  The caller (Task 5/7) MUST pass ``sql_list`` in
# the same order as the baseline ``roots`` / ``query_ids`` so that
# ``PriceAugmentedDataset`` can zip the two by index.

# train.py runs from experiments/ and prepends ../PRICE to
# sys.path so the canon and PRICE feature tooling resolves.
# price_data_utils relies on that bootstrap; replicate it here so this module can
# be imported from the baseline path without importing train.py (which would run
# the whole training script at import time).  Mirrors price_embedder_factory.py.




# ---------------------------------------------------------------------------
# Per-query feature construction
# ---------------------------------------------------------------------------
def load_price_feats(workload, sql_list, db_name, bin_size, price_n_or,
                     return_max_dims=False):
    """Build per-query PRICE features for ``sql_list``.

    Returns a list indexed by query position (0..N-1, same order as
    ``sql_list``).  Each entry is the per-query PRICE feature tuple that
    ``PRICEEmbedder.forward`` consumes (after batch stacking by
    ``_stack_price``):

      * single-clause (``price_n_or=False``):
            (price_feat, pad_mask, n_join_col, n_fanout, n_table, n_filter_col)
        where ``price_feat`` is a 1-D float tensor (flat_size,) and ``pad_mask``
        is a 1-D tensor (mask_size,).

      * multi-clause DNF (``price_n_or=True``):
            (price_feat, pad_mask, n_join_col, n_fanout, n_table, n_filter_col,
             num_clauses_i)
        where ``price_feat`` is (max_clauses, flat_size) and ``pad_mask`` is
        (max_clauses, mask_size) — all clauses of one query packed, exactly as
        the mode-7 LLMPriceDataset stores them under ``--price_n_or``.

    This wraps ``generate_price_features`` + ``pad_and_cache_features`` with the
    SAME PRICE_N configuration mode 7 uses (``--price_n`` => all four PRICE_N
    sub-flags on => 75-dim filter / 42-dim fanout tokens), honoring
    ``price_n_or`` for the DNF multi-clause path.  No train/val/test split is
    applied: features are produced for the whole ``sql_list`` in order so the
    caller can align them 1:1 to the baseline ``roots``.
    """
    # Single segment: extract (cached) then pad. Identical result to the previous
    # monolithic implementation — extraction + padding are just split into the two
    # reusable helpers below so build_aligned can extract train/test SEPARATELY
    # (hitting per-segment caches) and pad them JOINTLY, exactly like mode 7.
    return _pad_price_segments(
        [_extract_price_segment(workload, sql_list, db_name, bin_size, price_n_or)],
        bin_size, price_n_or, return_max_dims=return_max_dims)


def _extract_price_segment(workload, sql_list, db_name, bin_size, price_n_or):
    """Extract per-query RAW PRICE features for ONE segment via
    generate_price_features — the slow part, cached by (workload, db, count).

    Doing this PER SEGMENT lets a separate-file train segment (e.g. imdb's 100k
    queries) HIT its existing cache, exactly as mode 7 does with its two separate
    generate_price_features calls (utilsLLM.py:4752 test / :4958 train) instead of
    one combined call whose count matches no cache. Per-query extraction is
    stateless, so extracting segments separately and concatenating is byte-for-byte
    identical to a single combined extraction — only the cache key differs.

    `--price_n` turns on all four PRICE_N sub-flags (see CLAUDE.md PRICE_N_FLAGS);
    Sql2FeatureN always emits 75-dim filter / 42-dim fanout tokens (the sub-flags
    only gate which atoms populate, not the token shape) and, because
    price_n_pairwise=True, returns a 6-tuple with a trailing per-query
    n_pairwise_intras. Returns (features, njc, nfo, ntb, nfc, npi) where `features`
    is the single-clause data_features (5-tuples) or, under price_n_or, the
    multi_clause_data (list[list[6-tuple]])."""
    pn = True
    gpf = generate_price_features(
        workload, sql_list, db_name, bin_size,
        price_n_parsing=pn, price_n_filter=pn, price_n_fanout=pn,
        price_n_pairwise=pn, price_n_or=price_n_or, price_n_or_max_clauses=16)
    return (gpf[0], list(gpf[1]), list(gpf[2]), list(gpf[3]), list(gpf[4]), list(gpf[5]))


def _pad_price_segments(seg_raws, bin_size, price_n_or, return_max_dims=False):
    """Concatenate RAW features from one-or-more segments (in segment order) and
    pad them JOINTLY to a unified max — mirrors mode 7 padding train+test together
    after separate extraction. Packs each query into the tuple PRICEEmbedder
    consumes (see load_price_feats docstring). The pairwise-token axis is threaded
    via n_pairwise_intras (single-clause) / inside multi_clause_data (OR), so it is
    never silently dropped."""
    features = []
    njc, nfo, ntb, nfc, npi = [], [], [], [], []
    for f, a, b, c, d, e in seg_raws:
        features = features + list(f)
        njc += a; nfo += b; ntb += c; nfc += d; npi += e

    if price_n_or:
        # multi_clause_data path: pad all clauses of all queries, then pack each
        # query's rows into (max_clauses, flat_size). Mirrors
        # get_llm_price_ds_from_csv's _pad_and_unpack (utilsLLM.py ~4794-4839).
        out = pad_and_cache_features(
            [], [], [], [], [], bin_size=bin_size, filter_dim=75,
            price_n_pairwise=True, fanout_dim=42, pairwise_intra_dim=70,
            multi_clause_data=features)
        flat_pf = out["padded_features"]
        flat_pm = out["padding_masks"]
        max_n_clauses = int(out["max_n_clauses"])
        num_clauses = out["num_clauses"].tolist()
        feats = []
        for qi in range(len(features)):
            slc = flat_pf[qi * max_n_clauses:(qi + 1) * max_n_clauses]
            pf_q = torch.stack([
                t if isinstance(t, torch.Tensor) else torch.tensor(t, dtype=torch.float32)
                for t in slc])
            ms = flat_pm[qi * max_n_clauses:(qi + 1) * max_n_clauses]
            pm_q = torch.stack([
                t if isinstance(t, torch.Tensor) else torch.tensor(t) for t in ms])
            feats.append((pf_q, pm_q, njc[qi], nfo[qi], ntb[qi], nfc[qi],
                          int(num_clauses[qi])))
        max_dims = {
            "max_n_join_col": int(out["max_n_join_col"]),
            "max_n_fanout": int(out["max_n_fanout"]),
            "max_n_table": int(out["max_n_table"]),
            "max_n_filter_col": int(out["max_n_filter_col"]),
            "max_n_pairwise_intra": int(out.get("max_n_pairwise_intra", 0)),
        }
    else:
        padded_features, padding_masks, _mj, _mf, _mt, _mfc, _mpi = \
            pad_and_cache_features(
                features, njc, nfo, ntb, nfc, bin_size=bin_size, filter_dim=75,
                price_n_pairwise=True, fanout_dim=42, pairwise_intra_dim=70,
                n_pairwise_intras=npi)
        feats = [(padded_features[i], padding_masks[i], njc[i], nfo[i], ntb[i], nfc[i])
                 for i in range(len(padded_features))]
        max_dims = {
            "max_n_join_col": int(_mj), "max_n_fanout": int(_mf),
            "max_n_table": int(_mt), "max_n_filter_col": int(_mfc),
            "max_n_pairwise_intra": int(_mpi) if _mpi is not None else 0,
        }
    if return_max_dims:
        return feats, max_dims
    return feats


# ---------------------------------------------------------------------------
# Batch stacking — mirrors price_only_collate / price_or_collate
# ---------------------------------------------------------------------------
def _stack_price(price_items):
    """Stack a list of per-query PRICE feature tuples into the batched tuple
    ``PRICEEmbedder.forward`` consumes.

    Detects the OR (multi-clause) variant by item length (7 vs 6).

    Single-clause -> (price_feats, pad_masks, njcs, nfos, ntbs, nfcs)
      Mirrors price_only_collate (train.py ~479-490), minus pg_est_card (the
      embedder does not consume it), and the LLM-path llm_price_collate
      (train.py ~424-429): stack the per-query flat tensors, stack the masks,
      and make each count an (N, 1) float column.

    Multi-clause (OR) -> (price_feats, pad_masks, njcs, nfos, ntbs, nfcs, num_clauses)
      Mirrors price_or_collate (train.py ~501-510) for the stacking + the
      num_clauses long tensor, then applies the llm_price_or_collate 3D->2D
      reshape (train.py ~463-468) so price_feats is
      (batch * max_clauses, flat_size) and pad_masks is
      (batch * max_clauses, mask_len) — the layout PRICEEmbedder.forward expects
      when num_clauses is provided.
    """
    is_or = len(price_items[0]) == 7
    if is_or:
        pf, pm, njc, nfo, ntb, nfc, nc = zip(*price_items)
    else:
        pf, pm, njc, nfo, ntb, nfc = zip(*price_items)

    # Stack price feats / masks (identical to *_collate).
    price_feats = torch.stack([
        f if isinstance(f, torch.Tensor) else torch.tensor(f, dtype=torch.float32)
        for f in pf]).float()
    pad_masks = torch.stack([
        m if isinstance(m, torch.Tensor) else torch.tensor(m)
        for m in pm]).float()
    njcs = torch.tensor(njc, dtype=torch.float32).unsqueeze(1)
    nfos = torch.tensor(nfo, dtype=torch.float32).unsqueeze(1)
    ntbs = torch.tensor(ntb, dtype=torch.float32).unsqueeze(1)
    nfcs = torch.tensor(nfc, dtype=torch.float32).unsqueeze(1)

    if not is_or:
        return (price_feats, pad_masks, njcs, nfos, ntbs, nfcs)

    num_clauses = torch.tensor(nc, dtype=torch.long)
    # 3D (batch, max_clauses, *) -> 2D (batch * max_clauses, *), exactly as
    # llm_price_or_collate does before handing x to PRICEEmbedder.forward.
    if price_feats.dim() == 3:
        bsz, max_c, flat_size = price_feats.shape
        price_feats = price_feats.view(bsz * max_c, flat_size)
    if pad_masks.dim() == 3:
        bsz, max_c, mask_len = pad_masks.shape
        pad_masks = pad_masks.view(bsz * max_c, mask_len)
    return (price_feats, pad_masks, njcs, nfos, ntbs, nfcs, num_clauses)


# ---------------------------------------------------------------------------
# Augmented dataset + collate
# ---------------------------------------------------------------------------
class PriceAugmentedDataset(Dataset):
    """Wrap a baseline Dataset so __getitem__ -> (base_item, price_feat_tuple).

    ``price_feats`` must be aligned to ``base_ds`` order (index i of price_feats
    corresponds to index i of base_ds) — see the alignment contract in
    ``load_price_feats``.
    """
    def __init__(self, base_ds, price_feats):
        assert len(base_ds) == len(price_feats), (
            f"base_ds ({len(base_ds)}) and price_feats ({len(price_feats)}) "
            f"length mismatch — they must be index-aligned")
        self.base_ds = base_ds
        self.price_feats = price_feats   # aligned to base_ds order

    def __len__(self):
        return len(self.base_ds)

    def __getitem__(self, i):
        return self.base_ds[i], self.price_feats[i]


def baseline_price_collate(batch, base_collate):
    """Collate (base_item, price_feat) pairs.

    The base half goes through the baseline's own collate; the price half is
    stacked into the PRICEEmbedder tuple of batched tensors via ``_stack_price``.
    """
    base_items = [b for b, _ in batch]
    price_items = [p for _, p in batch]
    base_batch = base_collate(base_items)    # the baseline's existing collate
    price_batch = _stack_price(price_items)  # -> (x, padding_mask, n_join_col, ...)
    return base_batch, price_batch


# ---------------------------------------------------------------------------
# Per-split alignment to the baseline train/val/test split
# ---------------------------------------------------------------------------
def build_aligned_price_feats_for_splits(argsP, dat_paths_train_list, dat_path_test,
                                         dat_dict):
    """Produce (train_feats, val_feats, test_feats) aligned 1:1 to the baseline
    split (``dat_dict['train_roots']`` / ``val_roots`` / ``test_roots``).

    Mirrors mode 7's get_price_only_ds_from_csv split exactly (same_file vs
    separate-file) so the per-query PRICE feature at index ``i`` of each returned
    list corresponds to the baseline root at index ``i`` of the matching split:

      * same_file: build the FULL-file ``sql_list`` (file order) once, then subset
        by ``dat_dict['train_ids']/['val_ids']/['test_ids']`` — exactly how
        ``get_new`` derives ``train_roots = [roots[idx] for idx in train_ids]``.
      * separate-file: build train+val features from the concatenated training SQL
        (``for_training=True`` per train workload, in ``dat_paths_train_list``
        order — the SAME order ``get_new`` concatenates ``df_train``) and subset by
        ``train_ids``/``val_ids``; build test features from the test SQL
        (``card=False``) indexed by ``test_ids - train_rows`` (``get_new`` sets
        ``test_ids = range(train_rows, train_rows+test_rows)``).

    The split id lists in ``dat_dict`` are produced by dataset_utils.get_new with
    the SAME random_state=42 / TPC-DS template logic that mode 7's train_val_test
    uses, so the alignment is positionally exact.

    ALIGNMENT INVARIANT (verified for the in-scope postgres/time cells): the plan
    CSV and the SQL file must have the SAME row order and row count, because the
    ``*_ids`` index into both. ``get_new``/``df2nodes`` SKIPS rows whose plan JSON
    is the literal string 'failed' (dataset_utils.py df2nodes), so a CSV containing
    a failed row would make ``roots`` shorter than ``feats_all`` and shift the ids.
    All in-scope postgres CSVs (imdb, imdb_job, stats, tpch, tpcds) have zero failed
    rows, so this holds. The ``PriceAugmentedDataset`` length assertion catches a
    total-count mismatch; if this is ever extended to engines/CSVs with failed rows,
    add a per-segment count check (feats_all length vs baseline roots length).
    """
    bin_size = getattr(argsP, 'price_bin_size', 40)
    price_n_or = getattr(argsP, 'price_n_or', False)
    workload_test = argsP.workload_test

    train_ids = dat_dict.get('train_ids')
    val_ids = dat_dict.get('val_ids')
    test_ids = dat_dict.get('test_ids')
    if train_ids is None or val_ids is None or test_ids is None:
        raise RuntimeError(
            "baseline_price_concat: dat_dict is missing train/val/test ids "
            "(needed to align PRICE features to the baseline split)")

    def _subset(lst, ids):
        return [lst[i] for i in ids]

    # Build the FULL combined SQL list in the SAME order get_new builds
    # total_roots (df = concat(df_train_paths..., df_test) for separate-file;
    # df = df_test for same_file), so position i of feats_all aligns with
    # total_roots[i] and the dat_dict id-lists index into it directly.
    same_file = (len(dat_paths_train_list) == 1
                 and dat_paths_train_list[0] == dat_path_test)

    # Each segment: (workload, db_name, sql_list). Padding is done JOINTLY across
    # all segments so the per-feature width and the model dims (price_max_n_*) are
    # unified — exactly as mode 7's separate-file branch pads train+test together.
    segments = []
    if same_file:
        sql_file = get_sql_file_for_workload(workload_test, card=argsP.card)
        sql_list = extract_raw_sql(sql_file)
        segments.append((workload_test,
                         get_db_name_for_workload(workload_test),
                         sql_list))
    else:
        workloads_train = list(getattr(argsP, 'workloads_train', []) or [])
        for idx_dp, _train_path in enumerate(dat_paths_train_list):
            train_wl = (workloads_train[idx_dp]
                        if idx_dp < len(workloads_train) else workload_test)
            train_sql_file = get_sql_file_for_workload(
                train_wl, card=argsP.card, for_training=True)
            train_sqls = extract_raw_sql(train_sql_file)
            segments.append((train_wl,
                             get_db_name_for_workload(train_wl),
                             train_sqls))
        test_sql_file = get_sql_file_for_workload(workload_test, card=argsP.card)
        test_sqls = extract_raw_sql(test_sql_file)
        segments.append((workload_test,
                         get_db_name_for_workload(workload_test),
                         test_sqls))

    # Extract each segment SEPARATELY (so a separate-file train segment — e.g.
    # imdb's 100k queries — HITS its existing per-segment cache, exactly as mode 7
    # does with two separate generate_price_features calls), then pad ALL segments
    # JOINTLY to a unified max. Per-query extraction is stateless, so
    # per-segment-extract + concat is byte-for-byte identical to a single combined
    # extraction — only the cache key (and thus reuse) differs. Each segment is
    # extracted with its OWN db_name, so mixed-db families are fine too.
    seg_raws = [_extract_price_segment(wl, sqls, db, bin_size, price_n_or)
                for wl, db, sqls in segments]
    feats_all, max_dims = _pad_price_segments(
        seg_raws, bin_size, price_n_or, return_max_dims=True)

    # Publish the unified max dims so build_price_embedder sizes the PRICE model
    # to match these features (mode 7 sets these from pad_and_cache_features too).
    argsP.price_max_n_join_col = max_dims["max_n_join_col"]
    argsP.price_max_n_fanout = max_dims["max_n_fanout"]
    argsP.price_max_n_table = max_dims["max_n_table"]
    argsP.price_max_n_filter_col = max_dims["max_n_filter_col"]
    if getattr(argsP, 'price_n_pairwise', False):
        argsP.price_max_n_pairwise_intra = max_dims["max_n_pairwise_intra"]

    return (_subset(feats_all, train_ids),
            _subset(feats_all, val_ids),
            _subset(feats_all, test_ids))


# ---------------------------------------------------------------------------
# CPU verification (feature extraction is CPU-only; no GPU required)
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    from functools import partial
    from torch.utils.data import DataLoader

    workload = "stats"
    db_name = "stats"          # get_db_name_for_workload("stats") == "stats"
    bin_size = 40

    # Read the SAME source file mode 7 uses for the stats cardinality workload:
    #   get_price_only_ds_from_csv -> get_sql_file_for_workload("stats", card=True)
    #   -> queries/stats_statsCEB_sub.sql, parsed by
    #      extract_raw_sql.
    sql_file = get_sql_file_for_workload(workload, card=True)
    print(f"[verify] SQL source (mode-7 stats card file): {sql_file}")
    all_sqls = extract_raw_sql(sql_file)
    N = min(8, len(all_sqls))
    sql_list = all_sqls[:N]
    print(f"[verify] using {N} stats SQLs")

    for price_n_or in (False, True):
        print(f"\n========== price_n_or={price_n_or} ==========")
        feats = load_price_feats(workload, sql_list, db_name, bin_size, price_n_or)
        print(f"[verify] load_price_feats -> {len(feats)} per-query entries; "
              f"each entry length = {len(feats[0])}")

        base_ds = list(range(N))                 # trivial dummy baseline dataset
        aug = PriceAugmentedDataset(base_ds, feats)

        loader = DataLoader(
            aug, batch_size=4, shuffle=False,
            collate_fn=partial(baseline_price_collate,
                               base_collate=lambda xs: torch.tensor(xs)),
        )
        base_batch, price_batch = next(iter(loader))
        print(f"[verify] base_batch: shape={tuple(base_batch.shape)} dtype={base_batch.dtype}")
        names = (["price_feats", "pad_masks", "njcs", "nfos", "ntbs", "nfcs"]
                 + (["num_clauses"] if price_n_or else []))
        print(f"[verify] price_batch tuple length = {len(price_batch)}")
        for nm, t in zip(names, price_batch):
            print(f"    {nm:12s} shape={tuple(t.shape)} dtype={t.dtype}")

        if not price_n_or:
            # Strengthened single-clause cross-check: instead of re-stacking the
            # SAME `feats` (which can't catch a pairwise-arg divergence — it just
            # re-collates what load_price_feats already produced), independently
            # re-run generate_price_features + pad_and_cache_features with mode
            # 7's EXACT single-clause kwargs (get_price_only_ds_from_csv,
            # utilsLLM.py ~4449-4453 + the call ~4486-4491: price_n_pairwise=True,
            # filter_dim=75, fanout_dim=42, pairwise_intra_dim=70,
            # n_pairwise_intras=<from the 6-tuple return>). The per-query flat
            # tensor + mask WIDTHS from that mode-7 reproduction must equal what
            # load_price_feats produces; if the single-clause path ever dropped
            # the pairwise args, the widths would diverge whenever pairwise>0.
            _gpf = generate_price_features(
                workload, sql_list, db_name, bin_size,
                price_n_parsing=True, price_n_filter=True,
                price_n_fanout=True, price_n_pairwise=True,
                price_n_or=False,
            )
            assert len(_gpf) == 6, (
                f"generate_price_features(price_n_pairwise=True) arity "
                f"{len(_gpf)} != 6 (expected the extra n_pairwise_intras)")
            _df, _njc, _nfo, _ntb, _nfc, _npi = _gpf
            ref_pf_list, ref_pm_list, *_ = pad_and_cache_features(
                _df, _njc, _nfo, _ntb, _nfc,
                bin_size=bin_size,
                filter_dim=75,
                price_n_pairwise=True,
                fanout_dim=42,
                pairwise_intra_dim=70,
                n_pairwise_intras=_npi,
            )
            ref_flat_w = ref_pf_list[0].shape[-1]
            ref_mask_w = ref_pm_list[0].shape[-1]
            got_flat_w = price_batch[0].shape[-1]
            got_mask_w = price_batch[1].shape[-1]
            max_npi = max(_npi) if _npi else 0
            print(f"[verify] mode-7 single-clause widths: flat={ref_flat_w} "
                  f"mask={ref_mask_w} (max pairwise-intra tokens={max_npi})")
            ok = (got_flat_w == ref_flat_w and got_mask_w == ref_mask_w and
                  price_batch[2].shape == (4, 1) and price_batch[5].shape == (4, 1))
            print(f"[verify] single-clause widths match mode-7 "
                  f"pad_and_cache_features: {ok} "
                  f"(load_price_feats flat={got_flat_w} mask={got_mask_w})")
            assert ok, (
                "single-clause price_batch widths diverge from mode-7 "
                "pad_and_cache_features — pairwise token axis mismatch!")
        else:
            # OR (multi-clause) path already threads multi_clause_data (whose
            # padding includes the pairwise axis); re-stack the per-query `feats`
            # and confirm the embedder-relevant shapes survive _stack_price's
            # 3D->2D reshape (mirrors llm_price_or_collate).
            collate_items = [(pf, 1.0, pm, njc, nfo, ntb, nfc, nc, 0.0)
                             for (pf, pm, njc, nfo, ntb, nfc, nc) in feats[:4]]
            pf_, pgc_, pm_, njc_, nfo_, ntb_, nfc_, nc_, _lab = zip(*collate_items)
            ref_pf = torch.stack([f for f in pf_]).float()
            ref_pm = torch.stack([m for m in pm_]).float()
            ref_njc = torch.tensor(njc_, dtype=torch.float32).unsqueeze(1)
            ref_nfc = torch.tensor(nfc_, dtype=torch.float32).unsqueeze(1)
            if ref_pf.dim() == 3:
                b_, c_, f_ = ref_pf.shape
                ref_pf_cmp = ref_pf.view(b_ * c_, f_)
                ref_pm_cmp = ref_pm.view(b_ * c_, ref_pm.shape[-1])
            else:
                ref_pf_cmp, ref_pm_cmp = ref_pf, ref_pm
            ok = (price_batch[0].shape == ref_pf_cmp.shape and
                  price_batch[1].shape == ref_pm_cmp.shape and
                  price_batch[2].shape == ref_njc.shape and
                  price_batch[5].shape == ref_nfc.shape)
            print(f"[verify] shapes match mode-7 collate "
                  f"(price_feats/pad_masks/njc/nfc): {ok}")
            assert ok, "price_batch shapes diverge from mode-7 collate!"

    print("\n[verify] OK — price_batch is interchangeable with mode-7's PRICEEmbedder input.")
