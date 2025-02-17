import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/viewmodels/user_preferences_provider.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPreferences = ref.watch(userPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dark Mode Switch
            ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: userPreferences.isDarkMode,
                onChanged: (value) {
                  ref.read(userPreferencesProvider.notifier).toggleTheme();
                },
              ),
            ),
            // Sort Order Dropdown
            ListTile(
              title: const Text("Default Sort Order"),
              trailing: DropdownButton<String>(
                value: userPreferences.sortOrder,
                onChanged: (newSortOrder) {
                  if (newSortOrder != null) {
                    ref.read(userPreferencesProvider.notifier).updateSortOrder(newSortOrder);
                  }
                },
                items: <String>['byDate', 'byPriority'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'byDate' ? 'By Date' : 'By Priority'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
