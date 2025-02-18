import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/task_model.dart';
import 'package:taskmanagement/utils/appStrings.dart';
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

    return screenWidth < 600 // If the screen width is less than 600px (mobile)
        ? _buildMobileView(tasks, context, ref, selectedTask)
        : _buildTabletView(tasks, context, ref, selectedTask);
  }

  // Mobile View: A simple list of tasks
  Widget _buildMobileView(List<Task> tasks, BuildContext context, WidgetRef ref,
      Task? selectedTask) {
    return tasks.isEmpty
        ? EmptyTask()
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTaskScreen(task: task),
                      ),
                    );
                    ref.read(selectedTaskProvider.notifier).selectTask(task);
                  },
                  child: TaskItem(task: task, context: context, ref: ref));
            },
          );
  }

  // Tablet View: Split view with list and details side-by-side
  Widget _buildTabletView(List<Task> tasks, BuildContext context, WidgetRef ref,
      Task? selectedTask) {
    return Row(
      children: [
        // Task List
        Expanded(
          flex: 2,
          child: tasks.isEmpty
              ? EmptyTask()
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return GestureDetector(
                        onTap: () {
                          ref
                              .read(selectedTaskProvider.notifier)
                              .selectTask(task);
                        },
                        child:
                            TaskItem(task: task, context: context, ref: ref));
                  },
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
                    fontSize: 16,
                  ))
                : EditTaskScreen(
                    key: ValueKey(selectedTask.id), task: selectedTask),
          ),
        ),
      ],
    );
  }
}
