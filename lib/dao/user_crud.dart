import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import '/database/database_helper.dart';
import '/models/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Clase para realizar operaciones CRUD en la base de datos para usuarios.
class UserCRUD {
  /// Inserta un usuario en la base de datos.
  ///
  /// Si el correo electrónico ya está registrado, lanza una excepción.
  Future<int> insertUser(User user, BuildContext context) async {
    final db = await DatabaseHelper().database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [user.email],
    );

    if (result.isNotEmpty) {
      throw Exception(AppLocalizations.of(context)?.alreadyRegistered ?? 'El correo ya está registrado');
    }

    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtiene un usuario de la base de datos dado su [email] y [password].
  ///
  /// Si no se encuentra el usuario, retorna null.
  Future<User?> getUser(String email, String password, BuildContext context) async {
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

  /// Genera un código único.
  ///
  /// El código generado consiste en letras y dígitos aleatorios.
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

  /// Añade un amigo dado su [friendCode].
  ///
  /// Si el código de amigo es inválido o ya son amigos, lanza una excepción.
  Future<void> addFriend(User user, String friendCode, BuildContext context) async {
    final db = await DatabaseHelper().database;
    final userId = user.id;

    final friendResult = await db.query(
      'users',
      columns: ['id'],
      where: 'code = ?',
      whereArgs: [friendCode],
    );

    if (friendResult.isEmpty) {
      throw Exception(AppLocalizations.of(context)?.invalidFriendCode ?? 'Código de amigo no válido');
    }
    final friendId = friendResult.first['id'] as int;

    if (userId == friendId) {
      throw Exception(AppLocalizations.of(context)?.cantAddYourselfAsFriend ?? 'No puedes agregarte a ti mismo como amigo');
    }

    final existingFriendship = await db.query(
      'friends',
      where: '(user_id = ? AND friend_id = ?)',
      whereArgs: [userId, friendId],
    );

    if (existingFriendship.isNotEmpty) {
      throw Exception(AppLocalizations.of(context)?.alreadyFriends ?? 'Ya son amigos');
    }

    // Insertar la relación de amistad
    await db.insert('friends', {
      'user_id': userId,
      'friend_id': friendId,
    });
  }
}