import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/user_provider.dart';
import '../viewmodel/widgets/drawer_viewmodel.dart';

/// Widget que representa el Drawer de la aplicación.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrawerViewModel(),
      child: Consumer<DrawerViewModel>(
        builder: (context, viewModel, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double drawerWidth = constraints.maxWidth * 0.35;
              return Drawer(
                width: drawerWidth, // Ajuste el ancho del Drawer al 85% del ancho de la pantalla
                child: Column(
                  children: [
                    // Encabezado del Drawer con una imagen de fondo
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primaryContainer,
                            Theme.of(context).colorScheme.primary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      accountName: const Text(
                        "RECUERDACUMPLE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      accountEmail: Text(
                        AppLocalizations.of(context)?.muchToCelebrate ?? "¡Mucho que celebrar!",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    // Elementos del menú
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
                            title: Text(
                              AppLocalizations.of(context)?.profile ?? "Perfil",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              viewModel.navigateToProfile(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.secondary),
                            title: Text(
                              AppLocalizations.of(context)?.settings ?? "Configuración",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              viewModel.navigateToSettings(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).dividerColor,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app, color: Theme.of(context).colorScheme.secondary),
                      title: Text(
                        AppLocalizations.of(context)?.logOut ?? "Cerrar sesión",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        context.read<UserProvider>().clearUser();
                        viewModel.logOut(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}