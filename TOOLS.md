# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

---

## Git Configuration

### ✅ 已验证的标准下载方式

**后续所有代码下载任务必须使用以下方式**：

#### 方式一：SSH 直接克隆（推荐）

```bash
# 标准格式
git clone git@github.com:{owner}/{repo}.git {target-dir} --depth 1

# 示例
git clone git@github.com:vllm-project/vllm.git projects/vllm --depth 1
```

**优点**：
- SSH 认证已配置（`~/.ssh/id_ed25519`）
- 网络稳定，无需 HTTPS 认证
- 已验证：6秒完成克隆

#### 方式二：稳定脚本（大型仓库）

```bash
# 标准格式
./scripts/git-clone-stable.sh https://github.com/{owner}/{repo}.git {target-dir} [--depth 1]

# 示例
./scripts/git-clone-stable.sh https://github.com/vllm-project/vllm.git projects/vllm --depth 1
```

**优点**：
- 自动重试 3 次
- SSH 优先，HTTPS 兜底
- 适合网络不稳定环境

#### URL 转换规则

| HTTPS URL | SSH URL |
|-----------|---------|
| `https://github.com/user/repo.git` | `git@github.com:user/repo.git` |

**转换命令**：
```bash
# HTTPS 转 SSH
sed 's|https://github.com/|git@github.com:|'
```

### 全局配置

```bash
# 查看配置
git config --global --list

# 优化网络稳定性
git config --global http.postBuffer 524288000    # 500MB buffer
git config --global http.lowSpeedLimit 0         # 禁用低速限制
git config --global http.lowSpeedTime 999999     # 超时时间
git config --global core.compression 0           # 禁用压缩加速传输
```

### 认证方式

**SSH（推荐）**：
- 密钥位置：`~/.ssh/id_ed25519`
- 公钥已添加到 GitHub
- SSH URL：`git@github.com:user/repo.git`

**HTTPS**：
- 需要认证时可能不稳定
- 可使用 GitHub CLI：`gh auth login`

### 远程仓库

- 主仓库：`git@github.com:hongyu-zhou3434/code_store.git`
- 默认分支：`main`

### 稳定下载脚本

```bash
# 使用增强脚本克隆（自动重试、SSH 优先）
./scripts/git-clone-stable.sh https://github.com/user/repo.git target-dir --depth 1
```

## Scripts

| 脚本 | 用途 |
|------|------|
| `scripts/git-clone-stable.sh` | 增强 Git 克隆，自动重试，SSH 优先 |

---

## Summarize CLI

### 配置信息

| 项目 | 值 |
|------|-----|
| CLI 版本 | 0.12.0 |
| API Base URL | `https://coding.dashscope.aliyuncs.com/v1` |
| 默认模型 | `openai/qwen3-max-2026-01-23` |
| 配置文件 | `~/.summarize/config.json` |

### 环境变量

```bash
# 已配置在 ~/.bashrc
export OPENAI_API_KEY="sk-sp-1dfcd6127bfc4033b85aa78f2ed6a995"
export OPENAI_BASE_URL="https://coding.dashscope.aliyuncs.com/v1"
```

### 使用方式

```bash
# 总结网页
summarize "https://example.com" --length short

# 总结本地文件
summarize "/path/to/file.pdf"
summarize "/path/to/document.docx"

# 总结文本（stdin）
echo "文本内容" | summarize - --length short

# 总结 YouTube 视频
summarize "https://youtu.be/xxx" --youtube auto

# 指定长度
summarize "https://example.com" --length medium  # short|medium|long|xl|xxl

# JSON 输出
summarize "https://example.com" --json
```

### 可用模型

使用阿里云百炼（DashScope）OpenAI 兼容接口：

| 模型 ID | 说明 |
|---------|------|
| `openai/qwen3-max-2026-01-23` | Qwen3 Max（默认） |
| `openai/qwen3.5-plus` | Qwen3.5 Plus |
| `openai/qwen3-coder-plus` | Qwen3 Coder Plus |
| `openai/glm-5` | GLM-5 |
| `openai/glm-4.7` | GLM-4.7 |

### 配置文件

```json
// ~/.summarize/config.json
{
  "model": "openai/qwen3-max-2026-01-23"
}
```

---

## Tavily Search

### 配置信息

| 项目 | 值 |
|------|-----|
| 技能版本 | tavily-search |
| API Key | `TAVILY_API_KEY`（已配置在 ~/.bashrc） |

### 使用方式

```bash
# 基本搜索
node ~/.openclaw/workspace/skills/tavily-search/scripts/search.mjs "搜索内容"

# 指定结果数量
node ~/.openclaw/workspace/skills/tavily-search/scripts/search.mjs "搜索内容" -n 5

# 深度搜索
node ~/.openclaw/workspace/skills/tavily-search/scripts/search.mjs "搜索内容" --deep

# 新闻搜索
node ~/.openclaw/workspace/skills/tavily-search/scripts/search.mjs "搜索内容" --topic news
```

### 特点

- AI 优化的搜索结果
- 返回简洁、相关的内容
- 支持新闻、深度搜索模式
- 提供来源链接和相关度评分

---

## WPS Office Skill

### 配置信息

| 项目 | 值 |
|------|-----|
| 技能版本 | 1.3.0 |
| 默认保存路径 | `output/wps/` |
| 配置文件 | `skills/wps-skill/config.json` |

### 主要功能

