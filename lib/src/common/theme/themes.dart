import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.grey[100],
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.light,
    primary: Colors.deepPurpleAccent,
    secondary: Colors.teal,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.deepPurpleAccent,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.deepPurpleAccent,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 8.0,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.grey[800]),
    bodyMedium: TextStyle(color: Colors.grey[700]),
    titleLarge:
        const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
  ),
  iconTheme: const IconThemeData(color: Colors.black54),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
    primary: Colors.deepPurpleAccent[100]!,
    secondary: Colors.tealAccent[100]!,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    foregroundColor: Colors.white,
    elevation: 4.0,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.deepPurpleAccent[100],
    unselectedItemColor: Colors.grey[600],
    backgroundColor: Colors.grey[900],
    elevation: 8.0,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.grey[300]),
    bodyMedium: TextStyle(color: Colors.grey[400]),
    titleLarge:
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  iconTheme: IconThemeData(color: Colors.grey[400]),
);
