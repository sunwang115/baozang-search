@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ==========================================
echo  GitHub 图片提交脚本
echo ==========================================
echo.

REM 检查是否是 git 仓库
if not exist .git (
    echo [错误] 当前目录不是 git 仓库！
    echo 请先执行: git init
    pause
    exit /b 1
)

echo [1/4] 添加 README.md 和图片文件...
git add README.md docs/images/

echo.
echo [2/4] 提交更改...
git commit -m "docs: 优化 README，提取 Base64 图片到 docs/images 目录"

echo.
echo [3/4] 推送到远程仓库...
git push origin main

if %errorlevel% neq 0 (
    echo.
    echo [提示] 推送到 main 分支失败，尝试 master 分支...
    git push origin master
)

echo.
echo ==========================================
echo  完成！图片已推送到 GitHub
echo ==========================================
pause
