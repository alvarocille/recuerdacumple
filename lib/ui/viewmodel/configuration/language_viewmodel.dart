import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel que gestiona el estado del idioma de la aplicación.
class LanguageViewModel extends ChangeNotifier {
  LanguageViewModel() {
    SharedPreferences.getInstance().then((preferences) {
      _selectedLanguage = preferences.getString("language") ?? _selectedLanguage;
      notifyListeners();
    });
  }

  static const Map<String, String> _languages = {
    "es": "Español",
    "en": "English"
  };
  Map<String, String> get languages => _languages;

  String _selectedLanguage = _languages.keys.first;
  get selectedLanguage => _selectedLanguage;
  changeLanguage(String language) {
    _selectedLanguage = language;
    SharedPreferences.getInstance().then((preferences) {
      preferences.setString("language", language);
    });
    notifyListeners();
  }
}