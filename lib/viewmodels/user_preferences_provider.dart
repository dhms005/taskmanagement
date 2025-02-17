import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/user_preferences.dart';
import '../core/hive_storage.dart';

final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  return UserPreferencesNotifier();
});

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier() : super(UserPreferences(isDarkMode: false, sortOrder: 'byDate')) {
    _loadPreferences();
  }

  // Load both theme and sort order preferences from Hive
  Future<void> _loadPreferences() async {
    final isDarkMode = HiveStorage.getThemePreference();
    final sortOrder = HiveStorage.getSortOrderPreference();
    state = UserPreferences(isDarkMode: isDarkMode, sortOrder: sortOrder);
  }

  // Toggle theme and update state and Hive storage
  Future<void> toggleTheme() async {
    final newTheme = !state.isDarkMode;
    state = UserPreferences(isDarkMode: newTheme, sortOrder: state.sortOrder);
    await HiveStorage.setThemePreference(newTheme);
  }

  // Update sort order preference and update state and Hive storage
  Future<void> updateSortOrder(String newSortOrder) async {
    state = UserPreferences(isDarkMode: state.isDarkMode, sortOrder: newSortOrder);
    await HiveStorage.setSortOrderPreference(newSortOrder);
  }
}
