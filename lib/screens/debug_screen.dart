import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DebugScreen extends ConsumerWidget {
  const DebugScreen({super.key});

  Future<void> _resetDatabase(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('重置資料庫'),
        content: const Text('這將刪除所有資料並重新建立資料庫。\n\n確定要繼續嗎？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('確定重置'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbPath = p.join(dbFolder.path, 'db.sqlite');
      final dbFile = File(dbPath);

      if (await dbFile.exists()) {
        await dbFile.delete();
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('資料庫已重置，請重新啟動應用程式'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('重置失敗: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('除錯工具'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.warning, color: Colors.red),
              title: const Text('重置資料庫'),
              subtitle: const Text('刪除所有資料並重新建立資料庫'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _resetDatabase(context),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.orange[50],
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        '注意事項',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    '• 重置資料庫會刪除所有專案和日誌資料\n'
                    '• 重置後需要重新啟動應用程式\n'
                    '• 建議先匯出資料備份',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
