import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Projects Table - 年度專案
class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get year => integer().withDefault(const Constant(2026))();
  TextColumn get variety => text().withDefault(const Constant('甘露'))();
  RealColumn get wageGraft => real()();
  RealColumn get wageBag => real()();

  // Budget - 預算管理
  RealColumn get budgetLimit => real().nullable()(); // 預算上限
  BoolColumn get budgetAlertEnabled => boolean().withDefault(const Constant(false))(); // 預算警示開關
  RealColumn get budgetAlertThreshold => real().withDefault(const Constant(0.8))(); // 預算警示閾值（80%）
}

// DailyLogs Table - 每日日誌
class DailyLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().references(Projects, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get dayNumber => integer()();
  TextColumn get area => text()();
  TextColumn get weather => text()();
  IntColumn get scionBatchId => integer().nullable()();

  // Manpower - 人力數據
  IntColumn get graftingCount => integer().withDefault(const Constant(0))();
  IntColumn get baggingCount => integer().withDefault(const Constant(0))();

  // Cost - 成本數據
  RealColumn get laborCost => real().withDefault(const Constant(0.0))();
  RealColumn get materialCost => real().withDefault(const Constant(0.0))();
  RealColumn get totalCost => real().withDefault(const Constant(0.0))();

  // Material cost notes (optional)
  TextColumn get materialNotes => text().nullable()();

  // General notes (optional) - 日誌備註（天氣變化、特殊狀況等）
  TextColumn get notes => text().nullable()();

  // Importance level (0-5 stars) - 重要程度（0-5顆星）
  IntColumn get importanceLevel => integer().withDefault(const Constant(0))();
}

// Actions Table - 當日動作清單
class Actions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dailyLogId => integer().references(DailyLogs, #id)();
  TextColumn get type => text()(); // 藥劑/營養劑/肥料/調節劑
  TextColumn get itemName => text()();
}

// SccionBatches Table - 花苞批次
class ScionBatches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().references(Projects, #id)();
  DateTimeColumn get deliveryDate => dateTime()();
  TextColumn get batchName => text()();
  IntColumn get quantity => integer().nullable()();

  // 來源資訊
  TextColumn get sourceType => text().withDefault(const Constant('其他'))(); // 農會/自採/其他農友/花苞商/其他
  TextColumn get supplierName => text().nullable()(); // 供應商名稱（農友名稱、花苞商名稱等）
  TextColumn get supplierContact => text().nullable()(); // 聯絡方式

  // 自採專用欄位
  DateTimeColumn get harvestDate => dateTime().nullable()(); // 採收日期
  DateTimeColumn get coldStorageStartDate => dateTime().nullable()(); // 冷藏開始日期
  IntColumn get coldStorageDays => integer().nullable()(); // 冷藏天數

  // 品質與成本
  RealColumn get unitPrice => real().nullable()(); // 單價
  RealColumn get totalPrice => real().nullable()(); // 總價
  TextColumn get qualityRating => text().nullable()(); // 品質評級：優/良/普通

  // 備註
  TextColumn get notes => text().nullable()(); // 備註
}

// GraftStatus Table - 接穗狀態記錄（Phase 3）
class GraftStatus extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dailyLogId => integer().references(DailyLogs, #id)();
  DateTimeColumn get recordDate => dateTime()(); // 記錄日期
  TextColumn get status => text()(); // 狀態：黑頭/休眠/萌芽/展葉
  IntColumn get count => integer().withDefault(const Constant(0))(); // 該狀態的數量
  TextColumn get notes => text().nullable()(); // 備註（失敗原因等）
}

