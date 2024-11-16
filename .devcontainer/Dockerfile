FROM mcr.microsoft.com/devcontainers/base:ubuntu

USER root

# 基本的なパッケージのインストール
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
        wget \
        bzip2 \
        ca-certificates \
        gnupg2 \
        libyaml-dev \
        ninja-build \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Mambaforge
ENV CONDA_DIR=/opt/conda
RUN wget -q "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh" -O /tmp/mambaforge.sh \
    && chmod +x /tmp/mambaforge.sh \
    && bash /tmp/mambaforge.sh -b -p "${CONDA_DIR}" \
    && rm /tmp/mambaforge.sh

# ホストのCUDAを利用するための環境変数設定
ENV PATH=/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}
ENV PATH="${CONDA_DIR}/bin:${PATH}"

# Initialize conda for shell interaction
RUN mamba init bash

# Create conda environments
RUN mamba create -n dev python=3.10 -y \
    && mamba create -n alphapose python=3.10 -y \
    && echo "conda activate dev" >> ~/.bashrc

# AlphaPose環境のセットアップ
RUN conda run -n alphapose pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 \
    && conda run -n alphapose pip3 install cython

# Change ownership of conda directory
RUN chown -R vscode:vscode "${CONDA_DIR}"

# Switch back to non-root user
USER vscode