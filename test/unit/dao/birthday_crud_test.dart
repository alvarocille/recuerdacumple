import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recuerdacumple/dao/birthday_crud.dart';
import 'package:recuerdacumple/models/birthday.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('BirthdayCRUD Tests', () {
    final birthdayCRUD = BirthdayCRUD();

    testWidgets('insertBirthday añade un cumpleaños a la base de datos', (WidgetTester tester) async {
      // Construye una pequeña aplicación para obtener un BuildContext válido
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return Container();
            },
          ),
        ),
      ));

      final BuildContext context = tester.element(find.byType(Builder));

      final birthday = Birthday(
        id: 1,
        name: 'Cumpleaños de Prueba',
        date: DateTime(2000, 1, 1),
        userId: 1,
      );

      await birthdayCRUD.insertBirthday(birthday);
      final birthdays = await birthdayCRUD.getAllEvents();
      expect(birthdays, isNotEmpty);
    });

    testWidgets('getUserBirthday recupera el cumpleaños de un usuario', (WidgetTester tester) async {
      // Construye una pequeña aplicación para obtener un BuildContext válido
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return Container();
            },
          ),
        ),
      ));

      final BuildContext context = tester.element(find.byType(Builder));

      final birthday = await birthdayCRUD.getUserBirthday(1);
      expect(birthday, isNotNull);
      expect(birthday?.name, 'Cumpleaños de Prueba');
    });

  });
}
