import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:recuerdacumple/ui/screens/add_screen.dart';
import 'package:recuerdacumple/ui/screens/auth/register_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'ui/screens/auth/login_screen.dart';
import 'ui/screens/main_screen.dart'; // Nueva pantalla principal

void main() {
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
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
      initialRoute: '/', // Empieza en la pantalla de login
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MainScreen(), // Nueva pantalla principal
        '/add': (context) => const AddBirthdayScreen(),
      },
    );
  }
}
