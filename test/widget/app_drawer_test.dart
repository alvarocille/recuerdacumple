import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart'; // Import mockito
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recuerdacumple/provider/user_provider.dart';
import 'package:recuerdacumple/ui/viewmodel/widgets/drawer_viewmodel.dart';
import 'package:recuerdacumple/ui/widgets/app_drawer.dart';

void main() {
  testWidgets('AppDrawer widget test', (WidgetTester tester) async {

    final mockViewModel = MockDrawerViewModel();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DrawerViewModel>.value(value: mockViewModel),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            drawer: const AppDrawer(),
          ),
        ),
      ),
    );

    expect(find.text('RECUERDACUMPLE'), findsOneWidget);
    expect(find.text('¡Mucho que celebrar!'), findsOneWidget);


    expect(find.text('Perfil'), findsOneWidget);
    expect(find.text('Configuración'), findsOneWidget);

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();

    verify(mockViewModel.navigateToProfile(any as BuildContext)).called(1);

    await tester.tap(find.text('Configuración'));
    await tester.pumpAndSettle();

    verify(mockViewModel.navigateToSettings(any as BuildContext)).called(1);

    // Tap on the logout option
    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();

    verify(mockViewModel.logOut(any as BuildContext)).called(1);
  });
}

class MockDrawerViewModel extends Mock implements DrawerViewModel {}
