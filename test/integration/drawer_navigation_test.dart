import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:recuerdacumple/main.dart' as app;
import 'package:recuerdacumple/provider/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test de integración', () {
    testWidgets('Test de navegación lateral', (WidgetTester tester) async {

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: app.MyApp(),
          ),
        ),
      );

      final ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('RECUERDACUMPLE'), findsOneWidget);
      expect(find.text('¡Mucho que celebrar!'), findsOneWidget);
      expect(find.text('Perfil'), findsOneWidget);
      expect(find.text('Configuración'), findsOneWidget);
      expect(find.text('Cerrar sesión'), findsOneWidget);

      await tester.tap(find.text('Perfil'));
      await tester.pumpAndSettle();

      expect(find.text('Perfil'), findsOneWidget);

      scaffoldState.openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Configuración'));
      await tester.pumpAndSettle();

      expect(find.text('Configuración'), findsOneWidget);

      scaffoldState.openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cerrar sesión'));
      await tester.pumpAndSettle();

      expect(find.text('Cerrar sesión'), findsOneWidget);
    });
  });
}
