FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Set environment
ENV DEBIAN_FRONTEND=noninteractive

# System dependencies
RUN apt-get update && apt-get install -y \
    python3.12 python3.12-venv python3.12-dev python3-pip git curl build-essential \
    libglib2.0-0 libsm6 libxext6 libxrender-dev ninja-build \
    && apt-get clean

# Create venv
RUN python3.12 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Upgrade pip
RUN pip install --upgrade pip

# Install PyTorch (CUDA 12.6 wheels)
RUN pip install \
    torch==2.7.0 \
    torchvision==0.22.0 \
    torchaudio==2.7.0 \
    --index-url https://download.pytorch.org/whl/cu126

# Core Python packages
RUN pip install huggingface_hub wheel alive_progress seaborn
RUN pip install transformers==4.55.2
RUN pip install bitsandbytes==0.46.0
RUN pip install pandas
RUN pip install scikit-learn einops numpy pyparsing
RUN pip install peft==0.15.2
RUN pip install sqlglot scipy matplotlib psycopg2-binary tiktoken protobuf sentencepiece

# FlashAttention prebuilt wheel (cp312, matching the Python 3.12 venv above).
# Optional: the code falls back to PyTorch SDPA attention if flash-attn is absent.
RUN pip install \
  https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.3/flash_attn-2.8.3%2Bcu12torch2.7cxx11abiFALSE-cp312-cp312-linux_x86_64.whl

# Set working directory
WORKDIR /workspace
