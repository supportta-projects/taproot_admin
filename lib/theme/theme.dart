import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    dataTableTheme: DataTableThemeData(
      dataRowHeight: 50,
      headingRowHeight: 50,
      columnSpacing: 20,
      horizontalMargin: 10,
      // showBottomBorder: true,
      headingTextStyle: TextStyle(
        color: CustomColors.textColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      dataTextStyle: TextStyle(
        color: CustomColors.textColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    fontFamily: FontFamily.inter,
    scaffoldBackgroundColor: CustomColors.backgroundColor,
    hoverColor: CustomColors.hoverColor,
    primaryColor: CustomColors.primaryColor,

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
