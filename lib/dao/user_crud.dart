import 'dart:convert';
import 'dart:math';

import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import '/database/database_helper.dart';
import '/models/user.dart';

class UserCRUD {
  Future<int> insertUser(User user) async {
    final db = await DatabaseHelper().database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [user.email],
    );

    if (result.isNotEmpty) {
      throw Exception('El correo ya está registrado');
    }

    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser(String email, String password) async {
    final db = await DatabaseHelper().database;
    var bytes1 = utf8.encode(password);
    password = sha256.convert(bytes1).toString();
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty
        ? User(
            id: result.first['id'] as int,
            name: result.first['name'] as String,
            email: result.first['email'] as String,
            password: result.first['password'] as String,
            birthday: DateTime.parse(result.first['birthday'] as String),
            code: result.first['code'] as String,
          )
        : null;
  }

  String generateUniqueCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const digits = '0123456789';
    Random rand = Random();

    String randomLetters() {
      return String.fromCharCodes(
          Iterable.generate(3, (_) => letters.codeUnitAt(rand.nextInt(letters.length))));
    }

    String randomDigits() {
      return String.fromCharCodes(
          Iterable.generate(3, (_) => digits.codeUnitAt(rand.nextInt(digits.length))));
    }

    return '${randomLetters()}${randomDigits()}${randomLetters()}';
  }
}
