import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/birthday.dart';

/// Clase para realizar operaciones CRUD en la base de datos para eventos de cumpleaños.
class BirthdayCRUD {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  /// Obtiene el cumpleaños de un usuario dado su [userId].
  ///
  /// Retorna una instancia de [Birthday] si se encuentra, de lo contrario retorna null.
  Future<Birthday?> getUserBirthday(int userId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      final user = maps.first;
      return Birthday(
        id: user['id'],
        name: user['name'],
        date: DateTime.parse(user['birthday']),
        userId: user['id'],
      );
    }
    return null;
  }

  /// Obtiene los eventos de un usuario dado su [userId].
  ///
  /// Retorna una lista de instancias de [Birthday].
  Future<List<Birthday>> getUserEvents(int userId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'events',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      final event = maps[i];

      final String eventDateString = event['date'].toString();

      DateTime eventDate;
      try {
        eventDate = DateTime.parse(eventDateString);
      } catch (e) {
        eventDate = DateTime(2000, 1, 1);
      }

      return Birthday(
        id: event['id'],
        name: event['name'],
        date: eventDate,
        userId: event['user_id'],
      );
    });
  }

  /// Obtiene todos los eventos de la base de datos.
  ///
  /// Retorna una lista de instancias de [Birthday].
  Future<List<Birthday>> getAllEvents() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('events');

    return List.generate(maps.length, (i) {
      final event = maps[i];
      return Birthday(
        id: event['id'],
        name: event['name'],
        date: DateTime.parse(event['date']),
        userId: event['user_id'],
      );
    });
  }

  /// Inserta un cumpleaños o evento en la base de datos.
  Future<void> insertBirthday(Birthday birthday) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'events',
      birthday.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtiene los cumpleaños de los amigos de un usuario dado su [userId].
  ///
  /// Retorna una lista de instancias de [Birthday].
  Future<List<Birthday>> getFriendsBirthdays(int userId) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT u.id, u.name, u.birthday, u.id AS user_id
    FROM users u
    JOIN friends f ON f.friend_id = u.id
    WHERE f.user_id = ?
    ''', [userId]);

    return List.generate(maps.length, (i) {
      final friend = maps[i];
      return Birthday(
        id: friend['id'],
        name: friend['name'],
        date: DateTime.parse(friend['birthday']),
        userId: friend['user_id'],
      );
    });
  }

  /// Elimina un cumpleaños o evento de la base de datos dado su [id].
  Future<void> deleteBirthday(int? id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Elimina un cumpleaños de amigo de la base de datos dado su [id].
  Future<void> deleteFriendBirthday(int? id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'friends',
      where: 'friend_id = ?',
      whereArgs: [id],
    );
  }

  /// Verifica si un evento es del usuario dado su [id].
  ///
  /// Retorna true si el evento es del usuario, de lo contrario retorna false.
  Future<bool> isUserEvent(int? id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}