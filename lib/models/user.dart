import 'package:recuerdacumple/models/person.dart';

class User extends Person {
  final String email;
  final String password;
  final String code;

  User({
    super.id,
    required this.email,
    required this.password,
    required this.code,
    required super.name,
    required super.birthday,
  });

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'email': email,
        'password': password,
        'code': code,
      });
  }
}
