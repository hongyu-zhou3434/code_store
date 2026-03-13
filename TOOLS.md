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
