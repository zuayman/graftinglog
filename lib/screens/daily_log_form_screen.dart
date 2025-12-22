import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';
import '../data/database/database.dart';
import '../providers/database_provider.dart';
import 'scion_batch_screen.dart';

class DailyLogFormScreen extends ConsumerStatefulWidget {
  final int projectId;
  final DailyLog? existingLog;

  const DailyLogFormScreen({
    super.key,
    required this.projectId,
    this.existingLog,
  });

  @override
  ConsumerState<DailyLogFormScreen> createState() => _DailyLogFormScreenState();
}

class _DailyLogFormScreenState extends ConsumerState<DailyLogFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dayNumberController;
  late TextEditingController _areaController;
  late TextEditingController _graftingCountController;
  late TextEditingController _baggingCountController;
  late TextEditingController _materialCostController;
  late TextEditingController _materialNotesController;
  DateTime _selectedDate = DateTime.now();
  String _selectedWeather = '晴';
  final List<String> _weatherOptions = ['晴', '陰', '雨', '低溫'];

  // Action types and their items
  final Map<String, List<String>> _actionTypes = {
    '藥劑': ['殺菌劑', '殺蟲劑', '除草劑', '其他藥劑'],
    '營養劑': ['葉面肥', '胺基酸', '海藻精', '其他營養劑'],
    '肥料': ['氮肥', '磷肥', '鉀肥', '複合肥'],
    '調節劑': ['生長素', '抑制劑', '開花劑', '其他調節劑'],
  };

  final Set<String> _selectedActions = {};
  double _laborCost = 0.0;
  double _materialCost = 0.0;
  double _totalCost = 0.0;
  int? _selectedBatchId;
  int? _daysDifference;

  // Status tracking
  late TextEditingController _blackHeadController;
  late TextEditingController _dormantController;
  late TextEditingController _sproutingController;
  late TextEditingController _leafingController;
  late TextEditingController _statusNotesController;

  // General notes
  late TextEditingController _notesController;

  // Importance level (0-5 stars)
  int _importanceLevel = 0;

  @override
  void initState() {
    super.initState();

    // Always initialize status controllers first
    _blackHeadController = TextEditingController(text: '0');
    _dormantController = TextEditingController(text: '0');
    _sproutingController = TextEditingController(text: '0');
    _leafingController = TextEditingController(text: '0');
    _statusNotesController = TextEditingController();

    if (widget.existingLog != null) {
      final log = widget.existingLog!;
      _dayNumberController = TextEditingController(text: log.dayNumber.toString());
      _areaController = TextEditingController(text: log.area);
      _graftingCountController = TextEditingController(text: log.graftingCount.toString());
      _baggingCountController = TextEditingController(text: log.baggingCount.toString());
      _materialCostController = TextEditingController(text: log.materialCost.toStringAsFixed(0));
      _materialNotesController = TextEditingController(text: log.materialNotes ?? '');
      _notesController = TextEditingController(text: log.notes ?? '');
      _selectedDate = log.date;
      _selectedWeather = log.weather;
      _laborCost = log.laborCost;
      _materialCost = log.materialCost;
      _totalCost = log.totalCost;
      _selectedBatchId = log.scionBatchId;
      _importanceLevel = log.importanceLevel;

      // Load status data asynchronously after frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadStatusData();
      });
    } else {
      _dayNumberController = TextEditingController(text: '1');
      _areaController = TextEditingController(text: 'A區');
      _graftingCountController = TextEditingController(text: '0');
      _baggingCountController = TextEditingController(text: '0');
      _materialCostController = TextEditingController(text: '0');
      _materialNotesController = TextEditingController();
      _notesController = TextEditingController();
    }

    _graftingCountController.addListener(_calculateCost);
    _baggingCountController.addListener(_calculateCost);
    _materialCostController.addListener(_calculateCost);
  }

  @override
  void dispose() {
    _dayNumberController.dispose();
    _areaController.dispose();
    _graftingCountController.dispose();
    _baggingCountController.dispose();
    _materialCostController.dispose();
    _materialNotesController.dispose();
    _notesController.dispose();
    _blackHeadController.dispose();
    _dormantController.dispose();
    _sproutingController.dispose();
    _leafingController.dispose();
    _statusNotesController.dispose();
    super.dispose();
  }

  Future<void> _loadStatusData() async {
    if (widget.existingLog == null) return;

    try {
      final db = ref.read(databaseProvider);
      final statuses = await db.getStatusForLog(widget.existingLog!.id);

      if (!mounted) return;

      setState(() {
        for (var status in statuses) {
          switch (status.status) {
            case '黑頭':
              _blackHeadController.text = status.count.toString();
              break;
            case '休眠':
              _dormantController.text = status.count.toString();
              break;
            case '萌芽':
              _sproutingController.text = status.count.toString();
              break;
            case '展葉':
              _leafingController.text = status.count.toString();
              break;
          }
          // Only set notes from the last status record if it exists
          final notes = status.notes;
          if (notes != null && notes.isNotEmpty) {
            _statusNotesController.text = notes;
          }
        }
      });
    } catch (e) {
      debugPrint('Error loading status data: $e');
    }
  }

  void _calculateCost() {
    final project = ref.read(currentProjectProvider).value;
    if (project == null) return;

    final graftingCount = int.tryParse(_graftingCountController.text) ?? 0;
    final baggingCount = int.tryParse(_baggingCountController.text) ?? 0;
    final materialCostValue = double.tryParse(_materialCostController.text) ?? 0.0;

    setState(() {
      _laborCost = (graftingCount * project.wageGraft) + (baggingCount * project.wageBag);
      _materialCost = materialCostValue;
      _totalCost = _laborCost + _materialCost;
    });
  }

  Future<void> _loadPreviousDay() async {
    final db = ref.read(databaseProvider);
    final previousLog = await db.getPreviousLog(widget.projectId, _selectedDate);

    if (previousLog != null) {
      setState(() {
        _graftingCountController.text = previousLog.graftingCount.toString();
        _baggingCountController.text = previousLog.baggingCount.toString();
        _areaController.text = previousLog.area;
        _selectedWeather = previousLog.weather;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已帶入前一天資料')),
        );
      }

      final actions = await db.getActionsForLog(previousLog.id);
      setState(() {
        _selectedActions.clear();
        for (var action in actions) {
          _selectedActions.add('${action.type}:${action.itemName}');
        }
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('找不到前一天的資料')),
        );
      }
    }
  }

  Future<void> _saveLog() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);

    try {
      final logCompanion = DailyLogsCompanion(
        id: widget.existingLog != null ? drift.Value(widget.existingLog!.id) : const drift.Value.absent(),
        projectId: drift.Value(widget.projectId),
        date: drift.Value(_selectedDate),
        dayNumber: drift.Value(int.parse(_dayNumberController.text)),
        area: drift.Value(_areaController.text),
        weather: drift.Value(_selectedWeather),
        graftingCount: drift.Value(int.parse(_graftingCountController.text)),
        baggingCount: drift.Value(int.parse(_baggingCountController.text)),
        laborCost: drift.Value(_laborCost),
        materialCost: drift.Value(_materialCost),
        totalCost: drift.Value(_totalCost),
        materialNotes: _materialNotesController.text.isEmpty
            ? const drift.Value.absent()
            : drift.Value(_materialNotesController.text),
        notes: _notesController.text.isEmpty
            ? const drift.Value.absent()
            : drift.Value(_notesController.text),
        importanceLevel: drift.Value(_importanceLevel),
        scionBatchId: _selectedBatchId != null ? drift.Value(_selectedBatchId) : const drift.Value.absent(),
      );

      int logId;
      if (widget.existingLog != null) {
        logId = widget.existingLog!.id;
        final existingLogData = DailyLog(
          id: logId,
          projectId: widget.projectId,
          date: _selectedDate,
          dayNumber: int.parse(_dayNumberController.text),
          area: _areaController.text,
          weather: _selectedWeather,
          graftingCount: int.parse(_graftingCountController.text),
          baggingCount: int.parse(_baggingCountController.text),
          laborCost: _laborCost,
          materialCost: _materialCost,
          totalCost: _totalCost,
          materialNotes: _materialNotesController.text.isEmpty ? null : _materialNotesController.text,
          notes: _notesController.text.isEmpty ? null : _notesController.text,
          importanceLevel: _importanceLevel,
          scionBatchId: _selectedBatchId,
        );
        await db.updateDailyLog(existingLogData);
        await db.deleteActionsForLog(logId);
      } else {
        logId = await db.createDailyLog(logCompanion);
      }

      if (_selectedActions.isNotEmpty) {
        final actions = _selectedActions.map((action) {
          final parts = action.split(':');
          return ActionsCompanion(
            dailyLogId: drift.Value(logId),
            type: drift.Value(parts[0]),
            itemName: drift.Value(parts[1]),
          );
        }).toList();
        await db.createActions(actions);
      }

      // Save status tracking data
      await db.deleteStatusForLog(logId);

      final statusRecords = <GraftStatusCompanion>[];

      final blackHeadCount = int.tryParse(_blackHeadController.text) ?? 0;
      if (blackHeadCount > 0) {
        statusRecords.add(GraftStatusCompanion(
          dailyLogId: drift.Value(logId),
          recordDate: drift.Value(_selectedDate),
          status: const drift.Value('黑頭'),
          count: drift.Value(blackHeadCount),
          notes: _statusNotesController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(_statusNotesController.text),
        ));
      }

      final dormantCount = int.tryParse(_dormantController.text) ?? 0;
      if (dormantCount > 0) {
        statusRecords.add(GraftStatusCompanion(
          dailyLogId: drift.Value(logId),
          recordDate: drift.Value(_selectedDate),
          status: const drift.Value('休眠'),
          count: drift.Value(dormantCount),
          notes: _statusNotesController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(_statusNotesController.text),
        ));
      }

      final sproutingCount = int.tryParse(_sproutingController.text) ?? 0;
      if (sproutingCount > 0) {
        statusRecords.add(GraftStatusCompanion(
          dailyLogId: drift.Value(logId),
          recordDate: drift.Value(_selectedDate),
          status: const drift.Value('萌芽'),
          count: drift.Value(sproutingCount),
          notes: _statusNotesController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(_statusNotesController.text),
        ));
      }

      final leafingCount = int.tryParse(_leafingController.text) ?? 0;
      if (leafingCount > 0) {
        statusRecords.add(GraftStatusCompanion(
          dailyLogId: drift.Value(logId),
          recordDate: drift.Value(_selectedDate),
          status: const drift.Value('展葉'),
          count: drift.Value(leafingCount),
          notes: _statusNotesController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(_statusNotesController.text),
        ));
      }

      for (final status in statusRecords) {
        await db.createGraftStatus(status);
      }

      // Invalidate both providers to ensure refresh
      ref.invalidate(dailyLogsProvider);
      ref.invalidate(projectDailyLogsProvider(widget.projectId));

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('儲存失敗: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingLog != null ? '編輯日誌' : '新增日誌'),
        actions: [
          if (widget.existingLog == null)
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: _loadPreviousDay,
              tooltip: '複製前一天',
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildDateSection(),
            const SizedBox(height: 24),
            _buildBasicInfoSection(),
            const SizedBox(height: 24),
            _buildScionBatchSection(),
            const SizedBox(height: 24),
            _buildManpowerSection(),
            const SizedBox(height: 24),
            _buildMaterialCostSection(),
            const SizedBox(height: 24),
            _buildStatusTrackingSection(),
            const SizedBox(height: 24),
            _buildNotesSection(),
            const SizedBox(height: 24),
            _buildActionMatrixSection(),
            const SizedBox(height: 24),
            _buildCostDisplay(),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _saveLog,
              icon: const Icon(Icons.save),
              label: const Text('儲存'),
              style: FilledButton.styleFrom(
                elevation: 2,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('日期資訊', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _dayNumberController,
                    decoration: const InputDecoration(
                      labelText: '嫁接第 n 日',
                      border: OutlineInputBorder(),
                      suffixText: '日',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return '請輸入天數';
                      if (int.tryParse(value) == null) return '請輸入有效數字';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) {
                        setState(() => _selectedDate = date);
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '實際日期',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(DateFormat('yyyy/MM/dd').format(_selectedDate)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('基本資訊', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            TextFormField(
              controller: _areaController,
              decoration: const InputDecoration(
                labelText: '嫁接區域',
                border: OutlineInputBorder(),
                hintText: '例: A區、北坡',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return '請輸入區域';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedWeather,
              decoration: const InputDecoration(
                labelText: '天候狀況',
                border: OutlineInputBorder(),
              ),
              items: _weatherOptions.map((weather) {
                return DropdownMenuItem(
                  value: weather,
                  child: Text(weather),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedWeather = value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScionBatchSection() {
    final batchesAsync = ref.watch(scionBatchesProvider);

    return Card(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('花苞批次', style: Theme.of(context).textTheme.titleMedium),
                TextButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScionBatchScreen()),
                    );
                    // Refresh batches after returning
                    ref.invalidate(scionBatchesProvider);
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('管理批次'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            batchesAsync.when(
              data: (batches) {
                if (batches.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '尚無花苞批次，請先建立批次',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return DropdownButtonFormField<int>(
                  initialValue: _selectedBatchId,
                  decoration: const InputDecoration(
                    labelText: '選擇花苞批次（可選）',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<int>(
                      value: null,
                      child: Text('未選擇'),
                    ),
                    ...batches.map((batch) {
                      return DropdownMenuItem<int>(
                        value: batch.id,
                        child: Text(
                          '${batch.batchName} (${DateFormat('MM/dd').format(batch.deliveryDate)})',
                        ),
                      );
                    }),
                  ],
                  onChanged: (value) async {
                    setState(() {
                      _selectedBatchId = value;
                    });

                    // Calculate days difference
                    if (value != null) {
                      final selectedBatch = batches.firstWhere((b) => b.id == value);
                      final difference = _selectedDate.difference(selectedBatch.deliveryDate).inDays;
                      setState(() {
                        _daysDifference = difference;
                      });
                    } else {
                      setState(() {
                        _daysDifference = null;
                      });
                    }
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('錯誤: $error'),
            ),
            if (_daysDifference != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.blue.shade700, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '出庫後 $_daysDifference 天',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildManpowerSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('人力配置', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _graftingCountController,
                    decoration: const InputDecoration(
                      labelText: '嫁接人數',
                      border: OutlineInputBorder(),
                      suffixText: '人',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return '請輸入人數';
                      if (int.tryParse(value) == null) return '請輸入有效數字';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _baggingCountController,
                    decoration: const InputDecoration(
                      labelText: '套袋人數',
                      border: OutlineInputBorder(),
                      suffixText: '人',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return '請輸入人數';
                      if (int.tryParse(value) == null) return '請輸入有效數字';
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialCostSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('材料成本', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            TextFormField(
              controller: _materialCostController,
              decoration: const InputDecoration(
                labelText: '材料成本金額',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
                hintText: '例: 花苞、藥劑等',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return null;
                if (double.tryParse(value) == null) return '請輸入有效數字';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _materialNotesController,
              decoration: const InputDecoration(
                labelText: '材料備註（可選）',
                border: OutlineInputBorder(),
                hintText: '例: 花苞 200 個、殺菌劑 2 瓶',
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTrackingSection() {
    return Card(
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
                Icon(Icons.eco, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text('接穗狀態記錄', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _blackHeadController,
                    decoration: const InputDecoration(
                      labelText: '黑頭',
                      border: OutlineInputBorder(),
                      suffixText: '株',
                      prefixIcon: Icon(Icons.circle, color: Colors.grey, size: 16),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (int.tryParse(value) == null) return '請輸入數字';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _dormantController,
                    decoration: const InputDecoration(
                      labelText: '休眠',
                      border: OutlineInputBorder(),
                      suffixText: '株',
                      prefixIcon: Icon(Icons.circle, color: Colors.blue, size: 16),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (int.tryParse(value) == null) return '請輸入數字';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _sproutingController,
                    decoration: const InputDecoration(
                      labelText: '萌芽',
                      border: OutlineInputBorder(),
                      suffixText: '株',
                      prefixIcon: Icon(Icons.circle, color: Colors.lightGreen, size: 16),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (int.tryParse(value) == null) return '請輸入數字';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _leafingController,
                    decoration: const InputDecoration(
                      labelText: '展葉',
                      border: OutlineInputBorder(),
                      suffixText: '株',
                      prefixIcon: Icon(Icons.circle, color: Colors.green, size: 16),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (int.tryParse(value) == null) return '請輸入數字';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _statusNotesController,
              decoration: const InputDecoration(
                labelText: '狀態備註（可選）',
                border: OutlineInputBorder(),
                hintText: '例: 部分黑頭、低溫影響等',
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Card(
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
                Icon(Icons.note_alt, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text('日誌備註', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '記錄特殊狀況，例如：天氣變化、臨時事件等',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: '備註內容（可選）',
                border: OutlineInputBorder(),
                hintText: '例：早上天氣晴朗，下午突然降溫且下雨',
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              minLines: 3,
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.star_border, color: Colors.amber.shade700),
                const SizedBox(width: 8),
                Text('重要程度', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '選擇重要程度，星星越多視覺強調越明顯（0顆星為正常顯示）',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _importanceLevel = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      index <= _importanceLevel ? Icons.star : Icons.star_border,
                      color: index == 0
                          ? Colors.grey.shade400
                          : Colors.amber.shade700,
                      size: 40,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _importanceLevel == 0
                    ? '正常顯示'
                    : '$_importanceLevel 顆星',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _importanceLevel == 0
                          ? Colors.grey[600]
                          : Colors.amber.shade900,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionMatrixSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('當日施作項目', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('點擊快速勾選', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 16),
            ..._actionTypes.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: entry.value.map((item) {
                      final actionKey = '${entry.key}:$item';
                      final isSelected = _selectedActions.contains(actionKey);
                      return FilterChip(
                        label: Text(item),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedActions.add(actionKey);
                            } else {
                              _selectedActions.remove(actionKey);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCostDisplay() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '人工成本',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
                Text(
                  '\$${_laborCost.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '材料成本',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
                Text(
                  '\$${_materialCost.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '今日總成本',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${_totalCost.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
