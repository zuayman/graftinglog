# 梨果記 (Pearlog) - 設計風格指南

## 1. 色彩系統 (Color System)

### 主色調 (Primary Colors)
- **主要綠色**: `#4CAF50` - Material Green 500
- **次要綠色**: `#8BC34A` - Light Green 500
- **用途**: 主題色、按鈕、強調元素

### 功能色彩 (Functional Colors)
- **統計分析**: `#4CAF50` (綠色)
- **收入金額**: `#FF9800` (橙色)
- **價格管理**: `#FF9800` (橙色)
- **箱重管理**: `#FF9800` (橙色)
- **日曆功能**: `#2196F3` (藍色)
- **資料匯出**: `#9C27B0` (紫色)
- **備份管理**: `#607D8B` (藍灰色)
- **年度回顧**: `#673AB7` (深紫色)

### 狀態色彩 (State Colors)
- **成功/淨重**: `Colors.green` / `Colors.green[600]`
- **錯誤/刪除**: `Colors.red`
- **資訊/提示**: `Colors.blue[50]` 背景 + `Colors.blue[700]` 圖示
- **灰色系統**: `Colors.grey[50]`, `Colors.grey[300]`, `Colors.grey[700]`

### 漸層效果 (Gradients)
```dart
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    primaryColor,
    primaryColor.withValues(alpha: 0.7),
  ],
)
```

## 2. 文字系統 (Typography)

### 字體家族 (Font Families)
- **主要字體**: `NaikaiFont` (Regular)
  - 檔案: `assets/fonts/NaikaiFont-Regular.ttf`
- **備用字體**: `EduKai`
  - 檔案: `assets/fonts/edukai.ttf`

### 文字層級 (Text Hierarchy)

#### 標題層級
- **大標題**: 24px, FontWeight.bold (首頁歡迎標題)
- **頁面標題**: 20px, FontWeight.bold (卡片標題)
- **區塊標題**: 18px, FontWeight.bold (等級卡片、統計卡片)
- **次級標題**: 16px, FontWeight.bold/normal (按鈕文字、快速操作)

#### 內文層級
- **標準內文**: 14px, normal (記錄明細、統計數據)
- **小字**: 12px, normal/w600 (標籤、提示文字、時間)

#### 數字顯示
- **特大數字**: 28px, FontWeight.bold, Colors.white (統計卡片數值)
- **單位文字**: 14px, Colors.white70 (配合數字的單位)

#### 灰色文字
- **次要資訊**: `color: Colors.grey`
- **輔助說明**: `color: Colors.grey[700]`
- **淺色文字**: `color: Colors.white70` (用於深色背景)

## 3. 元件樣式 (Component Styles)

### 卡片 (Cards)

#### 標準卡片
```dart
CardTheme(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
)
```

#### 強調卡片
```dart
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
)
```

#### 等級輸入卡片
```dart
Card(
  elevation: 2,
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
)
```

### 按鈕 (Buttons)

#### ElevatedButton (主要按鈕)
```dart
ElevatedButton.styleFrom(
  elevation: 2,
  padding: EdgeInsets.symmetric(vertical: 16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
)
```

#### OutlinedButton (次要按鈕)
```dart
OutlinedButton.styleFrom(
  padding: EdgeInsets.symmetric(vertical: 16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  side: BorderSide(color: [功能色彩]),
  foregroundColor: [功能色彩],
)
```

#### IconButton
- 大圖示: 32px (新增按鈕)
- 中圖示: 28px (展開/收合)
- 小圖示: 24px (一般操作)
- 超小圖示: 18px (內嵌文字按鈕)

### 圓形頭像 (CircleAvatar)
```dart
CircleAvatar(
  backgroundColor: Theme.of(context).primaryColor,
  child: Text(
    gradeName,
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  ),
)
```

### 分隔線 (Dividers)
- **標準分隔**: `Divider(height: 1)`
- **白色半透明**: `Divider(color: Colors.white30, height: 32)`
- **卡片內分隔**: `Divider()` (預設樣式)

## 4. 間距系統 (Spacing System)

### 垂直間距
- **極小**: 2px
- **小**: 4px
- **標準**: 8px
- **中**: 12px
- **大**: 16px
- **特大**: 24px
- **超大**: 32px

### 水平間距
- 與垂直間距保持一致

### 內邊距 (Padding)
- **頁面邊距**: 16px (all)
- **卡片內距**: 16px (all) 或 24px (強調卡片)
- **按鈕內距**: vertical: 16px
- **容器內距**: 根據內容調整 (8-32px)

### 外邊距 (Margin)
- **卡片間距**: horizontal: 16px, vertical: 8px
- **區塊間距**: 16-24px

## 5. 圓角系統 (Border Radius)

- **標準卡片**: 12px
- **強調卡片**: 16px
- **按鈕**: 12px (主要) / 8px (次要)
- **小元件**: 4px (記錄項目)

