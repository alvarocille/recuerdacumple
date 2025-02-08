import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import '../../../service/birthday_service.dart';

class CalendarViewModel extends ChangeNotifier {
  final BirthdayService _birthdayService = BirthdayService();
  final EventController _eventController = EventController();

  EventController get eventController => _eventController;

  Future<void> loadUserBirthdays(int userId) async {
    final birthdays = await _birthdayService.getUserBirthdays(userId);
    _eventController.removeWhere((event) => event.event == 'Cumpleaños');

    for (var birthday in birthdays) {
      final DateTime eventDate = DateTime(DateTime.now().year, birthday.date.month, birthday.date.day);
      _eventController.add(CalendarEventData(
        date: eventDate,
        title: '🎂 ${birthday.name}',
        event: 'Cumpleaños',
      ));
    }

    notifyListeners(); // Asegúrate de que se notifique a los listeners para que se actualice el UI
  }
}