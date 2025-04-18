import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/main_theme.dart'; // Assuming lightMode and darkMode are defined here

class ThemeProvider with ChangeNotifier {
  bool isDark = false;
  bool loaded = false;
  ThemeData _themeData = lightMode; // Default theme

  ThemeProvider() {
    _loadSettings(); // Load the theme preference on initialization
  }

  ThemeData get themeData => _themeData;

  // Load the stored dark_mode setting and update the theme
  Future<void> _loadSettings() async {
    isDark =
        await SettingsStorage.loadBoolSetting('dark_mode', defaultValue: false);
    _themeData =
        isDark ? darkMode : lightMode; // Update theme based on saved setting
    loaded = true; // Indicate settings are loaded
    notifyListeners(); // Notify listeners to update the UI
  }

  // Toggle the theme and save the updated setting
  void toggleTheme() async {
    isDark = !isDark; // Toggle theme state
    _themeData = isDark ? darkMode : lightMode; // Update theme based on state
    await SettingsStorage.saveBoolSetting(
        'dark_mode', isDark); // Persist theme setting
    notifyListeners(); // Notify listeners to update the UI
  }
}

class SettingsStorage {
  // Load a boolean value from SharedPreferences
  static Future<bool> loadBoolSetting(String key,
      {bool defaultValue = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  // Save a boolean value to SharedPreferences
  static Future<void> saveBoolSetting(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}
