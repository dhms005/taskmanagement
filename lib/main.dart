import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/viewmodels/user_preferences_provider.dart';
import 'package:taskmanagement/views/home_screen.dart';

import 'core/hive_storage.dart';

Future<void> main() async {
  await HiveStorage.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the userPreferencesProvider to get the current theme preference
    final isDarkMode = ref.watch(userPreferencesProvider);
    return MaterialApp(
      title: 'Task Manager',
      theme: isDarkMode.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(),
    );
  }
}
