@echo off
chcp 65001 >nul
echo ====================================
echo   Git 雙向同步（拉取 + 推送）
echo ====================================
echo.

REM 先拉取遠端的變更
echo [1/5] 從 GitHub 拉取最新變更...
git pull
if errorlevel 1 (
    echo.
    echo ❌ 拉取失敗！可能有衝突需要解決
    echo.
    pause
    exit /b 1
)

echo.
echo ✓ 拉取完成

REM 檢查本地是否有修改
echo.
echo [2/5] 檢查本地修改...
git status
echo.

REM 詢問是否有本地修改要推送
set /p has_changes="本地有修改要推送嗎？(Y/N): "
if /i not "%has_changes%"=="Y" (
    echo.
    echo 同步完成！
    pause
    exit /b 0
)

REM 新增所有修改
echo.
echo [3/5] 新增所有修改...
git add .

REM 詢問提交說明
echo.
set /p message="請輸入提交說明: "
if "%message%"=="" set message=更新程式碼

REM 提交
echo.
echo [4/5] 提交變更...
git commit -m "%message%"

REM 推送
echo.
echo [5/5] 推送到 GitHub...
git push

echo.
echo ====================================
echo   雙向同步完成！
echo ====================================
echo.
pause
