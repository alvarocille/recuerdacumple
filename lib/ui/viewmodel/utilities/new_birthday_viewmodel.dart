import 'package:flutter/material.dart';

import '../../../dao/birthday_crud.dart';
import '../../../models/birthday.dart';

class NewBirthdayViewModel extends ChangeNotifier {
  final BirthdayCRUD _birthdayCRUD = BirthdayCRUD();

  String name = '';
  DateTime? date;

  Future<void> addBirthday(int? userId) async {
    if (name.isNotEmpty && date != null) {
      final newBirthday = Birthday(
        id: 0,
        name: name,
        date: date!,
        userId: userId,
      );
      await _birthdayCRUD.insertBirthday(newBirthday);
      notifyListeners();
    }
  }

  // Métodos para actualizar el estado del formulario
  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

  void setDate(DateTime newDate) {
    date = newDate;
    notifyListeners();
  }
}
