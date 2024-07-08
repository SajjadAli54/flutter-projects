import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_tasks/app/data/models/task.dart';

class DatabaseHelper {
  static const _databaseName = "Mydatabase.db";
  static const _databaseVersion = 1;
  static const _tableName = "tasks";

  static final DatabaseHelper instance = DatabaseHelper._internal();

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(db, version) async {
    await db.execute('''  
    CREATE TABLE $_tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL UNIQUE,
      isFavorite BOOLEAN NOT NULL
     )''');
  }

  Future<Task> upsert(Task task) async {
    Database db = await instance.database;
    if (task.id == -1) {
      task.id = await db.insert(_tableName, task.toJson());
    } else {
      await db.update(_tableName, task.toJson(),
          where: "id = ?", whereArgs: [task.id]);
    }
    return task;
  }

  Future<List<Task>> readAll() async {
    final db = await instance.database;
    final result = await db.query(_tableName);
    return result.map((json) => Task.fromJson(json)).toList();
  }
}
