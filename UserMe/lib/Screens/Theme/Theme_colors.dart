import 'package:UserMe/Utils/utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    appBarTheme: AppBarThemeData(
      backgroundColor: UIColours.white,
      surfaceTintColor: UIColours.white,
    ),
    primaryColor: UIColours.primaryColor,
    textTheme: TextTheme(bodyMedium: TextStyle(color: UIColours.black)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: UIColours.white,
    ),

    textSelectionTheme: TextSelectionThemeData(
      selectionColor: UIColours.primaryColor.withValues(alpha: 0.3),
      selectionHandleColor: UIColours.primaryColor,
    ),
    scaffoldBackgroundColor: UIColours.white,
    popupMenuTheme: PopupMenuThemeData(
      color: UIColours.white,
      iconColor: UIColours.black,
      textStyle: TextStyle(color: UIColours.black, fontSize: UISizes.tileTitle),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: UIColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: UIColours.grey.withValues(alpha: 0.5)),
      ),
    ),
    hintColor: UIColours.grey.withValues(alpha: 0.5),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: UIColours.white,
      hintStyle: TextStyle(color: UIColours.grey.withValues(alpha: 0.7)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarThemeData(
      backgroundColor: UIColours.black,
      surfaceTintColor: UIColours.black,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: UIColours.blackShade,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    textTheme: TextTheme(bodyMedium: TextStyle(color: UIColours.white)),
    popupMenuTheme: PopupMenuThemeData(
      color: UIColours.blackShade,
      textStyle: TextStyle(color: UIColours.white, fontSize: UISizes.tileTitle),
      iconColor: UIColours.white,
    ),

    primaryColor: UIColours.primaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: UIColours.black,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: UIColours.primaryColor,
    ),
    scaffoldBackgroundColor: UIColours.black,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: UIColours.blackShade,
      hintStyle: TextStyle(color: UIColours.grey.withValues(alpha: 0.7)),
    ),
  );
}
