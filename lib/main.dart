import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';

void main() {
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
