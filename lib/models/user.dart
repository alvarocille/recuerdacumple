import 'package:recuerdacumple/models/person.dart';

class User extends Person {
  final String email;
  final String password;

  User({
    super.id,
    required this.email,
    required this.password,
    required super.name,
    required super.birthday,
  });

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'email': email,
        'password': password,
      });
  }
}
