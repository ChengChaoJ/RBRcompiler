#!/usr/bin/env bash
# BiSheng编译器分区函数测试脚本 - 移除可执行文件大小对比

set -eo pipefail

# 设置颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== BiSheng编译器分区函数测试 ===${NC}"

# 设置BiSheng环境
export BISHENG_HOME=${BISHENG_HOME:-/opt/compiler/BiShengCompiler-4.2.0.2-aarch64-linux}
export PATH="$BISHENG_HOME/bin:$PATH"
export LD_LIBRARY_PATH="${BISHENG_HOME}/lib:${BISHENG_HOME}/lib/aarch64-unknown-linux-gnu:${LD_LIBRARY_PATH}"

echo "BiSheng环境设置:"
echo "BISHENG_HOME: $BISHENG_HOME"
echo ""

# 检查输入文件
INPUT_FILE="test_partition.c"
if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}错误: 文件 '$INPUT_FILE' 不存在${NC}"
    exit 1
fi

# 显示系统信息
echo -e "${BLUE}=== 系统信息 ===${NC}"
echo "系统架构: $(uname -m)"
echo "操作系统: $(uname -s)"
echo ""

# 检查BiSheng编译器
echo -e "${BLUE}=== 检查BiSheng编译器 ===${NC}"
if command -v clang >/dev/null 2>&1; then
    echo -e "${GREEN}✓ BiSheng clang编译器可用${NC}"
    clang --version | head -1
else
    echo -e "${RED}✗ BiSheng clang编译器不可用${NC}"
    exit 1
fi
echo ""

# 创建输出目录
OUTPUT_DIR="partition_output"
mkdir -p "$OUTPUT_DIR"

# 1. 编译程序 - 无优化版本
echo -e "${BLUE}=== 编译程序 (无优化) ===${NC}"
UNOPTIMIZED_EXE="$OUTPUT_DIR/partition_unoptimized"

echo "编译无优化版本..."
if clang -O0 "$INPUT_FILE" -o "$UNOPTIMIZED_EXE" 2>/dev/null; then
    echo -e "${GREEN}✓ BiSheng无优化动态链接编译成功${NC}"
    UNOPTIMIZED_METHOD="BiSheng动态链接(无优化)"
else
    echo -e "${RED}✗ BiSheng无优化编译失败${NC}"
    exit 1
fi

# 显示无优化文件信息（仅显示编译方法）
if [ -f "$UNOPTIMIZED_EXE" ]; then
    echo "编译方法: $UNOPTIMIZED_METHOD"
fi
echo ""

# 2. 编译程序 - 优化版本
echo -e "${BLUE}=== 编译程序 (优化) ===${NC}"
OPTIMIZED_EXE="$OUTPUT_DIR/partition_optimized"

echo "编译优化版本..."
if clang -O2 "$INPUT_FILE" -o "$OPTIMIZED_EXE" 2>/dev/null; then
    echo -e "${GREEN}✓ BiSheng优化动态链接编译成功${NC}"
    OPTIMIZED_METHOD="BiSheng动态链接(优化)"
else
    echo -e "${RED}✗ BiSheng优化编译失败${NC}"
    exit 1
fi

# 显示优化文件信息（仅显示编译方法）
if [ -f "$OPTIMIZED_EXE" ]; then
    echo "编译方法: $OPTIMIZED_METHOD"
fi
echo ""

# 3. 生成汇编代码
echo -e "${BLUE}=== 生成汇编代码 ===${NC}"
UNOPTIMIZED_ASM="$OUTPUT_DIR/partition_unoptimized.s"
OPTIMIZED_ASM="$OUTPUT_DIR/partition_optimized.s"

# 生成无优化汇编
echo "生成无优化汇编代码 (O0)..."
if clang -S -O0 "$INPUT_FILE" -o "$UNOPTIMIZED_ASM" 2>/dev/null; then
    echo -e "${GREEN}✓ BiSheng无优化汇编代码生成成功${NC}"
    UNOPTIMIZED_ASM_SIZE=$(stat -c%s "$UNOPTIMIZED_ASM" 2>/dev/null || stat -f%z "$UNOPTIMIZED_ASM" 2>/dev/null || echo "未知")
    echo "  文件大小: $UNOPTIMIZED_ASM_SIZE 字节"
    
    # 统计汇编指令行数（排除指令、空行、注释）
    UNOPTIMIZED_ASM_LINES=$(grep -v "^\s*\." "$UNOPTIMIZED_ASM" | grep -v "^\s*$" | grep -v "^\s*//" | wc -l 2>/dev/null || echo "未知")
    echo "  指令行数: $UNOPTIMIZED_ASM_LINES"
