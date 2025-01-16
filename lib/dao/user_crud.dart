import 'package:sqflite/sqflite.dart';
import '/database/database_helper.dart';
import '/models/user.dart';

class UserCRUD {
  Future<int> insertUser(User user) async {
    final db = await DatabaseHelper().database;

    // Verificar si el correo ya está registrado
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
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty
        ? User(
            id: result.first['id'] as int,
            email: result.first['email'] as String,
            password: result.first['password'] as String,
            birthday: DateTime.parse(result.first['birthday'] as String), // Parsear de vuelta a DateTime
          )
        : null;
  }
}
