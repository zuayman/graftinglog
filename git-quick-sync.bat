@echo off
chcp 65001 >nul
echo 正在雙向同步 GitHub...
echo.

REM 先拉取遠端變更
echo [1/3] 拉取遠端變更...
git pull
echo.

REM 顯示本地修改
echo [2/3] 檢查本地修改...
git status --short
echo.

REM 自動提交並推送
echo [3/3] 推送本地變更...
git add .
git commit -m "快速同步: %date% %time%"
git push

echo.
echo ✓ 雙向同步完成！
timeout /t 3
