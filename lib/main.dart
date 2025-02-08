import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recuerdacumple/provider/user_provider.dart';
import 'package:recuerdacumple/ui/screens/configuration/profile_screen.dart';
import 'package:recuerdacumple/ui/screens/configuration/settings_screen.dart';
import 'package:recuerdacumple/ui/screens/utilities/add_screen.dart';
import 'package:recuerdacumple/ui/screens/auth/register_screen.dart';
import 'package:recuerdacumple/ui/viewmodel/configuration/language_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/main/birthday_list_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/main/calendar_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/configuration/font_size_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/auth/login_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/main/community_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/main_screen_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/auth/register_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/configuration/theme_viewmodel.dart';
import 'package:recuerdacumple/ui/viewmodel/utilities/new_birthday_viewmodel.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'ui/screens/auth/login_screen.dart';
import 'ui/screens/main_screen.dart';

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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => MainScreenViewModel()),
        ChangeNotifierProvider(create: (context) => CalendarViewModel()),
        ChangeNotifierProvider(create: (context) => BirthdayListViewModel()),
        ChangeNotifierProvider(create: (context) => CommunityViewModel()),
        ChangeNotifierProvider(create: (context) => NewBirthdayViewModel()),
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

/// Clase principal de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageKey = context.watch<LanguageViewModel>().selectedLanguage;
    final fontSizeFactor = context.watch<FontSizeViewModel>().fontSizeFactor;

    return MaterialApp(
      title: 'Recuerdacumple',
      locale: Locale(languageKey),
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: context.watch<ThemeViewModel>().themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(fontSizeFactor),
          ),
          child: child!,
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => MainScreen(),
        '/add': (context) => const AddBirthdayScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen()
      },
    );
  }

  /// Construye el tema claro de la aplicación.
  ThemeData _buildLightTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      brightness: Brightness.light,
    );
  }

  /// Construye el tema oscuro de la aplicación.
  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith();
  }
}