import 'package:flutter/material.dart';
import '../../viewmodel/configuration/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ProfileViewModel();
    final user = viewModel.getCurrentUser(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: user != null
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Nombre: ${user.name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${user.email}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Cumpleaños: ${user.birthday.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        )
            : const Text(
          'No hay usuario registrado',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
