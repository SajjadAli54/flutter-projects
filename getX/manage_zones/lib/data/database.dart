import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('zones.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE changes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      table_name TEXT NOT NULL,
      operation TEXT NOT NULL,
      row_id INTEGER NOT NULL,
      row_data TEXT,
      timestamp TEXT NOT NULL
    )
    ''');
  }

  Future<void> logChange(String tableName, String operation, int rowId,
      [Map<String, dynamic>? rowData]) async {
    final db = await instance.database;
    await db.insert('changes', {
      'table_name': tableName,
      'operation': operation,
      'row_id': rowId,
      'row_data': rowData != null ? jsonEncode(rowData) : null,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    final db = await instance.database;
    final id = await db.insert(tableName, data);
    await logChange(tableName, 'insert', id, data);
    return id;
  }

  Future<int> update(
      String tableName, Map<String, dynamic> data, int id) async {
    final db = await instance.database;
    await db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
    await logChange(tableName, 'update', id, data);
    return id;
  }

  Future<int> delete(String tableName, int id) async {
    final db = await instance.database;
    final row = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (row.isNotEmpty) {
      await logChange(tableName, 'delete', id, row.first);
    }
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
