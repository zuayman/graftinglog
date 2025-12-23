@echo off
chcp 65001 >nul
echo 從 GitHub 拉取最新變更...
echo.
git pull
echo.
echo ✓ 同步完成！
pause
