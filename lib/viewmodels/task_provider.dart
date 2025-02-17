import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../core/database.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final tasks = await DatabaseHelper.instance.getTasks();
    state = tasks;
  }


  Future<void> addTask(Task task) async {
    await DatabaseHelper.instance.insertTask(task);
    loadTasks(); // Refresh the list
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    await loadTasks(); // Refresh the list
  }

  Future<void> deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    await loadTasks(); // Refresh the list
  }
}
