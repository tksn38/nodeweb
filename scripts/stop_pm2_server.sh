#!/bin/bash
set -e

echo "Stopping PM2 managed applications..."

# PM2で管理されているプロセスを停止（root権限も考慮）
if command -v pm2 &> /dev/null; then
    echo "Stopping all PM2 processes..."
    pm2 stop all || true
    pm2 delete all || true
    pm2 kill || true
    
    # root権限のPM2プロセスも停止
    sudo pm2 stop all || true
    sudo pm2 delete all || true
    sudo pm2 kill || true
fi

# 残存するNode.jsプロセスを強制終了
echo "Killing remaining Node.js processes..."
pkill -f "node.*app.js" || true
pkill -f "node.*server.js" || true
pkill -f "node.*index.js" || true

# ポート3000を使用しているプロセスを確認・終了
if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "Killing process using port 3000..."
    kill -9 $(lsof -Pi :3000 -sTCP:LISTEN -t) || true
fi

# ポート80を使用しているプロセスを確認・終了
if lsof -Pi :80 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "Killing process using port 80..."
    kill -9 $(lsof -Pi :80 -sTCP:LISTEN -t) || true
fi

# 少し待機
sleep 2

echo "Application stop completed"