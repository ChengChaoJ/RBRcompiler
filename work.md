# C语言自研编译器技术方案

## 项目概述

本项目旨在开发一个用Rust编写的自研C语言编译器，将C源代码转换为Bisheng的token流、AST、IR，最终生成RISC-V汇编代码。

## 技术架构

### 编译流程
```
C源代码 → Token流 → AST → Bisheng Token流 → Bisheng AST → Bisheng IR → 自定义IR → RISC-V汇编
```

### 核心阶段
1. **词法分析**：将C源代码转换为Token流
2. **语法分析**：构建抽象语法树(AST)
3. **Bisheng转换**：将AST转换为Bisheng格式
4. **中间代码生成**：生成自定义IR
5. **目标代码生成**：生成RISC-V汇编

## 文件架构设计

```
compiler/
├── Cargo.toml                 # Rust项目配置
├── src/
│   ├── main.rs               # 主程序入口
│   ├── lexer/                # 词法分析器
│   │   ├── mod.rs
│   │   ├── token.rs          # Token定义
│   │   ├── lexer.rs          # 词法分析器实现
│   │   └── keywords.rs       # C语言关键字
│   ├── parser/               # 语法分析器
│   │   ├── mod.rs
│   │   ├── ast.rs            # AST节点定义
│   │   ├── parser.rs         # 递归下降解析器
│   │   └── precedence.rs     # 运算符优先级
│   ├── semantic/             # 语义分析
│   │   ├── mod.rs
│   │   ├── analyzer.rs       # 语义分析器
│   │   ├── symbol_table.rs   # 符号表
│   │   └── types.rs          # 类型系统
│   ├── bisheng/              # Bisheng集成
│   │   ├── mod.rs
│   │   ├── token.rs          # Bisheng Token转换
│   │   ├── ast.rs            # Bisheng AST转换
│   │   └── ir.rs             # Bisheng IR转换
│   ├── ir/                   # 中间表示
│   │   ├── mod.rs
│   │   ├── instruction.rs    # IR指令定义
│   │   ├── basic_block.rs    # 基本块
│   │   └── function.rs       # 函数
│   ├── riscv/                # RISC-V代码生成
│   │   ├── mod.rs
│   │   ├── codegen.rs        # 代码生成器
│   │   ├── register.rs       # 寄存器分配
│   │   └── assembly.rs       # 汇编输出
│   ├── error/                # 错误处理
│   │   ├── mod.rs
│   │   └── error.rs          # 错误类型定义
│   └── utils/                # 工具函数
│       ├── mod.rs
│       └── helpers.rs
├── examples/                 # 示例C代码
├── tests/                    # 测试文件
└── docs/                     # 文档
```

## 已完成工作
- **项目初始化**: 创建 `Cargo.toml`，定义基础依赖 `anyhow`、`thiserror`、`serde`、`serde_json`、`clap`。
- **入口与模块骨架**:
  - `src/main.rs`: 程序入口，声明顶层模块。
  - `src/lexer/`: `mod.rs`、`token.rs`、`lexer.rs`、`keywords.rs`（提供最小可编译实现）。
  - `src/parser/`: `mod.rs`、`ast.rs`、`parser.rs`、`precedence.rs`。
  - `src/semantic/`: `mod.rs`、`analyzer.rs`、`symbol_table.rs`、`types.rs`。
  - `src/bisheng/`: `mod.rs`、`token.rs`、`ast.rs`、`ir.rs`（对接Bisheng的占位结构）。
  - `src/ir/`: `mod.rs`、`instruction.rs`、`basic_block.rs`、`function.rs`。
  - `src/riscv/`: `mod.rs`、`codegen.rs`、`register.rs`、`assembly.rs`。
  - `src/error/`: `mod.rs`、`error.rs`（统一错误枚举）。
  - `src/utils/`: `mod.rs`、`helpers.rs`。
- **测试与示例**: `tests/smoke.rs`（冒烟测试），`examples/hello.c`（占位示例）。
- **现状说明**: 当前环境未安装 `cargo`，本地构建需先安装 Rust 工具链。

## 构建与运行（先决条件）
- **安装Rust**: 建议使用 `rustup` 安装 stable 工具链。
- **构建**:
  - 构建: `cargo build`
  - 测试: `cargo test`
  - 运行: `cargo run`

## 近期
- **M0 骨架完成（已完成）**: 模块与目录对齐、最小可编译骨架、冒烟测试。
- **M1 词法分析**:
  - 实现标识符、关键字、整数字面量、运算符与分隔符；位置追踪与错误恢复。
  - 单元测试覆盖典型Token化案例；快照测试。
