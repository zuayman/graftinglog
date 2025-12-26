import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/database_provider.dart';
import 'project_list_screen.dart';
import 'daily_log_list_screen.dart';
import 'daily_log_form_screen.dart';
import 'scion_batch_screen.dart';
import 'cost_dashboard_screen.dart';
import 'export_screen.dart';
import 'statistics_screen.dart';
import 'charts_screen.dart';
import 'reminder_settings_screen.dart';
import 'area_analysis_screen.dart';
import 'task_checklist_screen.dart';
import 'debug_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);
    final currentProjectId = ref.watch(currentProjectIdProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('嫁接日誌'),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: () {
              if (currentProjectId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TaskChecklistScreen(projectId: currentProjectId),
                  ),
                );
              }
            },
            tooltip: '作業檢查清單',
          ),
          IconButton(
            icon: const Icon(Icons.inventory_2),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScionBatchScreen()),
              );
            },
            tooltip: '花苞批次管理',
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExportScreen()),
              );
            },
            tooltip: '資料匯出',
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              if (currentProjectId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReminderSettingsScreen(projectId: currentProjectId),
                  ),
                );
              }
            },
            tooltip: '提醒設定',
          ),
          IconButton(
            icon: const Icon(Icons.build),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DebugScreen()),
              );
            },
            tooltip: '維護工具',
          ),
        ],
      ),
      body: projectsAsync.when(
        data: (projects) {
          if (projects.isEmpty) {
            return _buildEmptyState(context, ref);
          }

          if (currentProjectId == null && projects.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(currentProjectIdProvider.notifier).state = projects.first.id;
            });
          }

          return _buildProjectView(context, ref);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('錯誤: $error'),
        ),
      ),
      floatingActionButton: projectsAsync.when(
        data: (projects) {
          if (projects.isEmpty) {
            // 無專案時顯示專案管理按鈕
            return FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProjectListScreen()),
                );
              },
              icon: const Icon(Icons.folder),
              label: const Text('專案管理'),
            );
          }
          // 有專案時不顯示 FAB（由 _buildProjectView 中的 Stack 處理）
          return null;
        },
        loading: () => null,
        error: (error, stack) => null,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.eco,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            '歡迎使用嫁接日誌',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const Text('請先建立您的第一個專案'),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProjectListScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.add),
            label: const Text('建立專案'),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectView(BuildContext context, WidgetRef ref) {
    final currentProject = ref.watch(currentProjectProvider);

    return currentProject.when(
      data: (project) {
        if (project == null) {
          return const Center(child: Text('請選擇專案'));
        }

        return Stack(
          children: [
            Column(
              children: [
                _buildProjectHeader(context, project),
                Expanded(
                  child: DailyLogListScreen(projectId: project.id),
                ),
              ],
            ),
            // 新增日誌按鈕
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                heroTag: 'addLog',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DailyLogFormScreen(
                        projectId: project.id,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('錯誤: $error')),
    );
  }

  Widget _buildProjectHeader(BuildContext context, project) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 專案資訊 - 可點擊進入專案管理
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProjectListScreen()),
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${project.year} 年度 - ${project.variety}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '點擊切換專案',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.swap_horiz,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.attach_money, size: 16, color: Colors.grey[700]),
              const SizedBox(width: 4),
              Text('嫁接: \$${project.wageGraft.toStringAsFixed(0)}'),
              const SizedBox(width: 16),
              Icon(Icons.shopping_bag, size: 16, color: Colors.grey[700]),
              const SizedBox(width: 4),
              Text('套袋: \$${project.wageBag.toStringAsFixed(0)}'),
            ],
          ),
          const SizedBox(height: 16),
          // 功能按鈕網格 (2x2)
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.analytics,
                  label: '成本分析',
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CostDashboardScreen(projectId: project.id),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.insights,
                  label: '成功統計',
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatisticsScreen(projectId: project.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.bar_chart,
                  label: '趨勢圖表',
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChartsScreen(projectId: project.id),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.map,
                  label: '區域分析',
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AreaAnalysisScreen(projectId: project.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
