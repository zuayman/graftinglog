# 嫁接日誌 (Grafting Log)

針對「甘露梨」等高價值作物的嫁接過程管理應用程式。

## 專案資訊

- **GitHub Repository**: https://github.com/zuayman/graftinglog
- **專案類型**: Flutter 跨平台應用程式
- **目標平台**: Windows, Android, iOS

## 功能特色

### ✅ 已完成 (MVP - Phase 1)

- **專案管理**
  - 建立年度專案（年度、品種、嫁接/套袋工資設定）
  - 專案切換與選擇

- **每日日誌記錄**
  - 記錄嫁接第 n 日與實際日期
  - 嫁接區域與天候狀況
  - 人力配置（嫁接人數、套袋人數）
  - 自動計算人工成本

- **快速填報系統**
  - 矩陣按鈕快速勾選施作項目（藥劑、營養劑、肥料、調節劑）
  - 「複製前一天」功能，一鍵帶入前日資料

- **離線優先**
  - 所有資料儲存在本地 SQLite 資料庫
  - 無需網路連線即可使用

## 技術架構

- **框架**: Flutter 3.35.3
- **狀態管理**: Riverpod 2.6.1
- **資料庫**: Drift (SQLite)
- **UI**: Material 3
- **平台支援**: Windows, Android, iOS

## 資料庫架構

### Projects (專案表)
- 年度、品種
- 嫁接工日薪、套袋工日薪

### DailyLogs (日誌表)
- 日期、天數
- 區域、天候
- 嫁接人數、套袋人數
- 計算後的人工成本

### Actions (動作表)
- 當日施作項目（類型 + 項目名稱）

### ScionBatches (花苞批次表)
- 為第二階段預留

## 如何使用

### 開發環境運行

```bash
# 安裝依賴
flutter pub get

# 生成資料庫程式碼
dart run build_runner build --delete-conflicting-outputs

# 運行 Windows 版本
flutter run -d windows

# 運行 Android/iOS（需要連接裝置或模擬器）
flutter run
```

### 建置發布版本

```bash
# Windows
flutter build windows --release

# Android
flutter build apk --release

# iOS
flutter build ios --release
```

建置完成的檔案位置：
- Windows: `build\windows\x64\runner\Release\graftinglog.exe`
- Android: `build\app\outputs\flutter-apk\app-release.apk`

## 使用流程

1. **建立專案**
   - 首次啟動時，點擊「建立專案」
   - 輸入年度（預設 2026）、品種（預設：甘露）
   - 設定嫁接工日薪與套袋工日薪

2. **記錄每日日誌**
   - 點擊右下角「+」按鈕
   - 填寫嫁接第 n 日與實際日期
   - 輸入區域與選擇天候
   - 設定嫁接與套袋人數（系統自動計算成本）
   - 勾選當日施作項目
   - 點擊「儲存」

3. **複製前一天資料**
   - 建立新日誌時，點擊右上角「複製」圖示
   - 系統自動帶入前一天的人數、區域、天候與施作項目

4. **查看與編輯**
   - 主畫面顯示所有日誌列表
   - 點擊任一日誌卡片即可編輯

## 下一階段功能 (Phase 2 & 3)

- [ ] 花苞批次追蹤與天數差計算
- [ ] 狀態追蹤（黑頭、休眠、萌芽、展葉）
- [ ] 相簿對比功能（依區域 + 第 n 日分類）
- [ ] Windows 端報表匯出（Excel/XLSX）
- [ ] 產銷履歷格式化輸出
- [ ] 圖表化統計成功率

## 專案結構

```
lib/
├── data/
│   └── database/
│       ├── database.dart          # 資料庫定義
│       └── database.g.dart        # 自動生成
├── providers/
│   └── database_provider.dart     # Riverpod providers
├── screens/
│   ├── home_screen.dart           # 主畫面
│   ├── project_list_screen.dart   # 專案列表
│   ├── daily_log_list_screen.dart # 日誌列表
│   └── daily_log_form_screen.dart # 日誌表單
└── main.dart                      # 應用入口
```

## Git 版本控制

此專案已設定 GitHub 遠端倉庫。為方便開發，提供以下批次檔工具：

### Windows 批次檔工具

在專案根目錄執行以下批次檔：

#### 1. `git-sync.bat` - 一鍵同步到 GitHub
```bash
git-sync.bat
```
功能：
- 檢查本地修改
- 詢問是否提交
- 輸入提交訊息
- 自動 add、commit、push

#### 2. `git-pull-push.bat` - 雙向同步
```bash
git-pull-push.bat
```
功能：
- 先從 GitHub 拉取最新版本
- 檢查本地修改
- 詢問是否要推送本地變更
- 執行完整的雙向同步

#### 3. `git-quick-sync.bat` - 快速同步
```bash
git-quick-sync.bat
```
功能：
- 快速執行 pull → add → commit → push
- 自動生成時間戳記的提交訊息
- 適合頻繁小改動時使用

#### 4. `git-pull-only.bat` - 僅拉取更新
```bash
git-pull-only.bat
```
功能：
- 只從 GitHub 拉取最新變更
- 不進行任何提交或推送

### 手動 Git 指令

如果不使用批次檔，也可以手動執行：

```bash
# 查看狀態
git status

# 拉取遠端更新
git pull

# 新增所有修改
git add .

# 提交變更
git commit -m "你的提交訊息"

# 推送到 GitHub
git push

# 雙向同步（拉取+推送）
git pull && git add . && git commit -m "更新" && git push
```

## 授權

此專案為私人使用。

## 聯絡資訊

如有問題或建議，請聯繫開發者。
