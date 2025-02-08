import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel que gestiona el estado del tema de la aplicación.
class ThemeViewModel extends ChangeNotifier {
  /// Crea una instancia de [ThemeViewModel] y carga el estado del tema desde las preferencias compartidas.
  ThemeViewModel() {
    SharedPreferences.getInstance().then((preferences) {
      _isDarkTheme = preferences.getBool("isDarkTheme") ?? _isDarkTheme;
      notifyListeners();
    });
  }

  /// Indica si el tema oscuro está activado.
  bool _isDarkTheme = false;

  /// Obtiene el estado del tema oscuro.
  bool get isDarkTheme => _isDarkTheme;

  /// Obtiene el modo de tema actual (claro u oscuro).
  ThemeMode get themeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  /// Alterna el estado del tema oscuro.
  ///
  /// Guarda el nuevo estado en las preferencias compartidas y notifica a los listeners.
  void toggleDarkTheme() {
    _isDarkTheme = !_isDarkTheme;
    SharedPreferences.getInstance().then((preferences) {
      preferences.setBool("isDarkTheme", _isDarkTheme);
    });
    notifyListeners();
  }
}