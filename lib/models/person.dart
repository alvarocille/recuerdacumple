class Person {
  final int? id;
  final String name;
  final DateTime birthday;

  Person({
    this.id,
    required this.name,
    required this.birthday,
  });

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      name: map['name'],
      birthday: DateTime.parse(map['birthdate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday.toIso8601String(),
    };
  }
}
