# Git 使用指南

## 日常工作流程

### 每次修改程式碼後

```bash
# 1. 查看修改
git status              # 查看哪些檔案被修改
git diff                # 查看具體修改內容

# 2. 新增修改
git add .               # 新增所有修改
# 或
git add 檔案名稱        # 新增特定檔案

# 3. 提交修改
git commit -m "提交說明"

# 4. 推送到 GitHub
git push
```

## 常用命令速查

### 查看狀態
```bash
git status              # 查看目前狀態
git log --oneline       # 查看提交歷史
git diff                # 查看未暫存的修改
git diff --staged       # 查看已暫存的修改
```

### 新增檔案
```bash
git add .               # 新增所有修改
git add *.dart          # 新增所有 .dart 檔案
git add lib/            # 新增整個目錄
git add file1 file2     # 新增多個檔案
```

### 提交程式碼
```bash
git commit -m "說明"           # 簡單提交
git commit --amend -m "新說明"  # 修改最後一次提交
```

### 推送程式碼
```bash
git push                # 推送到遠端
git push -f             # 強制推送（謹慎使用）
```

### 撤銷操作
```bash
git restore 檔案名稱    # 撤銷檔案的修改
git restore .           # 撤銷所有修改
git reset HEAD~1        # 撤銷最後一次提交（保留修改）
```

### 分支操作
```bash
git branch              # 查看所有分支
git branch 分支名稱     # 建立新分支
git checkout 分支名稱   # 切換分支
git checkout -b 分支名稱  # 建立並切換到新分支
git merge 分支名稱      # 合併分支
```

### 遠端操作
```bash
git pull                # 拉取遠端更新
git clone URL           # 複製儲存庫
git remote -v           # 查看遠端儲存庫
```

## 實用場景

### 場景 1: 開發新功能
```bash
# 建立功能分支
git checkout -b feature/新功能名稱

# 開發並提交
git add .
git commit -m "實現新功能"

# 推送分支
git push -u origin feature/新功能名稱

# 合併回主分支
git checkout master
git merge feature/新功能名稱
git push
```

### 場景 2: 修復 Bug
```bash
# 建立修復分支
git checkout -b fix/bug描述

# 修復並提交
git add .
git commit -m "修復：bug描述"
git push -u origin fix/bug描述
```

### 場景 3: 同步遠端程式碼
```bash
# 拉取最新程式碼
git pull

# 如果有衝突，解決後
git add .
git commit -m "解決衝突"
git push
```

### 場景 4: 查看歷史
```bash
# 查看提交歷史
git log --oneline --graph --all

# 查看某個檔案的歷史
git log -- lib/main.dart

# 查看某次提交的詳細內容
git show commit雜湊值
```

## 提交說明規範

### 推薦格式
```
<類型>: <簡短描述>

<詳細描述>（可選）
```

### 常用類型
- `feat`: 新功能
- `fix`: 修復 Bug
- `docs`: 文件更新
- `style`: 程式碼格式調整
- `refactor`: 重構程式碼
- `perf`: 效能優化
- `test`: 測試相關
- `chore`: 建置/工具設定

### 範例
```bash
git commit -m "feat: 新增年度對比分析功能"
git commit -m "fix: 修復統計圖表日期顯示錯誤"
git commit -m "docs: 更新 README 安裝說明"
git commit -m "perf: 優化資料庫查詢效率"
```

## 注意事項

1. **提交前先查看**: 使用 `git status` 和 `git diff` 確認修改
2. **小步提交**: 每完成一個小功能就提交，不要累積太多修改
3. **寫清楚說明**: 讓未來的自己和他人能理解你做了什麼
4. **推送前拉取**: `git pull` 確保沒有衝突
5. **不要提交**:
   - 編譯產物 (build/)
   - 相依套件 (.dart_tool/)
   - 個人設定 (.vscode/)
   - 敏感資訊 (金鑰、密碼)

## 手機上使用 GitHub.dev

1. 訪問儲存庫 URL，按 `.` 鍵開啟編輯器
2. 或將 `github.com` 改為 `github.dev`
3. 左側欄點擊原始碼管理圖示
4. 輸入提交說明並點擊提交
5. 點擊同步按鈕推送到遠端

## 出問題了怎麼辦？

### 提交錯了檔案
```bash
git reset HEAD~1        # 撤銷提交，保留修改
# 重新新增正確的檔案
git add 正確的檔案
git commit -m "新說明"
```

### 想恢復到之前的版本
```bash
git log --oneline       # 找到目標版本的雜湊值
git checkout 雜湊值     # 查看舊版本
git checkout master     # 回到最新版本
```

### 程式碼衝突了
```bash
git pull                # 拉取時出現衝突
# 開啟衝突檔案，手動解決衝突
git add .
git commit -m "解決衝突"
git push
```

## 更多資源

- Git 官方文件: https://git-scm.com/doc
- GitHub 文件: https://docs.github.com/
- Git 視覺化學習: https://learngitbranching.js.org/
