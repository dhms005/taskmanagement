import 'package:intl/intl.dart';

class AppStrings {

  static const String save = "Save";
  static const String cancel = "Cancel";
  static const String selectPriority = "Please Select Priority";
  static const String saveTask = "Save Task";
  static const String addTask = "Add Task";
  static const String title = "Title";
  static const String pleaseEnterTaskTitle = "Please enter task title";
  static const String description = "Description";
  static const String dueDate = "Due Date";
  static const String dueTime = "Due Time";
  static const String deleteTask = "Delete Task";
  static const String saveChanges = "Save Changes";
  static const String editTask = "Edit Task";
  static const String taskList = "Task List";
  static const String noTasksAvailable = "No tasks available";
  static const String noTasksFind = "No tasks found matching your search criteria.";
  static const String selectATaskToViewDetails = "Select a task to view details";
  static const String searchTasks = "Search Tasks";
  static const String taskHasBeenDeleted = "Task Has Been Deleted";
  static const String undo = "Undo";

  static DateFormat dateFormatFull = DateFormat('d MMM yyyy, hh:mm a');
  static DateFormat dateFormatOnlyDate = DateFormat('d MMM yyyy');
  static DateFormat dateFormatOnlyTime = DateFormat('hh:mm a');

  static const List<String> priorityTask = [
    "Low",
    "Medium",
    "High",
  ];

  static int getPriorityValue(String priority) {
    switch (priority) {
      case 'Low':
        return 3;
      case 'Medium':
        return 2;
      case 'High':
        return 1;
      default:
        return 1; // Default to Low if unknown
    }
  }

  static String getPriorityText(int value) {
    switch (value) {
      case 3:
        return 'Low';
      case 2:
        return 'Medium';
      case 1:
        return 'High';
      default:
        return 'Low';
    }
  }

}
