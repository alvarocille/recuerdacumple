import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel que gestiona el estado del idioma de la aplicación.
class LanguageViewModel extends ChangeNotifier {
  /// Crea una instancia de [LanguageViewModel] y carga el idioma seleccionado desde las preferencias compartidas.
  LanguageViewModel() {
    SharedPreferences.getInstance().then((preferences) {
      _selectedLanguage = preferences.getString("language") ?? _selectedLanguage;
      notifyListeners();
    });
  }

  /// Mapa que contiene los idiomas disponibles y sus nombres.
  static const Map<String, String> _languages = {
    "es": "Español",
    "en": "English",
    "ro": "Română",
    "zh": "中文"
  };

  /// Obtiene los idiomas disponibles.
  Map<String, String> get languages => _languages;

  /// Idioma seleccionado actualmente.
  String _selectedLanguage = _languages.keys.first;

  /// Obtiene el idioma seleccionado actualmente.
  String get selectedLanguage => _selectedLanguage;

  /// Cambia el idioma seleccionado.
  ///
  /// Guarda el nuevo idioma en las preferencias compartidas y notifica a los listeners.
  void changeLanguage(String language) {
    _selectedLanguage = language;
    SharedPreferences.getInstance().then((preferences) {
      preferences.setString("language", language);
    });
    notifyListeners();
  }
}
