import 'package:flutter/widgets.dart';
import 'package:taskmanagement/utils/appColors.dart';

class TextRobotoFont extends StatelessWidget {
  final String title;
  final bool isItalic;
  final double fontSize;
  final Color fontColor;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextDecoration decoration;

  const TextRobotoFont(
      {super.key,
      required this.title,
      this.isItalic = false,
      this.fontSize = 18,
      this.fontColor = AppColors.mainColor,
      this.textAlign = TextAlign.left,
      this.fontWeight = FontWeight.normal,
      this.decoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontFamily: 'Roboto',
        // Specify font family explicitly
        fontWeight: fontWeight,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        decoration: decoration,
      ),
      textAlign: textAlign,
    );
  }
}
