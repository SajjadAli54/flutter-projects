import 'dart:convert';
import 'package:manage_zones/models/region.dart';
import 'package:manage_zones/models/zone.dart';
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
    CREATE TABLE regions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT NOT NULL,
      zoneDtos TEXT,
      status BOOLEAN NOT NULL,
      title TEXT NOT NULL,
      createdBy TEXT NOT NULL,
      updatedBy TEXT NOT NULL,
      createdOn TEXT NOT NULL,
      updatedOn TEXT NOT NULL
    );
    ''');

    await db.execute('''

    CREATE TABLE zones (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      regionId INTEGER NOT NULL,
      areasDto TEXT,
      type TEXT NOT NULL,
      status BOOLEAN NOT NULL,
      title TEXT NOT NULL,
      createdBy TEXT NOT NULL,
      updatedBy TEXT NOT NULL,
      createdUpon TEXT NOT NULL,
      updatedUpon TEXT NOT NULL,
      FOREIGN KEY (regionId) REFERENCES regions(id) ON DELETE CASCADE ON UPDATE NO ACTION
    );
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
    final id = await db.insert(
        tableName, {...data, "createdOn": DateTime.now().toIso8601String()});
    await logChange(tableName, 'insert', id, data);
    return id;
  }

  Future<void> insertBatch(
      String tableName, List<Map<String, dynamic>> data) async {
    final db = await instance.database;
    Batch batch = db.batch();

    for (var datum in data) {
      batch.insert(tableName, datum);
    }

    await batch.commit(noResult: true);
  }

  Future<List<Region>> getAllRegions() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('regions');

    return List<Region>.from(maps.map((map) => Region.fromJson(map)));
  }

  Future<List<Zone>> getAllZones(int regionId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'zones',
      where: 'regionId = ?',
      whereArgs: [regionId],
    );

    return List<Zone>.from(maps.map((map) => Zone.fromJson(map)));
  }
}