// ReminderSettings Table - 提醒設定
class ReminderSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().references(Projects, #id)();

  // Daily work reminder - 每日作業提醒
  BoolColumn get dailyReminderEnabled => boolean().withDefault(const Constant(false))();
  IntColumn get dailyReminderHour => integer().withDefault(const Constant(9))(); // 預設早上9點
  IntColumn get dailyReminderMinute => integer().withDefault(const Constant(0))();

  // Grafting period reminders - 嫁接期間提醒
  BoolColumn get startDateReminderEnabled => boolean().withDefault(const Constant(false))();
  BoolColumn get endDateReminderEnabled => boolean().withDefault(const Constant(false))();
  DateTimeColumn get expectedStartDate => dateTime().nullable()(); // 預計開始日期
  DateTimeColumn get expectedEndDate => dateTime().nullable()(); // 預計結束日期（第30日）

  // Weather alerts - 天候警示
  BoolColumn get rainyDaysAlertEnabled => boolean().withDefault(const Constant(false))();
  IntColumn get consecutiveRainyDaysThreshold => integer().withDefault(const Constant(3))(); // 連續雨天閾值（預設3天）
  BoolColumn get lowTempAlertEnabled => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Projects, DailyLogs, Actions, ScionBatches, GraftStatus, ReminderSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Original migration code for older versions
      if (from < 2) {
        // Migration from version 1 to 2: Add material cost columns
        // Note: For existing databases, you may need to recreate or handle carefully
        // For new installs, this won't be an issue
      }
      if (from < 3) {
        // Migration from version 2 to 3: Add GraftStatus table
        await m.createTable(graftStatus);
      }
      if (from < 4) {
        // Migration from version 3 to 4: Add notes column to DailyLogs
        await customStatement(
          'ALTER TABLE daily_logs ADD COLUMN notes TEXT',
        );
      }
      if (from < 5) {
        // Migration from version 4 to 5: Add importanceLevel column to DailyLogs
        await customStatement(
          'ALTER TABLE daily_logs ADD COLUMN importance_level INTEGER NOT NULL DEFAULT 0',
        );
      }
      if (from < 6) {
        // Migration from version 5 to 6: Add source tracking columns to ScionBatches
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN source_type TEXT NOT NULL DEFAULT "其他"',
        );
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN supplier_name TEXT',
        );
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN supplier_contact TEXT',
        );
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN harvest_date INTEGER',
        );
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN cold_storage_start_date INTEGER',
        );
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN cold_storage_days INTEGER',
        );
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN unit_price REAL',
        );
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN total_price REAL',
        );
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN quality_rating TEXT',
        );
        await customStatement(
          'ALTER TABLE scion_batches ADD COLUMN notes TEXT',
        );
      }
      if (from < 7) {
        // Migration from version 6 to 7: Add ReminderSettings table
        await m.createTable(reminderSettings);
      }
      if (from < 8) {
        // Migration from version 7 to 8: Add weather alert columns to ReminderSettings
        // Drop and recreate ReminderSettings table to ensure all columns exist
        try {
          await customStatement('DROP TABLE IF EXISTS reminder_settings_old');
          await customStatement('ALTER TABLE reminder_settings RENAME TO reminder_settings_old');
          await m.createTable(reminderSettings);
          // Copy old data if exists
          await customStatement('''
            INSERT INTO reminder_settings (id, project_id, daily_reminder_enabled, daily_reminder_hour, daily_reminder_minute,
                                           start_date_reminder_enabled, end_date_reminder_enabled, expected_start_date, expected_end_date,
                                           rainy_days_alert_enabled, consecutive_rainy_days_threshold, low_temp_alert_enabled)
            SELECT id, project_id, daily_reminder_enabled, daily_reminder_hour, daily_reminder_minute,
                   COALESCE(start_date_reminder_enabled, 0), COALESCE(end_date_reminder_enabled, 0),
                   expected_start_date, expected_end_date,
                   0, 3, 0
            FROM reminder_settings_old
          ''');
          await customStatement('DROP TABLE reminder_settings_old');
        } catch (e) {
          // If migration fails, just create the table fresh
          try {
            await customStatement('DROP TABLE IF EXISTS reminder_settings');
            await m.createTable(reminderSettings);
          } catch (createError) {
            // Ignore if table creation also fails
          }
        }
      }
      if (from < 9) {
        // Migration from version 8 to 9: Add budget columns to Projects
        try {
          await customStatement(
            'ALTER TABLE projects ADD COLUMN budget_limit REAL',
          );
        } catch (e) {
          // Column might already exist, ignore error
        }
        try {
          await customStatement(
            'ALTER TABLE projects ADD COLUMN budget_alert_enabled INTEGER NOT NULL DEFAULT 0',
          );
        } catch (e) {
          // Column might already exist, ignore error
        }
        try {
          await customStatement(
            'ALTER TABLE projects ADD COLUMN budget_alert_threshold REAL NOT NULL DEFAULT 0.8',
          );
        } catch (e) {
          // Column might already exist, ignore error
        }
      }
    },
  );

  // Project Queries
  Future<List<Project>> getAllProjects() => select(projects).get();
  Future<Project> getProject(int id) =>
      (select(projects)..where((p) => p.id.equals(id))).getSingle();
  Future<int> createProject(ProjectsCompanion project) =>
      into(projects).insert(project);
  Future updateProject(Project project) =>
      update(projects).replace(project);

  // Daily Log Queries
  Future<List<DailyLog>> getLogsForProject(int projectId) =>
      (select(dailyLogs)..where((l) => l.projectId.equals(projectId))).get();

  Future<DailyLog?> getLogForDay(int projectId, DateTime date) async {
    final query = select(dailyLogs)
      ..where((l) => l.projectId.equals(projectId))
      ..where((l) => l.date.equals(date));
    final result = await query.getSingleOrNull();
    return result;
  }

  Future<DailyLog?> getPreviousLog(int projectId, DateTime currentDate) async {
    final query = select(dailyLogs)
      ..where((l) => l.projectId.equals(projectId))
      ..where((l) => l.date.isSmallerThanValue(currentDate))
      ..orderBy([(l) => OrderingTerm.desc(l.date)])
      ..limit(1);
    return await query.getSingleOrNull();
  }

  Future<List<DailyLog>> getRecentDailyLogs(int projectId, {int limit = 10}) async {
    final query = select(dailyLogs)
      ..where((l) => l.projectId.equals(projectId))
      ..orderBy([(l) => OrderingTerm.desc(l.date)])
      ..limit(limit);
    return await query.get();
  }

  Future<int> createDailyLog(DailyLogsCompanion log) =>
      into(dailyLogs).insert(log);

  Future updateDailyLog(DailyLog log) =>
      update(dailyLogs).replace(log);

  Future deleteDailyLog(int id) =>
      (delete(dailyLogs)..where((l) => l.id.equals(id))).go();

  // Action Queries
  Future<List<Action>> getActionsForLog(int logId) =>
      (select(actions)..where((a) => a.dailyLogId.equals(logId))).get();

  Future<int> createAction(ActionsCompanion action) =>
      into(actions).insert(action);

  Future deleteActionsForLog(int logId) =>
      (delete(actions)..where((a) => a.dailyLogId.equals(logId))).go();

  // Batch insert actions
  Future<void> createActions(List<ActionsCompanion> actionList) async {
    await batch((batch) {
      batch.insertAll(actions, actionList);
    });
  }

  // Scion Batch Queries
  Future<List<ScionBatche>> getBatchesForProject(int projectId) =>
      (select(scionBatches)..where((b) => b.projectId.equals(projectId))).get();

  Future<int> createScionBatch(ScionBatchesCompanion batch) =>
      into(scionBatches).insert(batch);

  Future updateScionBatch(ScionBatche batch) =>
      update(scionBatches).replace(batch);

  Future deleteScionBatch(int id) =>
      (delete(scionBatches)..where((b) => b.id.equals(id))).go();

  // Graft Status Queries
  Future<List<GraftStatusData>> getStatusForLog(int dailyLogId) =>
      (select(graftStatus)..where((s) => s.dailyLogId.equals(dailyLogId))).get();

  Future<int> createGraftStatus(GraftStatusCompanion status) =>
      into(graftStatus).insert(status);

  Future updateGraftStatus(GraftStatusData status) =>
      update(graftStatus).replace(status);

  Future deleteGraftStatus(int id) =>
      (delete(graftStatus)..where((s) => s.id.equals(id))).go();

  Future deleteStatusForLog(int dailyLogId) =>
      (delete(graftStatus)..where((s) => s.dailyLogId.equals(dailyLogId))).go();

  // Success Rate Statistics
  Future<Map<String, dynamic>> getSuccessRateStatistics(int projectId) async {
    final logs = await getLogsForProject(projectId);

    if (logs.isEmpty) {
      return {
        'totalGrafted': 0,
        'blackHead': 0,
        'dormant': 0,
        'sprouting': 0,
        'leafing': 0,
        'successRate': 0.0,
      };
    }

    double totalGrafted = 0;
    double blackHead = 0;
    double dormant = 0;
    double sprouting = 0;
    double leafing = 0;

    for (var log in logs) {
      totalGrafted += log.graftingCount.toDouble();

      final statuses = await getStatusForLog(log.id);
      for (var status in statuses) {
        switch (status.status) {
          case '黑頭':
            blackHead += status.count.toDouble();
            break;
          case '休眠':
            dormant += status.count.toDouble();
            break;
          case '萌芽':
            sprouting += status.count.toDouble();
            break;
          case '展葉':
            leafing += status.count.toDouble();
            break;
        }
      }
    }

    final successCount = sprouting + leafing;
    final successRate = totalGrafted > 0 ? (successCount / totalGrafted * 100) : 0.0;

    return {
      'totalGrafted': totalGrafted,
      'blackHead': blackHead,
      'dormant': dormant,
      'sprouting': sprouting,
      'leafing': leafing,
      'successRate': successRate,
    };
  }

  // Cost Statistics Queries
  Future<Map<String, double>> getCostStatistics(int projectId) async {
    final logs = await getLogsForProject(projectId);

    if (logs.isEmpty) {
      return {
        'totalLaborCost': 0.0,
        'totalMaterialCost': 0.0,
        'totalCost': 0.0,
        'averageDailyCost': 0.0,
        'averageLaborCost': 0.0,
        'averageMaterialCost': 0.0,
      };
    }

    double totalLaborCost = 0.0;
    double totalMaterialCost = 0.0;
    double totalCost = 0.0;

    for (var log in logs) {
      totalLaborCost += log.laborCost;
      totalMaterialCost += log.materialCost;
      totalCost += log.totalCost;
    }

    final logCount = logs.length;

    return {
      'totalLaborCost': totalLaborCost,
      'totalMaterialCost': totalMaterialCost,
      'totalCost': totalCost,
      'averageDailyCost': totalCost / logCount,
      'averageLaborCost': totalLaborCost / logCount,
      'averageMaterialCost': totalMaterialCost / logCount,
    };
  }

  // Action Distribution Statistics
  Future<Map<String, int>> getActionDistribution(int projectId) async {
    final logs = await getLogsForProject(projectId);
    final Map<String, int> distribution = {};

    for (var log in logs) {
      final actions = await getActionsForLog(log.id);
      for (var action in actions) {
        distribution[action.type] = (distribution[action.type] ?? 0) + 1;
      }
    }

    return distribution;
  }

  // Reminder Settings Queries
  Future<ReminderSetting?> getReminderSettings(int projectId) async {
    final query = select(reminderSettings)
      ..where((r) => r.projectId.equals(projectId));
    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  Future<int> createReminderSettings(ReminderSettingsCompanion settings) =>
      into(reminderSettings).insert(settings);

  Future<void> updateReminderSettings(ReminderSetting settings) =>
      update(reminderSettings).replace(settings);

  Future<void> deleteReminderSettings(int id) =>
      (delete(reminderSettings)..where((r) => r.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
