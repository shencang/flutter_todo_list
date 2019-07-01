import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/pages/login/login_page.dart';
import 'package:flutter_todo_list/pages/user/user_bloc.dart';
import 'package:flutter_todo_list/utils/app_constant.dart';
import 'package:flutter_todo_list/utils/loading.dart';

import 'modify_password_page.dart';

///用户界面
class PassWordModifyScreen extends StatefulWidget {
  @override
  _PassWordModifyScreen createState() => new _PassWordModifyScreen();
}

class _PassWordModifyScreen extends State<PassWordModifyScreen> {
  String _password, _newPassword;
  bool _isObscure = true, _isModify = false;
  UserBloc _userBloc = new UserBloc();
  Color _eyeColor;
  final _formKey = GlobalKey<FormState>();

  //static user userShow = GetInfo.userShow;
  Image userHead = new Image.network(
    Api.BaseUrl_com + GetInfo.userShow.userAvatar,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(GetInfo.userShow.username),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("风险操作",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    ListTile(
                      leading: Icon(Icons.group_work, color: Colors.black),
                      title: Text(GetInfo.userShow.userEmail),
                      subtitle: Text("修改密码"),
                      onTap: () =>Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                        return new ModifyScreen();
                      }))
                    ),
                  ])),
              Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                        child: Text("账号体系",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: FONT_MEDIUM)),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.delete_outline, color: Colors.black),
                        title: Text("销毁账号"),
                        subtitle: Text(
                          "警告：该操作不可逆转",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        //onTap: () => launchURL(GITHUB_URL),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsetsDirectional.only(top: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
