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