| 功能 | 命令 |
|------|------|
| Markdown → Word | `python3 scripts/main.py md_to_docx file=输入.md output=输出.docx` |
| Markdown → Excel | `python3 scripts/main.py md_to_xlsx file=输入.md output=输出.xlsx` |
| Markdown → PPT | `python3 scripts/main.py md_to_pptx file=输入.md output=输出.pptx` |
| Word → Markdown | `python3 scripts/main.py docx_to_md file=输入.docx output=输出.md` |
| 图片插入 Word | `python3 scripts/main.py insert_image docx=文档.docx image=图片.png` |
| 图文混排 | `python3 scripts/main.py create_text_image_layout ...` |

### 使用方式

```bash
cd /root/.openclaw/workspace/skills/wps-skill

# Markdown 转 Word
python3 scripts/main.py md_to_docx file=文档.md output=文档.docx title="标题"

# 批量转换
python3 scripts/main.py batch_convert dir=目录 format=pdf

# 创建文档
python3 scripts/main.py create type=writer filename=新文档.docx
```

### 注意事项

- 本地文档处理功能无需 WPS 365 凭证
- WPS 365 云端功能需要配置 `app_id` 和 `app_secret`
- 图形界面自动化（pyautogui）在无 GUI 环境下不可用
- 文档格式转换依赖 python-docx、openpyxl、python-pptx

---

## AI 技术洞察检索配置

### 检索源优先级

| 类型 | 首选源 | 备选源 |
|------|--------|--------|
| 学术论文 | arXiv | Papers with Code |
| 企业动态 | 官方博客 | 新闻媒体 |
| 中国资讯 | 量子位 | 机器之心 |
| 社区讨论 | Reddit | Hugging Face |

### 标准检索流程

```
1. 学术源（arXiv → Papers with Code）
2. 企业博客（官方 → 行业媒体）
3. 新闻媒体（量子位 → VentureBeat）
4. 社区论坛（Reddit → GitHub）
```

### 检索关键词库

**存储技术**：HBM, NVLink, GPU Memory, KV Cache, RDMA

**加速技术**：FlashAttention, Quantization, TensorRT, MoE, CUDA

**公司名**：OpenAI, Google, Meta, NVIDIA, DeepSeek, Qwen, GLM, MiniMax

### 检索清单文件

`tasks/ai-retrieval-manifest.md` - 完整检索配置与模板

---

## arXiv 检索技能

### 配置信息

| 项目 | 值 |
|------|-----|
| 技能版本 | 1.0.4 |
| Python 依赖 | arxiv>=2.0.0, pymongo>=4.0.0 |
| 路径 | `skills/arxiv/` |

### 使用方式

```bash
cd /root/.openclaw/workspace/skills/arxiv

# 搜索论文
python3 arxiv_tool.py search "FlashAttention" --max 5 --sort date

# 获取论文详情
python3 arxiv_tool.py get 2603.12267

# 下载 PDF
python3 arxiv_tool.py download 2603.12267

# 保存到阅读列表
python3 arxiv_tool.py save 2603.12267

# 列出已保存论文
python3 arxiv_tool.py list
```

### 搜索参数

| 参数 | 说明 |
|------|------|
| `--max N` | 返回结果数量 |
| `--sort relevance/date` | 排序方式 |
| `--json` | JSON 格式输出 |
| `-v` | 显示摘要 |

### 特点

- 无需 API Key（arXiv API 免费开放）
- 支持按相关性/日期排序
- 可下载 PDF
- 可保存阅读列表

---

## 每日定时任务

### AI洞察报告自动生成

| 项目 | 配置 |
|------|------|
| 执行时间 | 每日 19:00 |
| 脚本路径 | `scripts/daily-insight.sh` |
| 输出目录 | `output/daily-insights/{日期}/` |
| 输出格式 | MD + DOC + PDF |
| 归档周期 | 保留最近 30 天 |
| 信息源 | 全球AI动态权威资讯来源清单 |

**洞察目标**：
- 字节跳动、阿里巴巴、腾讯、智谱AI、DeepSeek
- Google、NVIDIA、MiniMax

**洞察范围**：

| 领域 | 细分方向 |
|------|----------|
| **硬件设备** | 训练与推理卡、超节点服务、网络、存储介质 |
| **模型** | 算法、架构、工程 |
| **Agent** | RAG、记忆系统 |
| **AI框架** | 编译、量化、稀疏化、调度、加速 |
| **数据** | 训练数据、数据处理、数据存储 |

**报告内容**：
1. 新产品与模型概览
2. 硬件设备（训练卡、推理卡、超节点、网络、存储）
3. 模型（算法、架构、工程）
4. Agent/智能体（RAG、记忆）
5. AI框架（编译、量化、稀疏化、调度）
6. 数据（训练数据、处理、存储）
7. 参考文献与论文
8. 关键信息链接
9. 技术趋势洞察

**查看今日报告**：
```bash
ls -la output/daily-insights/$(date +%Y-%m-%d)/
```

**手动执行**：
```bash
./scripts/daily-insight.sh
```

**查看 cron 日志**：
```bash
tail -f logs/cron-daily-insight.log
```

### 输出格式

| 格式 | 工具 | 说明 |
|------|------|------|
| **MD** | Tavily Search | 原始 Markdown 报告 |
| **DOC** | WPS Skill | Word 文档格式 |
| **PDF** | LibreOffice | PDF 格式 |

### 每日生成文件

```
output/daily-insights/{日期}/
├── {公司名}AI洞察报告_{日期}.md
├── {公司名}AI洞察报告_{日期}.docx
├── {公司名}AI洞察报告_{日期}.pdf
├── 每日AI洞察汇总_{日期}.md
├── 每日AI洞察汇总_{日期}.docx
└── 每日AI洞察汇总_{日期}.pdf
```
