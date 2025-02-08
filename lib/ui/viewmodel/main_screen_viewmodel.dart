import 'package:flutter/cupertino.dart';

import '../screens/main/calendar_screen.dart';
import '../screens/main/community_screen.dart';
import '../screens/main/list_screen.dart';

class MainScreenViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  DateTime? _selectedDate;

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

  DateTime? get selectedDate => _selectedDate;

  void onSectionChoose(int index, {DateTime? date}) {
    _currentIndex = index;
    _selectedDate = null;
    if (date != null) {
      _selectedDate = date;
    }
    notifyListeners();
  }

  String get currentTitle => _title[_currentIndex];
}