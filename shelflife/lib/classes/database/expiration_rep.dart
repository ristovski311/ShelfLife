import 'package:shelflife/classes/models/expiration.dart';
import 'package:shelflife/database/database_helper.dart';

class ExpirationRep {
  final _dbHelper = DatabaseHelper.instance;

  Future<List<Expiration>> getAll() async {
    final db = await _dbHelper.database;
    final rows = await db.query('expirations', orderBy: 'expirationDate ASC');
    return rows.map((r) => Expiration.fromMap(r)).toList();
  }

  Future<Expiration> getById(int id) async {
    final db = await _dbHelper.database;
    final row = await db.query('expirations', where: 'id = ?', whereArgs: [id]);
    return Expiration.fromMap(row.first);
  }

  Future<List<Expiration>> getForYearAndMonth(int year, int month) async {
    final db = await _dbHelper.database;
    final start = DateTime(year, month, 1).toIso8601String();
    final end = DateTime(year, month + 1, 1).toIso8601String();

    final rows = await db.query(
      'expirations',
      where: 'expirationDate >= ? AND expirationDate < ?',
      whereArgs: [start, end],
      orderBy: 'expirationDate ASC',
    );
    return rows.map((r) => Expiration.fromMap(r)).toList();
  }

  Future<List<Expiration>> getShouldRemindThisYearAndMonth(
    int year,
    int month, {
    int remindDaysInAdvance = 15,
  }) async {
    final db = await _dbHelper.database;
    final start = DateTime(
      year,
      month,
      1,
    ).add(Duration(days: remindDaysInAdvance)).toIso8601String();
    final end = DateTime(
      year,
      month + 1,
      1,
    ).add(Duration(days: remindDaysInAdvance)).toIso8601String();

    final rows = await db.query(
      'expirations',
      where: 'expirationDate >= ? AND expirationDate < ?',
      whereArgs: [start, end],
      orderBy: 'expirationDate ASC',
    );
    return rows.map((r) => Expiration.fromMap(r)).toList();
  }

  Future<List<Expiration>> getSoonExpiring(int maxDaysUntilExpiration) async {
    final db = await _dbHelper.database;
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day).toIso8601String();
    final end = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(Duration(days: maxDaysUntilExpiration)).toIso8601String();

    final rows = await db.query(
      'expirations',
      where: 'expirationDate >= ? AND expirationDate <= ?',
      whereArgs: [start, end],
      orderBy: 'expirationDate ASC',
    );
    return rows.map((r) => Expiration.fromMap(r)).toList();
  }

  Future<List<Expiration>> getByCategoryId(int categoryId) async {
    final db = await _dbHelper.database;

    final rows = await db.query(
      'expirations',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
      orderBy: 'expirationDate ASC',
    );
    return rows.map((r) => Expiration.fromMap(r)).toList();
  }

  Future<int> insert(Expiration e) async {
    final db = await _dbHelper.database;
    final map = e.toMap();
    map.remove('id');
    return db.insert('expirations', map);
  }

  Future<void> update(Expiration e) async {
    final db = await _dbHelper.database;
    await db.update(
      'expirations',
      e.toMap(),
      where: 'id = ?',
      whereArgs: [e.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await _dbHelper.database;
    await db.delete('expirations', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> setNoted(int id, bool noted) async {
    final db = await _dbHelper.database;
    await db.update(
      'expirations',
      {'noted': noted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
