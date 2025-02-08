import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recuerdacumple/ui/viewmodel/auth/register_viewmodel.dart';

void main() {
  group('RegisterViewModel Tests', () {
    final registerViewModel = RegisterViewModel();

    testWidgets('validateEmail retorna error para email vacío', (WidgetTester tester) async {
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

      final result = registerViewModel.validateEmail('', context);
      expect(result, 'Por favor, ingresa tu correo');
    });

    testWidgets('validatePassword retorna error para contraseña vacía', (WidgetTester tester) async {
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

      final result = registerViewModel.validatePassword('', context);
      expect(result, 'Por favor, ingresa tu contraseña');
    });

  });
}
