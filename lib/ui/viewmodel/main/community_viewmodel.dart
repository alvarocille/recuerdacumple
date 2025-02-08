import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recuerdacumple/dao/user_crud.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../provider/user_provider.dart';

/// ViewModel que gestiona la lógica de negocio de la comunidad y los códigos de amigo.
class CommunityViewModel extends ChangeNotifier {
  /// Código de amigo del usuario.
  String _myFriendCode = '';

  /// Clave global para el formulario de agregar amigo.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Controlador para el campo de entrada del código de amigo.
  final TextEditingController friendCodeController = TextEditingController();

  final UserCRUD _userCRUD = UserCRUD();

  /// Obtiene el código de amigo del usuario.
  String get myFriendCode => _myFriendCode;

  /// Comparte el código de amigo del usuario utilizando la funcionalidad de compartir del dispositivo.
  ///
  /// Muestra un mensaje personalizado incluyendo el código de amigo del usuario.
  void shareFriendCode(BuildContext context) {
    final message = AppLocalizations.of(context)?.dontForgetMyBirthday ?? 'No olvides mi cumpleaños. Mi código de amigo en RecuerdaCumple es: ';
    Share.share(message + _myFriendCode);
  }

  /// Actualiza el código de amigo del usuario.
  void updateFriendCode(String userCode) {
    _myFriendCode = userCode;
    notifyListeners();
  }

  /// Valida el código de amigo ingresado.
  ///
  /// Retorna un mensaje de error si la validación falla, de lo contrario retorna null.
  String? validateFriendCode(BuildContext context, String? value) {
    final regex = RegExp(r'^[A-Z]{3}\d{3}[A-Z]{3}$');
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.codeCannotBeEmpty ?? 'El código no puede estar vacío';
    } else if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)?.invalidFormatMustBeXXX111XXX ?? 'Formato inválido. Debe ser XXX111XXX';
    }
    return null;
  }

  /// Envía el formulario de agregar amigo.
  ///
  /// Si el formulario es válido, agrega al amigo utilizando el código de amigo proporcionado.
  /// Muestra mensajes de éxito o error según el resultado de la operación.
  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)?.errorUserNotAuthenticated ?? 'Error: Usuario no autenticado')),
        );
        return;
      }

      final friendCode = friendCodeController.text.trim();

      _userCRUD.addFriend(user, friendCode, context).then((_) {
        friendCodeController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)?.friendAddedSuccessfully ?? 'Amigo agregado con éxito')),
        );
        notifyListeners();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      });
    }
  }

  @override
  void dispose() {
    friendCodeController.dispose();
    super.dispose();
  }
}