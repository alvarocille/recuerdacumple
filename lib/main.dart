import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:recuerdacumple/ui/screens/add_screen.dart';
import 'package:recuerdacumple/ui/screens/auth/register_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'ui/screens/auth/login_screen.dart';
import 'ui/screens/calendar_screen.dart';
import 'ui/screens/list_screen.dart';

void main() {
  // Configuración específica para entornos de escritorio (Windows, Linux, macOS)
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    sqfliteFfiInit(); // Inicializa FFI para Sqflite
    databaseFactory = databaseFactoryFfi; // Configura el factory de la base de datos
  }

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    CalendarControllerProvider(
      controller: EventController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recuerdacumple',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/list': (context) => const ListScreen(),
        '/add': (context) => const AddBirthdayScreen()
      },
    );
  }
}
