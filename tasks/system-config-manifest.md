# System Configuration Manifest

系统配置清单 - 记录所有已生效的系统级配置

**最后更新**: 2026-03-13 14:45:00 +08:00

---

## 1. 工作区规范

| 配置项 | 状态 | 说明 |
|--------|------|------|
| 工作区目录 | ✅ 生效 | 所有任务文件必须在 `~/workspace/` 内 |
| 目录结构 | ✅ 生效 | projects/, tasks/, output/, temp/, .learnings/ |
| 写入限制 | ✅ 生效 | 禁止写入系统根目录、/root、/home、系统目录 |

**配置文件**: `AGENTS.md` → Workspace Rules 章节

---

## 2. 任务执行架构

| 配置项 | 状态 | 说明 |
|--------|------|------|
| 主线程/子线程模式 | ✅ 生效 | 主线程响应，子线程执行 |
| 长任务阈值 | ✅ 生效 | >30s 任务必须使用子线程 |
| 子线程工具 | ✅ 生效 | `sessions_spawn` 或 `exec background` |

**配置文件**: `AGENTS.md` → Task Execution Architecture 章节

---

## 3. 任务监控

| 配置项 | 状态 | 说明 |
|--------|------|------|
| 多维度监控 | ✅ 生效 | 时间、资源、输出、进度、状态、结果 |
| 监控配置 | ✅ 生效 | `tasks/task-monitoring.md` |
| 异常检测 | ✅ 生效 | 非零退出码、超时、资源耗尽等 |

**监控维度**:
- **时间**: 执行时长 > 预估 2x 触发警告
- **资源**: CPU > 90% 或 内存 > 85% 触发警告
- **输出**: stderr 持续输出、exit code 非 0
- **进度**: >5min 无更新触发检查
- **状态**: zombie/failed/timeout 记录异常
- **结果**: 文件缺失、格式错误

---

## 4. 自我改进系统

| 配置项 | 状态 | 说明 |
|--------|------|------|
| self-improving-agent | ✅ 已安装 | v3.0.1 |
| Hook 启用 | ✅ 生效 | 🧠 self-improvement hook |
| 学习日志 | ✅ 生效 | .learnings/ 目录已创建 |
| 自动提醒 | ✅ 生效 | agent:bootstrap 时注入提醒 |

**日志文件**:
- `.learnings/LEARNINGS.md` - 学习、纠正、最佳实践
- `.learnings/ERRORS.md` - 错误记录
- `.learnings/FEATURE_REQUESTS.md` - 功能请求

**自动触发条件**:
1. 命令返回非零退出码
2. 子线程异常终止
3. 任务超时或资源耗尽
4. 输出结果不符合预期
5. 用户纠正反馈

---

## 5. 技能商店策略

| 配置项 | 状态 | 说明 |
|--------|------|------|
| 优先源 | ✅ 配置 | skillhub (国内优化) |
| 备用源 | ✅ 配置 | clawhub (公共注册表) |
| 安装前摘要 | ✅ 配置 | 源、版本、风险信号 |

**策略**:
1. 先尝试 `skillhub search/install`
2. 如不可用/限流/无匹配，fallback 到 `clawhub`
3. 安装前汇报源、版本、风险信号
4. 不声明排他性，支持公共和私有注册表

---

## 6. 目录结构

```
~/workspace/
├── AGENTS.md              # 系统架构规则 ✅
├── SOUL.md                # 行为准则
├── TOOLS.md               # 工具配置
├── MEMORY.md              # 长期记忆
├── HEARTBEAT.md           # 心跳任务
├── IDENTITY.md            # 身份定义
├── USER.md                # 用户信息
├── projects/              # 项目工作区 ✅
├── tasks/                 # 任务文件 ✅
│   ├── .gitkeep
│   └── task-monitoring.md # 监控配置 ✅
├── output/                # 输出文件 ✅
├── temp/                  # 临时文件 ✅
├── skills/                # 技能目录
│   └── self-improving-agent/ ✅
├── .learnings/            # 学习日志 ✅
│   ├── LEARNINGS.md
│   ├── ERRORS.md
│   └── FEATURE_REQUESTS.md
└── memory/                # 每日记忆
```

---

## 7. Hooks 状态

| Hook | 状态 | 说明 |
|------|------|------|
| 🚀 boot-md | ✓ ready | 启动时运行 BOOT.md |
| 📎 bootstrap-extra-files | ✓ ready | 注入额外启动文件 |
| 📝 command-logger | ✓ ready | 命令审计日志 |
| 💾 session-memory | ✓ ready | 会话记忆保存 |
| 🧠 self-improvement | ✓ ready | 自我改进提醒 ✅ |

---

## 验证命令

```bash
# 检查系统状态
openclaw status

# 检查 hooks
openclaw hooks list

# 检查目录结构
ls -la ~/workspace/

# 检查学习日志
cat ~/workspace/.learnings/LEARNINGS.md
```

---

*本清单由系统自动生成，记录所有已生效配置*