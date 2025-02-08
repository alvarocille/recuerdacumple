import 'package:flutter/cupertino.dart';

import '../screens/main/calendar_screen.dart';
import '../screens/main/community_screen.dart';
import '../screens/main/list_screen.dart';

/// ViewModel que gestiona la lógica de negocio de la pantalla principal de la aplicación.
class MainScreenViewModel extends ChangeNotifier {
  /// Índice de la pantalla actual.
  int _currentIndex = 0;

  /// Fecha seleccionada actualmente.
  DateTime? _selectedDate;

  /// Títulos traducidos para las secciones.
  List<String> _translatedTitles = ["Calendario", "Cumpleaños", "Comunidad"];

  /// Obtiene el índice de la pantalla actual.
  int get currentIndex => _currentIndex;

  /// Lista de pantallas de la aplicación.
  final List<Widget> _screens = [
    const CalendarScreen(),
    const ListScreen(),
    const CommunityScreen(),
  ];

  /// Obtiene la lista de pantallas.
  List<Widget> get screens => _screens;

  /// Obtiene la fecha seleccionada actualmente.
  DateTime? get selectedDate => _selectedDate;

  /// Maneja la selección de una sección.
  ///
  /// Actualiza el índice de la pantalla actual y la fecha seleccionada (si se proporciona),
  /// y notifica a los listeners.
  void onSectionChoose(int index, {DateTime? date}) {
    _currentIndex = index;
    _selectedDate = null;
    if (date != null) {
      _selectedDate = date;
    }
    notifyListeners();
  }

  /// Establece los títulos traducidos para las secciones.
  void setTitles(List<String> titles) {
    _translatedTitles = titles;
    notifyListeners();
  }

  /// Obtiene el título de la sección actual.
  String get currentTitle => _translatedTitles[_currentIndex];

  /// Obtiene la lista de títulos traducidos.
  List<String> get translatedTitles => _translatedTitles;
}
