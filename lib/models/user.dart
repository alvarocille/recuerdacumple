class User {
  final int? id;
  final String email;
  final String password;
  final String birthday;

  User({
    this.id,
    required this.email,
    required this.password,
    required DateTime birthday,
  }) : birthday = birthday.toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'birthday': birthday,
    };
  }
}