#!/bin/bash
set -e

# Activate conda environment
source ~/.bashrc

# Install Python packages
mamba install -y \
    ipython \
    jupyter \
    numpy \
    pandas \
    matplotlib \
    scikit-learn \
    ruff \
    black \
    isort

# Update all packages
mamba update -y --all

# Clean up
mamba clean -afy