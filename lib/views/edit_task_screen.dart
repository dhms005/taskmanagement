import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/task_model.dart';
import 'package:taskmanagement/utils/appColors.dart';
import 'package:taskmanagement/utils/appStrings.dart';
import 'package:taskmanagement/viewmodels/selected_task_provider.dart';
import 'package:taskmanagement/viewmodels/task_provider.dart';
import 'package:taskmanagement/widgets/priority_selection_field.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  final Task task;

  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _priorityController;
  final _formKey = GlobalKey<FormState>();

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _dateController = TextEditingController(
        text: AppStrings.dateFormatOnlyDate.format(widget.task.date));
    _timeController = TextEditingController(
        text: AppStrings.dateFormatOnlyTime.format(widget.task.date));
    _priorityController = TextEditingController(
        text: AppStrings.getPriorityText(widget.task.priority));
    _selectedDate = widget.task.date;
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width to differentiate between mobile and tablet.
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.editTask)),
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
                    value!.isEmpty ? 'Title cannot be empty' : null,
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final updatedTask = widget.task.copyWith(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            date: _selectedDate,
                            priority: AppStrings.getPriorityValue(
                                _priorityController.text),
                          );

                          await ref
                              .read(taskProvider.notifier)
                              .updateTask(updatedTask);
                          Navigator.pop(context); // Go back after saving
                        }
                      },
                      child: const Text(AppStrings.saveChanges),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        ref
                            .read(taskProvider.notifier)
                            .deleteTask(widget.task.id!);
                        ref
                            .read(selectedTaskProvider.notifier)
                            .clearSelection();
                        // Navigator.pop(context); // Go back after deletion

                        if (screenWidth < 600) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(AppStrings.deleteTask),
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
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _priorityController.dispose();
    super.dispose();
  }
}
