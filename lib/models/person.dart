class Person {
  final int? id;
  final String name;
  final DateTime birthday;

  Person({
    this.id,
    required this.name,
    required this.birthday,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday,
    };
  }
}
