import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static late Box _preferencesBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _preferencesBox = await Hive.openBox('preferences');
  }

  // Get theme preference from Hive box
  static bool getThemePreference() {
    return _preferencesBox.get('isDarkMode', defaultValue: false);
  }

  // Save theme preference to Hive box
  static Future<void> setThemePreference(bool isDarkMode) async {
    await _preferencesBox.put('isDarkMode', isDarkMode);
  }

  // Get the stored sort order preference (e.g., 'byDate' or 'byPriority')
  static String getSortOrderPreference() {
    return _preferencesBox.get('sortOrder', defaultValue: 'byDate');
  }

  // Save the sort order preference
  static Future<void> setSortOrderPreference(String sortOrder) async {
    await _preferencesBox.put('sortOrder', sortOrder);
  }
}
