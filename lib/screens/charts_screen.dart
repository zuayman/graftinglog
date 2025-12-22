import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/database_provider.dart';

class ChartsScreen extends ConsumerWidget {
  final int projectId;

  const ChartsScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('視覺化圖表'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCostTrendChart(context, ref),
          const SizedBox(height: 24),
          _buildActionDistributionChart(context, ref),
          const SizedBox(height: 24),
          _buildDailyCostComparisonChart(context, ref),
        ],
      ),
    );
  }

  Widget _buildCostTrendChart(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(projectDailyLogsProvider(projectId));

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
                Icon(Icons.trending_up, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '成本趨勢',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '每日總成本變化趨勢',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),
            logsAsync.when(
              data: (logs) {
                if (logs.isEmpty) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text('尚無資料'),
                    ),
                  );
                }

                final sortedLogs = logs.toList()
                  ..sort((a, b) => a.dayNumber.compareTo(b.dayNumber));

                return SizedBox(
                  height: 250,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 1000,
                        verticalInterval: 1,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              if (value.toInt() < sortedLogs.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'D${sortedLogs[value.toInt()].dayNumber}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text(
                                '\$${value.toInt()}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      minX: 0,
                      maxX: (sortedLogs.length - 1).toDouble(),
                      minY: 0,
                      maxY: _calculateMaxY(sortedLogs.map((l) => l.totalCost).toList()),
                      lineBarsData: [
                        // Total Cost Line
                        LineChartBarData(
                          spots: sortedLogs.asMap().entries.map((entry) {
                            return FlSpot(
                              entry.key.toDouble(),
                              entry.value.totalCost,
                            );
                          }).toList(),
                          isCurved: true,
                          color: Theme.of(context).colorScheme.primary,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Theme.of(context).colorScheme.primary,
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color(0x1A2196F3), // Blue with 10% opacity
                          ),
                        ),
                        // Labor Cost Line
                        LineChartBarData(
                          spots: sortedLogs.asMap().entries.map((entry) {
                            return FlSpot(
                              entry.key.toDouble(),
                              entry.value.laborCost,
                            );
                          }).toList(),
                          isCurved: true,
                          color: Colors.orange,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          dashArray: [5, 5],
                        ),
                        // Material Cost Line
                        LineChartBarData(
                          spots: sortedLogs.asMap().entries.map((entry) {
                            return FlSpot(
                              entry.key.toDouble(),
                              entry.value.materialCost,
                            );
                          }).toList(),
                          isCurved: true,
                          color: Colors.green,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          dashArray: [5, 5],
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const SizedBox(
                height: 250,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => SizedBox(
                height: 250,
                child: Center(child: Text('載入失敗: $error')),
              ),
            ),
            const SizedBox(height: 16),
            _buildChartLegend(context),
          ],
        ),
      ),
    );
  }

  Widget _buildChartLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(context, '總成本', Theme.of(context).colorScheme.primary, solid: true),
        const SizedBox(width: 16),
        _buildLegendItem(context, '人工成本', Colors.orange),
        const SizedBox(width: 16),
        _buildLegendItem(context, '材料成本', Colors.green),
      ],
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color, {bool solid = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: solid ? 3 : 2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildActionDistributionChart(BuildContext context, WidgetRef ref) {
    final db = ref.read(databaseProvider);

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
                Icon(Icons.pie_chart, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '施作項目分布',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '各類施作項目使用次數統計',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),
            FutureBuilder<Map<String, int>>(
              future: db.getActionDistribution(projectId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                    height: 250,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final distribution = snapshot.data!;
                if (distribution.isEmpty) {
                  return const SizedBox(
                    height: 250,
                    child: Center(child: Text('尚無資料')),
                  );
                }

                final total = distribution.values.reduce((a, b) => a + b);
                final colors = [
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                  Colors.purple,
                  Colors.red,
                  Colors.teal,
                ];

                return SizedBox(
                  height: 250,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                            sections: distribution.entries.toList().asMap().entries.map((entry) {
                              final index = entry.key;
                              final mapEntry = entry.value;
                              final percentage = (mapEntry.value / total * 100);

                              return PieChartSectionData(
                                color: colors[index % colors.length],
                                value: mapEntry.value.toDouble(),
                                title: '${percentage.toStringAsFixed(1)}%',
                                radius: 60,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: distribution.entries.toList().asMap().entries.map((entry) {
                            final index = entry.key;
                            final mapEntry = entry.value;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: colors[index % colors.length],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${mapEntry.key} (${mapEntry.value})',
                                      style: Theme.of(context).textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyCostComparisonChart(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(projectDailyLogsProvider(projectId));

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
                Icon(Icons.bar_chart, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '每日成本比較',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '人工與材料成本對比',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),
            logsAsync.when(
              data: (logs) {
                if (logs.isEmpty) {
                  return const SizedBox(
                    height: 250,
                    child: Center(child: Text('尚無資料')),
                  );
                }

                final sortedLogs = logs.toList()
                  ..sort((a, b) => a.dayNumber.compareTo(b.dayNumber));

                return SizedBox(
                  height: 250,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _calculateMaxY(
                        sortedLogs.map((l) => l.laborCost > l.materialCost ? l.laborCost : l.materialCost).toList(),
                      ),
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              if (value.toInt() < sortedLogs.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'D${sortedLogs[value.toInt()].dayNumber}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text(
                                '\$${value.toInt()}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      barGroups: sortedLogs.asMap().entries.map((entry) {
                        return BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.laborCost,
                              color: Colors.orange,
                              width: 12,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                            BarChartRodData(
                              toY: entry.value.materialCost,
                              color: Colors.green,
                              width: 12,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
              loading: () => const SizedBox(
                height: 250,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => SizedBox(
                height: 250,
                child: Center(child: Text('載入失敗: $error')),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(context, '人工成本', Colors.orange, solid: true),
                const SizedBox(width: 16),
                _buildLegendItem(context, '材料成本', Colors.green, solid: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateMaxY(List<double> values) {
    if (values.isEmpty) return 10;
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final roundedMax = ((maxValue / 1000).ceil() * 1000).toDouble();
    return roundedMax > 0 ? roundedMax : 100;
  }
}