else
    echo -e "${YELLOW}⚠ BiSheng无优化汇编代码生成失败${NC}"
fi
echo ""

# 生成优化汇编
echo "生成优化汇编代码 (O2)..."
if clang -S -O2 "$INPUT_FILE" -o "$OPTIMIZED_ASM" 2>/dev/null; then
    echo -e "${GREEN}✓ BiSheng优化汇编代码生成成功${NC}"
    OPTIMIZED_ASM_SIZE=$(stat -c%s "$OPTIMIZED_ASM" 2>/dev/null || stat -f%z "$OPTIMIZED_ASM" 2>/dev/null || echo "未知")
    echo "  文件大小: $OPTIMIZED_ASM_SIZE 字节"
    
    # 统计汇编指令行数
    OPTIMIZED_ASM_LINES=$(grep -v "^\s*\." "$OPTIMIZED_ASM" | grep -v "^\s*$" | grep -v "^\s*//" | wc -l 2>/dev/null || echo "未知")
    echo "  指令行数: $OPTIMIZED_ASM_LINES"
else
    echo -e "${YELLOW}⚠ BiSheng优化汇编代码生成失败${NC}"
fi
echo ""

# 4. 运行程序 - 无优化版本
echo -e "${BLUE}=== 运行程序 (无优化版本) ===${NC}"
echo "程序输出:"
echo "----------------------------------------"

if [ -x "$UNOPTIMIZED_EXE" ]; then
    echo "无优化程序可执行，开始运行..."
    
    # 记录开始时间
    START_TIME=$(date +%s%3N 2>/dev/null || date +%s)
    
    # 直接运行程序
    if "$UNOPTIMIZED_EXE" 2>&1; then
        echo "----------------------------------------"
        echo -e "${GREEN}✓ 无优化程序运行成功${NC}"
    else
        echo "----------------------------------------"
        echo -e "${YELLOW}⚠ 无优化程序运行完成，但可能有警告${NC}"
    fi
    
    # 记录结束时间
    END_TIME=$(date +%s%3N 2>/dev/null || date +%s)
    UNOPTIMIZED_TIME=$((END_TIME - START_TIME))
    echo "无优化版本运行时间: ${UNOPTIMIZED_TIME}ms"
else
    echo -e "${RED}✗ 无优化程序不可执行${NC}"
fi
echo ""

# 5. 运行程序 - 优化版本
echo -e "${BLUE}=== 运行程序 (优化版本) ===${NC}"
echo "程序输出:"
echo "----------------------------------------"

if [ -x "$OPTIMIZED_EXE" ]; then
    echo "优化程序可执行，开始运行..."
    
    # 记录开始时间
    START_TIME=$(date +%s%3N 2>/dev/null || date +%s)
    
    # 直接运行程序
    if "$OPTIMIZED_EXE" 2>&1; then
        echo "----------------------------------------"
        echo -e "${GREEN}✓ 优化程序运行成功${NC}"
    else
        echo "----------------------------------------"
        echo -e "${YELLOW}⚠ 优化程序运行完成，但可能有警告${NC}"
    fi
    
    # 记录结束时间
    END_TIME=$(date +%s%3N 2>/dev/null || date +%s)
    OPTIMIZED_TIME=$((END_TIME - START_TIME))
    echo "优化版本运行时间: ${OPTIMIZED_TIME}ms"
else
    echo -e "${RED}✗ 优化程序不可执行${NC}"
fi
echo ""

# 6. 性能测试 - 无优化版本
echo -e "${BLUE}=== 性能测试 (无优化版本) ===${NC}"
echo "进行3次性能测试..."

