#!/bin/bash
set -e

echo "Setting up Node.js environment with PM2..."

# Node.jsリポジトリ追加とインストール
curl -sL https://rpm.nodesource.com/setup_22.x | sudo bash -
yum install -y gcc-c++ make
yum install -y nodejs

echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

# npmキャッシュクリーン
npm cache clean --force

# アプリケーションディレクトリの準備
mkdir -p /var/www/html
chown -R root:root /var/www/html
chmod -R 755 /var/www/html

# PM2のグローバルインストール
npm install -g pm2

# PM2の初期設定
pm2 install pm2-logrotate

echo "Node.js setup with PM2 completed successfully"