import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';
import 'services/backup_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await NotificationService().initialize();

  // Perform auto backup if needed (in background)
  BackupService().autoBackupIfNeeded().catchError((error) {
    debugPrint('Auto backup error: $error');
  });

  runApp(const ProviderScope(child: GraftingLogApp()));
}

class GraftingLogApp extends StatelessWidget {
  const GraftingLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '嫁接日誌',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
