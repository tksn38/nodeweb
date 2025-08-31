#!/bin/bash
set -e

echo "Starting Express.js application with PM2..."

cd /var/www/html/

# アプリケーションファイルの確認
if [ -f "app.js" ]; then
    APP_FILE="app.js"
elif [ -f "server.js" ]; then
    APP_FILE="server.js"
elif [ -f "index.js" ]; then
    APP_FILE="index.js"
else
    echo "Error: No main application file found (app.js, server.js, or index.js)"
    exit 1
fi

echo "Starting $APP_FILE with PM2..."

# 環境変数設定
export NODE_ENV=production
export PORT=3000

# PM2でアプリケーション起動
pm2 start $APP_FILE --name "express-app" --instances 1 --env production

# PM2設定保存（自動起動用）
pm2 save
pm2 startup

echo "Application started successfully with PM2"
echo "PM2 status:"
pm2 status