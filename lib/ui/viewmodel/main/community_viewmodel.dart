import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class CommunityViewModel extends ChangeNotifier {
  String _myFriendCode = '';
  final TextEditingController friendCodeController = TextEditingController();

  String get myFriendCode => _myFriendCode;

  void shareFriendCode() {
    Share.share('No olvides mi cumpleaños. Mi código de amigo en RecuerdaCumple es: $_myFriendCode');
  }

  void updateFriendCode(String userCode) {
    _myFriendCode = userCode;
    notifyListeners();
  }

  @override
  void dispose() {
    friendCodeController.dispose();
    super.dispose();
  }
}