UNOPTIMIZED_TIMES=()
for i in {1..3}; do
    echo "第 $i 次运行 (无优化)..."
    START_TIME=$(date +%s%3N 2>/dev/null || date +%s)
    
    # 直接运行程序
    "$UNOPTIMIZED_EXE" >/dev/null 2>&1
    
    END_TIME=$(date +%s%3N 2>/dev/null || date +%s)
    RUNTIME=$((END_TIME - START_TIME))
    UNOPTIMIZED_TIMES+=($RUNTIME)
    echo "  运行时间: ${RUNTIME}ms"
done

# 计算无优化平均时间
if [ ${#UNOPTIMIZED_TIMES[@]} -gt 0 ]; then
    SUM=0
    for time in "${UNOPTIMIZED_TIMES[@]}"; do
        SUM=$((SUM + time))
    done
    UNOPTIMIZED_AVG=$((SUM / ${#UNOPTIMIZED_TIMES[@]}))
    echo "无优化平均运行时间: ${UNOPTIMIZED_AVG}ms"
fi
echo ""

# 7. 性能测试 - 优化版本
echo -e "${BLUE}=== 性能测试 (优化版本) ===${NC}"
echo "进行3次性能测试..."

OPTIMIZED_TIMES=()
for i in {1..3}; do
    echo "第 $i 次运行 (优化)..."
    START_TIME=$(date +%s%3N 2>/dev/null || date +%s)
    
    # 直接运行程序
    "$OPTIMIZED_EXE" >/dev/null 2>&1
    
    END_TIME=$(date +%s%3N 2>/dev/null || date +%s)
    RUNTIME=$((END_TIME - START_TIME))
    OPTIMIZED_TIMES+=($RUNTIME)
    echo "  运行时间: ${RUNTIME}ms"
done

# 计算优化平均时间
if [ ${#OPTIMIZED_TIMES[@]} -gt 0 ]; then
    SUM=0
    for time in "${OPTIMIZED_TIMES[@]}"; do
        SUM=$((SUM + time))
    done
    OPTIMIZED_AVG=$((SUM / ${#OPTIMIZED_TIMES[@]}))
    echo "优化平均运行时间: ${OPTIMIZED_AVG}ms"
fi
echo ""

# 8. 性能对比报告
echo -e "${BLUE}=== 性能对比报告 (O0 vs O2) ===${NC}"
echo ""

# 汇编文件大小对比
echo -e "${CYAN}📄 汇编文件对比:${NC}"
printf "%-20s %-18s %-18s %-18s %-18s\n" "优化级别" "文件大小(字节)" "指令行数" "相对大小" "变化率"
printf "%-20s %-18s %-18s %-18s %-18s\n" "--------------------" "------------------" "------------------" "------------------" "------------------"

if [ "$UNOPTIMIZED_ASM_SIZE" != "未知" ] && [ "$OPTIMIZED_ASM_SIZE" != "未知" ]; then
    ASM_SIZE_REDUCTION=$((UNOPTIMIZED_ASM_SIZE - OPTIMIZED_ASM_SIZE))
    ASM_SIZE_REDUCTION_PERCENT=$((ASM_SIZE_REDUCTION * 100 / UNOPTIMIZED_ASM_SIZE))
    
    ASM_CHANGE_TYPE="减少"
    ASM_CHANGE_SIGN="-"
    if [ $ASM_SIZE_REDUCTION -lt 0 ]; then
        ASM_CHANGE_TYPE="增加"
        ASM_CHANGE_SIGN="+"
        ASM_SIZE_REDUCTION=$((OPTIMIZED_ASM_SIZE - UNOPTIMIZED_ASM_SIZE))
        ASM_SIZE_REDUCTION_PERCENT=$((ASM_SIZE_REDUCTION * 100 / UNOPTIMIZED_ASM_SIZE))
    fi
    
    printf "%-20s %-18s %-18s %-18s %-18s\n" "无优化 (O0)" "$UNOPTIMIZED_ASM_SIZE" "$UNOPTIMIZED_ASM_LINES" "100%" "基准"
    printf "%-20s %-18s %-18s %-18s %-18s\n" "优化 (O2)" "$OPTIMIZED_ASM_SIZE" "$OPTIMIZED_ASM_LINES" "$((OPTIMIZED_ASM_SIZE * 100 / UNOPTIMIZED_ASM_SIZE))%" "${ASM_CHANGE_TYPE}: ${ASM_CHANGE_SIGN}${ASM_SIZE_REDUCTION_PERCENT}%"
else
    printf "%-20s %-18s %-18s %-18s %-18s\n" "无优化 (O0)" "$UNOPTIMIZED_ASM_SIZE" "$UNOPTIMIZED_ASM_LINES" "N/A" "N/A"
    printf "%-20s %-18s %-18s %-18s %-18s\n" "优化 (O2)" "$OPTIMIZED_ASM_SIZE" "$OPTIMIZED_ASM_LINES" "N/A" "N/A"
fi

echo ""

# 运行时间对比
echo -e "${CYAN}⚡ 运行时间对比 (平均 3 次):${NC}"
printf "%-20s %-18s %-18s %-18s\n" "优化级别" "平均时间(ms)" "相对速度" "性能提升"
printf "%-20s %-18s %-18s %-18s\n" "--------------------" "------------------" "------------------" "------------------"

if [ $UNOPTIMIZED_AVG -gt 0 ] && [ $OPTIMIZED_AVG -gt 0 ]; then
    SPEEDUP=$((UNOPTIMIZED_AVG * 100 / OPTIMIZED_AVG))
    SPEEDUP_PERCENT=$((SPEEDUP - 100))
    
    printf "%-20s %-18s %-18s %-18s\n" "无优化 (O0)" "$UNOPTIMIZED_AVG" "100%" "基准"
    printf "%-20s %-18s %-18s %-18s\n" "优化 (O2)" "$OPTIMIZED_AVG" "$((OPTIMIZED_AVG * 100 / UNOPTIMIZED_AVG))%" "快 ${SPEEDUP_PERCENT}%"
else
    printf "%-20s %-18s %-18s %-18s\n" "无优化 (O0)" "$UNOPTIMIZED_AVG" "N/A" "N/A"
    printf "%-20s %-18s %-18s %-18s\n" "优化 (O2)" "$OPTIMIZED_AVG" "N/A" "N/A"
fi

echo ""

# 9. 生成报告
echo -e "${BLUE}=== 编译报告 ===${NC}"
echo "源文件: $INPUT_FILE"
echo "输出目录: $OUTPUT_DIR"
echo ""
echo "编译配置:"
echo "  无优化编译: $UNOPTIMIZED_METHOD"
echo "  优化编译:   $OPTIMIZED_METHOD"
echo ""
echo "生成的汇编文件:"
if [ -f "$UNOPTIMIZED_ASM" ]; then
    echo "  O0 汇编: $UNOPTIMIZED_ASM ($UNOPTIMIZED_ASM_SIZE 字节, $UNOPTIMIZED_ASM_LINES 指令行)"
fi
if [ -f "$OPTIMIZED_ASM" ]; then
    echo "  O2 汇编: $OPTIMIZED_ASM ($OPTIMIZED_ASM_SIZE 字节, $OPTIMIZED_ASM_LINES 指令行)"
fi
echo ""
echo "所有生成文件:"
ls -lh "$OUTPUT_DIR" 2>/dev/null || echo "输出目录为空"
echo ""

# 10. 显示汇编代码片段
echo -e "${BLUE}=== 汇编代码片段对比 ===${NC}"
echo ""

if [ -f "$UNOPTIMIZED_ASM" ]; then
    echo -e "${CYAN}无优化 (O0) 汇编代码 - 前15行:${NC}"
    head -15 "$UNOPTIMIZED_ASM"
    echo "..."
    echo ""
fi

if [ -f "$OPTIMIZED_ASM" ]; then
    echo -e "${CYAN}优化 (O2) 汇编代码 - 前15行:${NC}"
    head -15 "$OPTIMIZED_ASM"
    echo "..."
    echo ""
fi

echo -e "${GREEN}=== BiSheng编译器分区函数测试完成 ===${NC}"
echo "所有输出文件保存在: $OUTPUT_DIR"
echo ""
echo "汇编文件:"
echo "  无优化 (O0): $UNOPTIMIZED_ASM"
echo "  优化 (O2):   $OPTIMIZED_ASM"
