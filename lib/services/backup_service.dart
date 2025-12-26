import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';

/// 資料庫備份服務
class BackupService {
  /// 取得資料庫檔案路徑
  Future<String> getDatabasePath() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    return p.join(dbFolder.path, 'db.sqlite');
  }

  /// 取得備份目錄路徑
  Future<String> getBackupDirectory() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final backupDir = p.join(dbFolder.path, 'backups');

    // 確保備份目錄存在
    final dir = Directory(backupDir);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    return backupDir;
  }

  /// 建立資料庫備份
  Future<String> createBackup() async {
    try {
      final dbPath = await getDatabasePath();
      final dbFile = File(dbPath);

      if (!await dbFile.exists()) {
        throw Exception('資料庫檔案不存在');
      }

      // 產生備份檔案名稱（包含時間戳記）
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final backupDir = await getBackupDirectory();
      final backupPath = p.join(backupDir, 'backup_$timestamp.db');

      // 複製資料庫檔案
      await dbFile.copy(backupPath);

      debugPrint('資料庫備份成功: $backupPath');
      return backupPath;
    } catch (e) {
      debugPrint('資料庫備份失敗: $e');
      rethrow;
    }
  }

  /// 從備份還原資料庫
  Future<void> restoreBackup(String backupPath) async {
    try {
      final backupFile = File(backupPath);

      if (!await backupFile.exists()) {
        throw Exception('備份檔案不存在');
      }

      final dbPath = await getDatabasePath();

      // 備份當前資料庫（以防還原失敗）
      final currentDbFile = File(dbPath);
      if (await currentDbFile.exists()) {
        final tempBackup = '$dbPath.temp';
        await currentDbFile.copy(tempBackup);

        try {
          // 還原備份檔案
          await backupFile.copy(dbPath);

          // 刪除臨時備份
          await File(tempBackup).delete();

          debugPrint('資料庫還原成功: $backupPath');
        } catch (e) {
          // 還原失敗，恢復原資料庫
          await File(tempBackup).copy(dbPath);
          await File(tempBackup).delete();
          rethrow;
        }
      } else {
        // 沒有現有資料庫，直接複製
        await backupFile.copy(dbPath);
        debugPrint('資料庫還原成功: $backupPath');
      }
    } catch (e) {
      debugPrint('資料庫還原失敗: $e');
      rethrow;
    }
  }

  /// 取得所有備份檔案列表
  Future<List<FileInfo>> getBackupList() async {
    try {
      final backupDir = await getBackupDirectory();
      final dir = Directory(backupDir);

      if (!await dir.exists()) {
        return [];
      }

      final files = await dir
          .list()
          .where((entity) => entity is File && entity.path.endsWith('.db'))
          .cast<File>()
          .toList();

      final backupList = <FileInfo>[];
      for (final file in files) {
        final stat = await file.stat();
        backupList.add(FileInfo(
          path: file.path,
          name: p.basename(file.path),
          size: stat.size,
          modifiedTime: stat.modified,
        ));
      }

      // 按修改時間排序（最新的在前）
      backupList.sort((a, b) => b.modifiedTime.compareTo(a.modifiedTime));

      return backupList;
    } catch (e) {
      debugPrint('取得備份列表失敗: $e');
      return [];
    }
  }

  /// 刪除備份檔案
  Future<void> deleteBackup(String backupPath) async {
    try {
      final file = File(backupPath);
      if (await file.exists()) {
        await file.delete();
        debugPrint('備份檔案已刪除: $backupPath');
      }
    } catch (e) {
      debugPrint('刪除備份檔案失敗: $e');
      rethrow;
    }
  }

  /// 清理舊備份（保留最近 N 個）
  Future<void> cleanupOldBackups({int keepCount = 5}) async {
    try {
      final backupList = await getBackupList();

      if (backupList.length > keepCount) {
        final toDelete = backupList.skip(keepCount);
        for (final backup in toDelete) {
          await deleteBackup(backup.path);
        }
        debugPrint('已清理 ${toDelete.length} 個舊備份');
      }
    } catch (e) {
      debugPrint('清理舊備份失敗: $e');
    }
  }

  /// 自動備份（如果需要）
  Future<void> autoBackupIfNeeded() async {
    try {
      final dbPath = await getDatabasePath();
      final dbFile = File(dbPath);

      if (!await dbFile.exists()) {
        debugPrint('資料庫不存在，跳過自動備份');
        return;
      }

      final backupList = await getBackupList();

      // 如果沒有任何備份，建立第一個
      if (backupList.isEmpty) {
        debugPrint('建立首次自動備份');
        await createBackup();
        return;
      }

      // 檢查最後一次備份時間
      final lastBackup = backupList.first;
      final daysSinceLastBackup = DateTime.now().difference(lastBackup.modifiedTime).inDays;

      // 如果距離上次備份超過 3 天，自動備份
      if (daysSinceLastBackup >= 3) {
        debugPrint('距離上次備份已 $daysSinceLastBackup 天，執行自動備份');
        await createBackup();
        await cleanupOldBackups(keepCount: 5);
      } else {
        debugPrint('上次備份於 $daysSinceLastBackup 天前，暫不需要備份');
      }
    } catch (e) {
      debugPrint('自動備份失敗: $e');
      // 自動備份失敗不應該影響應用程式運行
    }
  }

  /// 格式化檔案大小
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

/// 備份檔案資訊
class FileInfo {
  final String path;
  final String name;
  final int size;
  final DateTime modifiedTime;

  FileInfo({
    required this.path,
    required this.name,
    required this.size,
    required this.modifiedTime,
  });
}
