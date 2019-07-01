import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/model/user.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/pages/login/login_page.dart';
import 'package:flutter_todo_list/utils/app_constant.dart';
import 'package:flutter_todo_list/utils/app_util.dart';

///用户界面
class UserScreen extends StatefulWidget {
  @override
  _UserScreen createState() => new _UserScreen();
}

class _UserScreen extends State<UserScreen> {
  //static user userShow = GetInfo.userShow;
  Image userHeadBlur = new Image.network(
    Api.BaseUrl_com + GetInfo.userShow.userAvatar,
    width: MediaQueryData.fromWindow(window).size.width,
    height: 300,
    fit: BoxFit.fitWidth,
  );
  Image userHead = new Image.network(
    Api.BaseUrl_com + GetInfo.userShow.userAvatar,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("用户"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        userHeadBlur,
                        BackdropFilter(
                          filter: new ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: new Container(
                            color: Colors.white.withOpacity(0.1),
                            width: MediaQueryData.fromWindow(window).size.width,
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(Api.BaseUrl_com +
                                            GetInfo.userShow.userAvatar)),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      GetInfo.userShow.username,
                                      style: TextStyle(fontSize: 30),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      GetInfo.userShow.userSignature == null
                                          ? ""
                                          : GetInfo.userShow.userSignature,
                                      style: TextStyle(fontSize: 20),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.email, color: Colors.black),
                        title: Text(GetInfo.userShow.userEmail),
                        subtitle: Text("电子邮箱"),
                        //onTap: () => launchURL(GITHUB_URL),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.assignment_ind, color: Colors.black),
                        title: Text(GetInfo.userShow.username),
                        subtitle: Text("个人信息"),
                        //onTap: () => launchURL(GITHUB_URL),
                      ),
                      ListTile(
                        leading: Icon(Icons.mode_edit, color: Colors.black),
                        title: Text("账号安全"),
                        subtitle: Text("密码。账号等"),
                        //onTap: () => launchURL(GITHUB_URL),
                      ),
                      ListTile(
                        leading: Icon(Icons.chat_bubble_outline,
                            color: Colors.black),
                        title: Text("反馈信息"),
                        subtitle: Text("让行知变得更好"),
                        //onTap: () => launchURL(GITHUB_URL),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsetsDirectional.only(top: 10)),
              MaterialButton(
                clipBehavior: Clip.antiAlias,
                height: 50.0,
                textColor: Colors.white,
                color: Colors.red,
                child: new Text("退出登录"),
                onPressed: () {
                  GetInfo.userShow = null;
                  Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                      return new LoginPage();
                    }));},
              )
            ],
          ),
        ),
      ),
    );
  }
}
