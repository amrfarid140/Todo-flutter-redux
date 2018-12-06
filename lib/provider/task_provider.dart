import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:todo/models/task.dart';

class TaskProvider {
  Database _db;
  final String _tableName = "Task";
  final String _databaseName = "task.db";

  Future<void> open() async {
    Directory documentsDirectoty = await getApplicationDocumentsDirectory();
    _db = await openDatabase(join(documentsDirectoty.path, _databaseName),
        version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
          CREATE TABLE Task(id TEXT PRIMARY KEY NOT NULL, description TEXT NOT NULL, timestamp INT NOT NULL) 
          ''');
  }

  Future<Task> insertTask(Task task) async {
    await _db.insert(_tableName, task.toMap());
    return task;
  }

  Future<List<Task>> getAllTasks() async {
    List<Map> result = await _db.query(_tableName);
    if (result.length > 0) {
      return result.map((Map item) => Task.fromMap(item)).toList();
    } else {
      return [];
    }
    
  }

  Future<Task> deleteTask(Task task) async {
    await _db.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
    return task;
  }
}
