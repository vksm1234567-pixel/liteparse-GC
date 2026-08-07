#!/usr/bin/env bash
set -e

echo "==> Building liteparse CLI (release)"
cargo build --release -p liteparse

echo "==> Symlinking lit onto PATH"
mkdir -p "$HOME/.local/bin"
ln -sf "$(pwd)/target/release/lit" "$HOME/.local/bin/lit"
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" || \
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"

echo "==> Installing maturin for Python bindings"
pip install --user maturin

echo "==> Building Python bindings (packages/python)"
if [ -d packages/python ]; then
  (cd packages/python && "$HOME/.local/bin/maturin" develop --release || true)
fi

echo "==> Installing Node deps + building Node bindings (packages/node)"
if [ -d packages/node ]; then
  (cd packages/node && npm install && npm run build || true)
fi

echo "==> Done. Try: lit --help"
