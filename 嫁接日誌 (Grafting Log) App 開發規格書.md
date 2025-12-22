# 嫁接日誌 (Grafting Log) App 開發規格書

## 1. 產品概述
* **目標：** 針對「甘露梨」等高價值作物，記錄嫁接過程、人力成本、農務行為與成功率分析。
* **平台：** Flutter 跨平台 (支援 Android, iOS, Windows Desktop)。
* **核心特性：** 離線優先 (Offline-First)、單手操作優化、數據統計分析。

---

## 2. 資料庫架構 (Database Schema)
建議使用 `Drift (SQLite)` 進行開發，以下為核心資料表定義：

### A. Projects (年度專案)
| 欄位名 | 型別 | 說明 |
| :--- | :--- | :--- |
| id | Integer (PK) | 專案唯一識別碼 |
| year | Integer | 年度 (預設 2026) |
| variety | String | 品種 (預設：甘露) |
| wage_graft | Double | 嫁接工日薪 |
| wage_bag | Double | 套袋工日薪 |

### B. DailyLogs (每日日誌)
| 欄位名 | 型別 | 說明 |
| :--- | :--- | :--- |
| id | Integer (PK) | 日誌唯一識別碼 |
| project_id | Integer (FK) | 關聯專案 |
| date | DateTime | 實際日期 |
| day_number | Integer | 嫁接第 n 日 |
| area | String | 嫁接區域 (如：A區、北坡) |
| weather | String | 天候狀況 (標籤：晴、陰、雨、低溫) |
| scion_batch_id | Integer (FK) | 關聯花苞出庫批次 |

### C. Actions & Manpower (行為與人力)
* **Manpower:** 記錄 `grafting_count` (嫁接人數) 與 `bagging_count` (套袋人數)。
* **Actions:** 儲存當日動作清單 (List)，包含 `type` (藥劑/營養劑/肥料/調節劑) 與 `item_name`。

---

## 3. 功能需求 (Functional Requirements)

### 第一階段：嫁接與管理 (16-30天)
1.  **人力成本自動計算：** * 計算公式：`(嫁接人數 * 嫁接薪資) + (套袋人數 * 套袋薪資)`。
2.  **花苞追蹤：** * 紀錄「花苞出庫日期」，並計算至嫁接日的天數差。
3.  **快速填報系統：**
    * 提供矩陣按鈕，快速勾選當天施作項目 (營養劑/生長調節劑等)。
    * 支持「同前一天人員數」一鍵帶入。

### 第二階段：觀察與維護 (天數不定)
1.  **狀態追蹤：** 記錄接穗狀態 (黑頭、休眠、萌芽、展葉)。
2.  **相簿對比：** 依據「區域 + 第 n 日」自動分類照片，方便觀察癒合組織生長。

---

## 4. UI/UX 設計規範
* **Mobile 端：** * 採用大按鈕設計，確保農友在田間單手可操作。
    * 進度條顯示：視覺化呈現 16-30 天的第一階段進度。
* **Windows 桌面端：**
    * 提供資料總表 (Data Grid)，支援 Excel (XLSX) 匯出。
    * 支援產銷履歷格式格式化輸出。

---

## 5. 開發優先級 (Roadmap)
1.  **MVP 階段：** 建立本地資料庫、每日人力與 Action 紀錄功能。
2.  **進階階段：** 照片管理、花苞批次關聯邏輯。
3.  **優化階段：** Windows 端報表匯出、圖表化統計成功率。

---

## 6. 技術備註 (For Claude/Developer)
* 請確保所有數據優先儲存在本地 `sqlite`，以防果園訊號不佳。
* 跨平台狀態管理建議使用 `Riverpod`。
* UI 框架請使用 `Material 3`。