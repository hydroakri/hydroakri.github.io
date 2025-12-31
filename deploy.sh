#!/bin/bash

# 手动构建和部署脚本
# 用于在本地构建并推送到gh-pages分支

set -e

echo "🛠️  Building site with Zola..."
zola build

echo "📦 Deploying to gh-pages branch..."
git worktree add /tmp/gh-pages gh-pages || git worktree add /tmp/gh-pages origin/gh-pages

# 清理旧文件
cd /tmp/gh-pages
git rm -rf .
cp -r ../public/* .

# 添加新文件
git add .
git commit -m "Deploy site - $(date)" || echo "No changes to deploy"

# 推送
git push origin gh-pages

# 清理
cd -
git worktree remove /tmp/gh-pages

echo "✅ Deployment complete!"
