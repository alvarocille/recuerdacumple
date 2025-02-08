import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import '/models/user.dart';
import '/dao/user_crud.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// ViewModel para la lógica de negocio de la pantalla de registro.
class RegisterViewModel extends ChangeNotifier {
  final UserCRUD _userCRUD = UserCRUD();

  /// Clave global para el formulario de registro.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Controlador para el campo de entrada del nombre.
  final TextEditingController nameController = TextEditingController();

  /// Controlador para el campo de entrada del correo electrónico.
  final TextEditingController emailController = TextEditingController();

  /// Controlador para el campo de entrada de la contraseña.
  final TextEditingController passwordController = TextEditingController();

  /// Controlador para el campo de entrada de la fecha de nacimiento.
  final TextEditingController birthdayController = TextEditingController();

  /// Indica si la contraseña debe mostrarse u ocultarse.
  bool obscurePassword = true;

  /// Fecha de nacimiento seleccionada.
  DateTime? selectedDate = DateTime.now();

  /// Registra un nuevo usuario con los datos proporcionados.
  ///
  /// Si el formulario es válido y la fecha de nacimiento está seleccionada,
  /// se registra el usuario y se muestran mensajes adecuados.
  Future<void> register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final name = nameController.text;
      var password = passwordController.text;
      var code = _userCRUD.generateUniqueCode();

      var bytes1 = utf8.encode(password);
      password = sha256.convert(bytes1).toString();

      if (selectedDate != null) {
        try {
          await _userCRUD.insertUser(User(
            name: name,
            email: email,
            password: password,
            birthday: selectedDate!,
            code: code,
          ), context);
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          birthdayController.clear();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)?.userRegisteredSuccessfully ?? 'Usuario registrado correctamente')),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)?.userRegistrationFailed ?? 'No se ha podido registrar correctamente.')),
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)?.pleaseSelectYourBirthday ?? 'Por favor, selecciona tu fecha de cumpleaños')),
          );
        }
      }
    }
  }

  /// Selecciona una fecha de nacimiento utilizando un selector de fecha.
  ///
  /// Actualiza el controlador de fecha de nacimiento y notifica a los listeners si la fecha cambia.
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      birthdayController.text = "${selectedDate!.toLocal()}".split(' ')[0];
      notifyListeners();
    }
  }

  /// Alterna la visibilidad de la contraseña.
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

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
}
