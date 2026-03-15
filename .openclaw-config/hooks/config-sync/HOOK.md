---
name: config-sync
description: "自动同步 OpenClaw 配置到 GitHub code_store 仓库"
metadata: { "openclaw": { "emoji": "🔄", "events": ["command:new", "command:reset"] } }
---

# Config Sync Hook

自动将 OpenClaw 配置同步到 GitHub 仓库。

## 触发条件

- 执行 `/new` 命令时
- 执行 `/reset` 命令时

## 同步内容

- openclaw.json 主配置
- cron 任务配置
- 技能列表
- 环境配置
- 同步日志