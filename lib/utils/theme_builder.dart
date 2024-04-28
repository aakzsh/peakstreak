import 'package:flutter/material.dart';
import 'package:peakstreak/constants/colors.dart';

ThemeData buildTheme(brightness) {
  var baseTheme = ThemeData(
    brightness: brightness,
    fontFamily: "KronaOne",
    colorScheme:const ColorScheme.dark(background: AppColors.bg),
    scaffoldBackgroundColor: AppColors.bg,
    primarySwatch: Colors.red,
  );
  return baseTheme.copyWith();
}
