import 'package:flutter/cupertino.dart';
import 'package:recuerdacumple/models/user.dart';

/// Proveedor de usuario que gestiona el estado del usuario actual.
class UserProvider extends ChangeNotifier {
  User? _user;

  /// Obtiene el usuario actual.
  User? get user => _user;

  /// Establece el usuario actual.
  ///
  /// Notifica a los listeners sobre el cambio de estado.
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  /// Limpia el usuario actual.
  ///
  /// Establece el usuario como nulo y notifica a los listeners sobre el cambio de estado.
  void clearUser() {
    _user = null;
    notifyListeners();
  }
}