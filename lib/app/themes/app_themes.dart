import 'package:flutter/material.dart';


class AppTheme {
  static final ThemeData kLightTheme = ThemeData.light().copyWith(
    textTheme: TextTheme(
      titleLarge:TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      titleMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      titleSmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      bodyMedium:TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelSmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
    ),
  );
}