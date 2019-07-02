import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_todo_list/db/app_db.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/fun.dart';
import 'package:flutter_todo_list/myHttp/model/task_r.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/pages/tasks/models/tasks.dart';
import 'package:flutter_todo_list/pages/projects/project.dart';
import 'package:flutter_todo_list/pages/labels/label.dart';
import 'package:flutter_todo_list/pages/tasks/models/task_labels.dart';
import 'package:sqflite/sqflite.dart';

///任务的数据库操作
class TaskDB {
  static final TaskDB _taskDb = TaskDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  TaskDB._internal(this._appDatabase);

  //static TaskDB get taskDb => _taskDb;

  static TaskDB get() {
    return _taskDb;
  }

  Future<List<Tasks>> getTasks(
      {int startDate = 0, int endDate = 0, TaskStatus taskStatus}) async {
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~>getTasks()");
    var db = await _appDatabase.getDb();
    var whereClause = startDate > 0 && endDate > 0
        ? "WHERE ${Tasks.tblTask}.${Tasks.dbDueDate} BETWEEN $startDate AND $endDate"
        : "";

    if (taskStatus != null) {
      var taskWhereClause =
          "${Tasks.tblTask}.${Tasks.dbStatus} = ${taskStatus.index}";
      whereClause = whereClause.isEmpty
          ? "WHERE $taskWhereClause"
          : "$whereClause AND $taskWhereClause";
    }

    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames '
        'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
        'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
        'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} $whereClause GROUP BY ${Tasks.tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');
    print(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames '
        'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
        'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
        'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} $whereClause GROUP BY ${Tasks.tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');
    print('?????????????????????????????');
    print(result);

