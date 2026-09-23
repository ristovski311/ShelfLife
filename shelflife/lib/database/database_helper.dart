import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  static Database? _db;
  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'shelflife.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE categories(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT
          )
      ''');

        await db.execute('''
          CREATE TABLE expirations(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productBrand TEXT NOT NULL,          
            productName TEXT NOT NULL,
            categoryId INTEGER NOT NULL,
            expirationDate TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            noted INTEGER NOT NULL DEFAULT 0,
            FOREIGN KEY (categoryId) REFERENCES categories(id)
          )
      ''');
      },
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}
}
