@echo off
chcp 65001 >nul
echo 設定 Git 一鍵同步別名...
echo.

REM 設定 Git 別名
git config --global alias.sync "!git add . && git commit -m 'sync' && git push"
git config --global alias.save "!f() { git add . && git commit -m \"$1\" && git push; }; f"

echo ✓ 已設定完成！
echo.
echo 現在你可以使用以下指令：
echo.
echo   git sync          - 快速同步（使用預設訊息）
echo   git save "訊息"   - 同步並使用自訂訊息
echo.
pause
