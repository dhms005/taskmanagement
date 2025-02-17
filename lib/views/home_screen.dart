import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/viewmodels/user_preferences_provider.dart';
import 'package:taskmanagement/views/add_task_screen.dart';
import 'package:taskmanagement/views/edit_task_screen.dart';
import 'package:taskmanagement/views/settings_screen.dart';

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
    List tasksToDisplay = [...tasks];
    if (userPreferences.sortOrder == 'byDate') {
      tasksToDisplay.sort((a, b) => a.date.compareTo(b.date));
    } else if (userPreferences.sortOrder == 'byPriority') {
      tasksToDisplay.sort((a, b) => a.priority.compareTo(b.priority));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Task Manager'),actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
      ],),
      body: screenWidth < 600 // If the screen width is less than 600px (mobile)
          ? _buildMobileView(tasks, context, ref)
          : _buildTabletView(tasks, context, ref),
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
  Widget _buildMobileView(List<Task> tasks, BuildContext context, WidgetRef ref) {
    return tasks.isEmpty
        ? Center(child: Text("No tasks available"))
        : ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.description),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              ref.read(taskProvider.notifier).updateTask(
                Task(
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    isCompleted: value!,
                    date: task.date,
                    priority: task.priority
                ),
              );
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: task),
              ),
            );
          },
        );
      },
    );
  }

  // Tablet View: Split view with list and details side-by-side
  Widget _buildTabletView(List<Task> tasks, BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        // Task List
        Expanded(
          flex: 2,
          child: tasks.isEmpty
              ? Center(child: Text("No tasks available"))
              : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    ref.read(taskProvider.notifier).updateTask(
                      Task(
                          id: task.id,
                          title: task.title,
                          description: task.description,
                          isCompleted: value!,
                          date: task.date,
                          priority: task.priority
                      ),
                    );
                  },
                ),
                onTap: () {
                  // If a task is clicked on tablet, show details on the right
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(task: task),
                    ),
                  );
                },
              );
            },
          ),
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
