/// Representa una persona.
class Person {
  /// El identificador único de la persona.
  final int? id;

  /// El nombre de la persona.
  final String name;

  /// La fecha de nacimiento de la persona.
  final DateTime birthday;

  /// Crea una instancia de [Person].
  ///
  /// El [id] es opcional. El [name] y [birthday] son obligatorios.
  Person({
    this.id,
    required this.name,
    required this.birthday,
  });

  /// Crea una [Person] a partir de un mapa.
  ///
  /// El mapa debe contener las claves 'id', 'name' y 'birthdate'.
  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      name: map['name'],
      birthday: DateTime.parse(map['birthdate']),
    );
  }

  /// Convierte la instancia de [Person] en un mapa.
  ///
  /// El mapa contiene las claves 'id', 'name' y 'birthday'.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday.toIso8601String(),
    };
  }
}
