import 'package:flutter/material.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import '/constants/constants.dart';
import '/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    dataTableTheme: DataTableThemeData(
      
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: [
      //     BoxShadow(
      //       color: CustomColors.textFieldBorderGrey.withOpacity(0.2),
      //       blurRadius: 5,
      //       offset: const Offset(0, 2),
      //     ),
      //   ],
      // ),
      headingRowColor: WidgetStatePropertyAll(Colors.white),
      dataRowColor: WidgetStatePropertyAll(Colors.white),
      // dataRowHeight: 50,
      // headingRowHeight: 50,
      // columnSpacing: 20,
      // horizontalMargin: 10,
      // showBottomBorder: true,
      headingTextStyle: TextStyle(
        color: CustomColors.textColor,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      ),
      dataTextStyle: TextStyle(
        color: CustomColors.textColor,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
      ),

      headingRowAlignment: MainAxisAlignment.center,
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
