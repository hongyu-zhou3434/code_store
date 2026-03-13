# AI技术洞察全网检索清单

**版本**: v1.0  
**更新日期**: 2026年3月13日  
**用途**: 为后续AI技术洞察任务提供标准化检索配置

---

## 一、检索源分类

### 1.1 学术论文源（优先级：最高）

| 平台 | URL模板 | 检索方式 | 适用场景 |
|------|---------|----------|----------|
| **arXiv** | `https://arxiv.org/search/?query={keyword}&searchtype=all` | API/Web | 论文首发、前沿研究 |
| **Papers with Code** | `https://paperswithcode.com/search?q={keyword}` | Web | 论文+代码+排行榜 |
| **Hugging Face Papers** | `https://huggingface.co/papers?search={keyword}` | API | 模型论文、开源模型 |
| **Semantic Scholar** | `https://www.semanticscholar.org/search?q={keyword}` | API | 论文引用分析 |

**arXiv 分类检索**：
```
cs.AI  - 人工智能
cs.CL  - 计算与语言（NLP）
cs.CV  - 计算机视觉
cs.LG  - 机器学习
cs.RO  - 机器人
cs.NE  - 神经与进化计算
```

### 1.2 企业博客源（优先级：高）

| 公司 | 博客URL | 更新频率 | 关注重点 |
|------|---------|----------|----------|
| **OpenAI** | `https://openai.com/blog` | 每周 | GPT、DALL-E、Sora |
| **Google AI** | `https://blog.google/technology/ai/` | 每周 | Gemini、TPU |
| **DeepMind** | `https://deepmind.google/discover/blog/` | 每周 | AlphaFold、强化学习 |
| **Meta AI** | `https://ai.meta.com/blog/` | 每两周 | LLaMA、PyTorch |
| **Microsoft** | `https://www.microsoft.com/research/blog/` | 每周 | Azure AI、Copilot |
| **NVIDIA** | `https://developer.nvidia.com/blog/` | 每周 | GPU、CUDA、TensorRT |
| **Anthropic** | `https://www.anthropic.com/research` | 每月 | Claude、AI安全 |

### 1.3 新闻媒体源（优先级：中）

#### 国际媒体

| 媒体 | URL | 特点 |
|------|-----|------|
| **VentureBeat AI** | `https://venturebeat.com/category/ai/` | 商业新闻、融资 |
| **TechCrunch AI** | `https://techcrunch.com/category/artificial-intelligence/` | 创业、产品 |
| **MIT Tech Review** | `https://www.technologyreview.com/topic/artificial-intelligence/` | 深度分析 |
| **Wired AI** | `https://www.wired.com/tag/artificial-intelligence/` | 伦理、趋势 |
| **MarkTechPost** | `https://www.marktechpost.com/` | 论文解读 |

#### 中国媒体

| 媒体 | URL | 公众号ID |
|------|-----|----------|
| **机器之心** | `https://www.jiqizhixin.com/` | almosthuman2014 |
| **量子位** | `https://www.qbitai.com/` | QbitAI |
| **新智元** | `https://www.163.com/dy/media/T1600000020962649.html` | AI_era |
| **智源社区** | `https://hub.baai.ac.cn/` | BAAI_Hub |
| **AI科技评论** | `https://www.leiphone.com/category/ai` | aitechtalk |

### 1.4 社区论坛源（优先级：中）

| 社区 | URL | 特点 |
|------|-----|------|
| **Reddit ML** | `https://www.reddit.com/r/MachineLearning/` | 社区讨论、论文讨论 |
| **Reddit AI** | `https://www.reddit.com/r/artificial/` | 通用AI讨论 |
| **Hugging Face** | `https://huggingface.co/` | 模型、数据集 |
| **Kaggle** | `https://www.kaggle.com/` | 竞赛、数据集 |
| **GitHub Trending** | `https://github.com/trending` | 开源项目 |

---

## 二、标准化检索模板

### 2.1 公司产品检索模板

