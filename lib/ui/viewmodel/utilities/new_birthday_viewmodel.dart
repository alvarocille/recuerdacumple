import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dao/birthday_crud.dart';
import '../../../models/birthday.dart';
import '../../viewmodel/main/birthday_list_viewmodel.dart';
import '../main/calendar_viewmodel.dart';  // Importa el ViewModel

class NewBirthdayViewModel extends ChangeNotifier {
  final BirthdayCRUD _birthdayCRUD = BirthdayCRUD();

  String name = '';
  DateTime? date;

  Future<void> addBirthday(int? userId, BuildContext context) async {
    if (name.isNotEmpty && date != null) {
      final newBirthday = Birthday(
        name: name,
        date: date!,
        userId: userId,
      );
      await _birthdayCRUD.insertBirthday(newBirthday);

      await Provider.of<BirthdayListViewModel>(context, listen: false)
          .loadUserEvents(userId!);

      await Provider.of<CalendarViewModel>(context, listen: false)
          .loadUserBirthdays(userId);

      notifyListeners();
    }
  }

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

  void setDate(DateTime newDate) {
    date = newDate;
    notifyListeners();
  }
}
