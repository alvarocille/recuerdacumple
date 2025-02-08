import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Clase para ayudar con la gestión de la base de datos.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  /// Retorna la instancia única de [DatabaseHelper].
  factory DatabaseHelper() => _instance;

  /// Obtiene la base de datos, inicializándola si es necesario.
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /// Inicializa la base de datos.
  ///
  /// Retorna una instancia de [Database].
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'recuerdacumple.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Crea las tablas necesarias en la base de datos.
  ///
  /// Este método se llama cuando la base de datos se crea por primera vez.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        birthday TEXT NOT NULL,
        code TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS friends (
        user_id INTEGER NOT NULL,
        friend_id INTEGER NOT NULL,
        FOREIGN KEY(user_id) REFERENCES users(id),
        FOREIGN KEY(friend_id) REFERENCES users(id),
        PRIMARY KEY(user_id, friend_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        date TEXT NOT NULL,
        user_id INTEGER,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');
  }
}
