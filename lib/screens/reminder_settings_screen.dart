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
  bool _startDateReminderEnabled = false;
  bool _endDateReminderEnabled = false;
  DateTime? _expectedStartDate;
  DateTime? _expectedEndDate;
  bool _rainyDaysAlertEnabled = false;
  int _consecutiveRainyDaysThreshold = 3;
  bool _lowTempAlertEnabled = false;
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
        _startDateReminderEnabled = settings.startDateReminderEnabled;
        _endDateReminderEnabled = settings.endDateReminderEnabled;
        _expectedStartDate = settings.expectedStartDate;
        _expectedEndDate = settings.expectedEndDate;
        _rainyDaysAlertEnabled = settings.rainyDaysAlertEnabled;
        _consecutiveRainyDaysThreshold = settings.consecutiveRainyDaysThreshold;
        _lowTempAlertEnabled = settings.lowTempAlertEnabled;
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

    // Validate date reminders
    if (_startDateReminderEnabled && _expectedStartDate == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('請選擇預計開始日期'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    if (_endDateReminderEnabled && _expectedEndDate == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('請選擇預計完成日期'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    // Request notification permissions first
    final permissionGranted = await notificationService.requestPermissions();
    if (!permissionGranted && (_dailyReminderEnabled || _startDateReminderEnabled || _endDateReminderEnabled)) {
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

    // Check and request exact alarm permission for Android
    if (_dailyReminderEnabled || _startDateReminderEnabled || _endDateReminderEnabled) {
      final canScheduleExact = await notificationService.canScheduleExactAlarms();
      if (!canScheduleExact) {
        // Show dialog to explain and request permission
        if (mounted) {
          final shouldRequest = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('需要精確鬧鐘權限'),
              content: const Text(
                '為了在精確的時間發送提醒通知，應用程式需要「精確鬧鐘」權限。\n\n'
                '點擊「前往設定」後，請在系統設定中允許此應用程式使用精確鬧鐘功能。',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('取消'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('前往設定'),
                ),
              ],
            ),
          );

          if (shouldRequest == true) {
            await notificationService.requestExactAlarmPermission();
            // Check again after user returns from settings
            final nowCan = await notificationService.canScheduleExactAlarms();
            if (!nowCan && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('未授予精確鬧鐘權限，提醒時間可能不精確'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 4),
                ),
              );
            }
          } else {
            return; // User cancelled
          }
        }
      }
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
            startDateReminderEnabled: drift.Value(_startDateReminderEnabled),
            endDateReminderEnabled: drift.Value(_endDateReminderEnabled),
            expectedStartDate: drift.Value(_expectedStartDate),
            expectedEndDate: drift.Value(_expectedEndDate),
            rainyDaysAlertEnabled: drift.Value(_rainyDaysAlertEnabled),
            consecutiveRainyDaysThreshold: drift.Value(_consecutiveRainyDaysThreshold),
            lowTempAlertEnabled: drift.Value(_lowTempAlertEnabled),
          ),
        );
      } else {
        // Update existing settings
        await db.updateReminderSettings(
          _currentSettings!.copyWith(
            dailyReminderEnabled: _dailyReminderEnabled,
            dailyReminderHour: _selectedHour,
            dailyReminderMinute: _selectedMinute,
            startDateReminderEnabled: _startDateReminderEnabled,
            endDateReminderEnabled: _endDateReminderEnabled,
            expectedStartDate: drift.Value(_expectedStartDate),
            expectedEndDate: drift.Value(_expectedEndDate),
            rainyDaysAlertEnabled: _rainyDaysAlertEnabled,
            consecutiveRainyDaysThreshold: _consecutiveRainyDaysThreshold,
            lowTempAlertEnabled: _lowTempAlertEnabled,
          ),
        );
      }

      // Schedule or cancel daily notification
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

      // Schedule or cancel start date notification
      if (_startDateReminderEnabled && _expectedStartDate != null) {
        final reminderDate = DateTime(
          _expectedStartDate!.year,
          _expectedStartDate!.month,
          _expectedStartDate!.day,
          9, // 早上9點提醒
          0,
        );
        await notificationService.scheduleNotification(
          id: NotificationIds.graftingStartReminder,
          title: '嫁接開始提醒',
          body: '今天是預計的嫁接開始日，記得開始記錄！',
          scheduledDate: reminderDate,
        );
      } else {
        await notificationService
            .cancelNotification(NotificationIds.graftingStartReminder);
      }

      // Schedule or cancel end date notification
      if (_endDateReminderEnabled && _expectedEndDate != null) {
        final reminderDate = DateTime(
          _expectedEndDate!.year,
          _expectedEndDate!.month,
          _expectedEndDate!.day,
          9, // 早上9點提醒
          0,
        );
        await notificationService.scheduleNotification(
          id: NotificationIds.graftingEndReminder,
          title: '嫁接完成提醒',
          body: '今天是預計的嫁接第30日，記得檢查接穗狀態！',
          scheduledDate: reminderDate,
        );
      } else {
        await notificationService
            .cancelNotification(NotificationIds.graftingEndReminder);
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
          const SizedBox(height: 16),

          // Key Date Reminders Section
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
                        Icons.event_note,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        '關鍵日期提醒',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Start Date Reminder
                  SwitchListTile(
                    title: const Text('嫁接開始日提醒'),
                    subtitle: const Text('提醒您開始嫁接作業'),
                    value: _startDateReminderEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _startDateReminderEnabled = value;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  if (_startDateReminderEnabled) ...[
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('預計開始日期'),
                      subtitle: Text(
                        _expectedStartDate != null
                            ? '${_expectedStartDate!.year}/${_expectedStartDate!.month}/${_expectedStartDate!.day}'
                            : '點擊選擇日期',
                      ),
                      trailing: const Icon(Icons.edit),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _expectedStartDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (date != null) {
                          setState(() {
                            _expectedStartDate = date;
                          });
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],

                  const Divider(height: 24),

                  // End Date Reminder
                  SwitchListTile(
                    title: const Text('嫁接完成日提醒（第30日）'),
                    subtitle: const Text('提醒您檢查接穗狀態'),
                    value: _endDateReminderEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _endDateReminderEnabled = value;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  if (_endDateReminderEnabled) ...[
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('預計完成日期'),
                      subtitle: Text(
                        _expectedEndDate != null
                            ? '${_expectedEndDate!.year}/${_expectedEndDate!.month}/${_expectedEndDate!.day}'
                            : '點擊選擇日期',
                      ),
                      trailing: const Icon(Icons.edit),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _expectedEndDate ??
                              (_expectedStartDate?.add(const Duration(days: 30)) ?? DateTime.now()),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (date != null) {
                          setState(() {
                            _expectedEndDate = date;
                          });
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Weather Alerts Section
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
                        Icons.cloud_outlined,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        '天候警示',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Rainy Days Alert
                  SwitchListTile(
                    title: const Text('連續雨天警告'),
                    subtitle: const Text('偵測連續雨天並提醒'),
                    value: _rainyDaysAlertEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _rainyDaysAlertEnabled = value;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  if (_rainyDaysAlertEnabled) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.water_drop, size: 20),
                          const SizedBox(width: 12),
                          const Text('連續'),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<int>(
                              value: _consecutiveRainyDaysThreshold,
                              underline: const SizedBox(),
                              items: [2, 3, 4, 5, 7].map((days) {
                                return DropdownMenuItem(
                                  value: days,
                                  child: Text('$days'),
                                );
                              }).toList(),
                              onChanged: (int? value) {
                                if (value != null) {
                                  setState(() {
                                    _consecutiveRainyDaysThreshold = value;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('天雨天時發送警示'),
                        ],
                      ),
                    ),
                  ],

                  const Divider(height: 24),

                  // Low Temperature Alert
                  SwitchListTile(
                    title: const Text('低溫警告'),
                    subtitle: const Text('低溫天候時提醒保護接穗'),
                    value: _lowTempAlertEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _lowTempAlertEnabled = value;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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
