import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recuerdacumple/ui/screens/add_screen.dart';
import 'package:recuerdacumple/ui/screens/auth/register_screen.dart';
import 'package:recuerdacumple/ui/viewmodel/font_size_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/language_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/theme_viewmodel.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'ui/screens/auth/login_screen.dart';
import 'ui/screens/main_screen.dart';

void main() {
  // Inicialización de sqflite en plataformas no web
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeViewModel()),
        ChangeNotifierProvider(create: (context) => LanguageViewModel()),
        ChangeNotifierProvider(create: (context) => FontSizeViewModel()),
      ],
      child: CalendarControllerProvider(
        controller: EventController(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Recuperar el idioma seleccionado y el tamaño de la fuente
    final languageKey = context.watch<LanguageViewModel>().selectedLanguage;
    final fontSizeFactor = context.watch<FontSizeViewModel>().fontSizeFactor;

    return MaterialApp(
      title: 'Recuerdacumple',
      locale: Locale(languageKey), // Asignar el idioma
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      darkTheme: ThemeData.dark(), // Habilitar tema oscuro si es necesario
      themeMode: context.watch<ThemeViewModel>().themeMode, // Asignar el modo de tema
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(fontSizeFactor), // Ajustar el tamaño de la fuente
          ),
          child: child!,
        );
      },
      initialRoute: '/', // Empieza en la pantalla de login
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MainScreen(),
        '/add': (context) => const AddBirthdayScreen(),
      },
    );
  }
}