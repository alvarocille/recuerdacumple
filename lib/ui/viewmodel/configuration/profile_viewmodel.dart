import 'package:flutter/material.dart';
import '../../../provider/user_provider.dart';
import '/models/user.dart';
import 'package:provider/provider.dart';

/// ViewModel que gestiona la lógica de negocio de la pantalla de perfil.
class ProfileViewModel extends ChangeNotifier {
  /// Obtiene el usuario actual del proveedor [UserProvider].
  ///
  /// Retorna una instancia de [User] si el usuario está presente, de lo contrario retorna null.
  User? getCurrentUser(BuildContext context) {
    return Provider.of<UserProvider>(context, listen: false).user;
  }
}