- **M2 语法分析**:
  - 递归下降或基于 Pratt 的表达式解析；支持声明、函数、语句块与控制流。
  - 生成最小AST；错误同步策略与报错位置优化。
- **M3 语义分析**:
  - 符号表、作用域、类型系统；基本类型检查与返回路径检查。
  - 为IR生成准备解糖（如一元/二元运算的规范化）。
- **M4 Bisheng集成与IR管线**:
  - C AST → Bisheng Token/AST/IR 的映射器原型；定义兼容性与限制清单。
  - Bisheng IR → 自定义IR 降级规则；基本块构建与控制流正确性校验。
  - 自定义IR → RISC-V 初版指令选择与线性扫描寄存器分配；汇编输出器。

## 中长期规划（M5+）
- **优化与质量**: 常量折叠、死代码消除、简单SSA、基本块合并、活跃变量分析。
- **平台与ABI**: RISC-V ABI 调用约定、栈帧布局、变长参数与结构体传参支持。
- **语言覆盖**: 指针与数组、函数指针、结构体/联合体、前置/后置自增自减等。
- **工具链集成**: 与 Bisheng 的版本/格式对齐脚手架、Fuzz/差分测试、增量编译。
- **工程化**: `clap` CLI 子命令（如 `lex`, `parse`, `ir`, `codegen`）、日志、`--emit` 选项。
- **CI/CD**: 引入 GitHub Actions 或本地CI，执行 `cargo fmt/clippy/test` 与快照对比。

## 任务清单（动态维护）
- [ ] 在本环境安装 `rustup` 与 `cargo`，完成首次 `cargo build`/`test`。
- [ ] `lexer::Lexer::tokenize` 实现与测试覆盖。
- [ ] 表达式解析与语句/声明解析，输出可视化AST（`--show-ast`）。
- [ ] 语义分析通过基础示例；错误信息包含行列范围。
- [ ] 定义 Bisheng 映射规范文档与适配层原型实现。
- [ ] 初版 RISC-V 代码生成（返回、简单算术、条件/跳转）。
- [ ] 端到端示例：`examples/hello.c` → `.s`。

## 验证与对齐脚本方案

- **目标**: 对每个阶段（Token、AST、IR、RISC-V汇编）将自研编译器输出与 Bisheng 官方接口输出对比，形成自动化一致性验证。
- **策略**: 自研输出统一为 JSON/文本，经标准化归一，再与 Bisheng 输出（同样标准化后）做结构化或文本 diff。

### 目录结构（新增）
```
compiler/
├── scripts/
│   ├── env.sh                       # 环境变量与路径配置（Bisheng 路径、LLVM 工具）
│   ├── lex_compare.sh               # 词法（Token）对比
│   ├── ast_compare.sh               # AST 对比
│   ├── ir_compare.sh                # IR 对比（基于 LLVM IR 文本）
│   ├── codegen_compare.sh           # RISC-V 汇编对比
│   └── run_all.sh                   # 批量运行所有阶段对比（遍历 examples/ tests/）
├── tools/
│   ├── clang_tokens_to_json.py      # 将 clang/Bisheng dump-tokens 标准输出转 JSON
│   ├── ast_normalize.py             # 归一化 AST（字段筛选、排序、删冗）
│   ├── ir_canonicalize.sh           # 归一化 LLVM IR（opt -S -instnamer -mem2reg 等）
│   └── asm_normalize.sh             # 归一化汇编文本（去注释/空白/伪指令差异）
└── out/                             # 比对产物与中间文件输出目录（gitignore）
```

### 环境要求
- 安装 Bisheng 工具链（`clang` 可用），并在 `scripts/env.sh` 中配置 `BISHENG_HOME`、`PATH`。
- 若进行 IR 规范化，对应安装 LLVM 工具（`opt`, `llvm-as`, `llvm-dis`, 可使用 Bisheng 自带或系统 LLVM）。

### 我方 CLI 约定（后续实现）
- 统一通过 `cargo run --` 执行，提供 `--emit` 选项：
  - `--emit tokens|ast|bisheng-tokens|bisheng-ast|bisheng-ir|ir|riscv`
  - 输出到 `stdout`，必要时用 `-o` 指定路径
- 示例：
```sh
cargo run -- --emit tokens examples/hello.c > out/ours.tokens.json
cargo run -- --emit ast    examples/hello.c > out/ours.ast.json
cargo run -- --emit ir     examples/hello.c > out/ours.ll
cargo run -- --emit riscv  examples/hello.c > out/ours.S
```

