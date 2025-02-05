import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// VieModel que gestiona el estado del tamaño del texto de la aplicación.
class FontSizeViewModel extends ChangeNotifier {
  FontSizeViewModel() {
    SharedPreferences.getInstance().then((preferences) {
      fontSizeFactor = preferences.getDouble("fontSizeFactor") ?? 1.0;
    });
  }

  double _fontSizeFactor = 1.0;

  double get fontSizeFactor => _fontSizeFactor;

  set fontSizeFactor(double value) {
    _fontSizeFactor = value;
    SharedPreferences.getInstance().then((preferences) {
      preferences.setDouble("fontSizeFactor", _fontSizeFactor);
      notifyListeners();
    });
  }
}
