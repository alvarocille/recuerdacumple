import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/auth/register_viewmodel.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: viewModel.formKey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: viewModel.nameController,
                              decoration: InputDecoration(
                                labelText: 'Nombre',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    viewModel.nameController.clear();
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: viewModel.emailController,
                              decoration: InputDecoration(
                                labelText: 'Correo electrónico',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    viewModel.emailController.clear();
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
                            TextFormField(
                              controller: viewModel.passwordController,
                              obscureText: viewModel.obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                                border: const OutlineInputBorder(),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        viewModel.obscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        viewModel.obscurePassword = !viewModel.obscurePassword;
                                        viewModel.notifyListeners();
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        viewModel.passwordController.clear();
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
                            TextFormField(
                              onTap: () => viewModel.selectDate(context),
                              controller: viewModel.birthdayController,
                              decoration: InputDecoration(
                                labelText: 'Cumpleaños',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => viewModel.selectDate(context),
                                ),
                              ),
                              validator: (value) {
                                if (viewModel.selectedDate == null) {
                                  return 'Por favor, selecciona tu fecha de cumpleaños';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24.0),
                            // Botón de registro
                            ElevatedButton(
                              onPressed: () => viewModel.register(context),
                              child: const Text('Registrarse'),
                            ),
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
        },
      ),
    );
  }
}