```bash
# 模板：{公司名} + {产品/模型} + {时间范围}
# 示例：

# 阿里巴巴 Qwen
"https://www.jiqizhixin.com/search?q=Qwen"
"https://paperswithcode.com/search?q=Qwen"

# DeepSeek
"https://arxiv.org/search/?query=DeepSeek&searchtype=all"
"https://www.qbitai.com/?s=DeepSeek"

# NVIDIA
"https://developer.nvidia.com/blog/search/#+stq=Blackwell"
"https://venturebeat.com/?s=NVIDIA+AI"
```

### 2.2 技术主题检索模板

```bash
# 模板：{技术关键词} + site限制

# 存储技术
"site:arxiv.org HBM GPU memory"
"site:developer.nvidia.com NVLink storage"

# 推理加速
"site:paperswithcode.com FlashAttention inference"
"site:huggingface.co quantization INT4"

# MoE 架构
"site:arxiv.org Mixture of Experts LLM"
"site:jiqizhixin.com MoE 混合专家"
```

### 2.3 多源聚合检索

```
检索顺序：
1. 学术源（arXiv → Papers with Code → Hugging Face）
2. 企业博客（OpenAI → Google → Meta → NVIDIA）
3. 新闻媒体（量子位 → 机器之心 → VentureBeat）
4. 社区论坛（Reddit → GitHub）
```

---

## 三、检索关键词库

### 3.1 存储技术关键词

```
英文关键词：
- HBM (High Bandwidth Memory)
- GPU Memory
- NVLink
- NVSwitch
- GPU Direct Storage
- RDMA
- KV Cache
- Memory Bandwidth

中文关键词：
- 显存
- 高带宽内存
- GPU互联
- 存储架构
- 内存优化
```

### 3.2 数据加速关键词

```
英文关键词：
- Inference Optimization
- FlashAttention
- Quantization (INT4/INT8/FP8/FP4)
- TensorRT
- CUDA
- Kernel Fusion
- Speculative Decoding
- MoE (Mixture of Experts)
- Expert Parallelism

中文关键词：
- 推理加速
- 量化
- 注意力优化
- 混合专家
- 算子融合
```

### 3.3 产品/公司关键词

```
公司名：
- OpenAI, Google, Meta, NVIDIA, Microsoft
- DeepSeek, Alibaba (Qwen), ByteDance
- Zhipu (GLM), MiniMax, Tencent (Hunyuan)
- Anthropic, Mistral

产品名：
- GPT, Gemini, LLaMA, Claude, Mistral
- Qwen, DeepSeek, GLM, 海螺AI, 混元
- H100, B200, Rubin, Blackwell
- Seedance, Doubao
```

---

## 四、检索API配置

### 4.1 Tavily Search（已配置）

```json
{
  "api_key": "TAVILY_API_KEY",
  "base_url": "https://api.tavily.com",
  "search_depth": "advanced",
  "max_results": 10,
  "include_domains": [
    "arxiv.org",
    "paperswithcode.com",
    "huggingface.co",
    "openai.com",
    "deepmind.google",
    "venturebeat.com",
    "jiqizhixin.com",
    "qbitai.com"
  ]
}
```

### 4.2 arXiv API

```
基础URL: http://export.arxiv.org/api/query
参数:
- search_query: 检索关键词
- start: 起始位置
- max_results: 结果数量
- sortBy: relevance/submittedDate/lastUpdatedDate
- sortOrder: ascending/descending

示例:
http://export.arxiv.org/api/query?search_query=all:DeepSeek&max_results=10&sortBy=submittedDate&sortOrder=descending
```

### 4.3 Hugging Face API

```
模型搜索: https://huggingface.co/api/models?search={keyword}
论文搜索: https://huggingface.co/api/daily_papers
```

---

## 五、检索任务模板

### 5.1 公司AI洞察检索模板

