import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'TaskModel.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'tasks.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, details TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> addTask(Task task) async {
    final Database db = await initializeDB();
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> retrieveTasks() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('tasks');
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }

  Future<void> deleteTask(int id) async {
    final Database db = await initializeDB();
    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}