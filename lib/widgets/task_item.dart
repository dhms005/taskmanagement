import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/task_model.dart';
import 'package:taskmanagement/utils/appColors.dart';
import 'package:taskmanagement/utils/appStrings.dart';
import 'package:taskmanagement/viewmodels/task_provider.dart';
import 'package:taskmanagement/viewmodels/user_preferences_provider.dart';
import 'package:taskmanagement/widgets/textRobotoFont.dart';
import 'package:taskmanagement/widgets/textRobotoFontColor.dart';

class TaskItem extends StatelessWidget {
  Task task;
  BuildContext context;
  WidgetRef ref;

  TaskItem(
      {super.key,
      required this.task,
      required this.context,
      required this.ref});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(userPreferencesProvider);

    return Dismissible(
      key: Key(task.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(14), // Adjust padding if needed
          child: Icon(Icons.delete),
        ),
      ),
      onDismissed: (direction) {
        ref.read(taskProvider.notifier).deleteTask(task.id!);

        // BlocProvider.of<EmployeeBloc>(context).add(DeleteEmployee(employee.id));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextRobotoFont(
              title: AppStrings.taskHasBeenDeleted,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
            action: SnackBarAction(
              label: AppStrings.undo,
              onPressed: () {
                ref.read(taskProvider.notifier).addTask(task);
              },
            ),
            duration: Duration(seconds: 3),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        // color: AppColors.mainWhiteColor,
        decoration: BoxDecoration(
          color: isDarkMode.isDarkMode
              ? AppColors.mainBlackColor
              : AppColors.mainWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        child: Stack(
          children: [
            // Left priority indicator
            Positioned(
              left: 0,
              top: 8,
              bottom: 8,
              child: Container(
                width: 6,
                decoration: BoxDecoration(
                  color: AppColors.getPriorityColor(task.priority),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Task Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextRobotoFontColor(
                            title: task.title,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontColor: isDarkMode.isDarkMode
                                ? AppColors.mainWhiteColor
                                : AppColors.mainBlackColor,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                          TextRobotoFontColor(
                            title: task.description,
                            fontColor: Colors.grey,
                            fontSize: 14,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              TextRobotoFontColor(
                                title:
                                    "${AppStrings.dateFormatOnlyDate.format(task.date)}",
                                fontColor: Colors.grey,
                                fontSize: 14,
                              ),
                              SizedBox(width: 8),
                              TextRobotoFontColor(
                                title:
                                    "${AppStrings.dateFormatOnlyTime.format(task.date)}",
                                fontColor: Colors.grey,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 8),

                    // Check Icon
                    GestureDetector(
                      onTap: () {
                        // task.isCompleted
                        bool taskIsCompleted = !task.isCompleted;
                        ref.read(taskProvider.notifier).updateTask(
                              Task(
                                  id: task.id,
                                  title: task.title,
                                  description: task.description,
                                  isCompleted: taskIsCompleted,
                                  date: task.date,
                                  priority: task.priority),
                            );
                      },
                      child: Icon(
                        Icons.check_circle,
                        color: task.isCompleted
                            ? Colors.blue
                            : Colors.grey.shade300,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
