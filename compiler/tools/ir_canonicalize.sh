#!/usr/bin/env bash
set -euo pipefail

# read from stdin, write to stdout
# requires opt available in PATH (can be from Bisheng or system LLVM)
 
opt -S -instnamer -mem2reg -simplifycfg -constprop -deadargelim -strip-debug || cat 