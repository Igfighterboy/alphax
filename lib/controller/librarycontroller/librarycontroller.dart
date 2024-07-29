import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const String _viewTypeKey = 'viewType';

  static Future<void> setViewType(bool isGridView) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_viewTypeKey, isGridView);
  }

  static Future<bool> getViewType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_viewTypeKey) ?? false; // Default to ListView (false)
  }
}