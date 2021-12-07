import 'dart:async';
import 'package:flutter_sqlite_todo/data/models/task_model.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskLocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'task_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, date TEXT, state INTEGER)');
  }

  Future<void> addTask(TaskModel task) async {
    //print("Adding task to db");
    final db = await database;

    await db.insert(
      'tasks',
      task.toMapSqlite(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //TO DO:
  Future<List<TaskModel>> getAllTasks() async {
    // 1.Obtener una referencia a la base de datos.
    final db = await database;

    // 2.Consultar la tabla para todas las Tareas.
    final List<Map<String, dynamic>> tasks = await db.query('tasks');

    // 3.Convertir la Lista<Map<String, dynamic> en una Lista<tasks>.
    return List.generate(tasks.length, (i) {
      return TaskModel(
          id: tasks[i]['id'],
          content: tasks[i]['content'],
          state: tasks[i]['state'] == 1 ? true : false,
          date: DateTime.parse(tasks[i]['date']));
    });
  }

  // 4.Implementa un futuro para eliminar tareas especificas.
  Future<void> deleteTask(id) async {
    final db = await database;

    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // 5.Implementa un futuro para eliminar todas las tareas
  Future<void> deleteAll() async {
    final db = await database;

    await db.delete('tasks');
  }

  // 6.Implementa un futuro para actualizar tareas
  Future<void> updateTask(TaskModel task) async {
    final db = await database;

    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }
}
