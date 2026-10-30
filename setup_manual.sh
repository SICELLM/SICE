#!/bin/bash
# Manual Installation Script for SICE
# This script sets up the environment for SICE manually
# Assumes you have already created and activated a Python 3.12 environment
# and have an NVIDIA driver / CUDA 12.x-compatible system.

echo "Setting up SICE environment manually..."

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y build-essential
sudo apt install python3.12 python3.12-venv python3.12-dev
# Create and activate a Python 3.12 virtual environment of your choice, e.g.:
#   python3.12 -m venv .venv && source .venv/bin/activate

echo "Installing PyTorch (CUDA 12.8 wheels) and Python packages..."

# Upgrade pip
python -m pip install --upgrade pip

# PyTorch + CUDA 12.8 wheels
python -m pip install torch==2.7.0 torchvision==0.22.0 torchaudio==2.7.0 \
  --index-url https://download.pytorch.org/whl/cu128

# Core Python packages
python -m pip install huggingface_hub wheel alive_progress seaborn sqlglot scipy matplotlib psycopg2-binary
python -m pip install transformers==4.55.2
python -m pip install bitsandbytes==0.46.0
python -m pip install pandas
python -m pip install scikit-learn einops numpy pyparsing
python -m pip install peft==0.15.2
python -m pip install tiktoken protobuf
python -m pip install sentencepiece

# FlashAttention prebuilt wheel
python -m pip install \
  https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.3/flash_attn-2.8.3%2Bcu12torch2.7cxx11abiFALSE-cp312-cp312-linux_x86_64.whl

# Extract the shipped workload SQL (used by the predicate canonicalization layer)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

echo "Manual installation completed!"
echo ""
echo "Make sure you have an appropriate NVIDIA driver and a Python 3.12 environment activated before running this script."
