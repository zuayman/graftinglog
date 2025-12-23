import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';
import '../data/database/database.dart';
import '../providers/database_provider.dart';

class GraftStatusScreen extends ConsumerStatefulWidget {
  final int dailyLogId;
  final int dayNumber;

  const GraftStatusScreen({
    super.key,
    required this.dailyLogId,
    required this.dayNumber,
  });

  @override
  ConsumerState<GraftStatusScreen> createState() => _GraftStatusScreenState();
}

class _GraftStatusScreenState extends ConsumerState<GraftStatusScreen> {
  final _blackHeadController = TextEditingController();
  final _dormantController = TextEditingController();
  final _sproutingController = TextEditingController();
  final _leafingController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _blackHeadController.dispose();
    _dormantController.dispose();
    _sproutingController.dispose();
    _leafingController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveStatus(String status, int count) async {
    if (count <= 0) return;

    final db = ref.read(databaseProvider);
    await db.createGraftStatus(
      GraftStatusCompanion.insert(
        dailyLogId: widget.dailyLogId,
        recordDate: DateTime.now(),
        status: status,
        count: drift.Value(count),
        notes: drift.Value(_notesController.text.isEmpty ? null : _notesController.text),
      ),
    );
  }

  Future<void> _saveAllStatuses() async {
    try {
      final blackHead = int.tryParse(_blackHeadController.text) ?? 0;
      final dormant = int.tryParse(_dormantController.text) ?? 0;
      final sprouting = int.tryParse(_sproutingController.text) ?? 0;
      final leafing = int.tryParse(_leafingController.text) ?? 0;

      if (blackHead + dormant + sprouting + leafing == 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('請至少輸入一個狀態的數量'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      if (blackHead > 0) await _saveStatus('黑頭', blackHead);
      if (dormant > 0) await _saveStatus('休眠', dormant);
      if (sprouting > 0) await _saveStatus('萌芽', sprouting);
      if (leafing > 0) await _saveStatus('展葉', leafing);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('狀態記錄已儲存'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
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
    final db = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('第 ${widget.dayNumber} 日 - 狀態記錄'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAllStatuses,
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
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '記錄當日觀察到的接穗狀態數量，系統會自動計算成功率統計',
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Existing Records
          FutureBuilder<List<GraftStatusData>>(
            future: db.getStatusForLog(widget.dailyLogId),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '歷史記錄',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    ...snapshot.data!.map((status) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 1,
                          child: ListTile(
                            leading: _getStatusIcon(status.status),
                            title: Text('${status.status}: ${status.count}'),
                            subtitle: Text(
                              DateFormat('yyyy/MM/dd HH:mm')
                                  .format(status.recordDate),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('確認刪除'),
                                    content: const Text('確定要刪除此記錄嗎？'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('取消'),
                                      ),
                                      FilledButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        style: FilledButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text('刪除'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await db.deleteGraftStatus(status.id);
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        )),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // Status Input Card
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
                  Text(
                    '新增狀態記錄',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),

                  // Black Head
                  _buildStatusInput(
                    label: '黑頭',
                    icon: Icons.circle,
                    color: Colors.grey,
                    controller: _blackHeadController,
                    hint: '失敗、死亡的數量',
                  ),
                  const SizedBox(height: 16),

                  // Dormant
                  _buildStatusInput(
                    label: '休眠',
                    icon: Icons.circle,
                    color: Colors.blue,
                    controller: _dormantController,
                    hint: '尚未萌芽的數量',
                  ),
                  const SizedBox(height: 16),

                  // Sprouting
                  _buildStatusInput(
                    label: '萌芽',
                    icon: Icons.circle,
                    color: Colors.lightGreen,
                    controller: _sproutingController,
                    hint: '開始萌芽的數量',
                  ),
                  const SizedBox(height: 16),

                  // Leafing
                  _buildStatusInput(
                    label: '展葉',
                    icon: Icons.circle,
                    color: Colors.green,
                    controller: _leafingController,
                    hint: '已展葉的數量',
                  ),
                  const SizedBox(height: 24),

                  // Notes
                  TextField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: '備註',
                      hintText: '記錄觀察心得或特殊狀況',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.note),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Save Button
          FilledButton.icon(
            onPressed: _saveAllStatuses,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.save),
            label: const Text(
              '儲存狀態記錄',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusInput({
    required String label,
    required IconData icon,
    required Color color,
    required TextEditingController controller,
    required String hint,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 12, color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              suffixText: '株',
            ),
          ),
        ),
      ],
    );
  }

  Widget _getStatusIcon(String status) {
    switch (status) {
      case '黑頭':
        return const Icon(Icons.circle, color: Colors.grey);
      case '休眠':
        return const Icon(Icons.circle, color: Colors.blue);
      case '萌芽':
        return const Icon(Icons.circle, color: Colors.lightGreen);
      case '展葉':
        return const Icon(Icons.circle, color: Colors.green);
      default:
        return const Icon(Icons.help_outline);
    }
  }
}
