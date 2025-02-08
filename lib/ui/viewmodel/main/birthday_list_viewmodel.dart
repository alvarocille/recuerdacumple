import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../dao/birthday_crud.dart';
import '../../../models/birthday.dart';

class BirthdayListViewModel extends ChangeNotifier {
  final BirthdayCRUD _birthdayCRUD = BirthdayCRUD();

  final List<Birthday> _birthdays = [];
  List<Birthday> get birthdays => _birthdays;

  List<Birthday> _filteredBirthdays = [];
  List<Birthday> get filteredBirthdays => _filteredBirthdays;

  String searchQuery = '';
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;

  final TextEditingController searchController = TextEditingController();

  Future<void> loadFriendsBirthdays(int userId) async {
    final friendsBirthdays = await _birthdayCRUD.getFriendsBirthdays(userId);
    _birthdays.clear();
    _birthdays.addAll(friendsBirthdays);
    _filteredBirthdays = _birthdays;
    notifyListeners();
  }

  Future<void> loadUserEvents(int userId) async {
    final events = await _birthdayCRUD.getUserEvents(userId);
    _birthdays.clear();
    _birthdays.addAll(events);
    _filteredBirthdays = _birthdays;
    notifyListeners();
  }

  void filterBirthdays({
    String? name,
    int? day,
    int? month,
    int? year,
  }) {
    _filteredBirthdays = _birthdays.where((birthday) {
      final matchesName = name == null || birthday.name.toLowerCase().contains(name.toLowerCase());
      final matchesDay = day == null || birthday.date.day == day;
      final matchesMonth = month == null || birthday.date.month == month;
      final matchesYear = year == null || birthday.date.year == year;
      return matchesName && matchesDay && matchesMonth && matchesYear;
    }).toList();

    notifyListeners();
  }

  void clearFilters() {
    searchController.clear();
    selectedDay = null;
    selectedMonth = null;
    selectedYear = null;
    filterBirthdays(name: null, day: null, month: null, year: null);
  }

  void updateSelectedDay(int? day) {
    selectedDay = day;
    filterBirthdays(name: searchController.text, day: selectedDay, month: selectedMonth, year: selectedYear);
  }

  void updateSelectedMonth(int? month) {
    selectedMonth = month;
    filterBirthdays(name: searchController.text, day: selectedDay, month: selectedMonth, year: selectedYear);
  }

  void updateSelectedYear(int? year) {
    selectedYear = year;
    filterBirthdays(name: searchController.text, day: selectedDay, month: selectedMonth, year: selectedYear);
  }

  Future<void> deleteBirthday(Birthday birthday) async {
    try {
      await _birthdayCRUD.deleteBirthday(birthday.id);

      birthdays.removeWhere((b) => b.id == birthday.id);

      filterBirthdays(
        name: searchController.text,
        day: selectedDay,
        month: selectedMonth,
        year: selectedYear,
      );

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error eliminando el cumpleaños: $e');
      }
    }
  }

  void setDate(DateTime? date) {
    if (date != null) {
      selectedDay = date.day;
      selectedMonth = date.month;
      filterBirthdays(name: searchController.text, day: selectedDay, month: selectedMonth);
    } else {
      selectedDay = null;
      selectedMonth = null;
      filterBirthdays();
    }
    notifyListeners();
  }


}

