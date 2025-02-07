class Birthday {
  final int? id;
  final String name;
  final DateTime date;
  final int? userId;

  Birthday({
    this.id,
    required this.name,
    required this.date,
    this.userId,
  });

  factory Birthday.fromMap(Map<String, dynamic> map) {
    return Birthday(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      userId: map['user_id'],
    );
  }



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'user_id': userId,
    };
  }
}

