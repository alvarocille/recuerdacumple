import 'package:flutter/material.dart';

import '../screens/main/calendar_screen.dart';
import '../screens/main/community_screen.dart';
import '../screens/main/list_screen.dart';

class MainScreenViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final List<Widget> _screens = [
    const CalendarScreen(),
    const ListScreen(),
    const CommunityScreen(),
  ];

  final List<String> _title = [
    "Calendario",
    "Cumpleaños",
    "Comunidad"
  ];

  List<Widget> get screens => _screens;
  List<String> get title => _title;

  // Cambiar la sección seleccionada
  void onSectionChoose(int index) {
    _currentIndex = index;
    notifyListeners(); // Notificar a la vista
  }

  // Obtener el título actual basado en el índice
  String get currentTitle => _title[_currentIndex];
}
