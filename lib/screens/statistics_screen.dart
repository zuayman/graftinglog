import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/database_provider.dart';

class StatisticsScreen extends ConsumerWidget {
  final int projectId;

  const StatisticsScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('統計分析'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: db.getSuccessRateStatistics(projectId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('錯誤: ${snapshot.error}'));
          }

          final stats = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSuccessRateCard(context, stats),
                const SizedBox(height: 16),
                _buildStatusBreakdownCard(context, stats),
                const SizedBox(height: 16),
                _buildInfoCard(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuccessRateCard(BuildContext context, Map<String, dynamic> stats) {
    final successRate = stats['successRate'] as double;
    final totalGrafted = stats['totalGrafted'] as double;
    final sprouting = stats['sprouting'] as double;
    final leafing = stats['leafing'] as double;
    final successCount = sprouting + leafing;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              '整體成功率',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              '${successRate.toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '成功 ${successCount.toInt()} / 總計 ${totalGrafted.toInt()}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: successRate / 100,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  successRate >= 80
                      ? Colors.green
                      : successRate >= 60
                          ? Colors.orange
                          : Colors.red,
                ),
                minHeight: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBreakdownCard(BuildContext context, Map<String, dynamic> stats) {
    final totalGrafted = stats['totalGrafted'] as double;
    final blackHead = stats['blackHead'] as double;
    final dormant = stats['dormant'] as double;
    final sprouting = stats['sprouting'] as double;
    final leafing = stats['leafing'] as double;

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
            Text(
              '接穗狀態分布',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            _buildStatusRow(
              context,
              icon: Icons.circle,
              label: '黑頭',
              count: blackHead.toInt(),
              total: totalGrafted.toInt(),
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            _buildStatusRow(
              context,
              icon: Icons.circle,
              label: '休眠',
              count: dormant.toInt(),
              total: totalGrafted.toInt(),
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildStatusRow(
              context,
              icon: Icons.circle,
              label: '萌芽',
              count: sprouting.toInt(),
              total: totalGrafted.toInt(),
              color: Colors.lightGreen,
            ),
            const SizedBox(height: 16),
            _buildStatusRow(
              context,
              icon: Icons.circle,
              label: '展葉',
              count: leafing.toInt(),
              total: totalGrafted.toInt(),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int count,
    required int total,
    required Color color,
  }) {
    final percentage = total > 0 ? (count / total * 100) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Text(
              '$count',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: color.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 50,
              child: Text(
                '${percentage.toStringAsFixed(1)}%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
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
                '狀態記錄功能即將推出！您可以在日誌中記錄接穗的生長狀態，系統將自動計算成功率統計。',
                style: TextStyle(color: Colors.blue.shade900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
