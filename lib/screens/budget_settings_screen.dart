import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../data/database/database.dart';
import '../providers/database_provider.dart';

class BudgetSettingsScreen extends ConsumerStatefulWidget {
  final int projectId;

  const BudgetSettingsScreen({super.key, required this.projectId});

  @override
  ConsumerState<BudgetSettingsScreen> createState() => _BudgetSettingsScreenState();
}

class _BudgetSettingsScreenState extends ConsumerState<BudgetSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _budgetController = TextEditingController();
  bool _budgetAlertEnabled = false;
  double _budgetAlertThreshold = 0.8;
  bool _isLoading = true;
  Project? _currentProject;

  @override
  void initState() {
    super.initState();
    _loadProject();
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _loadProject() async {
    final db = ref.read(databaseProvider);
    final project = await db.getProject(widget.projectId);

    setState(() {
      _currentProject = project;
      if (project.budgetLimit != null) {
        _budgetController.text = project.budgetLimit!.toStringAsFixed(0);
      }
      _budgetAlertEnabled = project.budgetAlertEnabled;
      _budgetAlertThreshold = project.budgetAlertThreshold;
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);

    try {
      final budgetLimit = _budgetController.text.isEmpty
          ? null
          : double.tryParse(_budgetController.text);

      final updatedProject = _currentProject!.copyWith(
        budgetLimit: drift.Value(budgetLimit),
        budgetAlertEnabled: _budgetAlertEnabled,
        budgetAlertThreshold: _budgetAlertThreshold,
      );

      await db.updateProject(updatedProject);

      // Invalidate provider to trigger refresh
      ref.invalidate(projectsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('預算設定已儲存'),
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
          title: const Text('預算設定'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('預算設定'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
            tooltip: '儲存',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
                        '設定專案預算上限，系統將協助您追蹤預算使用狀況',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Budget Limit Card
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
                          Icons.account_balance_wallet,
                          color: Theme.of(context).colorScheme.primary,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          '預算上限',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _budgetController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '預算金額',
                        hintText: '輸入預算上限（元）',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                        helperText: '留空表示不設上限',
                      ),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          final budget = double.tryParse(value);
                          if (budget == null || budget <= 0) {
                            return '請輸入有效的金額';
                          }
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Budget Alert Card
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
                          color: Theme.of(context).colorScheme.secondary,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          '預算警示',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('啟用預算警示'),
                      subtitle: const Text('當支出達到設定比例時提醒'),
                      value: _budgetAlertEnabled,
                      onChanged: _budgetController.text.isNotEmpty
                          ? (bool value) {
                              setState(() {
                                _budgetAlertEnabled = value;
                              });
                            }
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    if (_budgetAlertEnabled && _budgetController.text.isNotEmpty) ...[
                      const Divider(height: 32),
                      const Text(
                        '警示閾值',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Slider(
                        value: _budgetAlertThreshold,
                        min: 0.5,
                        max: 1.0,
                        divisions: 10,
                        label: '${(_budgetAlertThreshold * 100).toInt()}%',
                        onChanged: (value) {
                          setState(() {
                            _budgetAlertThreshold = value;
                          });
                        },
                      ),
                      Center(
                        child: Text(
                          '當支出達到預算的 ${(_budgetAlertThreshold * 100).toInt()}% 時發送警示',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
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
      ),
    );
  }
}
