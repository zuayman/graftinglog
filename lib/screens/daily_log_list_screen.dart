import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/database_provider.dart';
import 'daily_log_form_screen.dart';

class DailyLogListScreen extends ConsumerWidget {
  final int projectId;

  const DailyLogListScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(projectDailyLogsProvider(projectId));

    return logsAsync.when(
      data: (logs) {
        if (logs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.note_add,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                const Text('尚無嫁接日誌'),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => _navigateToForm(context, projectId),
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('建立日誌'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            final stars = log.importanceLevel;
            final hasImportance = stars > 0;

            // Visual emphasis increases with star level
            final elevation = hasImportance ? (2.0 + stars * 1.0) : 2.0;
            final borderWidth = hasImportance ? (1.0 + stars * 0.3) : 0.0;
            final Color borderColor = hasImportance
                ? (stars >= 4 ? Colors.red.shade600 : (stars >= 2 ? Colors.orange.shade600 : Colors.amber.shade600))
                : Colors.transparent;

            // Background gradient intensity based on stars
            final Color gradientStart = hasImportance
                ? (stars >= 5 ? const Color(0xFFFFEBEE) : // Red 50
                   stars >= 4 ? const Color(0xFFFFF3E0) : // Orange 50
                   stars >= 2 ? const Color(0xFFFFF8E1) : // Amber 50
                   const Color(0xFFFFFDE7))               // Yellow 50
                : Colors.white;

            return Card(
              elevation: elevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: hasImportance
                    ? BorderSide(
                        color: borderColor,
                        width: borderWidth,
                      )
                    : BorderSide.none,
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _navigateToForm(context, projectId, existingLog: log),
                child: Container(
                  decoration: hasImportance
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              gradientStart,
                              Colors.white,
                            ],
                          ),
                        )
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (hasImportance) ...[
                                  ...List.generate(
                                    stars,
                                    (i) => Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: Icon(
                                        Icons.star,
                                        color: stars >= 4
                                            ? Colors.red.shade700
                                            : (stars >= 2 ? Colors.orange.shade700 : Colors.amber.shade700),
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Text(
                                  '第 ${log.dayNumber} 日',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            Text(
                              DateFormat('yyyy/MM/dd').format(log.date),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(log.area),
                          const SizedBox(width: 16),
                          Icon(Icons.wb_sunny, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(log.weather),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.people, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text('嫁接: ${log.graftingCount}人'),
                          const SizedBox(width: 16),
                          Text('套袋: ${log.baggingCount}人'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '總成本: \$${log.totalCost.toStringAsFixed(0)}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (log.materialCost > 0) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.orange.shade300),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.inventory, size: 14, color: Colors.orange.shade700),
                                  const SizedBox(width: 4),
                                  Text(
                                    '\$${log.materialCost.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: Colors.orange.shade900,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('錯誤: $error')),
    );
  }

  void _navigateToForm(BuildContext context, int projectId, {dynamic existingLog}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DailyLogFormScreen(
          projectId: projectId,
          existingLog: existingLog,
        ),
      ),
    );
  }
}
