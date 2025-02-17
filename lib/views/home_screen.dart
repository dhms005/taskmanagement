import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/viewmodels/user_preferences_provider.dart';
import 'package:taskmanagement/views/add_task_screen.dart';
import 'package:taskmanagement/views/edit_task_screen.dart';
import 'package:taskmanagement/views/settings_screen.dart';
import 'package:taskmanagement/widgets/task_list.dart';

import '../models/task_model.dart';
import '../viewmodels/task_provider.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final tasks = ref.watch(taskProvider);

    // Get screen width to differentiate between mobile and tablet.
    double screenWidth = MediaQuery.of(context).size.width;

    final tasks = ref.watch(taskProvider);
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
        title: Text('Task Manager'),
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
      body: screenWidth < 600 // If the screen width is less than 600px (mobile)
          ? _buildMobileView(tasksToDisplay, context, ref)
          : _buildTabletView(tasksToDisplay, context, ref),
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

  // Mobile View: A simple list of tasks
  Widget _buildMobileView(
      List<Task> tasks, BuildContext context, WidgetRef ref) {
    return TaskList(tasks: tasks, context: context, ref: ref);
  }

  // Tablet View: Split view with list and details side-by-side
  Widget _buildTabletView(
      List<Task> tasks, BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        // Task List
        Expanded(
          flex: 2,
          child: TaskList(tasks: tasks, context: context, ref: ref),
        ),
        // Divider between the task list and task details
        VerticalDivider(width: 1),
        // Task Details (This could be a placeholder or actual details)
        Expanded(
          flex: 3,
          child: Center(
            child: Text("Select a task to view details."),
          ),
        ),
      ],
    );
  }
}
