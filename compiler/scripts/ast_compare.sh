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

cargo run -- --emit ast "$CASE_PATH" | python3 "$ROOT_DIR/tools/ast_normalize.py" > "$ROOT_DIR/out/ours.ast.json"
"$BISHENG_HOME/bin/clang" -Xclang -ast-dump=json -fsyntax-only "$CASE_PATH" \
  | python3 "$ROOT_DIR/tools/ast_normalize.py" > "$ROOT_DIR/out/ref.ast.json"

jq -S . "$ROOT_DIR/out/ours.ast.json" > "$ROOT_DIR/out/ours.ast.sorted.json"
jq -S . "$ROOT_DIR/out/ref.ast.json"  > "$ROOT_DIR/out/ref.ast.sorted.json"

diff -u "$ROOT_DIR/out/ref.ast.sorted.json" "$ROOT_DIR/out/ours.ast.sorted.json" 