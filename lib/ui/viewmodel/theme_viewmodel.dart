import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel que gestiona el estado del tema de la aplicación.
class ThemeViewModel extends ChangeNotifier {
  ThemeViewModel() {
    SharedPreferences.getInstance().then((preferences) {
      _isDarkTheme = preferences.getBool("isDarkTheme") ?? _isDarkTheme;
      notifyListeners();
    });
  }
  bool _isDarkTheme = false;
  get isDarkTheme => _isDarkTheme;
  get themeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  toggleDarkTheme() {
    _isDarkTheme = !_isDarkTheme;
    SharedPreferences.getInstance().then((preferences) {
      preferences.setBool("isDarkTheme", _isDarkTheme);
    });
    notifyListeners();
  }
}