import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Asegúrate de importar AppLocalizations
import '../../../provider/user_provider.dart';
import '../../viewmodel/utilities/new_birthday_viewmodel.dart';

/// Pantalla de agregación de cumpleaños.
class AddBirthdayScreen extends StatelessWidget {
  const AddBirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.addBirthday ?? 'Agregar Cumpleaños'),
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
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)?.name ?? 'Nombre',
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      viewModel.setName(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)?.birthdayDate ?? 'Fecha de Cumpleaños',
                      border: const OutlineInputBorder(),
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
                        SnackBar(content: Text(AppLocalizations.of(context)?.birthdayAdded ?? 'Cumpleaños Agregado')),
                      );
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)?.save ?? 'Guardar'),
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
