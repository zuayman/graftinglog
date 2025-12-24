import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/database_provider.dart';

class AreaAnalysisScreen extends ConsumerStatefulWidget {
  final int projectId;

  const AreaAnalysisScreen({
    super.key,
    required this.projectId,
  });

  @override
  ConsumerState<AreaAnalysisScreen> createState() => _AreaAnalysisScreenState();
}

class _AreaAnalysisScreenState extends ConsumerState<AreaAnalysisScreen> {
  Map<String, Map<String, dynamic>> _areaStats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAreaStatistics();
  }

  Future<void> _loadAreaStatistics() async {
    setState(() => _isLoading = true);

    final db = ref.read(databaseProvider);
    final logs = await db.getLogsForProject(widget.projectId);

    final Map<String, Map<String, dynamic>> stats = {};

    for (var log in logs) {
      final area = log.area;

      if (!stats.containsKey(area)) {
        stats[area] = {
          'totalDays': 0,
          'totalGrafting': 0,
          'totalBagging': 0,
          'totalCost': 0.0,
          'laborCost': 0.0,
          'materialCost': 0.0,
          'weatherCount': <String, int>{},
          'blackHead': 0.0,
          'dormant': 0.0,
          'sprouting': 0.0,
          'leafing': 0.0,
          'firstDate': log.date,
          'lastDate': log.date,
          'statusRecordsCount': 0,
        };
      }

      // 基本統計
      stats[area]!['totalDays'] = (stats[area]!['totalDays'] as int) + 1;
      stats[area]!['totalGrafting'] = (stats[area]!['totalGrafting'] as int) + log.graftingCount;
      stats[area]!['totalBagging'] = (stats[area]!['totalBagging'] as int) + log.baggingCount;
      stats[area]!['totalCost'] = (stats[area]!['totalCost'] as double) + log.totalCost;
      stats[area]!['laborCost'] = (stats[area]!['laborCost'] as double) + log.laborCost;
      stats[area]!['materialCost'] = (stats[area]!['materialCost'] as double) + log.materialCost;

      // 天候統計
      final weatherMap = stats[area]!['weatherCount'] as Map<String, int>;
      weatherMap[log.weather] = (weatherMap[log.weather] ?? 0) + 1;

      // 日期範圍
      if (log.date.isBefore(stats[area]!['firstDate'] as DateTime)) {
        stats[area]!['firstDate'] = log.date;
      }
      if (log.date.isAfter(stats[area]!['lastDate'] as DateTime)) {
        stats[area]!['lastDate'] = log.date;
      }

      // 接穗狀態統計
      final statuses = await db.getStatusForLog(log.id);
      if (statuses.isNotEmpty) {
        stats[area]!['statusRecordsCount'] = (stats[area]!['statusRecordsCount'] as int) + 1;

        for (var status in statuses) {
          switch (status.status) {
            case '黑頭':
              stats[area]!['blackHead'] = (stats[area]!['blackHead'] as double) + status.count;
              break;
            case '休眠':
              stats[area]!['dormant'] = (stats[area]!['dormant'] as double) + status.count;
              break;
            case '萌芽':
              stats[area]!['sprouting'] = (stats[area]!['sprouting'] as double) + status.count;
              break;
            case '展葉':
              stats[area]!['leafing'] = (stats[area]!['leafing'] as double) + status.count;
              break;
          }
        }
      }
    }

    // 計算每個區域的成功率
    for (var area in stats.keys) {
      final statusCount = stats[area]!['statusRecordsCount'] as int;
      if (statusCount > 0) {
        final sprouting = stats[area]!['sprouting'] as double;
        final leafing = stats[area]!['leafing'] as double;
        final blackHead = stats[area]!['blackHead'] as double;
        final dormant = stats[area]!['dormant'] as double;

        final total = blackHead + dormant + sprouting + leafing;
        if (total > 0) {
          stats[area]!['successRate'] = ((sprouting + leafing) / total * 100);
        } else {
          stats[area]!['successRate'] = 0.0;
        }
      } else {
        stats[area]!['successRate'] = 0.0;
      }
    }

    setState(() {
      _areaStats = stats;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('區域分析'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAreaStatistics,
            tooltip: '重新整理',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _areaStats.isEmpty
              ? const Center(
                  child: Text('尚無區域資料'),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildOverviewCard(),
                    const SizedBox(height: 16),
                    _buildTimeAnalysisSection(),
                    const SizedBox(height: 16),
                    _buildSuccessRateChart(),
                    const SizedBox(height: 16),
                    _buildWeatherDistributionChart(),
                    const SizedBox(height: 16),
                    _buildCostComparisonChart(),
                    const SizedBox(height: 16),
                    _buildDetailedStatsList(),
                  ],
                ),
    );
  }

  Widget _buildOverviewCard() {
    final totalAreas = _areaStats.length;
    final totalDays = _areaStats.values.fold<int>(
      0,
      (sum, area) => sum + (area['totalDays'] as int),
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.map, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  '區域總覽',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildOverviewItem('作業區域', '$totalAreas', '個', Colors.blue),
                _buildOverviewItem('總作業天', '$totalDays', '天', Colors.green),
                _buildOverviewItem('平均天數', '${(totalDays / totalAreas).toStringAsFixed(1)}', '天/區', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                unit,
                style: TextStyle(fontSize: 12, color: color),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSuccessRateChart() {
    // 過濾出有狀態記錄的區域
    final areasWithStatus = _areaStats.entries
        .where((e) => (e.value['statusRecordsCount'] as int) > 0)
        .toList();

    if (areasWithStatus.isEmpty) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '各區域成功率',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                '尚無接穗狀態記錄',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '各區域成功率比較',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final area = areasWithStatus[groupIndex].key;
                        return BarTooltipItem(
                          '$area\n${rod.toY.toStringAsFixed(1)}%',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= areasWithStatus.length) return const SizedBox();
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              areasWithStatus[value.toInt()].key,
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}%', style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20,
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(
                    areasWithStatus.length,
                    (index) {
                      final successRate = areasWithStatus[index].value['successRate'] as double;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: successRate,
                            color: _getSuccessRateColor(successRate),
                            width: 32,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSuccessRateColor(double rate) {
    if (rate >= 80) return Colors.green;
    if (rate >= 60) return Colors.orange;
    return Colors.red;
  }

  Widget _buildWeatherDistributionChart() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '各區域天候分布',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ..._areaStats.entries.map((entry) {
              final area = entry.key;
              final weatherMap = entry.value['weatherCount'] as Map<String, int>;
              final totalDays = entry.value['totalDays'] as int;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      area,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    ...weatherMap.entries.map((weather) {
                      final count = weather.value;
                      final percentage = (count / totalDays * 100);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Row(
                                children: [
                                  Icon(_getWeatherIcon(weather.key), size: 16, color: _getWeatherColor(weather.key)),
                                  const SizedBox(width: 4),
                                  Text(weather.key, style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: percentage / 100,
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: _getWeatherColor(weather.key),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 80,
                              child: Text(
                                '$count天 (${percentage.toStringAsFixed(0)}%)',
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(String weather) {
    switch (weather) {
      case '晴':
        return Icons.wb_sunny;
      case '陰':
        return Icons.cloud;
      case '雨':
        return Icons.umbrella;
      case '低溫':
        return Icons.ac_unit;
      default:
        return Icons.help_outline;
    }
  }

  Color _getWeatherColor(String weather) {
    switch (weather) {
      case '晴':
        return Colors.orange;
      case '陰':
        return Colors.grey;
      case '雨':
        return Colors.blue;
      case '低溫':
        return Colors.lightBlue;
      default:
        return Colors.grey;
    }
  }

  Widget _buildCostComparisonChart() {
    final areas = _areaStats.keys.toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '各區域成本比較',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final area = areas[groupIndex];
                        final type = rodIndex == 0 ? '人工' : '材料';
                        return BarTooltipItem(
                          '$area\n$type: \$${rod.toY.toStringAsFixed(0)}',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= areas.length) return const SizedBox();
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              areas[value.toInt()],
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) {
                          return Text('\$${(value / 1000).toStringAsFixed(0)}k', style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(
                    areas.length,
                    (index) {
                      final area = areas[index];
                      final laborCost = _areaStats[area]!['laborCost'] as double;
                      final materialCost = _areaStats[area]!['materialCost'] as double;

                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: laborCost,
                            color: Colors.blue,
                            width: 12,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                          BarChartRodData(
                            toY: materialCost,
                            color: Colors.orange,
                            width: 12,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(Colors.blue, '人工成本'),
                const SizedBox(width: 24),
                _buildLegendItem(Colors.orange, '材料成本'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildTimeAnalysisSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '各區域時間分析',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ..._areaStats.entries.map((entry) {
              final area = entry.key;
              final firstDate = entry.value['firstDate'] as DateTime;
              final lastDate = entry.value['lastDate'] as DateTime;
              final totalDays = entry.value['totalDays'] as int;
              final duration = lastDate.difference(firstDate).inDays + 1;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          area,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '作業 $totalDays 天',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Colors.blue.shade700),
                        const SizedBox(width: 4),
                        Text(
                          '${DateFormat('yyyy/MM/dd').format(firstDate)} - ${DateFormat('yyyy/MM/dd').format(lastDate)}',
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.timelapse, size: 16, color: Colors.blue.shade700),
                        const SizedBox(width: 4),
                        Text(
                          '期間 $duration 天',
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '作業頻率: ${(totalDays / duration * 100).toStringAsFixed(0)}%',
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedStatsList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '詳細統計資料',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ..._areaStats.entries.map((entry) {
              final area = entry.key;
              final stats = entry.value;
              final totalDays = stats['totalDays'] as int;
              final avgCost = (stats['totalCost'] as double) / totalDays;

              return ExpansionTile(
                title: Text(
                  area,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('作業 $totalDays 天 • 平均成本 \$${avgCost.toStringAsFixed(0)}/天'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildStatRow('總人工成本', '\$${(stats['laborCost'] as double).toStringAsFixed(0)}'),
                        _buildStatRow('總材料成本', '\$${(stats['materialCost'] as double).toStringAsFixed(0)}'),
                        _buildStatRow('總成本', '\$${(stats['totalCost'] as double).toStringAsFixed(0)}'),
                        const Divider(),
                        _buildStatRow('嫁接總人數', '${stats['totalGrafting']} 人'),
                        _buildStatRow('套袋總人數', '${stats['totalBagging']} 人'),
                        const Divider(),
                        if ((stats['statusRecordsCount'] as int) > 0) ...[
                          _buildStatRow('成功率', '${(stats['successRate'] as double).toStringAsFixed(1)}%'),
                          _buildStatRow('黑頭', '${(stats['blackHead'] as double).toStringAsFixed(0)}%'),
                          _buildStatRow('休眠', '${(stats['dormant'] as double).toStringAsFixed(0)}%'),
                          _buildStatRow('萌芽', '${(stats['sprouting'] as double).toStringAsFixed(0)}%'),
                          _buildStatRow('展葉', '${(stats['leafing'] as double).toStringAsFixed(0)}%'),
                        ] else
                          const Text('尚無接穗狀態記錄', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
