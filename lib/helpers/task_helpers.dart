import 'package:lista_app/models/tarefa.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskHelper {
  static final TaskHelper _instance = TaskHelper.internal();

  factory TaskHelper() => _instance;

  TaskHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "todo_list.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE task("
          "id INTEGER PRIMARY KEY, "
          "titulo TEXT) ");
    });
  }

  Future<Tarefa> save(Tarefa task) async {
    Database database = await db;
    task.id = await database.insert('task', task.toMap());
    return task;
  }

  Future<Tarefa?> getById(int id) async {
    Database database = await db;
    List maps = await database.query('task',
        columns: ['id', 'titulo'], where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Tarefa.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Tarefa>> getAll() async {
    Database database = await db;
    List listMap = await database.rawQuery("SELECT * FROM task");
    List<Tarefa> stuffList = listMap.map((x) => Tarefa.fromMap(x)).toList();
    return stuffList;
  }

  Future<int> update(Tarefa task) async {
    Database database = await db;
    return await database
        .update('task', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete('task', where: 'id = ?', whereArgs: [id]);
  }
}
