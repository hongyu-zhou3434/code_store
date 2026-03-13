#!/bin/bash
# 每日AI洞察报告生成脚本
# 执行时间：每日 19:00
# 输出格式：MD + DOC + PDF
# 信息源：全球AI动态权威资讯来源清单
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

log "=========================================="
log "    每日AI洞察报告生成任务启动"
log "=========================================="
log ""

# 加载环境变量
source /root/.openclaw/secrets/api-keys.env 2>/dev/null || true
export TAVILY_API_KEY
export OPENAI_API_KEY
export OPENAI_BASE_URL

# 洞察目标公司
COMPANIES=(
    "字节跳动:ByteDance:豆包,Seedance,Seed"
    "阿里巴巴:Qwen:Qwen3,通义千问"
    "腾讯:Tencent HY:混元,腾讯AI"
    "智谱:GLM:GLM-5,智谱清言"
    "DeepSeek:DeepSeek:DeepSeek-V3,R1"
    "Google:Google AI:Gemini,TPU"
    "NVIDIA:NVIDIA AI:H100,B200,Rubin"
    "MiniMax:MiniMax:海螺AI"
)

# 洞察范围关键词（按类别）
declare -A TOPIC_CATEGORIES
TOPIC_CATEGORIES["硬件设备"]="GPU训练卡 GPU推理卡 HBM NVLink NVSwitch RDMA 网络互联 存储介质 显存优化"
TOPIC_CATEGORIES["模型"]="大语言模型 多模态 推理模型 算法创新 架构优化 工程实践"
TOPIC_CATEGORIES["Agent"]="智能体 RAG 检索增强 记忆系统 工具调用 自主代理"
TOPIC_CATEGORIES["AI框架"]="编译优化 量化技术 稀疏化 调度优化 推理加速 训练框架"
TOPIC_CATEGORIES["数据"]="训练数据 数据处理 数据存储 数据加速"

# 检索工具路径
TAVILY_SCRIPT="$WORKSPACE/skills/tavily-search/scripts/search.mjs"
ARXIV_TOOL="$WORKSPACE/skills/arxiv/arxiv_tool.py"
WPS_SCRIPT="$WORKSPACE/skills/wps-skill/scripts/main.py"

