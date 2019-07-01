
import 'package:flutter_todo_list/db/app_db.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/fun.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/pages/projects/project.dart';
import 'package:sqflite/sqflite.dart';


///项目的数据库操作
class ProjectDB {
  static final ProjectDB _projectDb = ProjectDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  ProjectDB._internal(this._appDatabase);

  static ProjectDB get() {
    return _projectDb;
  }

  Future<List<Project>> getProjects({bool isInboxVisible = true}) async {
    print("======================>getProjects");
    print(isInboxVisible);
    var db = await _appDatabase.getDb();
    var whereClause = isInboxVisible ? ";" : " WHERE ${Project.dbId}!=1;";
    var result =
        await db.rawQuery('SELECT * FROM ${Project.tblProject} $whereClause');
    List<Project> projects = List();
    for (Map<String, dynamic> item in result) {
      var myProject = Project.fromMap(item);
      projects.add(myProject);
    }
    print(projects);
    return projects;
  }

  Future insertOrReplace(Project project) async {
    print("======================>insertOrReplace");
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Project.tblProject}(${Project.dbId},${Project.dbName},${Project.dbColorCode},${Project.dbColorName})'
          ' VALUES(${project.id},"${project.name}", ${project.colorValue}, "${project.colorName}")');
    });
  }

  Future deleteProject(int projectID) async {
    print('======================>deleteProject');
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Project.tblProject} WHERE ${Project.dbId}==$projectID;');
    });
  }
  Future deleteProjectR(int projectID)async{
    Map<String, dynamic> del = {'projectId':projectID};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();

    return await fun.messagePostR(Api.DeleteProject, del);
  }
  Future insertOrReplaceR(Project project)async{
    Map<String, dynamic> create = {
      "projectName":project.name,
      "projectColorName":project.colorName,
      "projectColorCode": project.colorValue,
      "projectUser": GetInfo.userShow.userId};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();

    return await fun.messagePostR(Api.AddProject, create);

  }
  Future<List<Project>> getProjectsR({bool isInboxVisible = true}) async {
    //var whereClause = isInboxVisible ?  : " WHERE ${Project.dbId}!=1;";
//    Map<String, dynamic> pros = {'userId':GetInfo.userShow.userId};
//    Fun fun = new Fun();
//    await fun.
//    List<Project> projects = List();
//    for (Map<String, dynamic> item in result) {
//      var myProject = Project.fromMap(item);
//      projects.add(myProject);
//    }
//    return projects;
  }
}
