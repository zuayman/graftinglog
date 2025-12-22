import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../data/database/database.dart';

class CsvExportService {
  static Future<String> exportProjectToCsv(
    AppDatabase db,
    int projectId,
  ) async {
    // Get project details
    final project = await db.getProject(projectId);
    final logs = await db.getLogsForProject(projectId);

    // Prepare CSV data
    List<List<dynamic>> rows = [];

    // Add header information
    rows.add(['嫁接日誌匯出']);
    rows.add(['專案', '${project.year} 年度 - ${project.variety}']);
    rows.add(['嫁接工資', project.wageGraft]);
    rows.add(['套袋工資', project.wageBag]);
    rows.add(['匯出時間', DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())]);
    rows.add([]); // Empty row

    // Add daily logs header
    rows.add([
      '日期',
      '第 n 日',
      '區域',
      '天候',
      '嫁接人數',
      '套袋人數',
      '人工成本',
      '材料成本',
      '總成本',
      '材料備註',
      '施作項目',
    ]);

    // Add daily logs data
    for (var log in logs) {
      // Get actions for this log
      final actions = await db.getActionsForLog(log.id);
      final actionsList = actions.map((a) => '${a.type}-${a.itemName}').join(', ');

      rows.add([
        DateFormat('yyyy/MM/dd').format(log.date),
        log.dayNumber,
        log.area,
        log.weather,
        log.graftingCount,
        log.baggingCount,
        log.laborCost.toStringAsFixed(0),
        log.materialCost.toStringAsFixed(0),
        log.totalCost.toStringAsFixed(0),
        log.materialNotes ?? '',
        actionsList,
      ]);
    }

    // Add summary
    rows.add([]); // Empty row
    final stats = await db.getCostStatistics(projectId);
    rows.add(['統計摘要']);
    rows.add(['總成本', stats['totalCost']!.toStringAsFixed(0)]);
    rows.add(['總人工成本', stats['totalLaborCost']!.toStringAsFixed(0)]);
    rows.add(['總材料成本', stats['totalMaterialCost']!.toStringAsFixed(0)]);
    rows.add(['平均每日成本', stats['averageDailyCost']!.toStringAsFixed(0)]);
    rows.add(['日誌總數', logs.length]);

    // Convert to CSV
    String csv = const ListToCsvConverter().convert(rows);

    // Save to file
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final fileName = 'grafting_log_${project.year}_${project.variety}_$timestamp.csv';
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsString(csv, encoding: utf8);

    return filePath;
  }

  static Future<String> exportBatchesToCsv(
    AppDatabase db,
    int projectId,
  ) async {
    // Get project details
    final project = await db.getProject(projectId);
    final batches = await db.getBatchesForProject(projectId);

    // Prepare CSV data
    List<List<dynamic>> rows = [];

    // Add header information
    rows.add(['花苞批次匯出']);
    rows.add(['專案', '${project.year} 年度 - ${project.variety}']);
    rows.add(['匯出時間', DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())]);
    rows.add([]); // Empty row

    // Add batches header
    rows.add([
      '批次名稱',
      '出庫日期',
      '數量',
    ]);

    // Add batches data
    for (var batch in batches) {
      rows.add([
        batch.batchName,
        DateFormat('yyyy/MM/dd').format(batch.deliveryDate),
        batch.quantity ?? '',
      ]);
    }

    // Convert to CSV
    String csv = const ListToCsvConverter().convert(rows);

    // Save to file
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final fileName = 'scion_batches_${project.year}_${project.variety}_$timestamp.csv';
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsString(csv, encoding: utf8);

    return filePath;
  }
}
