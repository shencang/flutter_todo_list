import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/pages/labels/label.dart';
import 'package:flutter_todo_list/pages/projects/project.dart';
import 'package:flutter_todo_list/pages/tasks/models/task_labels.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_todo_list/pages/tasks/models/tasks.dart';
import 'package:mysql1/mysql1.dart';

/// 这是处理所有数据库事务的单例数据库类
/// 这里处理所有任务原始查询并返回带有结果的Future <T>
class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  //private internal constructor to make it singleton
  AppDatabase._internal();

  Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// 使用此方法访问数据库，为您提供[Database]的future，
  /// because initialization of the database (it has to go through the method channel)
  /// 因为数据库的初始化（它必须通过方法通道）
  Future<Database> getDb() async {
    if (!didInit) await _init();
    await _connectionUserTable();
    return _database;
  }

  ///创建数据库并添加对应的表
  Future _init() async {
    // 使用path_provider获取位置
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tasks.db");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // 创建数据库时，请创建表
      await _createProjectTable(db);
      await _createTaskTable(db);
      await _createLabelTable(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE ${Tasks.tblTask}");
      await db.execute("DROP TABLE ${Project.tblProject}");
      await db.execute("DROP TABLE ${TaskLabels.tblTaskLabel}");
      await db.execute("DROP TABLE ${Label.tblLabel}");
      await _createProjectTable(db);
      await _createTaskTable(db);
      await _createLabelTable(db);
    });
    didInit = true;
  }

  ///创建项目表
  Future _createProjectTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Project.tblProject} ("
          "${Project.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Project.dbName} TEXT,"
          "${Project.dbColorName} TEXT,"
          "${Project.dbColorCode} INTEGER);");
      txn.rawInsert('INSERT INTO '
          '${Project.tblProject}(${Project.dbId},${Project.dbName},${Project.dbColorName},${Project.dbColorCode})'
          ' VALUES(1, "默认收集箱", "灰", ${Colors.grey.value});');
    });
  }

  ///创建标签表
  Future _createLabelTable(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${Label.tblLabel} ("
          "${Label.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Label.dbName} TEXT,"
          "${Label.dbColorName} TEXT,"
          "${Label.dbColorCode} INTEGER);");
      txn.execute("CREATE TABLE ${TaskLabels.tblTaskLabel} ("
          "${TaskLabels.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${TaskLabels.dbTaskId} INTEGER,"
          "${TaskLabels.dbLabelId} INTEGER,"
          "FOREIGN KEY(${TaskLabels.dbTaskId}) REFERENCES ${Tasks.tblTask}(${Tasks.dbId}) ON DELETE CASCADE,"
          "FOREIGN KEY(${TaskLabels.dbLabelId}) REFERENCES ${Label.tblLabel}(${Label.dbId}) ON DELETE CASCADE);");
    });
  }

  ///创建任务表
  Future _createTaskTable(Database db) {
    return db.execute("CREATE TABLE ${Tasks.tblTask} ("
        "${Tasks.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${Tasks.dbTitle} TEXT,"
        "${Tasks.dbComment} TEXT,"
        "${Tasks.dbDueDate} LONG,"
        "${Tasks.dbPriority} LONG,"
        "${Tasks.dbProjectID} LONG,"
        "${Tasks.dbStatus} LONG,"
        "FOREIGN KEY(${Tasks.dbProjectID}) REFERENCES ${Project.tblProject}(${Project.dbId}) ON DELETE CASCADE);");
  }

  ///连接用户表
  Future _connectionUserTable() async{
    var settings = new ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'jinhao',
        db: 'world'
    );
    var conn = await MySqlConnection.connect(settings);
    print("===============>${conn.toString()}");
  }
}
