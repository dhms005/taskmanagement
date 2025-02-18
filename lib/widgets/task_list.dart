import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/task_model.dart';
import 'package:taskmanagement/viewmodels/task_provider.dart';
import 'package:taskmanagement/views/edit_task_screen.dart';
import 'package:taskmanagement/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  List<Task> tasks;
  BuildContext context;
  WidgetRef ref;

  TaskList(
      {super.key,
      required this.tasks,
      required this.context,
      required this.ref});

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(child: Text("No tasks available"))
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
                  },
                  child: TaskItem(task: task, context: context, ref: ref));
            },
          );
  }
}
