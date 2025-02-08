import 'package:flutter/cupertino.dart';

import '../../../models/birthday.dart';

class EditBirthdayViewModel extends ChangeNotifier {
  final Birthday birthday;
  final TextEditingController nameController;
  final TextEditingController dateController;

  EditBirthdayViewModel(this.birthday)
      : nameController = TextEditingController(text: birthday.name),
        dateController = TextEditingController(text: '${birthday.date.day}/${birthday.date.month}/${birthday.date.year}');

  void updateName(String name) {
    birthday.name = name;
    notifyListeners();
  }

  void updateDate(String date) {
    final parts = date.split('/');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final parsedDate = DateTime(year, month, day);
      birthday.date = parsedDate;
      notifyListeners();
    } else {
      throw FormatException("Invalid date format");
    }
  }

  bool validate() {
    return nameController.text.isNotEmpty && dateController.text.isNotEmpty;
  }

  void save() {
    birthday.updateDetails(
      newName: nameController.text,
      newDate: DateTime.parse(dateController.text),
    );
    // Notificar al ViewModel principal que los cambios han sido guardados.
    notifyListeners();
  }
}
