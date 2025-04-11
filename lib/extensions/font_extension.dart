
import 'package:flutter/material.dart';






const String fontFamily1 = 'Lato';
extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get adaptiveTextColor => Theme.of(this).brightness == Brightness.dark
      ? Colors.white
      : Colors.black;

  TextStyle baseTextStyle(String fontFamily, FontWeight fontWeight) {




    return TextStyle(

      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: adaptiveTextColor,
    );
  }
  TextStyle get labelLarge => baseTextStyle(fontFamily1, FontWeight.w700);
  TextStyle get labelMedium => baseTextStyle(fontFamily1, FontWeight.w500);
  TextStyle get labelSmall => baseTextStyle(fontFamily1, FontWeight.w400);
  TextStyle get bodyLarge => baseTextStyle(fontFamily1, FontWeight.w700);
  TextStyle get bodyMedium => baseTextStyle(fontFamily1, FontWeight.w500);
  TextStyle get bodySmall => baseTextStyle(fontFamily1, FontWeight.w400);
  TextStyle get headlineLarge => baseTextStyle(fontFamily1, FontWeight.w700);
  TextStyle get headlineMedium => baseTextStyle(fontFamily1, FontWeight.w500);
  TextStyle get headlineSmall => baseTextStyle(fontFamily1, FontWeight.w400);
  TextStyle get titleLarge => baseTextStyle(fontFamily1, FontWeight.w700);
  TextStyle get titleMedium => baseTextStyle(fontFamily1, FontWeight.w500);
  TextStyle get titleSmall => baseTextStyle(fontFamily1, FontWeight.w400);
  TextStyle get displayLarge => baseTextStyle(fontFamily1, FontWeight.w700);

  TextStyle get displayMedium => baseTextStyle(fontFamily1, FontWeight.w500);
  TextStyle get displaySmall => baseTextStyle(fontFamily1, FontWeight.w400);
  TextStyle get caption => baseTextStyle(fontFamily1, FontWeight.w400);
  TextStyle get overline => baseTextStyle(fontFamily1, FontWeight.w400);
  TextStyle get button => baseTextStyle(fontFamily1, FontWeight.w700);
    TextStyle get latoRegular => baseTextStyle(fontFamily1, FontWeight.w400);
  // TextStyle get latoBold => baseTextStyle(fontFamily1, FontWeight.w700);
  // TextStyle get latoBlack => baseTextStyle('Lato', FontWeight.w900);
  // TextStyle get latoLight => baseTextStyle('Lato', FontWeight.w300);
  // TextStyle get latoThin => baseTextStyle('Lato', FontWeight.w100);
  
  
  
  }
