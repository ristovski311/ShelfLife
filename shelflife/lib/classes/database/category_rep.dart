import 'package:shelflife/classes/models/category.dart';
import 'package:shelflife/database/database_helper.dart';

class CategoryRep {
  final _dbHelper = DatabaseHelper.instance;

  Future<List<Category>> getAll() async {
    final db = await _dbHelper.database;
    final rows = await db.query('categories', orderBy: 'name ASC');
    return rows.map((r) => Category.fromMap(r)).toList();
  }

  Future<Category> getById(int id) async {
    final db = await _dbHelper.database;
    final row = await db.query('categories', where: 'id = ?', whereArgs: [id]);
    return Category.fromMap(row.first);
  }

  Future<int> insert(Category c) async {
    final db = await _dbHelper.database;
    final map = c.toMap();
    map.remove('id');
    return db.insert('categories', map);
  }

  Future<void> update(Category c) async {
    final db = await _dbHelper.database;
    await db.update(
      'categories',
      c.toMap(),
      where: 'id = ?',
      whereArgs: [c.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await _dbHelper.database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
