import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanagement/utils/appImagePath.dart';
import 'package:taskmanagement/utils/appStrings.dart';
import 'package:taskmanagement/widgets/textRobotoFont.dart';

/// 📌 UI for Empty Task
class EmptyTask extends StatelessWidget {
  final String title;

  const EmptyTask({super.key, this.title = AppStrings.noTasksAvailable});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImagePath.imgNoData,
            width: 250,
          ),
          TextRobotoFont(
            title: title,
            fontWeight: FontWeight.values[5],
            fontSize: 16,
          )
        ],
      ),
    );
  }
}
