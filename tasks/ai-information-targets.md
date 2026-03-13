# 系统可用的AI信息获取目标清单

**版本**: v1.0  
**更新日期**: 2026年3月13日  
**用途**: 定义系统可检索的所有AI信息目标

---

## 一、AI公司目标清单

### 1.1 国际AI公司

| 公司 | 主要产品 | 检索优先级 | 状态 |
|------|----------|----------|------|
| **OpenAI** | GPT 系列、DALL-E、Sora | 高 | ✅ 可检索 |
| **Google** | Gemini、TPU、Gemini App | 高 | ✅ 可检索 |
| **Meta** | LLaMA、PyTorch、AI Studio | 高 | ✅ 可检索 |
| **NVIDIA** | GPU (H100/B200/Rubin)、CUDA、TensorRT | 高 | ✅ 已生成报告 |
| **Microsoft** | Azure AI、Copilot、Phi | 中 | ✅ 可检索 |
| **Anthropic** | Claude 系列 | 中 | ✅ 可检索 |
| **Mistral** | Mistral、Mixtral | 中 | ✅ 可检索 |
| **Amazon** | AWS AI、Bedrock、Titan | 中 | ✅ 可检索 |

### 1.2 中国AI公司

| 公司 | 主要产品 | 检索优先级 | 状态 |
|------|----------|----------|------|
| **阿里巴巴** | 千问（Qwen）系列 | 高 | ✅ 已生成报告 |
| **字节跳动** | 豆包、Seedance、Seed | 高 | ✅ 已生成报告 |
| **DeepSeek** | DeepSeek-V3、R1 | 高 | ✅ 已生成报告 |
| **智谱AI** | GLM 系列 | 高 | ✅ 已生成报告 |
| **MiniMax** | 海螺AI、星野、Talkie | 高 | ✅ 已生成报告 |
| **腾讯** | 混元（HY）系列 | 高 | ✅ 已生成报告 |
| **百度** | 文心一言、文心一格 | 中 | ✅ 可检索 |
| **华为** | 盘古系列 | 中 | ✅ 可检索 |
| **讯飞** | 星火大模型 | 中 | ✅ 可检索 |
| **商汤** | 日日新、SenseChat | 中 | ✅ 可检索 |

---

## 二、AI产品/模型目标清单

### 2.1 大语言模型（LLM）

| 模型系列 | 公司 | 检索关键词 |
|----------|------|----------|
| **GPT 系列** | OpenAI | GPT-4, GPT-4o, GPT-5 |
| **Gemini 系列** | Google | Gemini 2.0, Flash, Pro |
| **Claude 系列** | Anthropic | Claude 3.5, Claude 4 |
| **LLaMA 系列** | Meta | LLaMA 3, LLaMA 4 |
| **Qwen 系列** | 阿里巴巴 | Qwen3, Qwen3.5, Qwen-MoE |
| **DeepSeek 系列** | DeepSeek | DeepSeek-V3, R1 |
| **GLM 系列** | 智谱AI | GLM-5, GLM-4 |
| **混元系列** | 腾讯 | HY 2.0, Hunyuan |
| **Mistral 系列** | Mistral | Mistral Large, Mixtral |

### 2.2 多模态模型

| 模型 | 公司 | 检索关键词 |
|------|------|----------|
| **GPT-4V/4o** | OpenAI | 视觉理解, 多模态 |
| **Gemini** | Google | 原生多模态 |
| **Seedance** | 字节跳动 | 视频生成 |
| **Sora** | OpenAI | 视频生成 |
| **DALL-E** | OpenAI | 图像生成 |
| **Midjourney** | Midjourney | 图像生成 |
| **Stable Diffusion** | Stability AI | 图像生成 |

### 2.3 推理模型

| 模型 | 公司 | 特点 |
|------|------|------|
| **OpenAI o1** | OpenAI | 深度推理 |
| **DeepSeek R1** | DeepSeek | 强化学习推理 |
| **Gemini Flash Thinking** | Google | 推理优化 |
| **HY 2.0 Think** | 腾讯 | 深度推理 |

### 2.4 视频生成模型

| 模型 | 公司 | 特点 |
|------|------|------|
| **Sora** | OpenAI | 文本生成视频 |
| **Seedance 2.0** | 字节跳动 | 四模态输入 |
| **Runway Gen-3** | Runway | 视频生成 |
| **Pika** | Pika Labs | 视频生成 |

---

## 三、技术主题目标清单

### 3.1 数据存储技术

| 技术主题 | 检索关键词 | arXiv 分类 |
|----------|----------|----------|
| **高带宽内存** | HBM, HBM4, HBM3e | cs.AR, cs.DC |
| **GPU 互联** | NVLink, NVSwitch, RDMA | cs.AR, cs.DC |
| **显存优化** | GPU Memory, VRAM, Memory Bandwidth | cs.DC, cs.LG |
| **存储架构** | GPU Direct Storage, 存算分离 | cs.DC, cs.AR |
| **KV Cache** | KV Cache, PagedAttention | cs.LG, cs.CL |

### 3.2 数据加速技术

| 技术主题 | 检索关键词 | arXiv 分类 |
|----------|----------|----------|
| **注意力优化** | FlashAttention, Sparse Attention | cs.LG, cs.CL |
| **模型量化** | Quantization, INT4, INT8, FP8, FP4 | cs.LG, cs.CL |
| **推理加速** | Inference Optimization, Speculative Decoding | cs.LG, cs.CL |
| **MoE 架构** | Mixture of Experts, Expert Parallelism | cs.LG, cs.CL |
| **训练优化** | Distributed Training, ZeRO, FSDP | cs.LG, cs.DC |
| **算子优化** | Kernel Fusion, CUDA Optimization | cs.LG, cs.DC |

