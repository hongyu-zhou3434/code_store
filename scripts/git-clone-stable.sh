#!/bin/bash
# Git Clone Wrapper - 增强网络稳定性
# 用法: git-clone-stable.sh <repo_url> [target_dir] [--depth 1]

set -e

REPO_URL="$1"
TARGET_DIR="$2"
DEPTH="$3"

MAX_RETRIES=3
RETRY_DELAY=10

# 解析 URL，自动选择最佳方式
if [[ "$REPO_URL" == https://github.com/* ]]; then
    # GitHub HTTPS 转 SSH（更稳定）
    REPO_PATH="${REPO_URL#https://github.com/}"
    SSH_URL="git@github.com:${REPO_PATH}"
    echo "检测到 GitHub 仓库，优先尝试 SSH 方式..."
    
    # 尝试 SSH
    for i in $(seq 1 $MAX_RETRIES); do
        echo "[尝试 $i/$MAX_RETRIES] SSH 克隆..."
        if git clone "$SSH_URL" $TARGET_DIR $DEPTH; then
            echo "✓ SSH 克隆成功"
            exit 0
        fi
        echo "SSH 克隆失败，等待 ${RETRY_DELAY}s 后重试..."
        sleep $RETRY_DELAY
    done
    
    # SSH 失败，尝试 HTTPS
    echo "SSH 方式失败，尝试 HTTPS..."
fi

# HTTPS 克隆（带重试）
for i in $(seq 1 $MAX_RETRIES); do
    echo "[尝试 $i/$MAX_RETRIES] HTTPS 克隆..."
    if git clone "$REPO_URL" $TARGET_DIR $DEPTH --config http.postBuffer=524288000; then
        echo "✓ HTTPS 克隆成功"
        exit 0
    fi
    echo "HTTPS 克隆失败，等待 ${RETRY_DELAY}s 后重试..."
    sleep $RETRY_DELAY
done

echo "✗ 克隆失败，已达最大重试次数"
exit 1