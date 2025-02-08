import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recuerdacumple/ui/viewmodel/auth/login_viewmodel.dart';

void main() {
  group('LoginViewModel Tests', () {
    final loginViewModel = LoginViewModel();

    testWidgets('validateEmail retorna error para email inválido', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              body: Column(
                children: [Container()],
              ),
            );
          },
        ),
      ));

      final BuildContext context = tester.element(find.byType(Builder));

      final result = loginViewModel.validateEmail('email-invalido', context);
      expect(result, 'Por favor, ingresa un correo válido');
    });

    testWidgets('validatePassword retorna error para contraseña corta', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              body: Column(
                children: [Container()],
              ),
            );
          },
        ),
      ));

      final BuildContext context = tester.element(find.byType(Builder));

      final result = loginViewModel.validatePassword('corta', context);
      expect(result, 'La contraseña debe tener al menos 6 caracteres');
    });

    // Añadir más pruebas para otros métodos si es necesario...
  });
}
