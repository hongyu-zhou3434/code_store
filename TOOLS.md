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
