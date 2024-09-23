import 'package:flutter/material.dart';
import 'package:pankti_app/core/themes/theme_colors.dart';

class AppTheme {
  static _border([Color color = ThemeColors.fieldColor]) => OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 2),
      borderRadius: BorderRadius.circular(10));

  static final appTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: ThemeColors.whiteColor,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: _border(),
          errorBorder: _border(),
          focusedErrorBorder: _border(ThemeColors.redColor),
          focusedBorder: _border(ThemeColors.backgroundColor)));
}
