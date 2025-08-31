#!/bin/bash
set -e

echo "Validating PM2 service..."

# PM2プロセス状態確認
pm2 status

# アプリケーションが起動しているか確認
if pm2 list | grep -q "express-app.*online"; then
    echo "✅ Express app is running"
else
    echo "❌ Express app is not running"
    exit 1
fi

# HTTPレスポンス確認
echo "Testing HTTP response..."
sleep 5  # アプリケーション起動待ち

if curl -f -s http://localhost:3000/ > /dev/null; then
    echo "✅ HTTP service is responding"
else
    echo "❌ HTTP service is not responding"
    # 詳細ログ出力
    echo "PM2 logs:"
    pm2 logs express-app --lines 10
    exit 1
fi

echo "✅ Service validation completed successfully"