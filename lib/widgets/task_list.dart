import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/task_model.dart';
import 'package:taskmanagement/utils/appColors.dart';
import 'package:taskmanagement/utils/appStrings.dart';
import 'package:taskmanagement/viewmodels/search_provider.dart';
import 'package:taskmanagement/viewmodels/selected_task_provider.dart';
import 'package:taskmanagement/views/edit_task_screen.dart';
import 'package:taskmanagement/widgets/empty_task.dart';
import 'package:taskmanagement/widgets/task_item.dart';
import 'package:taskmanagement/widgets/textRobotoFont.dart';

class TaskList extends StatelessWidget {
  List<Task> tasks;
  BuildContext context;
  WidgetRef ref;
  Task? selectedTask;

  TaskList(
      {super.key,
      required this.tasks,
      required this.context,
      required this.ref,
      this.selectedTask});

  @override
  Widget build(BuildContext context) {
    // Get screen width to differentiate between mobile and tablet.
    double screenWidth = MediaQuery.of(context).size.width;
    final searchQuery = ref.watch(searchQueryProvider);

    // Search and Filter tasks
    List<Task> tasksToDisplay = [...tasks];

    // Apply search
    if (searchQuery.isNotEmpty) {
      tasksToDisplay = tasksToDisplay
          .where((task) =>
              task.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              task.description
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    return screenWidth < 600 // If the screen width is less than 600px (mobile)
        ? _buildMobileView(
            tasksToDisplay,
            tasks,
            context,
            ref,
            selectedTask,
          )
        : _buildTabletView(tasksToDisplay, tasks, context, ref, selectedTask);
  }

  // Mobile View: A simple list of tasks
  Widget _buildMobileView(List<Task> filterTask, List<Task> tasks,
      BuildContext context, WidgetRef ref, Task? selectedTask) {
    return tasks.isEmpty
        ? EmptyTask()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: AppStrings.searchTasks,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      // Rounded corners
                      borderSide: const BorderSide(
                          color: AppColors.editTextBorderColor, width: 1),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(9), // Adjust padding if needed
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                  onChanged: (query) {
                    ref.read(searchQueryProvider.notifier).state =
                        query; // Update the search query in Riverpod
                  },
                ),
              ),
              Expanded(
                child: filterTask.isEmpty
                    ? EmptyTask(
                        title: AppStrings.noTasksFind,
                      )
                    : ListView.builder(
                        itemCount: filterTask.length,
                        itemBuilder: (context, index) {
                          final task = filterTask[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditTaskScreen(task: task),
                                  ),
                                );
                                ref
                                    .read(selectedTaskProvider.notifier)
                                    .selectTask(task);
                              },
                              child: TaskItem(
                                  task: task, context: context, ref: ref));
                        },
                      ),
              ),
              /// Swipe Text
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  child: TextRobotoFont(
                    title: "Swipe left to delete",
                    fontSize: 15,
                  )),
            ],
          );
  }

  // Tablet View: Split view with list and details side-by-side
  Widget _buildTabletView(List<Task> filterTask, List<Task> tasks,
      BuildContext context, WidgetRef ref, Task? selectedTask) {
    return Row(
      children: [
        // Task List
        Expanded(
          flex: 2,
          child: tasks.isEmpty
              ? EmptyTask()
              : Column(
                  children: [
                    // Search bar
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: AppStrings.searchTasks,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            // Rounded corners
                            borderSide: const BorderSide(
                                color: AppColors.editTextBorderColor, width: 1),
                          ),
                          prefixIcon: Padding(
                            padding:
                                EdgeInsets.all(9), // Adjust padding if needed
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                        onChanged: (query) {
                          ref.read(searchQueryProvider.notifier).state =
                              query; // Update the search query in Riverpod
                        },
                      ),
                    ),
                    Expanded(
                      child: filterTask.isEmpty
                          ? EmptyTask(
                              title: AppStrings.noTasksFind,
                            )
                          : ListView.builder(
                              itemCount: filterTask.length,
                              itemBuilder: (context, index) {
                                final task = filterTask[index];
                                return GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(selectedTaskProvider.notifier)
                                          .selectTask(task);
                                    },
                                    child: TaskItem(
                                        task: task,
                                        context: context,
                                        ref: ref));
                              },
                            ),
                    ),

                    /// Swipe Text
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        child: TextRobotoFont(
                          title: "Swipe left to delete",
                          fontSize: 14,
                        )),
                  ],
                ),
        ),
        // Divider between the task list and task details
        VerticalDivider(width: 1),
        // Task Details (This could be a placeholder or actual details)
        Expanded(
          flex: 3,
          child: Center(
            child: selectedTask == null
                ? Center(
                    child: TextRobotoFont(
                    title: AppStrings.selectATaskToViewDetails,
                    fontWeight: FontWeight.values[5],
                    fontSize: 14,
                  ))
                : EditTaskScreen(
                    key: ValueKey(selectedTask.id), task: selectedTask),
          ),
        ),
      ],
    );
  }
}
