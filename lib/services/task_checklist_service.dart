import 'package:flutter/foundation.dart';
import '../data/database/database.dart';
import 'notification_service.dart';

/// 作業檢查清單服務
class TaskChecklistService {
  final AppDatabase _db;
  final NotificationService _notificationService;

  TaskChecklistService(this._db, this._notificationService);

  /// 檢查今日是否有未記錄的日誌
  Future<void> checkTodayLog(int projectId) async {
    try {
      final today = DateTime.now();
      final todayLog = await _db.getLogForDay(projectId, today);

      // 如果今天還沒有記錄日誌，發送提醒
      if (todayLog == null) {
        await _notificationService.showNotification(
          id: NotificationIds.taskChecklist,
          title: '作業提醒',
          body: '今天還沒有記錄嫁接日誌，記得填寫喔！',
        );
        debugPrint('作業提醒：今日尚未記錄日誌');
      }
    } catch (e) {
      debugPrint('檢查今日日誌失敗: $e');
    }
  }

  /// 檢查逾期未記錄的日誌
  Future<List<DateTime>> checkOverdueLogs(int projectId) async {
    try {
      final settings = await _db.getReminderSettings(projectId);
      if (settings == null ||
          settings.expectedStartDate == null ||
          settings.expectedEndDate == null) {
        return [];
      }

      final startDate = settings.expectedStartDate!;
      final endDate = settings.expectedEndDate!;
      final now = DateTime.now();

      // 如果尚未開始或已結束，不檢查
      if (now.isBefore(startDate) || now.isAfter(endDate)) {
        return [];
      }

      // 獲取所有日誌
      final logs = await _db.getLogsForProject(projectId);
      final logDates = logs.map((log) => _normalizeDate(log.date)).toSet();

      // 檢查從開始日到今天之間缺少的日誌
      final missingDates = <DateTime>[];
      var checkDate = startDate;

      while (checkDate.isBefore(now) || _isSameDay(checkDate, now)) {
        final normalizedCheckDate = _normalizeDate(checkDate);
        if (!logDates.contains(normalizedCheckDate)) {
          missingDates.add(normalizedCheckDate);
        }
        checkDate = checkDate.add(const Duration(days: 1));
      }

      // 如果有逾期未記錄的日誌，發送提醒
      if (missingDates.isNotEmpty) {
        await _notificationService.showNotification(
          id: NotificationIds.taskChecklist,
          title: '逾期提醒',
          body: '有 ${missingDates.length} 天的日誌尚未記錄，請盡快補填',
        );
        debugPrint('逾期提醒：有 ${missingDates.length} 天的日誌未記錄');
      }

      return missingDates;
    } catch (e) {
      debugPrint('檢查逾期日誌失敗: $e');
      return [];
    }
  }

  /// 標準化日期（只保留年月日）
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// 檢查兩個日期是否是同一天
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
