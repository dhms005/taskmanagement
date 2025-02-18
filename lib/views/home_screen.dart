import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/task_model.dart';
import 'package:taskmanagement/utils/appStrings.dart';
import 'package:taskmanagement/viewmodels/selected_task_provider.dart';
import 'package:taskmanagement/viewmodels/task_provider.dart';
import 'package:taskmanagement/viewmodels/user_preferences_provider.dart';
import 'package:taskmanagement/views/add_task_screen.dart';
import 'package:taskmanagement/views/settings_screen.dart';
import 'package:taskmanagement/widgets/task_list.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tasks = ref.watch(taskProvider);
    final selectedTask = ref.watch(selectedTaskProvider);
    final userPreferences = ref.watch(userPreferencesProvider);

    // Sort tasks based on the selected sort order
    List<Task> tasksToDisplay = [...tasks];
    if (userPreferences.sortOrder == 'byDate') {
      tasksToDisplay.sort((a, b) => a.date.compareTo(b.date));
    } else if (userPreferences.sortOrder == 'byPriority') {
      tasksToDisplay.sort((a, b) => a.priority.compareTo(b.priority));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.taskList),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: TaskList(
          tasks: tasksToDisplay,
          context: context,
          ref: ref,
          selectedTask: selectedTask),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
