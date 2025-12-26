import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/database_provider.dart';
import '../services/task_checklist_service.dart';
import '../services/notification_service.dart';

class TaskChecklistScreen extends ConsumerStatefulWidget {
  final int projectId;

  const TaskChecklistScreen({super.key, required this.projectId});

  @override
  ConsumerState<TaskChecklistScreen> createState() => _TaskChecklistScreenState();
}

class _TaskChecklistScreenState extends ConsumerState<TaskChecklistScreen> {
  List<DateTime> _missingDates = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMissingLogs();
  }

  Future<void> _loadMissingLogs() async {
    final db = ref.read(databaseProvider);
    final notificationService = NotificationService();
    final checklistService = TaskChecklistService(db, notificationService);

    final missingDates = await checklistService.checkOverdueLogs(widget.projectId);

    setState(() {
      _missingDates = missingDates;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('作業檢查清單'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('作業檢查清單'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _loadMissingLogs();
            },
            tooltip: '重新整理',
          ),
        ],
      ),
      body: _missingDates.isEmpty
          ? _buildEmptyState()
          : _buildMissingLogsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 80,
            color: Colors.green[300],
          ),
          const SizedBox(height: 24),
          Text(
            '太棒了！',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '所有日誌都已記錄完成',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissingLogsList() {
    return Column(
      children: [
        // Summary Card
        Card(
          margin: const EdgeInsets.all(16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 48,
                  color: Colors.orange[700],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '待補記錄',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '共有 ${_missingDates.length} 天的日誌尚未記錄',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Missing Dates List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _missingDates.length,
            itemBuilder: (context, index) {
              final date = _missingDates[index];
              final dateFormat = DateFormat('yyyy/MM/dd (E)', 'zh_TW');
              final now = DateTime.now();
              final daysAgo = now.difference(date).inDays;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.event_busy,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                  title: Text(
                    dateFormat.format(date),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    daysAgo == 0
                        ? '今天'
                        : daysAgo == 1
                            ? '昨天'
                            : '$daysAgo 天前',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Navigate to add log for this date
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('請點擊首頁「新增日誌」補填 ${dateFormat.format(date)} 的記錄'),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
