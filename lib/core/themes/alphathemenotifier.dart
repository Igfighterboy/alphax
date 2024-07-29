import 'package:flutter/material.dart';
import 'package:myapp/core/themes/alphathemes.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeType { system, light, dark }

class ThemeNotifier extends ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.system;

  ThemeModeType get themeMode => _themeMode;

  ThemeNotifier() {
    _loadThemeMode();
  }

  ThemeData get currentTheme {
    switch (_themeMode) {
      case ThemeModeType.light:
        return lightTheme;
      case ThemeModeType.dark:
        return darkTheme;
      default:
        return WidgetsBinding.instance.window.platformBrightness ==
                Brightness.light
            ? lightTheme
            : darkTheme;
    }
  }

  void switchTheme(ThemeModeType mode) {
    _themeMode = mode;
    _saveThemeMode(); // Save the theme mode whenever it is changed
    notifyListeners();
  }

  void _saveThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('thememode', _themeMode.index); // Save the index of the theme mode
  }

  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeIndex = prefs.getInt('thememode') ?? 0;
    _themeMode = ThemeModeType.values[themeIndex];
    notifyListeners();
  }
}