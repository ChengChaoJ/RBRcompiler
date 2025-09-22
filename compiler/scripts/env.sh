#!/usr/bin/env bash
# Set up environment for Bisheng toolchain and utilities

# NOTE: update this path to your actual Bisheng installation

export BISHENG_HOME=${BISHENG_HOME:-/opt/BishengCompiler/BiShengCompiler-4.2.0.2-aarch64-linux}

export PATH="$BISHENG_HOME/bin:$PATH"

# LLVM tools (optional if using Bisheng-provided)
export LLVM_BIN=${LLVM_BIN:-$BISHENG_HOME/bin}
export PATH="$LLVM_BIN:$PATH"

# Strict bash
set -o pipefail 