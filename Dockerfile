FROM mcr.microsoft.com/devcontainers/rust:1-bookworm

# Native deps liteparse's Rust core needs to build/run
# (matches run-llama/liteparse's own Dockerfile)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libclang-dev \
    libtesseract-dev \
    libleptonica-dev \
    cmake \
    g++ \
    pkg-config \
    tesseract-ocr-eng \
    libreoffice \
    && rm -rf /var/lib/apt/lists/*
