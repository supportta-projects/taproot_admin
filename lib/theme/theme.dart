import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: FontFamily.inter,

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.textFieldBorderGrey),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.textFieldBorderGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.textFieldBorderGrey),
      ),
    ),
  );
}
