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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${project.year} 年度 - ${project.variety}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('嫁接工資: \$${project.wageGraft.toStringAsFixed(0)}'),
                        const SizedBox(width: 24),
                        Text('套袋工資: \$${project.wageBag.toStringAsFixed(0)}'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CostDashboardScreen(projectId: project.id),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.analytics, size: 20),
                    label: const Text('成本'),
                  ),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatisticsScreen(projectId: project.id),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.insights, size: 20),
                    label: const Text('統計'),
                  ),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChartsScreen(projectId: project.id),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.bar_chart, size: 20),
                    label: const Text('圖表'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
