# Learnings

Corrections, insights, and knowledge gaps captured during development.

**Categories**: correction | insight | knowledge_gap | best_practice
**Areas**: frontend | backend | infra | tests | docs | config
**Statuses**: pending | in_progress | resolved | wont_fix | promoted | promoted_to_skill

## Status Definitions

| Status | Meaning |
|--------|---------|
| `pending` | Not yet addressed |
| `in_progress` | Actively being worked on |
| `resolved` | Issue fixed or knowledge integrated |
| `wont_fix` | Decided not to address (reason in Resolution) |
| `promoted` | Elevated to CLAUDE.md, AGENTS.md, or copilot-instructions.md |
| `promoted_to_skill` | Extracted as a reusable skill |

## Skill Extraction Fields

When a learning is promoted to a skill, add these fields:

```markdown
**Status**: promoted_to_skill
**Skill-Path**: skills/skill-name
```

Example:
```markdown
## [LRN-20250115-001] best_practice

**Logged**: 2025-01-15T10:00:00Z
**Priority**: high
**Status**: promoted_to_skill
**Skill-Path**: skills/docker-m1-fixes
**Area**: infra

### Summary
Docker build fails on Apple Silicon due to platform mismatch
...
```

---

## [LRN-20260313-001] best_practice

**Logged**: 2026-03-13T14:10:00+08:00
**Priority**: high
**Status**: resolved
**Area**: config

### Summary
所有任务文件必须在 workspace 目录下按类别创建，禁止直接在系统根目录写文件

### Details
用户明确要求系统行为规范：
- 输出文件必须在 `~/workspace/` 目录内
- 按类别组织：projects/, tasks/, output/, temp/
- 禁止写入根目录、/root、/home、系统目录

### Metadata
- Source: user_feedback
- Tags: workspace, file-organization, security

---

## [LRN-20260313-002] best_practice

**Logged**: 2026-03-13T14:15:00+08:00
**Priority**: high
**Status**: resolved
**Area**: config

### Summary
任务执行架构：主线程响应、子线程执行、多维度监控、异常自改进

### Details
用户明确系统架构要求：

1. **主线程/子线程模式**
   - 主线程：快速响应用户请求
   - 子线程：执行耗时任务（>30s 必须用子线程）

2. **多维度任务监控**
   - 时间维度：执行时长是否异常
   - 资源维度：CPU/内存使用
   - 输出维度：stdout/stderr 错误
   - 进度维度：里程碑完成情况
   - 状态维度：进程状态
   - 结果维度：输出文件完整性

3. **异常自改进流程**
   - 检测异常 → 记录到 .learnings/
   - 调用 self-improving-agent 分析
   - 必要时重新规划任务执行

### Metadata
- Source: user_feedback
- Tags: architecture, task-execution, monitoring, self-improvement

---

## [LRN-20260313-003] best_practice

**Logged**: 2026-03-13T15:25:00+08:00
**Priority**: medium
**Status**: promoted
**Area**: infra

### Summary
Git clone 大型仓库时网络不稳定，需要优化配置和重试机制

### Details
**问题**：
- 克隆 vllm 等大型仓库时，HTTPS 方式经常超时
- 错误：`RPC failed; curl 28 Failed to connect to github.com port 443 after 134438 ms`

**解决方案**：
1. **优先使用 SSH**：SSH 方式比 HTTPS 更稳定（已验证 6s 完成）
   - 已生成 `~/.ssh/id_ed25519` 并添加到 GitHub
   - URL 转换：`https://github.com/user/repo.git` → `git@github.com:user/repo.git`

2. **优化 Git 配置**：
   ```bash
   git config --global http.postBuffer 524288000
   git config --global http.lowSpeedLimit 0
   git config --global http.lowSpeedTime 999999
   git config --global core.compression 0
   ```

3. **使用浅克隆**：`--depth 1` 减少传输量

4. **重试脚本**：`scripts/git-clone-stable.sh` 自动重试 3 次

**已验证的标准下载方式**：
```bash
git clone git@github.com:{owner}/{repo}.git {target-dir} --depth 1
```

**Promoted**: TOOLS.md, tasks/system-config-manifest.md

### Metadata
- Source: troubleshooting
- Tags: git, network, stability, github
- Related Files: scripts/git-clone-stable.sh, TOOLS.md

---

## [LRN-20260313-004] best_practice

**Logged**: 2026-03-13T15:45:00+08:00
**Priority**: medium
**Status**: resolved
**Area**: config

### Summary
Find-Skills 技能已启用，自动应用于所有任务的技能发现

### Details
**配置内容**：
1. **自动触发条件**：
   - 用户问"如何做 X"、"怎么实现 X"
   - 用户问"有没有 X 技能"
   - 用户表达扩展能力需求

