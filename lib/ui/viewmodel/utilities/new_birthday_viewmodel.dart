import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dao/birthday_crud.dart';
import '../../../models/birthday.dart';
import '../../viewmodel/main/birthday_list_viewmodel.dart';
import '../main/calendar_viewmodel.dart';

/// ViewModel que gestiona la lógica de negocio para añadir nuevos cumpleaños.
class NewBirthdayViewModel extends ChangeNotifier {
  final BirthdayCRUD _birthdayCRUD = BirthdayCRUD();

  /// Nombre del cumpleañero.
  String name = '';

  /// Fecha del cumpleaños.
  DateTime? date;

  /// Añade un nuevo cumpleaños para el usuario dado su [userId].
  ///
  /// Si el nombre y la fecha no están vacíos, inserta el cumpleaños en la base de datos,
  /// carga los eventos de usuario y los cumpleaños del usuario en el calendario.
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

  /// Establece el nombre del cumpleañero.
  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

  /// Establece la fecha del cumpleaños.
  void setDate(DateTime newDate) {
    date = newDate;
    notifyListeners();
  }
}
