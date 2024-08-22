import 'package:car_rental/cores/palette/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static final _border = OutlineInputBorder(
        
        borderSide: BorderSide(
          color: AppPallete.borderColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(12)
      );
  static final darkThemeMode =ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,

    // theme for input decoration:
    inputDecorationTheme:  InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      enabledBorder: _border,
      focusedBorder: _border
    ),
  );
}