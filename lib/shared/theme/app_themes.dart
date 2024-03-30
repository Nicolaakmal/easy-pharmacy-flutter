import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: const ColorScheme.light(
      secondary: Colors.blueAccent,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue, // Changed from 'color' to 'backgroundColor'
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor:
              Colors.blue), // Corrected from 'primary' to 'foregroundColor'
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    colorScheme: const ColorScheme.dark(
      secondary: Colors.tealAccent,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor:
          Color(0xFF1E1E1E), // Changed from 'color' to 'backgroundColor'
      iconTheme: IconThemeData(color: Colors.tealAccent),
      titleTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 20.0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: Colors
              .tealAccent), // Corrected from 'primary' to 'foregroundColor'
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.black,
    ),
  );

  static final customTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.purple,
    colorScheme: const ColorScheme.light(
      secondary: Colors.purpleAccent,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor:
          Colors.purple, // Changed from 'color' to 'backgroundColor'
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor:
              Colors.purple), // Corrected from 'primary' to 'foregroundColor'
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    ),
  );
}