# 生成单公司洞察报告（MD格式）
generate_insight_md() {
    local company=$1
    local company_en=$2
    local products=$3
    
    log "正在生成 $company 洞察报告..."
    
    REPORT_FILE="$OUTPUT_DIR/${company}AI洞察报告_${DATE}.md"
    
    # 创建报告框架
    cat > "$REPORT_FILE" << HEADER
# $company AI 产品与模型洞察报告

**生成日期**: $DATE  
**报告版本**: 每日自动生成  
**目标公司**: $company  
**核心产品**: $products  
**信息来源**: 全球AI动态权威资讯来源清单

---

## 一、新产品与模型概览

HEADER

    # 搜索最新产品发布
    log "  [1/10] 检索新产品与模型信息..."
    SEARCH_RESULT=$(node "$TAVILY_SCRIPT" "$company AI 产品 模型 发布 $DATE" -n 5 2>&1)
    echo "$SEARCH_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 二、硬件设备

### 2.1 训练与推理卡

CONTENT

    log "  [2/10] 检索硬件设备信息..."
    HW_RESULT=$(node "$TAVILY_SCRIPT" "$company GPU 训练卡 推理卡 H100 B200 HBM" -n 4 2>&1)
    echo "$HW_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

### 2.2 超节点服务

CONTENT

    NODE_RESULT=$(node "$TAVILY_SCRIPT" "$company 超节点 GPU集群 服务器" -n 3 2>&1)
    echo "$NODE_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

### 2.3 网络

CONTENT

    NET_RESULT=$(node "$TAVILY_SCRIPT" "$company NVLink NVSwitch RDMA 网络 互联" -n 3 2>&1)
    echo "$NET_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

### 2.4 存储介质

CONTENT

    STORAGE_RESULT=$(node "$TAVILY_SCRIPT" "$company 存储 HBM 显存 NVMe" -n 3 2>&1)
    echo "$STORAGE_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 三、模型

### 3.1 算法创新

CONTENT

    log "  [3/10] 检索模型算法..."
    ALGO_RESULT=$(node "$TAVILY_SCRIPT" "$company 算法创新 模型架构" -n 3 2>&1)
    echo "$ALGO_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

### 3.2 架构设计

CONTENT

    log "  [4/10] 检索模型架构..."
    ARCH_RESULT=$(node "$TAVILY_SCRIPT" "$company 模型架构 Transformer MoE" -n 3 2>&1)
    echo "$ARCH_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

### 3.3 工程实践

CONTENT

    log "  [5/10] 检索工程实践..."
    ENG_RESULT=$(node "$TAVILY_SCRIPT" "$company 模型工程 训练优化 推理优化" -n 3 2>&1)
    echo "$ENG_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 四、Agent/智能体

### 4.1 RAG与检索增强

CONTENT

    log "  [6/10] 检索 Agent RAG..."
    RAG_RESULT=$(node "$TAVILY_SCRIPT" "$company Agent RAG 检索增强 知识库" -n 3 2>&1)
    echo "$RAG_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

### 4.2 记忆系统

CONTENT

    MEM_RESULT=$(node "$TAVILY_SCRIPT" "$company Agent 记忆 长期记忆 上下文" -n 3 2>&1)
    echo "$MEM_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 五、AI框架

### 5.1 编译优化

CONTENT

    log "  [7/10] 检索 AI 框架..."
    COMPILER_RESULT=$(node "$TAVILY_SCRIPT" "$company AI框架 编译优化 CUDA TensorRT" -n 3 2>&1)
    echo "$COMPILER_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

### 5.2 量化技术

CONTENT

    QUANT_RESULT=$(node "$TAVILY_SCRIPT" "$company 量化 INT4 INT8 FP8 推理加速" -n 3 2>&1)
    echo "$QUANT_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

### 5.3 稀疏化与调度

CONTENT

    SPARSE_RESULT=$(node "$TAVILY_SCRIPT" "$company 稀疏化 调度优化 训练框架" -n 3 2>&1)
    echo "$SPARSE_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 六、数据

### 6.1 训练数据

CONTENT

    log "  [8/10] 检索数据信息..."
    DATA_RESULT=$(node "$TAVILY_SCRIPT" "$company 训练数据 数据集 规模" -n 3 2>&1)
    echo "$DATA_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

### 6.2 数据处理与存储

CONTENT

    DATASTORE_RESULT=$(node "$TAVILY_SCRIPT" "$company 数据处理 数据存储 数据加速" -n 3 2>&1)
    echo "$DATASTORE_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 七、参考文献与论文

CONTENT

    log "  [9/10] 检索相关论文..."
    cd "$WORKSPACE/skills/arxiv"
    PAPER_RESULT=$(python3 arxiv_tool.py search "$company_en AI architecture" --max 5 --sort date 2>&1)
    echo "$PAPER_RESULT" >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << CONTENT

---

## 八、关键信息链接

### 官方链接
- **官方网站**: 
- **官方博客**: 
- **GitHub**: 

### 产品链接
- **产品主页**: 
- **API 文档**: 
- **模型下载**: 

### 学术资源
- **论文地址**: 
- **开源代码**: 

---

## 九、技术趋势洞察

**生成时间**: $(date '+%Y-%m-%d %H:%M:%S')

### 今日观察

### 技术趋势判断

### 关注重点

---

*本报告由 OpenClaw AI 助手自动生成*  
*信息源：全球AI动态权威资讯来源清单*
CONTENT

    log "$company MD 报告生成完成"
    echo "$REPORT_FILE"
}

# 转换 MD 为 DOC 格式
convert_to_doc() {
    local md_file=$1
    local company=$2
    
    log "  转换 MD → DOC..."
    
    local doc_file="${md_file%.md}.docx"
    
    cd "$WORKSPACE/skills/wps-skill"
    python3 scripts/main.py md_to_docx file="$md_file" output="$doc_file" title="$company AI洞察报告" 2>&1 >> "$LOG_FILE"
    
    if [ -f "$doc_file" ]; then
        log "  ✅ DOC 生成成功: $(ls -lh "$doc_file" | awk '{print $5}')"
    else
        log "  ❌ DOC 转换失败"
    fi
}

# 转换 DOC 为 PDF 格式
convert_to_pdf() {
    local doc_file=$1
    local company=$2
    
    log "  转换 DOC → PDF..."
    
    local pdf_file="${doc_file%.docx}.pdf"
    
    libreoffice --headless --convert-to pdf --outdir "$OUTPUT_DIR" "$doc_file" 2>&1 >> "$LOG_FILE"
    
    if [ -f "$pdf_file" ]; then
        log "  ✅ PDF 生成成功: $(ls -lh "$pdf_file" | awk '{print $5}')"
    else
        log "  ❌ PDF 转换失败"
    fi
}

