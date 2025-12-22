import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/database.dart';

// Database Provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});

// Current Project Provider
final currentProjectIdProvider = StateProvider<int?>((ref) => null);

// Projects List Provider
final projectsProvider = FutureProvider<List<Project>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllProjects();
});

// Current Project Provider
final currentProjectProvider = FutureProvider<Project?>((ref) async {
  final db = ref.watch(databaseProvider);
  final projectId = ref.watch(currentProjectIdProvider);
  if (projectId == null) return null;
  return db.getProject(projectId);
});

// Daily Logs for Current Project Provider
final dailyLogsProvider = FutureProvider<List<DailyLog>>((ref) async {
  final db = ref.watch(databaseProvider);
  final projectId = ref.watch(currentProjectIdProvider);
  if (projectId == null) return [];
  return db.getLogsForProject(projectId);
});

// Actions for a specific log
final actionsProvider = FutureProvider.family<List<Action>, int>((ref, logId) async {
  final db = ref.watch(databaseProvider);
  return db.getActionsForLog(logId);
});

// Daily Logs for a specific project (family version)
final projectDailyLogsProvider = FutureProvider.family<List<DailyLog>, int>((ref, projectId) async {
  final db = ref.watch(databaseProvider);
  return db.getLogsForProject(projectId);
});
