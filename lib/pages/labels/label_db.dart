import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_todo_list/db/app_db.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/fun.dart';
import 'package:flutter_todo_list/myHttp/model/label_r.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/pages/labels/label.dart';
import 'package:sqflite/sqflite.dart';

/// 对标签的数据库操作
class LabelDB {
  static final LabelDB _labelDb = LabelDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  LabelDB._internal(this._appDatabase);

  static LabelDB get() {
    return _labelDb;
  }

  Future<bool> isLabelExits(Label label) async {
    print('------------------->isLabelExits');
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${Label.tblLabel} WHERE ${Label.dbName} LIKE '${label.name}'");
    if (result.length == 0) {
      return await updateLabels(label).then((value) {
        return false;
      });
    } else {
      return true;
    }
  }

  Future updateLabels(Label label) async {
    print("-------------------->updateLabels");
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Label.tblLabel}(${Label.dbName},${Label.dbColorCode},${Label.dbColorName})'
          ' VALUES("${label.name}", ${label.colorValue}, "${label.colorName}")');
    });
  }

  Future<List<Label>> getLabels() async {
    print("-------------------->getLabels()");
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery('SELECT * FROM ${Label.tblLabel}');
    List<Label> projects = List();
    for (Map<String, dynamic> item in result) {
      var myProject = Label.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future deleteLabel(int labelID) async {
    print('======================>deleteLabel');
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Label.tblLabel} WHERE ${Label.dbId}==$labelID;');
    });
  }


  Future<bool> isLabelExitsR(Label label) async {
    print('------------------->isLabelExits');
    Map<String, dynamic> labelId = {'lebelId': label.id};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();
    Response response = await fun.labelPostsR(Api.FindLabelRep, labelId);
    if (response.data['id'] == "0") {
      return await insertOrReplaceR(label).then((value) {
        return false;
      });
    } else {
      return true;
    }
  }



  Future insertOrReplaceR(Label label)async{
    Map<String, dynamic> create = {
      "labelName":label.name,
      "labelColorName":label.colorName,
      "labelColorCode": label.colorValue,
      "labelUser": GetInfo.userShow.userId};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();

    return await fun.messagePostR(Api.AddLabel, create);

  }

  Future<List<LabelR>> getLabelsR({bool isInboxVisible = true}) async {
    Map<String, dynamic> emails = {'userId': GetInfo.userShow.userId};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();
    Response response = await fun.labelPostsR(Api.FindLabel, emails);
    List responseList = json.decode(response.data);
    List pro = getLabelList(responseList);
    return pro;
  }

  List<LabelR> getLabelList(List<dynamic> list) {
    print(list);
    List<LabelR> result = [];
    list.forEach((item) {
      print("!!!!");
      result.add(LabelR.fromJson(item));
    });
    return result;
  }

}