```yaml
task: company_ai_insight
company: {公司名}
steps:
  1. 搜索最新产品/模型发布
     - 源: 企业博客 + 新闻媒体
     - 关键词: "{公司名} AI 产品 模型 2025 2026"
  
  2. 搜索技术架构
     - 源: arXiv + Papers with Code
     - 关键词: "{产品名} architecture MoE"
  
  3. 搜索存储技术
     - 关键词: "{公司名} GPU memory storage"
  
  4. 搜索加速技术
     - 关键词: "{公司名} inference optimization quantization"
  
  5. 汇总生成洞察报告
```

### 5.2 技术主题检索模板

```yaml
task: tech_topic_insight
topic: {技术主题}
steps:
  1. 学术论文检索
     - 源: arXiv (cs.AI, cs.CL, cs.LG)
     - 关键词: "{topic}"
  
  2. 工程实践检索
     - 源: 企业博客 + GitHub
     - 关键词: "{topic} implementation"
  
  3. 行业应用检索
     - 源: 新闻媒体
     - 关键词: "{topic} application"
```

---

## 六、自动化检索脚本

### 6.1 公司AI动态检索脚本

```bash
#!/bin/bash
# AI 公司动态检索脚本
# 用法: ./ai_search.sh "公司名"

COMPANY=$1

echo "=== $COMPANY AI 动态检索 ==="

# 1. 新闻检索
echo "1. 新闻媒体..."
curl -s "https://www.qbitai.com/?s=$COMPANY" | grep -o '<title>[^<]*' | head -5

# 2. 学术检索
echo "2. arXiv 论文..."
curl -s "http://export.arxiv.org/api/query?search_query=all:$COMPANY&max_results=5"

# 3. 企业博客
echo "3. 企业博客..."
# 根据公司名选择博客URL

echo "检索完成"
```

### 6.2 技术主题检索脚本

```bash
#!/bin/bash
# AI 技术主题检索脚本
# 用法: ./tech_search.sh "技术关键词"

TOPIC=$1

echo "=== $TOPIC 技术检索 ==="

# Tavily 搜索
export TAVILY_API_KEY="your_key"
node tavily-search/scripts/search.mjs "$TOPIC" -n 10

# arXiv 搜索
curl -s "http://export.arxiv.org/api/query?search_query=all:$TOPIC&max_results=10"
```

---

## 七、检索源优先级矩阵

| 检索类型 | 首选源 | 备选源 | 说明 |
|----------|--------|--------|------|
| **产品发布** | 企业博客 | 新闻媒体 | 官方信息最准确 |
| **技术架构** | arXiv | Papers with Code | 学术论文最深入 |
| **商业动态** | VentureBeat | TechCrunch | 商业媒体最快 |
| **开源项目** | GitHub | Hugging Face | 社区驱动 |
| **中国动态** | 量子位 | 机器之心 | 中文资讯最快 |
| **社区讨论** | Reddit | Twitter/X | 舆论风向 |

---

## 八、输出格式规范

### 8.1 洞察报告标准结构

```markdown
# {公司名} AI 产品与模型洞察报告

## 一、核心产品概览
- 最新产品/模型
- 发布时间线
- 核心规格

## 二、数据存储技术
- 存储架构
- 关键技术
- 性能指标

## 三、数据加速技术
- 推理加速
- 训练优化
- 量化技术

## 四、核心洞察
- 技术趋势
- 竞争优势
- 未来展望
```

### 8.2 文件命名规范

```
{公司名}AI洞察报告_{日期}.docx
{公司名}AI洞察报告_技术深度版_{日期}.docx
```

---

## 九、维护更新

### 9.1 定期更新项

| 更新频率 | 更新内容 |
|----------|----------|
| **每周** | 企业博客URL、新闻媒体动态 |
| **每月** | 检索关键词库、API配置 |
| **每季度** | 公司列表、产品矩阵 |

### 9.2 新增公司模板

```yaml
new_company:
  name: ""
  blog_url: ""
  products: []
  search_keywords: []
```

---

*本清单为AI技术洞察任务的标准检索配置*
