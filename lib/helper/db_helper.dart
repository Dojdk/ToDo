import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/task.dart';
import '../models/type.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static const _databaseName = 'tasks_database.db';
  static const _databaseVersion = 1;

  static const table = 'tasks';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnIsDone = 'isdone';
  static const typesTable = 'types';
  static const columnTypeId = 'typeId';
  static const columnTypeName = 'name';
  static const columnTypeColor = 'color';

  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $typesTable (
        $columnTypeId INTEGER PRIMARY KEY,
        $columnTypeName TEXT NOT NULL,
        $columnTypeColor INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnIsDone BOOLEAN NOT NULL,
        $columnTypeId INTEGER,
        FOREIGN KEY ($columnTypeId) REFERENCES $typesTable($columnTypeId)
      )
    ''');
  }

  Future<void> insertType(TaskType type) async {
    final db = await instance.database;
    await db.insert(typesTable, type.toMap());
  }

  Future<List<TaskType>> getAllTypes() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(typesTable);
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (i) {
      return TaskType(
        id: maps[i][columnTypeId],
        name: maps[i][columnTypeName],
        color: Color(maps[i][columnTypeColor]),
      );
    });
  }

  Future<void> updateType(TaskType type) async {
    final db = await instance.database;
    await db.update(
      typesTable,
      type.toMap(),
      where: '$columnTypeId = ?',
      whereArgs: [type.id],
    );
  }

  Future<void> deleteType(int typeId) async {
    final db = await instance.database;
    await db.delete(
      table,
      where: '$columnTypeId = ?',
      whereArgs: [typeId],
    );
    await db.delete(
      typesTable,
      where: '$columnTypeId = ?',
      whereArgs: [typeId],
    );
  }

  Future<void> insertTask(Task task) async {
    final db = await instance.database;
    await db.insert(table, task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i][columnId],
        name: maps[i][columnName],
        typeId: maps[i][columnTypeId],
        isDone: maps[i][columnIsDone] == 1,
      );
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await instance.database;
    await db.update(
      table,
      task.toMap(),
      where: '$columnId = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int taskId) async {
    final db = await instance.database;
    await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [taskId],
    );
  }
}
