import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

/// ViewModel que gestiona la navegación desde el drawer de la aplicación.
class DrawerViewModel extends ChangeNotifier {
    /// Navega a la pantalla de perfil.
    void navigateToProfile(BuildContext context) {
        Navigator.of(context).pushNamed('/profile');
    }

    /// Navega a la pantalla de configuración.
    void navigateToSettings(BuildContext context) {
        Navigator.of(context).pushNamed('/settings');
    }

    /// Cierra la sesión del usuario actual y navega a la pantalla de inicio de sesión.
    void logOut(BuildContext context) {
        context.read<UserProvider>().clearUser();
        Navigator.pushReplacementNamed(context, '/');
    }
}
