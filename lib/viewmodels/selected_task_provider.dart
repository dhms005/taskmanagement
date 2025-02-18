import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';

// Use StateNotifier instead of StateProvider for better reactivity
class SelectedTaskNotifier extends StateNotifier<Task?> {
  SelectedTaskNotifier() : super(null);

  void selectTask(Task task) {
    state = task; //
    SelectedTaskNotifier();
  }

  void clearSelection() {
    state = null;
  }
}

final selectedTaskProvider =
StateNotifierProvider<SelectedTaskNotifier, Task?>((ref) {
  return SelectedTaskNotifier();
});

