import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: FontFamily.inter,
    scaffoldBackgroundColor: CustomColors.backgroundColor,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: CustomColors.textColor),
      titleTextStyle: TextStyle(
        color: CustomColors.textColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

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