## 6. 陰影系統 (Elevation)

- **標準卡片**: elevation: 2
- **強調卡片**: elevation: 4
- **按鈕**: elevation: 2

## 7. 圖示系統 (Icons)

### Material Icons 使用
- **今日記錄**: `Icons.edit_note`
- **統計分析**: `Icons.bar_chart`
- **收入金額**: `Icons.attach_money`
- **價格管理**: `Icons.price_change`
- **箱重管理**: `Icons.scale`
- **日曆功能**: `Icons.calendar_month` / `Icons.calendar_today`
- **資料匯出**: `Icons.file_download`
- **備份管理**: `Icons.backup`
- **年度回顧**: `Icons.history_edu`
- **新增**: `Icons.add_circle`
- **展開**: `Icons.expand_more` / `Icons.expand_less`
- **資訊**: `Icons.info_outline`
- **重新整理**: `Icons.refresh`
- **提示**: `Icons.lightbulb_outline`
- **刪除**: `Icons.delete`
- **拖曳**: `Icons.drag_indicator`

### Emoji 使用
- **品牌圖示**: 🍐 (甘露梨)

## 8. 動畫與互動 (Animations & Interactions)

### 過渡動畫
```dart
AnimatedCrossFade(
  duration: Duration(milliseconds: 300),
  crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
)
```

### 滑動刪除
```dart
Dismissible(
  direction: DismissDirection.endToStart,
  background: Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 16),
    color: Colors.red,
    child: Icon(Icons.delete, color: Colors.white),
  ),
)
```

### 下拉重新整理
```dart
RefreshIndicator(
  onRefresh: () async { ... },
  child: SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
  ),
)
```

## 9. 特殊元件樣式

### 統計卡片 (帶漸層背景)
- 使用主色漸層
- 白色文字系統
- 分隔線使用 `Colors.white30`
- 數字大、單位小的層級設計

### 日期選擇器背景
```dart
Container(
  padding: EdgeInsets.all(16),
  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
)
```

### 記錄項目容器
```dart
Container(
  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  margin: EdgeInsets.only(bottom: 4),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4),
    border: Border.all(color: Colors.grey[300]!),
  ),
)
```

### 提示卡片
```dart
Card(
  color: Colors.blue[50],
  child: Row with Icon + Text,
)
```

## 10. 語系設定 (Localization)

- **預設語系**: 繁體中文 (`zh_TW`)
- **日期格式**: `yyyy年MM月dd日 EEEE` (含星期)
- **時間格式**: `HH:mm` (24小時制)

## 11. Material 3 設定

```dart
ThemeData(
  useMaterial3: true,
  fontFamily: 'NaikaiFont',
  primaryColor: Color(0xFF4CAF50),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF4CAF50),
    secondary: Color(0xFF8BC34A),
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
)
```

## 12. 設計原則

1. **一致性**: 所有頁面使用相同的色彩、字體、間距系統
2. **清晰的層級**: 透過字體大小、粗細、顏色區分資訊重要性
3. **視覺回饋**: 按鈕按下、滑動刪除等操作都有明確的視覺回饋
4. **易讀性**: 使用台灣本地化字體 (NaikaiFont)，確保中文顯示品質
5. **色彩語義**: 綠色代表成功/主要、橙色代表金錢、藍色代表資訊、紅色代表警告
6. **圓潤設計**: 大量使用圓角 (8-16px)，營造友善、現代的視覺感受

## 13. UI 元件範例

### 標準頁面佈局
```dart
Scaffold(
  appBar: AppBar(
    title: const Text('頁面標題'),
    actions: [
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () { },
      ),
    ],
  ),
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 內容區域
      ],
    ),
  ),
)
```

### 對話框樣式
```dart
AlertDialog(
  title: const Text('對話框標題'),
  content: const Text('對話框內容'),
  actions: [
    TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('取消'),
    ),
    ElevatedButton(
      onPressed: () { },
      child: const Text('確定'),
    ),
  ],
)
```

### SnackBar 提示
```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('操作成功'),
    duration: Duration(seconds: 2),
  ),
)
```

---

## 附錄：設計資源

### 相關檔案位置
- 主題配置: [lib/main.dart](lib/main.dart#L60-L82)
- 首頁範例: [lib/features/home/home_page.dart](lib/features/home/home_page.dart)
- 等級卡片範例: [lib/features/daily_record/widgets/grade_input_card.dart](lib/features/daily_record/widgets/grade_input_card.dart)
- 字體資源: `assets/fonts/`

### 版本資訊
- Flutter SDK: ^3.9.2
- Material Design: Material 3
- 語言: Dart
- 狀態管理: Riverpod

---

© 2024 梨果記 (Pearlog) - 台灣甘露梨採收記錄管理系統