# 主执行流程
main() {
    log "洞察目标: ${#COMPANIES[@]} 家公司"
    log "输出格式: MD + DOC + PDF"
    log "信息源: 全球AI动态权威资讯来源清单"
    log ""
    
    # 为每家公司生成报告
    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en products <<< "$company_info"
        
        log "----------------------------------------"
        log "开始处理: $company_cn"
        
        # 1. 生成 MD 格式
        md_file=$(generate_insight_md "$company_cn" "$company_en" "$products")
        
        # 2. 转换为 DOC 格式
        convert_to_doc "$md_file" "$company_cn"
        
        # 3. 转换为 PDF 格式
        doc_file="${md_file%.md}.docx"
        if [ -f "$doc_file" ]; then
            convert_to_pdf "$doc_file" "$company_cn"
        fi
        
        log ""
    done
    
    # 生成汇总报告
    log "=========================================="
    log "生成每日汇总报告..."
    log "=========================================="
    
    SUMMARY_MD="$OUTPUT_DIR/每日AI洞察汇总_${DATE}.md"
    
    cat > "$SUMMARY_MD" << SUMMARY
# 每日AI洞察汇总报告

**日期**: $DATE  
**生成时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**报告数量**: ${#COMPANIES[@]} 份  
**信息来源**: 全球AI动态权威资讯来源清单

---

## 一、今日洞察公司

| 公司 | 核心产品 |
|------|----------|
SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en products <<< "$company_info"
        echo "| **$company_cn** | $products |" >> "$SUMMARY_MD"
    done
    
    cat >> "$SUMMARY_MD" << SUMMARY

---

## 二、报告列表

### Markdown 格式
SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en products <<< "$company_info"
        echo "- [$company_cn AI洞察报告](${company_cn}AI洞察报告_${DATE}.md)" >> "$SUMMARY_MD"
    done
    
    cat >> "$SUMMARY_MD" << SUMMARY

### Word 格式
SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en products <<< "$company_info"
        echo "- ${company_cn}AI洞察报告_${DATE}.docx" >> "$SUMMARY_MD"
    done
    
    cat >> "$SUMMARY_MD" << SUMMARY

### PDF 格式
SUMMARY

    for company_info in "${COMPANIES[@]}"; do
        IFS=':' read -r company_cn company_en products <<< "$company_info"
        echo "- ${company_cn}AI洞察报告_${DATE}.pdf" >> "$SUMMARY_MD"
    done
    
    cat >> "$SUMMARY_MD" << SUMMARY

---

## 三、洞察范围

| 领域 | 细分方向 |
|------|----------|
| **硬件设备** | 训练与推理卡、超节点服务、网络、存储介质 |
| **模型** | 算法、架构、工程 |
| **Agent** | RAG、记忆系统 |
| **AI框架** | 编译、量化、稀疏化、调度、加速 |
| **数据** | 训练数据、数据处理、数据存储 |

---

## 四、报告内容结构

1. 新产品与模型概览
2. 硬件设备（训练卡、推理卡、超节点、网络、存储）
3. 模型（算法、架构、工程）
4. Agent/智能体（RAG、记忆）
5. AI框架（编译、量化、稀疏化、调度）
6. 数据（训练数据、处理、存储）
7. 参考文献与论文
8. 关键信息链接
9. 技术趋势洞察

---

## 五、信息来源

**全球AI动态权威资讯来源清单**：

- arXiv 学术论文库
- 企业官方博客（OpenAI, Google, Meta, NVIDIA 等）
- 行业媒体（量子位、机器之心、VentureBeat 等）
- 技术社区（GitHub, Reddit, Hugging Face 等）

---

*本报告由 OpenClaw AI 助手自动生成*
SUMMARY

    # 转换汇总报告为 DOC 和 PDF
    convert_to_doc "$SUMMARY_MD" "汇总"
    summary_doc="${SUMMARY_MD%.md}.docx"
    if [ -f "$summary_doc" ]; then
        convert_to_pdf "$summary_doc" "汇总"
    fi
    
    # 清理超过30天的旧报告
    log ""
    log "清理 30 天前的旧报告..."
    find "$WORKSPACE/output/daily-insights" -type d -mtime +30 -exec rm -rf {} \; 2>/dev/null || true
    
    # 统计生成文件
    md_count=$(find "$OUTPUT_DIR" -name "*.md" -type f 2>/dev/null | wc -l)
    doc_count=$(find "$OUTPUT_DIR" -name "*.docx" -type f 2>/dev/null | wc -l)
    pdf_count=$(find "$OUTPUT_DIR" -name "*.pdf" -type f 2>/dev/null | wc -l)
    
    log ""
    log "=========================================="
    log "    每日AI洞察任务执行完成"
    log "=========================================="
    log ""
    log "报告目录: $OUTPUT_DIR"
    log "生成统计: MD=${md_count}, DOC=${doc_count}, PDF=${pdf_count}"
    log ""
}

# 执行
main
