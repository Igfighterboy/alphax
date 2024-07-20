import 'package:flutter/material.dart';
import 'package:myapp/core/themes/alphathemes.dart';

enum ThemeModeType { system, light, dark }

class ThemeNotifier extends ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.system;

  ThemeModeType get themeMode => _themeMode;

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
    notifyListeners();
  }
}
