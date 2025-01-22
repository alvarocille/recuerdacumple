class Person {
  final int? id;
  final String name;
  final String birthday;

  Person({
    this.id,
    required this.name,
    required DateTime birthday,
  }) : birthday = birthday.toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday,
    };
  }
}
