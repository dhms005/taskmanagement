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
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: isDarkMode.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   primaryColor: AppColors.mainColor,
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: AppColors.mainColor, // AppBar color
      //     foregroundColor: AppColors.mainWhiteColor, // Text & icon color
      //     elevation: 2, // Shadow effect
      //
      //   ),
      //   useMaterial3: true,
      // ),
    );
  }
}
