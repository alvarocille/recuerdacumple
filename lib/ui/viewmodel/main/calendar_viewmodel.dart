import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:recuerdacumple/dao/birthday_crud.dart';

/// ViewModel que gestiona la lógica de negocio del calendario de cumpleaños.
class CalendarViewModel extends ChangeNotifier {
  final BirthdayCRUD _birthdayCRUD = BirthdayCRUD();
  final EventController _eventController = EventController();

  /// Obtiene el controlador de eventos del calendario.
  EventController get eventController => _eventController;

  /// Carga los cumpleaños del usuario y sus amigos dado su [userId].
  ///
  /// Elimina los eventos de cumpleaños actuales y agrega los cumpleaños del usuario y sus amigos.
  Future<void> loadUserBirthdays(int userId) async {
    final localBirthdays = await _birthdayCRUD.getUserEvents(userId);
    final friendBirthdays = await _birthdayCRUD.getFriendsBirthdays(userId);
    _eventController.removeWhere((event) => event.event == 'Cumpleaños');

    for (var birthday in localBirthdays) {
      _addYearlyEvents(birthday.name, birthday.date, Colors.blue);
    }

    for (var birthday in friendBirthdays) {
      _addYearlyEvents(birthday.name, birthday.date, Colors.red);
    }

    notifyListeners();
  }

  /// Añade eventos de cumpleaños anuales.
  ///
  /// Crea eventos de cumpleaños para cada año en un rango de 10 años antes y 10 años después del año actual.
  void _addYearlyEvents(String name, DateTime date, Color color) {
    final int currentYear = DateTime.now().year;
    for (int year = currentYear - 10; year <= currentYear + 10; year++) {
      final DateTime eventDate = DateTime(year, date.month, date.day);
      _eventController.add(CalendarEventData(
        date: eventDate,
        title: '🎂 $name',
        event: 'Cumpleaños',
        color: color,
      ));
    }
  }
}