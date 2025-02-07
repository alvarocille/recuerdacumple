import 'package:flutter/material.dart';

class CalendarViewModel extends ChangeNotifier {
  List<String> events = [];

  void addEvent(String event) {
    events.add(event);
    notifyListeners();
  }

  List<String> getEvents() {
    return events;
  }
}
