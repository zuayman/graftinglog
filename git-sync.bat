@echo off
chcp 65001 >nul
echo ====================================
echo   Git 一鍵同步到 GitHub
echo ====================================
echo.

REM 查看目前狀態
echo [1/4] 檢查修改...
git status
echo.

REM 詢問是否繼續
set /p confirm="是否要提交並推送所有修改？(Y/N): "
if /i not "%confirm%"=="Y" (
    echo 已取消
    pause
    exit /b
)

REM 新增所有修改
echo.
echo [2/4] 新增所有修改...
git add .

REM 詢問提交說明
echo.
set /p message="請輸入提交說明: "
if "%message%"=="" set message=更新程式碼

REM 提交
echo.
echo [3/4] 提交變更...
git commit -m "%message%"

REM 推送
echo.
echo [4/4] 推送到 GitHub...
git push

echo.
echo ====================================
echo   同步完成！
echo ====================================
echo.
pause
