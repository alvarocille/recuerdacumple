import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../dao/birthday_crud.dart';
import '../../../models/birthday.dart';

/// ViewModel que gestiona la lógica de negocio de la lista de cumpleaños.
class BirthdayListViewModel extends ChangeNotifier {
  final BirthdayCRUD _birthdayCRUD = BirthdayCRUD();

  /// Lista de todos los cumpleaños.
  final List<Birthday> _birthdays = [];
  List<Birthday> get birthdays => _birthdays;

  /// Lista de cumpleaños filtrados según criterios de búsqueda.
  List<Birthday> _filteredBirthdays = [];
  List<Birthday> get filteredBirthdays => _filteredBirthdays;

  /// Consulta de búsqueda actual.
  String searchQuery = '';

  /// Día seleccionado para filtrar.
  int? selectedDay;

  /// Mes seleccionado para filtrar.
  int? selectedMonth;

  /// Año seleccionado para filtrar.
  int? selectedYear;

  /// Controlador de texto para el campo de búsqueda.
  final TextEditingController searchController = TextEditingController();

  /// Carga los cumpleaños de los amigos del usuario dado su [userId].
  ///
  /// Agrega los cumpleaños a la lista de cumpleaños y notifica a los listeners.
  Future<void> loadFriendsBirthdays(int userId) async {
    final friendsBirthdays = await _birthdayCRUD.getFriendsBirthdays(userId);
    _birthdays.addAll(friendsBirthdays);
    _filteredBirthdays = _birthdays;
    notifyListeners();
  }

  /// Carga los eventos de cumpleaños del usuario dado su [userId].
  ///
  /// Agrega los eventos a la lista de cumpleaños y notifica a los listeners.
  Future<void> loadUserEvents(int userId) async {
    final events = await _birthdayCRUD.getUserEvents(userId);
    _birthdays.addAll(events);
    _filteredBirthdays = _birthdays;
    notifyListeners();
  }

  /// Filtra los cumpleaños según el [name], [day], [month] y [year] proporcionados.
  ///
  /// Actualiza la lista de cumpleaños filtrados y notifica a los listeners.
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

    Future.microtask(() => notifyListeners());
  }

  /// Limpia los filtros de búsqueda.
  void clearFilters() {
    searchController.clear();
    selectedDay = null;
    selectedMonth = null;
    selectedYear = null;
    filterBirthdays(name: null, day: null, month: null, year: null);
  }

  /// Actualiza el día seleccionado para filtrar.
  void updateSelectedDay(int? day) {
    selectedDay = day;
    filterBirthdays(name: searchController.text, day: selectedDay, month: selectedMonth, year: selectedYear);
  }

  /// Actualiza el mes seleccionado para filtrar.
  void updateSelectedMonth(int? month) {
    selectedMonth = month;
    filterBirthdays(name: searchController.text, day: selectedDay, month: selectedMonth, year: selectedYear);
  }

  /// Actualiza el año seleccionado para filtrar.
  void updateSelectedYear(int? year) {
    selectedYear = year;
    filterBirthdays(name: searchController.text, day: selectedDay, month: selectedMonth, year: selectedYear);
  }

  /// Elimina un cumpleaños de la lista y de la base de datos.
  ///
  /// Verifica si el cumpleaños es un evento del usuario o de un amigo
  /// y lo elimina de la base de datos correspondiente.
  Future<void> deleteBirthday(Birthday birthday) async {
    try {
      final bool isUserEvent = await _birthdayCRUD.isUserEvent(birthday.id);

      if (isUserEvent) {
        await _birthdayCRUD.deleteBirthday(birthday.id);
      } else {
        await _birthdayCRUD.deleteFriendBirthday(birthday.id);
      }

      _birthdays.removeWhere((b) => b.id == birthday.id);

      filterBirthdays(
        name: searchController.text,
        day: selectedDay,
        month: selectedMonth,
        year: selectedYear,
      );

      Future.microtask(() => notifyListeners());
    } catch (e) {
      if (kDebugMode) {
        print('Error eliminando el cumpleaños: $e');
      }
    }
  }

  /// Establece la fecha seleccionada para filtrar.
  void setDate(DateTime? date) {
    if (date != null) {
      selectedDay = date.day;
      selectedMonth = date.month;
      selectedYear = null;
      filterBirthdays(name: searchController.text, day: selectedDay, month: selectedMonth);
    } else {
      selectedDay = null;
      selectedMonth = null;
      selectedYear = null;
      filterBirthdays();
    }
    Future.microtask(() => notifyListeners());
  }
}