    return _bindData(result);
  }

  List<Tasks> _bindData(List<Map<String, dynamic>> result) {
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~>_bindData");
    List<Tasks> tasks = List();
    for (Map<String, dynamic> item in result) {
      var myTask = Tasks.fromMap(item);
      myTask.projectName = item[Project.dbName];
      myTask.projectColor = item[Project.dbColorCode];
      var labelComma = item["labelNames"];
      if (labelComma != null) {
        myTask.labelList = labelComma.toString().split(",");
      }
      tasks.add(myTask);
    }
    return tasks;
  }

  Future<List<Tasks>> getTasksByProject(int projectId,
      {TaskStatus status}) async {
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~>getTasksByProject");
    var db = await _appDatabase.getDb();
    String whereStatus = status != null
        ? "AND ${Tasks.tblTask}.${Tasks.dbStatus}=${status.index}"
        : "";
    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames '
        'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
        'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
        'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=$projectId $whereStatus GROUP BY ${Tasks.tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');
    print('?????????????????????????????');
    print(result);
    return _bindData(result);
  }

  Future<List<Tasks>> getTasksByLabel(String labelName,
      {TaskStatus status}) async {
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~>getTasksByLabel");
    var db = await _appDatabase.getDb();
    String whereStatus = status != null
        ? "AND ${Tasks.tblTask}.${Tasks.dbStatus}=${TaskStatus.PENDING.index}"
        : "";
    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
        'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
        'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=${Project.tblProject}.${Project.dbId} $whereStatus GROUP BY ${Tasks.tblTask}.${Tasks.dbId} having labelNames LIKE "%$labelName%" ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');
    print('?????????????????????????????');
    print(result);
    return _bindData(result);
  }

  Future deleteTask(int taskID) async {
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~>deleteTask");
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Tasks.tblTask} WHERE ${Tasks.dbId}=$taskID;');
    });
  }

  Future updateTaskStatus(int taskID, TaskStatus status) async {
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~>updateTaskStatus");
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${Tasks.tblTask} SET ${Tasks.dbStatus} = '${status.index}' WHERE ${Tasks.dbId} = '$taskID'");
    });
  }

  /// Inserts or replaces the task.
  Future updateTask(Tasks task, {List<int> labelIDs}) async {
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~>updateTask");
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Tasks.tblTask}(${Tasks.dbId},${Tasks.dbTitle},${Tasks.dbProjectID},${Tasks.dbComment},${Tasks.dbDueDate},${Tasks.dbPriority},${Tasks.dbStatus})'
          ' VALUES(${task.id}, "${task.title}", ${task.projectId},"${task.comment}", ${task.dueDate},${task.priority.index},${task.tasksStatus.index})');
      if (id > 0 && labelIDs != null && labelIDs.length > 0) {
        labelIDs.forEach((labelId) {
          txn.rawInsert('INSERT OR REPLACE INTO '
              '${TaskLabels.tblTaskLabel}(${TaskLabels.dbId},${TaskLabels.dbTaskId},${TaskLabels.dbLabelId})'
              ' VALUES(null, $id, $labelId)');
        });
      }
    });
  }

  Future<List<TaskR>> getTasksR(
      {int startDate = 0, int endDate = 0, TaskStatus taskStatus}) async {
    Fun fun = new Fun();
    Response response;
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    if (startDate > 0 && endDate > 0) {
      Map<String, dynamic> get = {
        'userId': GetInfo.userShow.userId,
        'startDate': startDate,
        'endDate': endDate
      };
      response = await fun.labelPostsR(Api.FindTaskByDate, get);
    } else {}
    if (taskStatus != null) {
      Map<String, dynamic> get = {'userId': GetInfo.userShow.userId};
      response = await fun.labelPostsR(Api.FindTaskByStatus, get);
    } else {
      Map<String, dynamic> get = {'userId': GetInfo.userShow.userId};
      response = await fun.labelPostsR(Api.FindTask, get);
    }
    List responseList = json.decode(response.data);
    List pro = getTaskList(responseList);
    return pro;
  }

  List<TaskR> getTaskList(List<dynamic> list) {
    print(list);
    List<TaskR> result = [];
    list.forEach((item) {
      print("!!!!");
      result.add(TaskR.fromJson(item));
    });
    return result;
  }

  Future<List<Tasks>> getTasksByProjectR(int projectId,
      {TaskStatus status}) async {
    Fun fun = new Fun();
    Response response;
    if (status != null) {
      Map<String, dynamic> get = {
        'projectId': projectId,
        'taskStatus': status.index
      };
      response = await fun.labelPostsR(Api.GetTaskByProject, get);
    } else {
      Map<String, dynamic> get = {
        'projectId': projectId,
      };
      response = await fun.labelPostsR(Api.GetTaskByProject, get);
    }
    List responseList = json.decode(response.data);
    List pro = getTaskList(responseList);
    return _bindData(pro);
  }

  Future<List<Tasks>> getTasksByLabelR(String labelName,String labelId,
      {TaskStatus status}) async {
    Fun fun = new Fun();
    Response response;
    if(status != null){
      Map<String, dynamic> get = {
        'labelId': labelId,
        'taskStatus': status.index
      };
      response = await fun.labelPostsR(Api.GetTaskByLabel, get);
    }
    else{
      Map<String, dynamic> get = {
        'labelId': labelId,
      };
      response = await fun.labelPostsR(Api.GetTaskByLabel, get);
    }
    List responseList = json.decode(response.data);
    List pro = getTaskList(responseList);

    return _bindData(pro);
  }

  Future deleteTaskR(int taskID) async {
    Map<String, dynamic> del = {'taskId':taskID};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();
    return await fun.messagePostR(Api.DeleteTask, del);

  }

  Future updateTaskStatusR(int taskID, TaskStatus status) async {
    Map<String, dynamic> up = {'taskId': taskID,'taskStatus': status};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();
    return await fun.messagePostR(Api.UpdateTask, up);
  }

  /// Inserts or replaces the task.
  Future updateTaskR(Tasks task, {List<int> labelIDs}) async {
    Map<String, dynamic> up = {'taskId': task.id, 'taskTitles': task.title,
      'taskComment': task.comment, 'taskDueDate': task.tasksStatus,
      'taskPriority': task.priority, 'taskProjectId': task.projectId,
      'taskUserId': GetInfo.userShow.userId, 'taskStatus': task.tasksStatus};
    Fun fun = new Fun();
   // return await fun.messagePostR(Api.UpdateTask, up);
//    if (id > 0 && labelIDs != null && labelIDs.length > 0) {
//        labelIDs.forEach((labelId) {
//          txn.rawInsert('INSERT OR REPLACE INTO '
//              '${TaskLabels.tblTaskLabel}(${TaskLabels.dbId},${TaskLabels.dbTaskId},${TaskLabels.dbLabelId})'
//              ' VALUES(null, $id, $labelId)');
//        });
//      }
    return await fun.messagePostR(Api.UpdateTask, up);
  }
}
