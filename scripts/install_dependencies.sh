#!/bin/bash
set -e

echo "Installing npm dependencies..."
cd /var/www/html/

# package.jsonの存在確認
if [ -f "package.json" ]; then
    # npmキャッシュクリーン（エラー対策）
    npm cache clean --force
    
    # 依存関係インストール
    npm install --production
    
    echo "Dependencies installed successfully"
else
    echo "No package.json found, skipping npm install"
fi