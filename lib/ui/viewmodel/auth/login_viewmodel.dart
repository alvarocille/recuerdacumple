import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';
import '/dao/user_crud.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// ViewModel para la lógica de negocio de la pantalla de inicio de sesión.
class LoginViewModel extends ChangeNotifier {
  final _userCRUD = UserCRUD();

  /// Controlador para el campo de entrada de correo electrónico.
  final TextEditingController emailController = TextEditingController();

  /// Controlador para el campo de entrada de contraseña.
  final TextEditingController passwordController = TextEditingController();

  /// Indica si la contraseña debe mostrarse u ocultarse.
  bool obscurePassword = true;

  /// Valida el correo electrónico ingresado.
  ///
  /// Retorna un mensaje de error si la validación falla, de lo contrario retorna null.
  String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.pleaseEnterYourEmail ?? 'Por favor, ingresa tu correo';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return AppLocalizations.of(context)?.pleaseEnterValidEmail ?? 'Por favor, ingresa un correo válido';
    }
    return null;
  }

  /// Valida la contraseña ingresada.
  ///
  /// Retorna un mensaje de error si la validación falla, de lo contrario retorna null.
  String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.pleaseEnterYourPassword ?? 'Por favor, ingresa tu contraseña';
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)?.passwordMustBeAtLeast6Characters ?? 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  /// Inicia sesión con el correo electrónico y la contraseña proporcionados.
  ///
  /// Si las credenciales son correctas, redirige al usuario a la pantalla principal.
  /// Muestra un mensaje de error si las credenciales son incorrectas o si ocurre un error.
  Future<void> login(BuildContext context) async {
    final emailValidation = validateEmail(emailController.text, context);
    final passwordValidation = validatePassword(passwordController.text, context);

    if (emailValidation == null && passwordValidation == null) {
      final email = emailController.text;
      final password = passwordController.text;

      try {
        final user = await _userCRUD.getUser(email, password, context);

        if (user != null) {
          emailController.clear();
          passwordController.clear();
          context.read<UserProvider>().setUser(user);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)?.incorrectEmailOrPassword ?? 'Correo o contraseña incorrectos')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)?.loginErrorTryAgainLater ?? 'Error al iniciar sesión. Intenta de nuevo más tarde')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(emailValidation ?? passwordValidation ?? '')),
      );
    }
  }

  /// Alterna la visibilidad de la contraseña.
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}