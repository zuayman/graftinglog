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

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Icon(
                    Icons.eco,
                    color: isSelected ? Theme.of(context).colorScheme.primary : null,
                  ),
                  title: Text('${project.year} 年度 - ${project.variety}'),
                  subtitle: Text('嫁接: \$${project.wageGraft.toStringAsFixed(0)} / 套袋: \$${project.wageBag.toStringAsFixed(0)}'),
                  trailing: isSelected
                    ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                    : null,
                  onTap: () {
                    ref.read(currentProjectIdProvider.notifier).state = project.id;
                    Navigator.pop(context);
                  },
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
}
