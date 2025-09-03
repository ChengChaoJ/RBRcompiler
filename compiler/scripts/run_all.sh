#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cases=$(find "$ROOT_DIR/examples" "$ROOT_DIR/tests" -type f -name "*.c" 2>/dev/null || true)

pass=0
fail=0
skipped=0

for c in $cases; do
  echo "==> $c"
  for s in lex_compare.sh ast_compare.sh ir_compare.sh codegen_compare.sh; do
    if bash "$SCRIPT_DIR/$s" "$c"; then
      echo "[OK] $s $c"
      pass=$((pass+1))
    else
      echo "[FAIL] $s $c"
      fail=$((fail+1))
    fi
  done
  echo
done

echo "Summary: pass=$pass fail=$fail skipped=$skipped"
[[ $fail -eq 0 ]] || exit 1 