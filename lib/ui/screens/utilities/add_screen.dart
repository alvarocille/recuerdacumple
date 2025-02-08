import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';
import '../../viewmodel/utilities/new_birthday_viewmodel.dart';

class AddBirthdayScreen extends StatelessWidget {
  const AddBirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Cumpleaños'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<NewBirthdayViewModel>(
          builder: (context, viewModel, child) {
            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      viewModel.setName(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Cumpleaños',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        viewModel.setDate(selectedDate);
                      }
                    },
                    controller: TextEditingController(
                      text: viewModel.date != null
                          ? '${viewModel.date?.day}/${viewModel.date?.month}/${viewModel.date?.year}'
                          : '',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await viewModel.addBirthday(user?.id, context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cumpleaños Agregado')),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

