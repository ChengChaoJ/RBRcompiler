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

cargo run -- --emit riscv "$CASE_PATH" | "$ROOT_DIR/tools/asm_normalize.sh" > "$ROOT_DIR/out/ours.S"
"$BISHENG_HOME/bin/clang" --target=riscv64-unknown-linux-gnu -S -o - "$CASE_PATH" \
  | "$ROOT_DIR/tools/asm_normalize.sh" > "$ROOT_DIR/out/ref.S"

diff -u "$ROOT_DIR/out/ref.S" "$ROOT_DIR/out/ours.S" 