2. **搜索优先级**：
   - `skillhub search`（国内优化，优先）
   - `npx skills find`（skills.sh，备用）

3. **安装前摘要**：必须汇报来源、版本、功能、风险信号

**已验证**：
- skills CLI v1.4.4 正常工作
- skillhub 和 skills find 搜索功能正常

### Metadata
- Source: user_feedback
- Tags: skills, discovery, automation
- Related Files: AGENTS.md, tasks/system-config-manifest.md

---

## [LRN-20260313-005] best_practice

**Logged**: 2026-03-13T15:50:00+08:00
**Priority**: high
**Status**: resolved
**Area**: config

### Summary
Find-Skills 与 self-improving-agent 协同处理任务异常

### Details
**协作流程**：

1. **任务异常发生**
   - self-improving-agent 记录到 `.learnings/ERRORS.md`

2. **分析异常类型**
   - **能力缺失** → Find-Skills 搜索解决方案 → 安装新技能 → 重试
   - **知识错误** → 记录到 `.learnings/LEARNINGS.md` → 更新文档
   - **流程问题** → 优化执行策略 → 重新规划

3. **协作触发条件**：
   | 异常类型 | self-improving-agent | Find-Skills |
   |----------|---------------------|-------------|
   | 命令失败 | ✅ 记录错误 | 搜索工具技能 |
   | 能力缺失 | ✅ 记录请求 | ✅ 搜索方案 |
   | API失败 | ✅ 记录错误 | 搜索替代方案 |
   | 用户纠正 | ✅ 记录纠正 | 搜索最佳实践 |

### Metadata
- Source: user_feedback
- Tags: collaboration, exception-handling, self-improvement
- Related Files: AGENTS.md

---

## [LRN-20260313-006] best_practice

**Logged**: 2026-03-13T16:00:00+08:00
**Priority**: high
**Status**: resolved
**Area**: config

### Summary
Summarize、Find-Skills、self-improving-agent 三技能协作处理任务异常

### Details
**协作机制**：

1. **self-improving-agent**：记录异常、学习纠正
2. **Find-Skills**：搜索解决方案、安装新技能
3. **Summarize**：文档总结、内容提炼

**触发场景**：
- 能力缺失 → Find-Skills 搜索
- 文档理解困难 → Summarize 总结
- 知识错误 → self-improving-agent 记录
- 流程问题 → 优化策略重试

**Summarize 默认使用**：
- 网页总结、文档总结、YouTube 总结
- 长文本摘要、内容要点提取

### Metadata
- Source: user_feedback
- Tags: collaboration, skills, summarize
- Related Files: AGENTS.md, TOOLS.md

---

## [LRN-20260313-007] best_practice

**Logged**: 2026-03-13T16:20:00+08:00
**Priority**: high
**Status**: resolved
**Area**: config

### Summary
WPS Office Skill 默认用于本地文档处理任务

### Details
**配置规则**：

1. **使用限制**：
   - ✅ 仅处理本地文档操作
   - ❌ 不使用 WPS 365 云端功能

2. **默认触发场景**：
   - 文档创建（Word/Excel/PPT）
   - Markdown 转换（MD → Word/Excel/PPT）
   - 格式转换（文档格式互转）
   - 图文排版（图片插入、图文混排）
   - 批量处理（批量文档操作）

3. **主要功能**：
   - Markdown ↔ Word/Excel/PPT 转换
   - 文档创建与格式转换
   - 图文混排
   - 批量处理

### Metadata
- Source: user_feedback
- Tags: wps, document, local-processing
- Related Files: AGENTS.md, TOOLS.md

---

## [LRN-20260313-008] best_practice

**Logged**: 2026-03-13T18:45:00+08:00
**Priority**: high
**Status**: resolved
**Area**: automation

### Summary
配置每日定时任务，自动生成AI洞察报告

### Details
**定时任务配置**：
- 执行时间：每日 19:00
- Cron 表达式：`0 19 * * *`
- 脚本：`scripts/daily-insight.sh`

**洞察目标**：
- 字节跳动、阿里巴巴、腾讯、智谱AI、DeepSeek
- Google、NVIDIA、MiniMax

**洞察范围**：
- 模型、算力卡、数据存储、数据加速、Agent/智能体

**自动化流程**：
1. Cron 触发脚本执行
2. 使用 Tavily Search 检索最新动态
3. 生成各公司洞察报告
4. 生成汇总报告
5. 清理 30 天前的旧报告

### Metadata
- Source: user_feedback
- Tags: automation, cron, daily-task, insight
- Related Files: scripts/daily-insight.sh, HEARTBEAT.md

---