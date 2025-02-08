import 'package:flutter/material.dart';
import '../../../provider/user_provider.dart';
import '/models/user.dart';
import 'package:provider/provider.dart';

class ProfileViewModel extends ChangeNotifier {
  User? getCurrentUser(BuildContext context) {
    return Provider.of<UserProvider>(context, listen: false).user;
  }
}
