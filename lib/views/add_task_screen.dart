import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/utils/appColors.dart';
import 'package:taskmanagement/utils/appStrings.dart';
import 'package:taskmanagement/viewmodels/task_provider.dart';
import 'package:taskmanagement/models/task_model.dart';
import 'package:taskmanagement/widgets/priority_selection_field.dart';


class AddTaskScreen extends ConsumerStatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _priorityController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addTask),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: AppStrings.title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                    borderSide: const BorderSide(
                        color: AppColors.editTextBorderColor, width: 1),
                  ),
                ),
                validator: (value) =>
                value!.isEmpty ? AppStrings.pleaseEnterTaskTitle : null,
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: AppStrings.description,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                    borderSide: const BorderSide(
                        color: AppColors.editTextBorderColor, width: 1),
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: AppStrings.dueDate,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        // Rounded corners
                        borderSide: const BorderSide(
                            color: AppColors.editTextBorderColor, width: 1),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(9), // Adjust padding if needed
                        child: Icon(
                          Icons.calendar_today,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: _pickTime,
                child: AbsorbPointer(
                  child: TextField(
                    controller: _timeController,
                    decoration: InputDecoration(
                      labelText: AppStrings.dueTime,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        // Rounded corners
                        borderSide: const BorderSide(
                            color: AppColors.editTextBorderColor, width: 1),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(9), // Adjust padding if needed
                        child: Icon(
                          Icons.access_time,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              PrioritySelectionField(controller: _priorityController),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final newTask = Task(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            date: _selectedDate, // Store both date and time
                            priority:
                                AppStrings.getPriorityValue(_priorityController.text),
                          );

                          ref.read(taskProvider.notifier).addTask(newTask);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(AppStrings.saveTask),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        _selectedDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedDate.hour,
          _selectedDate.minute,
        );

        _dateController.text =
            AppStrings.dateFormatOnlyDate.format(_selectedDate);
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

        _timeController.text =
            AppStrings.dateFormatOnlyTime.format(_selectedDate);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateController.text = AppStrings.dateFormatOnlyDate.format(_selectedDate);
    _timeController.text = AppStrings.dateFormatOnlyTime.format(_selectedDate);
    _priorityController.text = AppStrings.getPriorityText(3);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _priorityController.dispose();
    super.dispose();
  }
}
