#!/bin/bash
# 每日AI洞察报告生成脚本
# 执行时间：每日 19:00
# 输出格式：MD + DOC + PDF
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

# 检索工具路径
TAVILY_SCRIPT="$WORKSPACE/skills/tavily-search/scripts/search.mjs"
WPS_SCRIPT="$WORKSPACE/skills/wps-skill/scripts/main.py"

# 生成单公司洞察报告（MD格式）
generate_insight_md() {
    local company=$1
    local company_en=$2
    
    log "正在生成 $company 洞察报告 (MD)..."
    
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

    log "$company MD 报告生成完成"
    echo "$REPORT_FILE"
}

# 转换 MD 为 DOC 格式
convert_to_doc() {
    local md_file=$1
    local company=$2
    
    log "转换 $company MD → DOC..."
    
    local doc_file="${md_file%.md}.docx"
    
    cd "$WORKSPACE/skills/wps-skill"
    python3 scripts/main.py md_to_docx file="$md_file" output="$doc_file" title="$company AI洞察报告" 2>&1 | while read line; do
        log "  $line"
    done
    
    if [ -f "$doc_file" ]; then
        log "$company DOC 报告生成完成: $doc_file"
    else
        log "警告: $company DOC 转换失败"
    fi
}

# 转换 DOC 为 PDF 格式
convert_to_pdf() {
    local doc_file=$1
    local company=$2
    
    log "转换 $company DOC → PDF..."
    
    local pdf_file="${doc_file%.docx}.pdf"
    
    # 使用 LibreOffice 转换
    if command -v libreoffice &> /dev/null; then
        libreoffice --headless --convert-to pdf --outdir "$OUTPUT_DIR" "$doc_file" 2>&1 | while read line; do
            log "  $line"
        done
        if [ -f "$pdf_file" ]; then
            log "$company PDF 报告生成完成: $pdf_file"
        else
            log "警告: $company PDF 转换失败"
        fi
    elif command -v soffice &> /dev/null; then
        soffice --headless --convert-to pdf --outdir "$OUTPUT_DIR" "$doc_file" 2>&1 | while read line; do
            log "  $line"
        done
        if [ -f "$pdf_file" ]; then
            log "$company PDF 报告生成完成: $pdf_file"
        else
            log "警告: $company PDF 转换失败"
        fi
    else
        log "警告: LibreOffice 未安装，跳过 PDF 转换"
    fi
}

# 主执行流程
main() {
    log "洞察目标: ${#COMPANIES[@]} 家公司"
    log "输出格式: MD + DOC + PDF"
    
    # 为每家公司生成报告
    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en <<< "$company_info"
        
        # 1. 生成 MD 格式
        md_file=$(generate_insight_md "$company_cn" "$company_en")
        
        # 2. 转换为 DOC 格式
        convert_to_doc "$md_file" "$company_cn"
        
        # 3. 转换为 PDF 格式
        doc_file="${md_file%.md}.docx"
        if [ -f "$doc_file" ]; then
            convert_to_pdf "$doc_file" "$company_cn"
        fi
    done
    
    # 生成汇总报告
    log "生成每日汇总报告..."
    SUMMARY_MD="$OUTPUT_DIR/每日AI洞察汇总_${DATE}.md"
    
    cat > "$SUMMARY_MD" << SUMMARY
# 每日AI洞察汇总

**日期**: $DATE  
**生成时间**: $(date '+%Y-%m-%d %H:%M:%S')

---

## 一、今日洞察公司

SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en <<< "$company_info"
        echo "- **$company_cn**" >> "$SUMMARY_MD"
    done
    
    cat >> "$SUMMARY_MD" << SUMMARY

## 二、报告列表

### Markdown 格式
SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en <<< "$company_info"
        echo "- [$company_cn AI洞察报告](${company_cn}AI洞察报告_${DATE}.md)" >> "$SUMMARY_MD"
    done
    
    cat >> "$SUMMARY_MD" << SUMMARY

### Word 格式
SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en <<< "$company_info"
        echo "- $company_cn AI洞察报告_${DATE}.docx" >> "$SUMMARY_MD"
    done
    
    cat >> "$SUMMARY_MD" << SUMMARY

### PDF 格式
SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en <<< "$company_info"
        echo "- $company_cn AI洞察报告_${DATE}.pdf" >> "$SUMMARY_MD"
    done
    
    cat >> "$SUMMARY_MD" << SUMMARY

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

    # 转换汇总报告为 DOC 和 PDF
    convert_to_doc "$SUMMARY_MD" "汇总"
    summary_doc="${SUMMARY_MD%.md}.docx"
    if [ -f "$summary_doc" ]; then
        convert_to_pdf "$summary_doc" "汇总"
    fi
    
    log "汇总报告生成完成"
    
    # 清理超过30天的旧报告
    log "清理30天前的旧报告..."
    find "$WORKSPACE/output/daily-insights" -type d -mtime +30 -exec rm -rf {} \; 2>/dev/null || true
    
    log "=== 每日AI洞察任务完成 ==="
    log "报告目录: $OUTPUT_DIR"
    
    # 统计生成文件
    md_count=$(find "$OUTPUT_DIR" -name "*.md" -type f 2>/dev/null | wc -l)
    doc_count=$(find "$OUTPUT_DIR" -name "*.docx" -type f 2>/dev/null | wc -l)
    pdf_count=$(find "$OUTPUT_DIR" -name "*.pdf" -type f 2>/dev/null | wc -l)
    
    log "生成文件统计: MD=${md_count}, DOC=${doc_count}, PDF=${pdf_count}"
}

# 执行
main
