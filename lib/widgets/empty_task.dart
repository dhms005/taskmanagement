import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanagement/utils/appImagePath.dart';
import 'package:taskmanagement/utils/appStrings.dart';
import 'package:taskmanagement/widgets/textRobotoFont.dart';

/// 📌 UI for Empty Task
class EmptyTask extends StatelessWidget {
  const EmptyTask({super.key});

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
            title: AppStrings.noTasksAvailable,
            fontWeight: FontWeight.values[5],
            fontSize: 16,
          )
        ],
      ),
    );
  }
}
