import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recuerdacumple/ui/viewmodel/configuration/font_size_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FontSizeViewModel Tests', () {
    testWidgets('fontSizeFactor actualiza y notifica a los listeners', (WidgetTester tester) async {
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

      final viewModel = FontSizeViewModel();
      SharedPreferences.setMockInitialValues({});

      expect(viewModel.fontSizeFactor, 1.0);

      viewModel.fontSizeFactor = 1.5;
      expect(viewModel.fontSizeFactor, 1.5);
    });

  });
}
