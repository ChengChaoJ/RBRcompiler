#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/env.sh"

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <case.c>" >&2
  exit 2
fi

CASE_PATH="$1"
mkdir -p "$ROOT_DIR/out"

# ours (llvm ir text)
cargo run -- --emit ir "$CASE_PATH" | "$ROOT_DIR/tools/ir_canonicalize.sh" > "$ROOT_DIR/out/ours.ll"

# reference
"$BISHENG_HOME/bin/clang" -S -emit-llvm -o - "$CASE_PATH" | "$ROOT_DIR/tools/ir_canonicalize.sh" > "$ROOT_DIR/out/ref.ll"

diff -u "$ROOT_DIR/out/ref.ll" "$ROOT_DIR/out/ours.ll" 