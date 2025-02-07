import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';
import '/dao/user_crud.dart';

class LoginViewModel extends ChangeNotifier {
  final _userCRUD = UserCRUD();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu correo';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Por favor, ingresa un correo válido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  Future<void> login(BuildContext context) async {
    final emailValidation = validateEmail(emailController.text);
    final passwordValidation = validatePassword(passwordController.text);

    if (emailValidation == null && passwordValidation == null) {
      final email = emailController.text;
      final password = passwordController.text;

      try {
        final user = await _userCRUD.getUser(email, password);

        if (user != null) {
          emailController.clear();
          passwordController.clear();
          context.read<UserProvider>().setUser(user);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Correo o contraseña incorrectos')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al iniciar sesión. Intenta de nuevo más tarde')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(emailValidation ?? passwordValidation ?? '')),
      );
    }
  }



  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}
