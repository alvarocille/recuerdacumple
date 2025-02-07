import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importar Provider
import '../../viewmodel/auth/login_viewmodel.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
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
                child: Consumer<LoginViewModel>(
                  builder: (context, viewModel, child) {
                    return Form(
                      key: GlobalKey<FormState>(),
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
                              validator: viewModel.validateEmail,
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
                                        viewModel.togglePasswordVisibility();
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
                              validator: viewModel.validatePassword,
                            ),
                            const SizedBox(height: 24.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    viewModel.login(context);
                                  },
                                  child: const Text('Iniciar sesión'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const RegisterScreen()),
                                    );
                                  },
                                  child: const Text(
                                      '¿No tienes una cuenta? Regístrate aquí'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
