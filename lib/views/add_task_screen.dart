import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/viewmodels/task_provider.dart';
import 'package:taskmanagement/models/task_model.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int _priority = 1; // Default priority

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            ListTile(
              title: Text("Due Date: ${_selectedDate.toLocal().toString().split(' ')[0]}"),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            ListTile(
              title: Text("Due Time: ${_selectedDate.toLocal().toString().split(' ')[1]}"),
              trailing: Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            DropdownButton<int>(
              value: _priority,
              onChanged: (int? newValue) {
                setState(() {
                  _priority = newValue!;
                });
              },
              items: [1, 2, 3].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('Priority $value'),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: _selectedDate,  // Store both date and time
                  priority: _priority,
                );

                ref.read(taskProvider.notifier).addTask(newTask);
                Navigator.pop(context);
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }

  _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
}
