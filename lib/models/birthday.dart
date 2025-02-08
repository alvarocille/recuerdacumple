class Birthday {
  final int? id;
  String name;
  DateTime date;
  final int? userId;

  Birthday({
    this.id,
    required this.name,
    required this.date,
    this.userId,
  });

  /// Actualiza los detalles del cumpleaños
  void updateDetails({required String newName, required DateTime newDate}) {
    name = newName;
    date = newDate;
  }

  /// Crea un [Birthday] a partir de un mapa.
  ///
  /// El mapa debe contener las claves 'id', 'name', 'date' y 'user_id'.
  factory Birthday.fromMap(Map<String, dynamic> map) {
    return Birthday(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      userId: map['user_id'],
    );
  }

  /// Convierte la instancia de [Birthday] en un mapa.
  ///
  /// El mapa contiene las claves 'id', 'name', 'date' y 'user_id'.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'user_id': userId,
    };
  }
}
