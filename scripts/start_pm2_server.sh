#!/bin/bash
set -e

echo "Starting Express.js application with PM2..."

cd /var/www/html/

# アプリケーションファイルの確認（app.jsを最初に確認）
if [ -f "app.js" ]; then
    APP_FILE="app.js"
elif [ -f "index.js" ]; then
    APP_FILE="index.js"
elif [ -f "server.js" ]; then
    APP_FILE="server.js"
else
    echo "Error: No main application file found (app.js, index.js, or server.js)"
    exit 1
fi

echo "Starting $APP_FILE with PM2..."

# 環境変数設定
export NODE_ENV=production
export PORT=80  # app.jsではポート80を使用

# PM2でアプリケーション起動（root権限でポート80使用）
sudo pm2 start $APP_FILE --name "express-app" --instances 1

# PM2設定保存（root権限）
sudo pm2 save
sudo pm2 startup

echo "Application started successfully with PM2"
echo "PM2 status:"
pm2 status