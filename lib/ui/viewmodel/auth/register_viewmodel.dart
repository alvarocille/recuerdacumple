import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import '/models/user.dart';
import '/dao/user_crud.dart';

class RegisterViewModel extends ChangeNotifier {
  final UserCRUD _userCRUD = UserCRUD();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  bool obscurePassword = true;
  DateTime? selectedDate = DateTime.now();

  Future<void> register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final name = nameController.text;
      var password = passwordController.text;

      var bytes1 = utf8.encode(password);
      password = sha256.convert(bytes1).toString();

      if (selectedDate != null) {
        try {
          await _userCRUD.insertUser(User(
            name: name,
            email: email,
            password: password,
            birthday: selectedDate!,
          ));
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          birthdayController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario registrado correctamente')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('El correo ya está registrado')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona tu fecha de cumpleaños')),
        );
      }
    }
  }

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
}
