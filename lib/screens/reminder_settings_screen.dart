import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../data/database/database.dart';
import '../providers/database_provider.dart';
import '../services/notification_service.dart';

class ReminderSettingsScreen extends ConsumerStatefulWidget {
  final int projectId;

  const ReminderSettingsScreen({super.key, required this.projectId});

  @override
  ConsumerState<ReminderSettingsScreen> createState() =>
      _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState
    extends ConsumerState<ReminderSettingsScreen> {
  bool _dailyReminderEnabled = false;
  int _selectedHour = 9;
  int _selectedMinute = 0;
  bool _isLoading = true;
  ReminderSetting? _currentSettings;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final db = ref.read(databaseProvider);
    final settings = await db.getReminderSettings(widget.projectId);

    if (settings != null) {
      setState(() {
        _currentSettings = settings;
        _dailyReminderEnabled = settings.dailyReminderEnabled;
        _selectedHour = settings.dailyReminderHour;
        _selectedMinute = settings.dailyReminderMinute;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveSettings() async {
    final db = ref.read(databaseProvider);
    final notificationService = NotificationService();

    // Request permissions first
    final permissionGranted = await notificationService.requestPermissions();
    if (!permissionGranted && _dailyReminderEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('需要通知權限才能使用提醒功能'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    try {
      if (_currentSettings == null) {
        // Create new settings
        await db.createReminderSettings(
          ReminderSettingsCompanion.insert(
            projectId: widget.projectId,
            dailyReminderEnabled: drift.Value(_dailyReminderEnabled),
            dailyReminderHour: drift.Value(_selectedHour),
            dailyReminderMinute: drift.Value(_selectedMinute),
          ),
        );
      } else {
        // Update existing settings
        await db.updateReminderSettings(
          _currentSettings!.copyWith(
            dailyReminderEnabled: _dailyReminderEnabled,
            dailyReminderHour: _selectedHour,
            dailyReminderMinute: _selectedMinute,
          ),
        );
      }

      // Schedule or cancel notification
      if (_dailyReminderEnabled) {
        await notificationService.scheduleDailyReminder(
          id: NotificationIds.dailyWorkReminder,
          title: '嫁接日誌提醒',
          body: '記得記錄今天的嫁接作業！',
          hour: _selectedHour,
          minute: _selectedMinute,
        );
      } else {
        await notificationService
            .cancelNotification(NotificationIds.dailyWorkReminder);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('提醒設定已儲存'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('儲存失敗: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('提醒設定'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('提醒設定'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
            tooltip: '儲存',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Info Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      '設定每日提醒，讓您不會忘記記錄嫁接日誌',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Daily Reminder Section
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        '每日作業提醒',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('啟用每日提醒'),
                    subtitle: const Text('每天定時提醒您記錄日誌'),
                    value: _dailyReminderEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _dailyReminderEnabled = value;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  if (_dailyReminderEnabled) ...[
                    const Divider(height: 32),
                    const Text(
                      '提醒時間',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 16),
                          // Hour selector
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: DropdownButton<int>(
                              value: _selectedHour,
                              underline: const SizedBox(),
                              items: List.generate(24, (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    index.toString().padLeft(2, '0'),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              }),
                              onChanged: (int? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedHour = value;
                                  });
                                }
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              ':',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Minute selector
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: DropdownButton<int>(
                              value: _selectedMinute,
                              underline: const SizedBox(),
                              items: List.generate(4, (index) {
                                final minute = index * 15;
                                return DropdownMenuItem(
                                  value: minute,
                                  child: Text(
                                    minute.toString().padLeft(2, '0'),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              }),
                              onChanged: (int? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedMinute = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '將在每天 ${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')} 提醒您',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Save Button
          FilledButton.icon(
            onPressed: _saveSettings,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.save),
            label: const Text(
              '儲存設定',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
