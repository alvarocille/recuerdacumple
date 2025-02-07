import 'package:flutter/material.dart';
import '../../../dao/birthday_crud.dart';
import '/models/birthday.dart';

class BirthdayListViewModel extends ChangeNotifier {
  final BirthdayCRUD _birthdayCRUD = BirthdayCRUD();

  // Lista para almacenar todos los cumpleaños y eventos
  final List<Birthday> _birthdays = [];
  List<Birthday> get birthdays => _birthdays;

  List<Birthday> _filteredBirthdays = [];
  List<Birthday> get filteredBirthdays => _filteredBirthdays.isEmpty ? _birthdays : _filteredBirthdays;

  String searchQuery = '';

  Future<void> loadFriendsBirthdays(int userId) async {
    final friendsBirthdays = await _birthdayCRUD.getFriendsBirthdays(userId);
    _birthdays.addAll(friendsBirthdays);
    notifyListeners();
  }

  Future<void> loadUserEvents(int userId) async {
    final events = await _birthdayCRUD.getUserEvents(userId);
    _birthdays.addAll(events);
    notifyListeners();
  }

  void filterBirthdays(String query) {
    searchQuery = query;
    _filteredBirthdays = _birthdays.where((birthday) {
      return birthday.name.toLowerCase().contains(query.toLowerCase()) ||
          birthday.date.toString().contains(query);
    }).toList();
    notifyListeners();
  }

  void addBirthday(Birthday birthday) {
    _birthdays.add(birthday);
    notifyListeners();
  }

  void removeBirthday(Birthday birthday) {
    _birthdays.remove(birthday);
    notifyListeners();
  }
}