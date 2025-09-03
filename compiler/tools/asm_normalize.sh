#!/usr/bin/env bash
set -euo pipefail
 
# remove comments, leading/trailing spaces, collapse multiple spaces, drop empty lines
sed -E 's/#.*$//; s/[[:space:]]+$//; s/^[[:space:]]+//; s/[[:space:]]{2,}/ /g' \
  | grep -v -E '^[[:space:]]*$' || true 