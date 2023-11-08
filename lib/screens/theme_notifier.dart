import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  static const String _kThemePreferenceKey = 'theme_preference';
  late SharedPreferences _preferences;

  ThemeNotifier() {
    _loadTheme();
  }

  ThemeData _themeData = ThemeData.light();

  ThemeData getTheme() => _themeData;

  Future<void> _loadTheme() async {
    _preferences = await SharedPreferences.getInstance();
    final isDarkTheme = _preferences.getBool(_kThemePreferenceKey) ?? false;
    _themeData = isDarkTheme ? _createDarkTheme() :  ThemeData.light();
    notifyListeners();
  }

  ThemeData _createDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
    );
  }


  Future<void> setTheme(bool isDarkTheme) async {
    await _preferences.setBool(_kThemePreferenceKey, isDarkTheme);
    _themeData = isDarkTheme ? _createDarkTheme() :  ThemeData.light();
    notifyListeners();
  }
}
