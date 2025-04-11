import 'package:flutter/material.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/gen/fonts.gen.dart';

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
