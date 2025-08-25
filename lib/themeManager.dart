import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.light;
  SharedPreferences? _prefs;

  ThemeManager() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Light Theme
  ThemeData get lightTheme => ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade800,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    scaffoldBackgroundColor: Colors.grey.shade100,
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
    ),
  );

  // Dark Theme
  ThemeData get darkTheme => ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade800,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    cardTheme: CardThemeData(
      color: Colors.grey.shade800,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.grey.shade800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
    ),
  );

  // Load theme from SharedPreferences
  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final isDark = _prefs?.getBool(_themeKey) ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Toggle theme
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _saveTheme();
    notifyListeners();
  }

  // Save theme to SharedPreferences
  Future<void> _saveTheme() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(_themeKey, _themeMode == ThemeMode.dark);
  }

  // Set specific theme
  Future<void> setTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    await _saveTheme();
    notifyListeners();
  }

  // Get current theme colors for custom widgets
  Color get primaryColor => isDarkMode ? Colors.grey.shade800 : Colors.blue.shade800;
  Color get backgroundColor => isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100;
  Color get cardColor => isDarkMode ? Colors.grey.shade800 : Colors.white;
  Color get textColor => isDarkMode ? Colors.white : Colors.black;
  Color get containerColor => isDarkMode ? Colors.grey.shade700 : Colors.blue.shade800;
}