### 3.3 架构创新

| 技术主题 | 检索关键词 | arXiv 分类 |
|----------|----------|----------|
| **Transformer 变体** | Transformer, Linear Attention | cs.CL, cs.LG |
| **扩散模型** | Diffusion, DiT, Latent Diffusion | cs.CV, cs.LG |
| **多模态架构** | Multimodal, Vision-Language | cs.CV, cs.CL |
| **长上下文** | Long Context, Context Window | cs.CL, cs.LG |

---

## 四、检索源与工具对应

### 4.1 学术论文检索

| 检索源 | 工具 | 检索命令 |
|--------|------|----------|
| **arXiv** | arxiv 技能 | `python3 arxiv_tool.py search "关键词"` |
| **Papers with Code** | Tavily Search | `node search.mjs "关键词 site:paperswithcode.com"` |
| **Hugging Face Papers** | Tavily Search | `node search.mjs "关键词 site:huggingface.co"` |

### 4.2 企业动态检索

| 检索源 | 工具 | 检索命令 |
|--------|------|----------|
| **企业博客** | Tavily Search | `node search.mjs "公司名 AI blog 2026"` |
| **官方公告** | Tavily Search | `node search.mjs "公司名 AI 发布"` |

### 4.3 新闻媒体检索

| 检索源 | 工具 | 检索命令 |
|--------|------|----------|
| **量子位** | Tavily Search | `node search.mjs "关键词 site:qbitai.com"` |
| **机器之心** | Tavily Search | `node search.mjs "关键词 site:jiqizhixin.com"` |
| **VentureBeat** | Tavily Search | `node search.mjs "关键词 site:venturebeat.com"` |

### 4.4 社区论坛检索

| 检索源 | 工具 | 检索命令 |
|--------|------|----------|
| **Reddit** | Tavily Search | `node search.mjs "关键词 site:reddit.com/r/MachineLearning"` |
| **GitHub** | gh CLI | `gh search repos "关键词"` |

---

## 五、已生成的洞察报告

| 公司 | 报告文件 | 生成日期 |
|------|----------|----------|
| **阿里巴巴/Qwen** | 阿里巴巴千问QwenAI洞察报告_20260313.docx | 2026-03-13 |
| **DeepSeek** | DeepSeekAI洞察报告_20260313.docx | 2026-03-13 |
| **GLM/智谱** | 智谱GLMAI洞察报告_20260313.docx | 2026-03-13 |
| **MiniMax** | MiniMaxAI洞察报告_20260313.docx | 2026-03-13 |
| **Google Gemini** | GoogleGeminiAI洞察报告_20260313.docx | 2026-03-13 |
| **腾讯** | 腾讯混元HYAI洞察报告_20260313.docx | 2026-03-13 |
| **字节跳动** | 字节跳动AI洞察报告_技术深度版_20260313.docx | 2026-03-13 |
| **英伟达** | 英伟达NAI洞察报告_技术深度版_20260313.docx | 2026-03-13 |

---

## 六、待检索目标

### 6.1 未生成报告的公司

| 公司 | 优先级 | 主要关注点 |
|------|--------|----------|
| **OpenAI** | 高 | GPT-5, Sora, 推理模型 |
| **Meta** | 高 | LLaMA 4, AI Studio |
| **Anthropic** | 高 | Claude 4, AI安全 |
| **Microsoft** | 中 | Azure AI, Copilot |
| **百度** | 中 | 文心系列 |
| **华为** | 中 | 盘古系列 |
| **Mistral** | 中 | Mistral Large |

### 6.2 待深入的技术主题

| 主题 | 关键词 |
|------|--------|
| **长上下文技术** | Long Context, 1M context |
| **AI Agent** | Autonomous Agent, Tool Use |
| **RAG 技术** | Retrieval Augmented Generation |
| **模型压缩** | Distillation, Pruning, Quantization |
| **分布式训练** | ZeRO, FSDP, Model Parallelism |

---

## 七、检索任务模板

### 7.1 公司AI洞察任务

```yaml
任务: {公司名} AI洞察
步骤:
  1. Tavily Search: "{公司名} AI 产品 模型 2026"
  2. arxiv: "{公司产品名} architecture"
  3. 企业博客: 官方博客检索
  4. 新闻媒体: 量子位/机器之心
输出: output/{公司名}AI洞察报告_{日期}.docx
```

### 7.2 技术主题洞察任务

```yaml
任务: {技术主题} 洞察
步骤:
  1. arxiv: "{关键词}" --sort relevance
  2. Tavily Search: "{关键词} 最新进展"
  3. Papers with Code: 论文+代码
  4. GitHub: 开源项目
输出: output/{技术主题}洞察报告_{日期}.docx
```

---

## 八、维护更新

### 8.1 定期更新

| 更新频率 | 更新内容 |
|----------|----------|
| **每周** | 公司产品动态、新模型发布 |
| **每月** | 目标清单、检索关键词 |
| **每季度** | 技术主题优先级 |

### 8.2 新增目标模板

```yaml
新公司:
  名称: ""
  产品: []
  关键词: []
  优先级: 高/中/低
```

---

*本清单定义系统可检索的所有AI信息目标*
