import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/birthday.dart';
import '../../viewmodel/utilities/edit_birthday_viewmodel.dart';

class EditBirthdayDialog extends StatelessWidget {
  final Birthday birthday;

  const EditBirthdayDialog({super.key, required this.birthday});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)?.editBirthday ?? 'Editar Cumpleaños'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)?.editFunctionNotAvailable ?? 'Función editar no disponible. Cree un nuevo cumpleaños y elimine el actual.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancelar'),
        ),
      ],
    );
  }
}

