import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recuerdacumple/dao/user_crud.dart';
import 'package:recuerdacumple/models/user.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('UserCRUD Tests', () {
    final userCRUD = UserCRUD();

    testWidgets('insertUser añade un usuario a la base de datos', (WidgetTester tester) async {
      // Construye una pequeña aplicación para obtener un BuildContext válido
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              body: Container(),
            );
          },
        ),
      ));

      final BuildContext context = tester.element(find.byType(Builder));

      final user = User(
        id: 1,
        name: 'Usuario de Prueba',
        email: 'usuarioprueba@example.com',
        password: 'contraseña',
        birthday: DateTime(2000, 1, 1),
        code: 'ABC123ABC',
      );

      final userId = await userCRUD.insertUser(user, context);
      expect(userId, isNotNull);
    });

    testWidgets('getUser recupera un usuario de la base de datos', (WidgetTester tester) async {
      // Construye una pequeña aplicación para obtener un BuildContext válido
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              body: Container(),
            );
          },
        ),
      ));

      final BuildContext context = tester.element(find.byType(Builder));

      final user = await userCRUD.getUser('usuarioprueba@example.com', 'contraseña', context);
      expect(user, isNotNull);
      expect(user?.name, 'Usuario de Prueba');
    });

  });
}
