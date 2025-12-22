import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';
import '../data/database/database.dart';
import '../providers/database_provider.dart';

// Provider for scion batches
final scionBatchesProvider = FutureProvider<List<ScionBatche>>((ref) async {
  final db = ref.watch(databaseProvider);
  final projectId = ref.watch(currentProjectIdProvider);
  if (projectId == null) return [];
  return db.getBatchesForProject(projectId);
});

class ScionBatchScreen extends ConsumerWidget {
  const ScionBatchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchesAsync = ref.watch(scionBatchesProvider);
    final currentProjectId = ref.watch(currentProjectIdProvider);

    if (currentProjectId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('花苞批次管理')),
        body: const Center(child: Text('請先選擇專案')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('花苞批次管理'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: batchesAsync.when(
        data: (batches) {
          if (batches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text('尚無花苞批次'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScionBatchFormScreen(projectId: currentProjectId),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('新增批次'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: batches.length,
            itemBuilder: (context, index) {
              final batch = batches[index];
              return _buildBatchCard(context, ref, batch);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('錯誤: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScionBatchFormScreen(projectId: currentProjectId),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBatchCard(BuildContext context, WidgetRef ref, ScionBatche batch) {
    final sourceColor = _getSourceColor(batch.sourceType);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScionBatchFormScreen(
              projectId: batch.projectId,
              existingBatch: batch,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      batch.batchName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: sourceColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: sourceColor),
                    ),
                    child: Text(
                      batch.sourceType,
                      style: TextStyle(
                        color: sourceColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text('出庫: ${DateFormat('yyyy/MM/dd').format(batch.deliveryDate)}'),
                  if (batch.quantity != null) ...[
                    const SizedBox(width: 16),
                    Icon(Icons.inventory, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('${batch.quantity} 個'),
                  ],
                ],
              ),
              if (batch.supplierName != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.store, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('供應商: ${batch.supplierName}'),
                  ],
                ),
              ],
              if (batch.sourceType == '自採' && batch.harvestDate != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.eco, size: 16, color: Colors.green[600]),
                    const SizedBox(width: 4),
                    Text('採收: ${DateFormat('yyyy/MM/dd').format(batch.harvestDate!)}'),
                    if (batch.coldStorageDays != null) ...[
                      const SizedBox(width: 16),
                      Icon(Icons.ac_unit, size: 16, color: Colors.blue[600]),
                      const SizedBox(width: 4),
                      Text('冷藏: ${batch.coldStorageDays} 天'),
                    ],
                  ],
                ),
              ],
              if (batch.qualityRating != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber[700]),
                    const SizedBox(width: 4),
                    Text('品質: ${batch.qualityRating}'),
                  ],
                ),
              ],
              if (batch.totalPrice != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.attach_money, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('總價: \$${batch.totalPrice!.toStringAsFixed(0)}'),
                    if (batch.unitPrice != null && batch.quantity != null) ...[
                      Text(' (單價: \$${batch.unitPrice!.toStringAsFixed(1)})'),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getSourceColor(String sourceType) {
    switch (sourceType) {
      case '農會':
        return Colors.blue;
      case '自採':
        return Colors.green;
      case '其他農友':
        return Colors.orange;
      case '花苞商':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

// 花苞批次表單畫面
class ScionBatchFormScreen extends ConsumerStatefulWidget {
  final int projectId;
  final ScionBatche? existingBatch;

  const ScionBatchFormScreen({
    super.key,
    required this.projectId,
    this.existingBatch,
  });

  @override
  ConsumerState<ScionBatchFormScreen> createState() => _ScionBatchFormScreenState();
}

class _ScionBatchFormScreenState extends ConsumerState<ScionBatchFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _batchNameController;
  late TextEditingController _quantityController;
  late TextEditingController _supplierNameController;
  late TextEditingController _supplierContactController;
  late TextEditingController _coldStorageDaysController;
  late TextEditingController _unitPriceController;
  late TextEditingController _totalPriceController;
  late TextEditingController _notesController;

  DateTime _deliveryDate = DateTime.now();
  String _sourceType = '其他';
  DateTime? _harvestDate;
  DateTime? _coldStorageStartDate;
  String? _qualityRating;

  final List<String> _sourceTypes = ['農會', '自採', '其他農友', '花苞商', '其他'];
  final List<String> _qualityOptions = ['優', '良', '普通'];

  @override
  void initState() {
    super.initState();
    final batch = widget.existingBatch;

    _batchNameController = TextEditingController(text: batch?.batchName ?? '');
    _quantityController = TextEditingController(text: batch?.quantity?.toString() ?? '');
    _supplierNameController = TextEditingController(text: batch?.supplierName ?? '');
    _supplierContactController = TextEditingController(text: batch?.supplierContact ?? '');
    _coldStorageDaysController = TextEditingController(text: batch?.coldStorageDays?.toString() ?? '');
    _unitPriceController = TextEditingController(text: batch?.unitPrice?.toString() ?? '');
    _totalPriceController = TextEditingController(text: batch?.totalPrice?.toString() ?? '');
    _notesController = TextEditingController(text: batch?.notes ?? '');

    if (batch != null) {
      _deliveryDate = batch.deliveryDate;
      _sourceType = batch.sourceType;
      _harvestDate = batch.harvestDate;
      _coldStorageStartDate = batch.coldStorageStartDate;
      _qualityRating = batch.qualityRating;
    }
  }

  @override
  void dispose() {
    _batchNameController.dispose();
    _quantityController.dispose();
    _supplierNameController.dispose();
    _supplierContactController.dispose();
    _coldStorageDaysController.dispose();
    _unitPriceController.dispose();
    _totalPriceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingBatch == null ? '新增花苞批次' : '編輯花苞批次'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildBasicInfoSection(),
            const SizedBox(height: 24),
            _buildSourceInfoSection(),
            const SizedBox(height: 24),
            if (_sourceType == '自採') ...[
              _buildSelfHarvestSection(),
              const SizedBox(height: 24),
            ],
            _buildPriceQualitySection(),
            const SizedBox(height: 24),
            _buildNotesSection(),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('取消'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _saveBatch,
                    child: const Text('儲存'),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text('基本資訊', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _batchNameController,
              decoration: const InputDecoration(
                labelText: '批次名稱 *',
                border: OutlineInputBorder(),
                hintText: '例：2026-01 批',
              ),
              validator: (value) => value?.isEmpty ?? true ? '請輸入批次名稱' : null,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _deliveryDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  setState(() => _deliveryDate = date);
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: '出庫日期 *',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(DateFormat('yyyy/MM/dd').format(_deliveryDate)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: '數量（可選）',
                border: OutlineInputBorder(),
                suffixText: '個',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceInfoSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.source, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text('來源資訊', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _sourceType,
              decoration: const InputDecoration(
                labelText: '來源類型 *',
                border: OutlineInputBorder(),
              ),
              items: _sourceTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() => _sourceType = value ?? '其他');
              },
            ),
            if (_sourceType != '自採') ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _supplierNameController,
                decoration: InputDecoration(
                  labelText: _sourceType == '農會' ? '農會名稱' :
                             _sourceType == '其他農友' ? '農友名稱' :
                             _sourceType == '花苞商' ? '花苞商名稱' : '供應商名稱',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _supplierContactController,
                decoration: const InputDecoration(
                  labelText: '聯絡方式（可選）',
                  border: OutlineInputBorder(),
                  hintText: '電話或地址',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSelfHarvestSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.eco, color: Colors.green[700]),
                const SizedBox(width: 8),
                Text('自採資訊', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _harvestDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _harvestDate = date);
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: '採收日期',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _harvestDate != null
                    ? DateFormat('yyyy/MM/dd').format(_harvestDate!)
                    : '選擇採收日期',
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _coldStorageStartDate ?? _harvestDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _coldStorageStartDate = date);
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: '冷藏開始日期',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _coldStorageStartDate != null
                    ? DateFormat('yyyy/MM/dd').format(_coldStorageStartDate!)
                    : '選擇冷藏開始日期',
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _coldStorageDaysController,
              decoration: const InputDecoration(
                labelText: '冷藏天數',
                border: OutlineInputBorder(),
                suffixText: '天',
                hintText: '或系統自動計算',
              ),
              keyboardType: TextInputType.number,
            ),
            if (_coldStorageStartDate != null) ...[
              const SizedBox(height: 8),
              Text(
                '自動計算: ${_deliveryDate.difference(_coldStorageStartDate!).inDays} 天',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPriceQualitySection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.attach_money, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text('價格與品質', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _unitPriceController,
                    decoration: const InputDecoration(
                      labelText: '單價（可選）',
                      border: OutlineInputBorder(),
                      prefixText: '\$ ',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _totalPriceController,
                    decoration: const InputDecoration(
                      labelText: '總價（可選）',
                      border: OutlineInputBorder(),
                      prefixText: '\$ ',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _qualityRating,
              decoration: const InputDecoration(
                labelText: '品質評級（可選）',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('未評級')),
                ..._qualityOptions.map((quality) {
                  return DropdownMenuItem(value: quality, child: Text(quality));
                }),
              ],
              onChanged: (value) {
                setState(() => _qualityRating = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.note_alt, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text('備註', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: '備註內容（可選）',
                border: OutlineInputBorder(),
                hintText: '記錄特殊資訊',
              ),
              maxLines: 3,
              minLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveBatch() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);

    // 計算冷藏天數（如果是自採且有設定日期）
    int? coldStorageDays;
    if (_sourceType == '自採' && _coldStorageStartDate != null) {
      if (_coldStorageDaysController.text.isNotEmpty) {
        coldStorageDays = int.tryParse(_coldStorageDaysController.text);
      } else {
        coldStorageDays = _deliveryDate.difference(_coldStorageStartDate!).inDays;
      }
    }

    try {
      if (widget.existingBatch != null) {
        // 更新現有批次
        final updatedBatch = ScionBatche(
          id: widget.existingBatch!.id,
          projectId: widget.projectId,
          batchName: _batchNameController.text,
          deliveryDate: _deliveryDate,
          quantity: _quantityController.text.isEmpty ? null : int.parse(_quantityController.text),
          sourceType: _sourceType,
          supplierName: _supplierNameController.text.isEmpty ? null : _supplierNameController.text,
          supplierContact: _supplierContactController.text.isEmpty ? null : _supplierContactController.text,
          harvestDate: _harvestDate,
          coldStorageStartDate: _coldStorageStartDate,
          coldStorageDays: coldStorageDays,
          unitPrice: _unitPriceController.text.isEmpty ? null : double.parse(_unitPriceController.text),
          totalPrice: _totalPriceController.text.isEmpty ? null : double.parse(_totalPriceController.text),
          qualityRating: _qualityRating,
          notes: _notesController.text.isEmpty ? null : _notesController.text,
        );
        await db.updateScionBatch(updatedBatch);
      } else {
        // 新增批次
        await db.createScionBatch(
          ScionBatchesCompanion(
            projectId: drift.Value(widget.projectId),
            batchName: drift.Value(_batchNameController.text),
            deliveryDate: drift.Value(_deliveryDate),
            quantity: _quantityController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(int.parse(_quantityController.text)),
            sourceType: drift.Value(_sourceType),
            supplierName: _supplierNameController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(_supplierNameController.text),
            supplierContact: _supplierContactController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(_supplierContactController.text),
            harvestDate: _harvestDate == null
              ? const drift.Value.absent()
              : drift.Value(_harvestDate),
            coldStorageStartDate: _coldStorageStartDate == null
              ? const drift.Value.absent()
              : drift.Value(_coldStorageStartDate),
            coldStorageDays: coldStorageDays == null
              ? const drift.Value.absent()
              : drift.Value(coldStorageDays),
            unitPrice: _unitPriceController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(double.parse(_unitPriceController.text)),
            totalPrice: _totalPriceController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(double.parse(_totalPriceController.text)),
            qualityRating: _qualityRating == null
              ? const drift.Value.absent()
              : drift.Value(_qualityRating),
            notes: _notesController.text.isEmpty
              ? const drift.Value.absent()
              : drift.Value(_notesController.text),
          ),
        );
      }

      ref.invalidate(scionBatchesProvider);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.existingBatch == null ? '批次已新增' : '批次已更新')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('儲存失敗: $e')),
        );
      }
    }
  }
}
