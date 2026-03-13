#!/bin/bash
# 每日AI洞察报告生成脚本
# 执行时间：每日 19:00
# 作者：OpenClaw AI Assistant

set -e

# 配置
WORKSPACE="/root/.openclaw/workspace"
DATE=$(date +%Y-%m-%d)
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="$WORKSPACE/output/daily-insights/$DATE"
LOG_FILE="$WORKSPACE/logs/daily-insight-$DATE.log"

# 创建目录
mkdir -p "$OUTPUT_DIR"
mkdir -p "$WORKSPACE/logs"

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== 开始每日AI洞察任务 ==="

# 加载环境变量
source /root/.openclaw/secrets/api-keys.env 2>/dev/null || true
export TAVILY_API_KEY
export OPENAI_API_KEY
export OPENAI_BASE_URL

# 洞察目标公司
COMPANIES=(
    "字节跳动:ByteDance"
    "阿里巴巴:Qwen"
    "腾讯:Tencent HY"
    "智谱:GLM"
    "DeepSeek:DeepSeek"
    "Google:Gemini"
    "NVIDIA:NVIDIA AI"
    "MiniMax:MiniMax"
)

# 洞察范围关键词
TOPICS=(
    "模型发布 新模型"
    "算力卡 GPU HBM"
    "数据存储 存储 架构"
    "数据加速 推理优化"
    "Agent 智能体"
)

# 检索工具路径
TAVILY_SCRIPT="$WORKSPACE/skills/tavily-search/scripts/search.mjs"
ARXIV_TOOL="$WORKSPACE/skills/arxiv/arxiv_tool.py"
WPS_SCRIPT="$WORKSPACE/skills/wps-skill/scripts/main.py"

# 生成单公司洞察报告
generate_insight() {
    local company=$1
    local company_en=$2
    
    log "正在生成 $company 洞察报告..."
    
    REPORT_FILE="$OUTPUT_DIR/${company}AI洞察报告_${DATE}.md"
    
    # 创建报告框架
    cat > "$REPORT_FILE" << HEADER
# $company AI 产品与模型洞察报告

**生成日期**: $DATE  
**版本**: 每日自动生成

---

## 一、核心产品动态

HEADER

    # 使用 Tavily 搜索最新动态
    log "检索 $company 最新产品发布..."
    SEARCH_RESULT=$(node "$TAVILY_SCRIPT" "$company AI 产品 模型 $(date +%Y) 最新" -n 5 2>&1)
    
    # 提取关键信息并追加到报告
    echo "$SEARCH_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 二、数据存储技术

CONTENT

    # 搜索存储技术
    log "检索 $company 存储技术..."
    STORAGE_RESULT=$(node "$TAVILY_SCRIPT" "$company GPU 内存 存储 HBM" -n 3 2>&1)
    echo "$STORAGE_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 三、数据加速技术

CONTENT

    # 搜索加速技术
    log "检索 $company 加速技术..."
    ACCEL_RESULT=$(node "$TAVILY_SCRIPT" "$company 推理加速 量化 FlashAttention" -n 3 2>&1)
    echo "$ACCEL_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 四、技术趋势洞察

**生成时间**: $(date '+%Y-%m-%d %H:%M:%S')

---

*本报告由 OpenClaw AI 助手自动生成*
CONTENT

    log "$company 洞察报告生成完成: $REPORT_FILE"
}

# 主执行流程
main() {
    log "洞察目标: ${#COMPANIES[@]} 家公司"
    
    # 为每家公司生成报告
    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en <<< "$company_info"
        generate_insight "$company_cn" "$company_en"
    done
    
    # 生成汇总报告
    log "生成每日汇总报告..."
    SUMMARY_FILE="$OUTPUT_DIR/每日AI洞察汇总_${DATE}.md"
    
    cat > "$SUMMARY_FILE" << SUMMARY
# 每日AI洞察汇总

**日期**: $DATE  
**生成时间**: $(date '+%Y-%m-%d %H:%M:%S')

---

## 一、今日洞察公司

SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en <<< "$company_info"
        echo "- **$company_cn**" >> "$SUMMARY_FILE"
    done
    
    cat >> "$SUMMARY_FILE" << SUMMARY

## 二、报告列表

SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en <<< "$company_info"
        echo "- [$company_cn AI洞察报告](${company_cn}AI洞察报告_${DATE}.md)" >> "$SUMMARY_FILE"
    done
    
    cat >> "$SUMMARY_FILE" << SUMMARY

## 三、洞察范围

- **模型发布**: 大语言模型、多模态模型、推理模型
- **算力卡**: GPU、HBM、NVLink
- **数据存储**: 存储架构、显存优化、KV Cache
- **数据加速**: 推理优化、量化技术、FlashAttention
- **Agent/智能体**: 自主代理、工具调用、多步推理

## 四、技术趋势观察

（由各公司报告汇总）

---

*本报告由 OpenClaw AI 助手自动生成*
SUMMARY

    log "汇总报告生成完成: $SUMMARY_FILE"
    
    # 清理超过30天的旧报告
    log "清理30天前的旧报告..."
    find "$WORKSPACE/output/daily-insights" -type d -mtime +30 -exec rm -rf {} \; 2>/dev/null || true
    
    log "=== 每日AI洞察任务完成 ==="
    log "报告目录: $OUTPUT_DIR"
}

# 执行
main
