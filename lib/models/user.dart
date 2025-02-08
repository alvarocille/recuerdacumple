import 'package:recuerdacumple/models/person.dart';

/// Representa un usuario que extiende la clase [Person].
class User extends Person {
  /// El correo electrónico del usuario.
  final String email;

  /// La contraseña del usuario.
  final String password;

  /// El código del usuario.
  final String code;

  /// Crea una instancia de [User].
  ///
  /// El [id] es opcional. El [email], [password], [code], [name] y [birthday] son obligatorios.
  User({
    super.id,
    required this.email,
    required this.password,
    required this.code,
    required super.name,
    required super.birthday,
  });

  /// Convierte la instancia de [User] en un mapa.
  ///
  /// El mapa contiene las claves 'id', 'name', 'birthday', 'email', 'password' y 'code'.
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