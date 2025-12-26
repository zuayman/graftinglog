import 'package:flutter/foundation.dart';
import '../data/database/database.dart';
import 'notification_service.dart';

/// 天候警示服務
class WeatherAlertService {
  final AppDatabase _db;
  final NotificationService _notificationService;

  WeatherAlertService(this._db, this._notificationService);

  /// 檢查天候警示（在儲存日誌後調用）
  Future<void> checkWeatherAlerts(int projectId) async {
    final settings = await _db.getReminderSettings(projectId);
    if (settings == null) return;

    // 檢查連續雨天警示
    if (settings.rainyDaysAlertEnabled) {
      await _checkConsecutiveRainyDays(
        projectId,
        settings.consecutiveRainyDaysThreshold,
      );
    }

    // 檢查低溫警示
    if (settings.lowTempAlertEnabled) {
      await _checkLowTemperature(projectId);
    }
  }

  /// 檢查連續雨天
  Future<void> _checkConsecutiveRainyDays(
    int projectId,
    int threshold,
  ) async {
    // 獲取最近的日誌記錄
    final recentLogs = await _db.getRecentDailyLogs(projectId, limit: threshold);

    if (recentLogs.length < threshold) return;

    // 檢查是否連續雨天
    int consecutiveRainyDays = 0;
    for (var log in recentLogs) {
      if (log.weather == '雨') {
        consecutiveRainyDays++;
      } else {
        break; // 遇到非雨天就中斷
      }
    }

    // 如果達到閾值，發送警示
    if (consecutiveRainyDays >= threshold) {
      await _notificationService.showNotification(
        id: NotificationIds.weatherAlert,
        title: '天候警示：連續雨天',
        body: '已連續 $consecutiveRainyDays 天雨天，請注意嫁接作業可能受影響',
      );
      debugPrint('天候警示：連續 $consecutiveRainyDays 天雨天');
    }
  }

  /// 檢查低溫
  Future<void> _checkLowTemperature(int projectId) async {
    // 獲取最新的日誌記錄
    final recentLogs = await _db.getRecentDailyLogs(projectId, limit: 1);

    if (recentLogs.isEmpty) return;

    final latestLog = recentLogs.first;

    // 如果天候標記為低溫，發送警示
    if (latestLog.weather == '低溫') {
      await _notificationService.showNotification(
        id: NotificationIds.weatherAlert,
        title: '天候警示：低溫',
        body: '今日記錄為低溫天候，請注意保護接穗避免凍傷',
      );
      debugPrint('天候警示：低溫');
    }
  }
}
