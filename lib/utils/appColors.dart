import 'dart:ui';

class AppColors {
  static const Color mainColor = Color(0xFF3085fe);
  static const Color mainDarkColor = Color(0xFF0E8AD7);
  static const Color disabledButtonColor = Color(0xFFa9a9a9);
  static const Color lightButtonBgColor = Color(0xFFEDF8FF);

  static const Color editTextBorderColor = Color(0xFFE5E5E5);
  static const Color editTextHintColor = Color(0xFF949C9E);


  static const Color mainWhiteColor = Color(0xFFffffff);
  static const Color mainBlackColor = Color(0xFF000000);
  static const Color mainLightRedColor = Color(0xFFf9b5c2);
  static const Color mainLightYellowColor = Color(0xFFffc774);
  static const Color mainLightGreenColor = Color(0xFF90d19e);

  static const Color mainLightBgColor = Color(0xFFf5f9fc);
  static const Color mainDarkBgColor = Color(0xFF323238);

  static Color getPriorityColor(int value) {
    switch (value) {
      case 3:
        return mainLightGreenColor;
      case 2:
        return mainLightYellowColor;
      case 1:
        return mainLightRedColor;
      default:
        return mainLightGreenColor;
    }
  }
}
