import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../viewmodel/configuration/profile_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Pantalla con la información del usuario.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.profile ?? 'Perfil'),
          centerTitle: true,
        ),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            final user = viewModel.getCurrentUser(context);
            if (user == null) {
              return Center(child: Text(AppLocalizations.of(context)?.noUserRegistered ?? 'No hay usuario registrado'));
            }

            final DateFormat formatter = DateFormat.yMd(AppLocalizations.of(context)?.localeName);
            final String formattedDate = formatter.format(user.birthday);

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)?.name ?? 'Nombre'}: ${user.name}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${AppLocalizations.of(context)?.email ?? 'Email'}: ${user.email}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${AppLocalizations.of(context)?.birthday ?? 'Fecha de nacimiento'}: $formattedDate',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}