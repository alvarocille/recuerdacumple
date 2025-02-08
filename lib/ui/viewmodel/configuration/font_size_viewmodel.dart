import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel que gestiona el estado del tamaño del texto de la aplicación.
class FontSizeViewModel extends ChangeNotifier {
  /// Crea una instancia de [FontSizeViewModel] y carga el factor de tamaño de texto desde las preferencias compartidas.
  FontSizeViewModel() {
    SharedPreferences.getInstance().then((preferences) {
      fontSizeFactor = preferences.getDouble("fontSizeFactor") ?? 1.0;
    });
  }

  /// Factor de tamaño de fuente actual.
  double _fontSizeFactor = 1.0;

  /// Obtiene el factor de tamaño de fuente.
  double get fontSizeFactor => _fontSizeFactor;

  /// Establece el factor de tamaño de fuente.
  ///
  /// Guarda el nuevo valor en las preferencias compartidas y notifica a los listeners.
  set fontSizeFactor(double value) {
    _fontSizeFactor = value;
    SharedPreferences.getInstance().then((preferences) {
      preferences.setDouble("fontSizeFactor", _fontSizeFactor);
      notifyListeners();
    });
  }
}