### 参考侧（Bisheng）命令约定
- **Token**：
```sh
"$BISHENG_HOME/bin/clang" -Xclang -dump-tokens -fsyntax-only examples/hello.c \
  | python3 tools/clang_tokens_to_json.py > out/ref.tokens.json
```
- **AST（JSON）**：
```sh
"$BISHENG_HOME/bin/clang" -Xclang -ast-dump=json -fsyntax-only examples/hello.c \
  | python3 tools/ast_normalize.py > out/ref.ast.json
```
- **IR（LLVM IR 文本）**：
```sh
"$BISHENG_HOME/bin/clang" -S -emit-llvm -o - examples/hello.c \
  | tools/ir_canonicalize.sh > out/ref.ll
```
- **RISC-V 汇编**：
```sh
"$BISHENG_HOME/bin/clang" --target=riscv64-unknown-linux-gnu -S -o - examples/hello.c \
  | tools/asm_normalize.sh > out/ref.S
```

### 对比流程与标准化
- **Token**：两侧均为 JSON 数组（字段：kind、value、位置信息可选）。按顺序对比，或基于 kind/value 做序列比对。
- **AST**：两侧均为 JSON。先归一化（删除非语义字段如 UID、位置信息可选字段、排序子节点）。使用 `jq -S` 或 Python 深度比较。
- **IR**：文本 IR 经 `ir_canonicalize.sh` 处理（`opt -S -instnamer -mem2reg -simplifycfg`），再做 `diff -u`；可选用 `llvm-diff` 辅助。
- **汇编**：经 `asm_normalize.sh` 去注释/空白与伪指令差异，再 `diff -u`。允许白名单忽略指令选择差异。

### 脚本入口示例
- `scripts/lex_compare.sh`：
```sh
#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"
case=$1
mkdir -p out
cargo run -- --emit tokens "$case" > out/ours.tokens.json
"$BISHENG_HOME/bin/clang" -Xclang -dump-tokens -fsyntax-only "$case" \
  | python3 tools/clang_tokens_to_json.py > out/ref.tokens.json
jq -S . out/ours.tokens.json > out/ours.tokens.sorted.json
jq -S . out/ref.tokens.json  > out/ref.tokens.sorted.json
diff -u out/ref.tokens.sorted.json out/ours.tokens.sorted.json || exit 1
```
- 其余阶段脚本 `ast_compare.sh`、`ir_compare.sh`、`codegen_compare.sh` 类似，分别替换命令与标准化步骤。
- `scripts/run_all.sh`：遍历 `examples/` 与 `tests/`，依次对每个 `*.c` 运行四个阶段脚本，最终聚合结果。

### 数据格式与约定
- **Token JSON**：`[{"kind": "Identifier", "value": "x"}, ...]`；可选字段：`loc: {line, column}`。
- **AST JSON**：树形结构；归一化时只保留语义字段，如 `kind`、`name`、`type`、`children`。
- **IR**：优先使用 LLVM IR 文本以便工具链通用；若后续接入 Bisheng 专有 IR，再增加适配转换与规范化脚本。
- **汇编**：文本 `.S`，按行对比。

### 注意事项
- Bisheng 的 `clang` 版本与选项可能与社区 `clang` 略有差异；脚本需对错误返回码做健壮处理。
- 位置相关差异（loc）常见，默认不纳入强一致；可提供 `--strict-loc` 开关启用严格对比。
- IR 对比建议在 `-O0` 下进行，减少优化带来的无关差异；必要时可对我方与参考两侧统一加 `-O0`。

## 脚本与工具落地记录
- 新增目录：`compiler/scripts/`、`compiler/tools/`、`compiler/out/`
- 新增脚本：
  - `scripts/env.sh`
  - `scripts/lex_compare.sh`
  - `scripts/ast_compare.sh`
  - `scripts/ir_compare.sh`
  - `scripts/codegen_compare.sh`
  - `scripts/run_all.sh`
- 新增工具：
  - `tools/clang_tokens_to_json.py`
  - `tools/ast_normalize.py`
  - `tools/ir_canonicalize.sh`
  - `tools/asm_normalize.sh`
- 已设置可执行权限：上述 `*.sh`、`*.py` 均已 `chmod +x`
- 输出目录：`out/` 已创建用于存放对比产物
- 使用示例：
  - 单文件 Token 对比：`bash scripts/lex_compare.sh examples/hello.c`
  - 批量对比：`bash scripts/run_all.sh`
- 前提：安装 Rust 与 Bisheng，并在 `scripts/env.sh` 配置 `BISHENG_HOME`，确保 `clang`、`opt` 可用
