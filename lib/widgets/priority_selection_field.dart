import 'package:flutter/material.dart';
import 'package:taskmanagement/utils/appColors.dart';
import 'package:taskmanagement/utils/appStrings.dart';


/// UI for Select Priority
class PrioritySelectionField extends StatefulWidget {
  final TextEditingController controller;

  const PrioritySelectionField({required this.controller});

  @override
  _PrioritySelectionFieldState createState() => _PrioritySelectionFieldState();
}

class _PrioritySelectionFieldState extends State<PrioritySelectionField> {
  ///  UI for Show Role Dialog
  void _showPriorityBottomSheet() async {
    String? selectedRole = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: AppStrings.priorityTask.map((role) {
            return Container(
              // color: AppColors.mainBgColor,
              margin: EdgeInsets.only(bottom: 0.7),
              child: Container(
                // color: AppColors.mainWhiteColor,
                child: ListTile(
                  title: Text(
                    role,
                    textAlign: TextAlign.center,
                    // fontSize: 16,
                  ),
                  onTap: () => Navigator.pop(context, role),
                ),
              ),
            );
          }).toList(),
        );
      },
    );

    if (selectedRole != null) {
      setState(() {
        widget.controller.text = selectedRole;

        // if (selectedRole == AppStrings.priorityTask[0]) {
        //   widget.controller.text = "1";
        // } else if (selectedRole == AppStrings.priorityTask[1]) {
        //   widget.controller.text = "2";
        // } else {
        //   widget.controller.text = "3";
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPriorityBottomSheet,
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: 'Select Priority:',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5), // Rounded corners
              borderSide: const BorderSide(
                  color: AppColors.editTextBorderColor, width: 1),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(9), // Adjust padding if needed
              child: Icon(
                Icons.low_priority,
              ),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.all(9), // Adjust padding if needed
              child: Icon(
                Icons.arrow_drop_down,
              ),
            ),
            // contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          ),
          validator: (value) =>
              value!.isEmpty ? AppStrings.selectPriority : null,
        ),
      ),
    );
  }
}
