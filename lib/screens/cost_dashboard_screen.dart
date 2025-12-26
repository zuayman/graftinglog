import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/database.dart';
import '../providers/database_provider.dart';
import 'budget_settings_screen.dart';

class CostDashboardScreen extends ConsumerWidget {
  final int projectId;

  const CostDashboardScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('成本儀表板'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BudgetSettingsScreen(projectId: projectId),
                ),
              );
            },
            tooltip: '預算設定',
          ),
        ],
      ),
      body: FutureBuilder<(Map<String, double>, Project)>(
        future: Future.wait([
          db.getCostStatistics(projectId),
          db.getProject(projectId),
        ]).then((results) => (results[0] as Map<String, double>, results[1] as Project)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('錯誤: ${snapshot.error}'));
          }

          final (stats, project) = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Budget Progress Card (if budget is set)
                if (project.budgetLimit != null) ...[
                  _buildBudgetProgressCard(context, stats, project),
                  const SizedBox(height: 16),
                ],
                _buildTotalCostCard(context, stats),
                const SizedBox(height: 16),
                _buildCostBreakdownCard(context, stats),
                const SizedBox(height: 16),
                _buildAverageCostCard(context, stats),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTotalCostCard(BuildContext context, Map<String, double> stats) {
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
              '專案總成本',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              '\$${stats['totalCost']!.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '累計至今',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostBreakdownCard(BuildContext context, Map<String, double> stats) {
    final totalLaborCost = stats['totalLaborCost']!;
    final totalMaterialCost = stats['totalMaterialCost']!;
    final totalCost = stats['totalCost']!;

    final laborPercentage = totalCost > 0 ? (totalLaborCost / totalCost * 100) : 0.0;
    final materialPercentage = totalCost > 0 ? (totalMaterialCost / totalCost * 100) : 0.0;

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
              '成本組成',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            _buildCostRow(
              context,
              icon: Icons.person,
              label: '人工成本',
              amount: totalLaborCost,
              percentage: laborPercentage,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildCostRow(
              context,
              icon: Icons.inventory,
              label: '材料成本',
              amount: totalMaterialCost,
              percentage: materialPercentage,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.analytics, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      '總計',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Text(
                  '\$${totalCost.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required double amount,
    required double percentage,
    required Color color,
  }) {
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
              '\$${amount.toStringAsFixed(0)}',
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

  Widget _buildAverageCostCard(BuildContext context, Map<String, double> stats) {
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
              '平均成本',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildAverageRow(
              context,
              icon: Icons.calendar_today,
              label: '每日平均',
              amount: stats['averageDailyCost']!,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            _buildAverageRow(
              context,
              icon: Icons.person_outline,
              label: '每日人工平均',
              amount: stats['averageLaborCost']!,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildAverageRow(
              context,
              icon: Icons.inventory_outlined,
              label: '每日材料平均',
              amount: stats['averageMaterialCost']!,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAverageRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required double amount,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetProgressCard(BuildContext context, Map<String, double> stats, Project project) {
    final totalCost = stats['totalCost']!;
    final budgetLimit = project.budgetLimit!;
    final budgetUsagePercentage = (totalCost / budgetLimit * 100).clamp(0, 100);
    final remainingBudget = budgetLimit - totalCost;
    final isOverBudget = totalCost > budgetLimit;
    final isNearingLimit = project.budgetAlertEnabled &&
                           budgetUsagePercentage >= (project.budgetAlertThreshold * 100);

    Color progressColor;
    if (isOverBudget) {
      progressColor = Colors.red;
    } else if (isNearingLimit) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.green;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isOverBudget ? Icons.warning_amber : Icons.account_balance_wallet,
                  color: progressColor,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '預算使用狀況',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (isOverBudget)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '超支',
                      style: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                else if (isNearingLimit)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '警告',
                      style: TextStyle(
                        color: Colors.orange[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (budgetUsagePercentage / 100).clamp(0, 1),
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                minHeight: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Budget Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '已使用',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${totalCost.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: progressColor,
                          ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '使用比例',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${budgetUsagePercentage.toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: progressColor,
                          ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isOverBudget ? '超支金額' : '剩餘預算',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${remainingBudget.abs().toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isOverBudget ? Colors.red : Colors.green,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Budget Limit
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '預算上限',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '\$${budgetLimit.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
