import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/birthday.dart';

class BirthdayCRUD {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

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

  // Insertar un cumpleaños o evento
  Future<void> insertBirthday(Birthday birthday) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'events',
      birthday.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

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

  Future<void> deleteBirthday(int? id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
