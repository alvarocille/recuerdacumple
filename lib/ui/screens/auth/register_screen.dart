import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import '/models/user.dart';
import '/dao/user_crud.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthdayController = TextEditingController();
  bool _obscurePassword = true;
  DateTime? _selectedDate;

  final UserCRUD _userCRUD = UserCRUD();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final name = _nameController.text;
      var password = _passwordController.text;

      var bytes1 = utf8.encode(password);
      password = sha256.convert(bytes1).toString();

      if (_selectedDate != null) {
        try {
          await _userCRUD.insertUser(User(
            name: name,
            email: email,
            password: password,
            birthday: _selectedDate!,
          ));
          _emailController.clear();
          _passwordController.clear();
          _birthdayController.clear();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdayController.text = "${_selectedDate!.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de pantalla
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Formulario de registro
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Campo de nombre
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _emailController.clear();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Campo de correo electrónico
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _emailController.clear();
                            },
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu correo';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Por favor, ingresa un correo válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Campo de contraseña
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: const OutlineInputBorder(),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _passwordController.clear();
                                },
                              ),
                            ],
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu contraseña';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Campo de cumpleaños con selector de fecha
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _birthdayController,
                            decoration: InputDecoration(
                              labelText: 'Cumpleaños (YYYY-MM-DD)',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                            validator: (value) {
                              if (_selectedDate == null) {
                                return 'Por favor, selecciona tu fecha de cumpleaños';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      // Botón de registro
                      ElevatedButton(
                        onPressed: _register,
                        child: const Text('Registrarse'),
                      ),
                      // Botón para volver al inicio de sesión
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('¿Ya tienes una cuenta? Inicia sesión aquí'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}