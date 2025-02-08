import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/auth/register_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Pantalla de registro de usuario.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings');
                },
              ),
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double defaultWidth = 500; // Tamaño de cuadro más grande por defecto
                        double containerWidth = constraints.maxWidth > defaultWidth
                            ? defaultWidth
                            : constraints.maxWidth;

                        return Form(
                          key: viewModel.formKey,
                          child: Container(
                            width: containerWidth,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: viewModel.nameController,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)?.name ?? 'Nombre',
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          viewModel.nameController.clear();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Flexible(
                                  child: TextFormField(
                                    controller: viewModel.emailController,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)?.email ?? 'Correo electrónico',
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          viewModel.emailController.clear();
                                        },
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) => viewModel.validateEmail(value, context),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Flexible(
                                  child: TextFormField(
                                    controller: viewModel.passwordController,
                                    obscureText: viewModel.obscurePassword,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)?.password ?? 'Contraseña',
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
                                    validator: (value) => viewModel.validatePassword(value, context),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Flexible(
                                  child: TextFormField(
                                    onTap: () => viewModel.selectDate(context),
                                    controller: viewModel.birthdayController,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)?.birthday ?? 'Fecha de nacimiento',
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.calendar_today),
                                        onPressed: () => viewModel.selectDate(context),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (viewModel.selectedDate == null) {
                                        return AppLocalizations.of(context)?.pleaseSelectYourBirthday ?? "Por favor, selecciona tu fecha de cumpleaños";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 24.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => viewModel.register(context),
                                        child: Text(AppLocalizations.of(context)?.register ?? 'Registrarse'),
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(AppLocalizations.of(context)?.alreadyHaveAnAccountLoginHere ?? "¿Ya tienes una cuenta? Inicia sesión aquí"),
                                      ),
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
          );
        },
      ),
    );
  }
}