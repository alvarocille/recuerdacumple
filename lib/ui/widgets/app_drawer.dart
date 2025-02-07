import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import '../screens/configuration/profile_screen.dart';
import '../screens/configuration/settings_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Encabezado del Drawer con una imagen de fondo
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade600, Colors.purple.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              "RECUERDACUMPLE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              "¡Mucho que celebrar!",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          // Elementos del menú
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: Colors.purple.shade700),
                  title: Text(
                    "Perfil",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ProfileScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.purple.shade700),
                  title: Text(
                    "Configuración",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.purple.shade100,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          // Puedes agregar más opciones aquí
          // Ejemplo:
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.purple.shade700),
            title: Text(
              "Cerrar sesión",
              style: TextStyle(
                fontSize: 16,
                color: Colors.purple.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              context.read<UserProvider>().clearUser();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}