import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider({bool isDarkModeInitially = false}) {
    _themeMode = isDarkModeInitially ? ThemeMode.dark : ThemeMode.light;
  }

  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
