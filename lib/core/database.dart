import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    // final path = join(await getDatabasesPath(), 'tasks.db');

    late DatabaseFactory dbFactory;
    String path;

    if (kIsWeb) {
      // Use Web Database Factory
      dbFactory = databaseFactoryFfiWeb;
      path = 'tasks.db'; // Web does not use file paths
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Use sqflite_common_ffi for Desktop
      sqfliteFfiInit();
      dbFactory = databaseFactoryFfi;
      path = join(await getDatabasesPath(), 'tasks.db');
    } else {
      // Use Default SQLite for Mobile (Android/iOS)
      dbFactory = databaseFactory; // Fix for mobile
      path = join(await getDatabasesPath(), 'tasks.db');
    }

    return await dbFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        date TEXT NOT NULL,
        priority INTEGER NOT NULL
      )
    ''');
        },
      ),
    );

    // return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        date TEXT NOT NULL,
        priority INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertTask(Task task) async {
    final db = await instance.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final result = await db.query('tasks');
    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<void> updateTask(Task task) async {
    final db = await instance.database;
    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(int id) async {
    final db = await instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
