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

# our tokens
cargo run -- --emit tokens "$CASE_PATH" > "$ROOT_DIR/out/ours.tokens.json"

# ref tokens from Bisheng clang
"$BISHENG_HOME/bin/clang" -Xclang -dump-tokens -fsyntax-only "$CASE_PATH" \
  | python3 "$ROOT_DIR/tools/clang_tokens_to_json.py" > "$ROOT_DIR/out/ref.tokens.json"

# normalize and diff
jq -S . "$ROOT_DIR/out/ours.tokens.json" > "$ROOT_DIR/out/ours.tokens.sorted.json"
jq -S . "$ROOT_DIR/out/ref.tokens.json"  > "$ROOT_DIR/out/ref.tokens.sorted.json"

diff -u "$ROOT_DIR/out/ref.tokens.sorted.json" "$ROOT_DIR/out/ours.tokens.sorted.json" 