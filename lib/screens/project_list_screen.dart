import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../data/database/database.dart';
import '../providers/database_provider.dart';

class ProjectListScreen extends ConsumerWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('專案管理'),
      ),
      body: projectsAsync.when(
        data: (projects) {
          if (projects.isEmpty) {
            return const Center(
              child: Text('尚無專案'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              final currentProjectId = ref.watch(currentProjectIdProvider);
              final isSelected = project.id == currentProjectId;

              return Dismissible(
                key: Key('project_${project.id}'),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  return await _confirmDeleteDialog(context, project);
                },
                onDismissed: (direction) async {
                  await _performDelete(ref, project);
                },
                background: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      ref.read(currentProjectIdProvider.notifier).state = project.id;
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.eco,
                            color: isSelected ? Theme.of(context).colorScheme.primary : null,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${project.year} 年度 - ${project.variety}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '嫁接: \$${project.wageGraft.toStringAsFixed(0)} / 套袋: \$${project.wageBag.toStringAsFixed(0)}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                                onPressed: () => _showEditProjectDialog(context, ref, project),
                                tooltip: '編輯專案',
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateProjectDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<bool?> _confirmDeleteDialog(BuildContext context, Project project) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('確認刪除'),
        content: Text(
          '確定要刪除 ${project.year} 年度 - ${project.variety} 專案嗎？\n\n'
          '警告：此操作將刪除所有相關的日誌、花苞批次等資料，且無法恢復！',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('刪除'),
          ),
        ],
      );
    },
  );
}

Future<void> _performDelete(WidgetRef ref, Project project) async {
  try {
    final db = ref.read(databaseProvider);

    // Delete all related data
    final logs = await db.getLogsForProject(project.id);
    for (final log in logs) {
      await db.deleteActionsForLog(log.id);
      await db.deleteStatusForLog(log.id);
      await db.deleteDailyLog(log.id);
    }

    final batches = await db.getBatchesForProject(project.id);
    for (final batch in batches) {
      await db.deleteScionBatch(batch.id);
    }

    final settings = await db.getReminderSettings(project.id);
    if (settings != null) {
      await db.deleteReminderSettings(settings.id);
    }

    // Delete project
    await db.delete(db.projects).delete(project);

    // Update current project
    final currentProjectId = ref.read(currentProjectIdProvider);
    if (currentProjectId == project.id) {
      final remainingProjects = await db.getAllProjects();
      ref.read(currentProjectIdProvider.notifier).state =
          remainingProjects.isEmpty ? null : remainingProjects.first.id;
    }

    ref.invalidate(projectsProvider);
  } catch (e) {
    debugPrint('Error deleting project: $e');
  }
}

void _showEditProjectDialog(BuildContext context, WidgetRef ref, Project project) {
  final yearController = TextEditingController(text: project.year.toString());
  final varietyController = TextEditingController(text: project.variety);
  final wageGraftController = TextEditingController(text: project.wageGraft.toStringAsFixed(0));
  final wageBagController = TextEditingController(text: project.wageBag.toStringAsFixed(0));

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('編輯專案'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: '年度',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: varietyController,
              decoration: const InputDecoration(
                labelText: '品種',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: wageGraftController,
              decoration: const InputDecoration(
                labelText: '嫁接工日薪',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: wageBagController,
              decoration: const InputDecoration(
                labelText: '套袋工日薪',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () async {
            final db = ref.read(databaseProvider);

            final updatedProject = project.copyWith(
              year: int.parse(yearController.text),
              variety: varietyController.text,
              wageGraft: double.parse(wageGraftController.text),
              wageBag: double.parse(wageBagController.text),
            );

            await db.updateProject(updatedProject);
            ref.invalidate(projectsProvider);

            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('專案已更新'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: const Text('儲存'),
        ),
      ],
    ),
  );
}

void _showCreateProjectDialog(BuildContext context, WidgetRef ref) {
  final yearController = TextEditingController(text: '2026');
  final varietyController = TextEditingController(text: '甘露');
  final wageGraftController = TextEditingController(text: '1800');
  final wageBagController = TextEditingController(text: '1600');

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('建立新專案'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: '年度',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: varietyController,
              decoration: const InputDecoration(
                labelText: '品種',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: wageGraftController,
              decoration: const InputDecoration(
                labelText: '嫁接工日薪',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: wageBagController,
              decoration: const InputDecoration(
                labelText: '套袋工日薪',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () async {
            final db = ref.read(databaseProvider);

            final projectId = await db.createProject(
              ProjectsCompanion(
                year: drift.Value(int.parse(yearController.text)),
                variety: drift.Value(varietyController.text),
                wageGraft: drift.Value(double.parse(wageGraftController.text)),
                wageBag: drift.Value(double.parse(wageBagController.text)),
              ),
            );

            ref.invalidate(projectsProvider);
            ref.read(currentProjectIdProvider.notifier).state = projectId;

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text('建立'),
        ),
      ],
    ),
  );
}
