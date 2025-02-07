import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class CommunityViewModel extends ChangeNotifier {
  final String _myFriendCode = "ABC123XYZ";
  final TextEditingController friendCodeController = TextEditingController();

  String get myFriendCode => _myFriendCode;

  // Método para compartir el código de amigo
  void shareFriendCode() {
    Share.share('No olvides mi cumpleaños. Mi código de amigo en RecuerdaCumple es: $_myFriendCode');
  }

  @override
  void dispose() {
    friendCodeController.dispose();
    super.dispose();
  }
}