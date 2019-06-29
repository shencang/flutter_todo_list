import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/utils/app_constant.dart';
import 'package:flutter_todo_list/utils/app_util.dart';

///用户界面
class UserScreen extends StatefulWidget {
  @override
  _UserScreen createState() => new _UserScreen();
}

class _UserScreen extends State<UserScreen> {
  Image userHeadBlur = new Image.asset(
    "assets/avatar/wo.png",
    width: MediaQueryData.fromWindow(window).size.width,
    height: 300,
    fit: BoxFit.fitHeight,
  );
  Image userHead = new Image.asset("assets/avatar/wo.png");

  getUserHead() {
    return "assets/avatar/wo.png";
  }

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
                                        image: AssetImage(
                                            "assets/avatar/wo.png")),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      "用户名",
                                      style: TextStyle(fontSize: 30),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "用户的个性签名",
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
                        title: Text("1145534369@qq.com"),
                        subtitle: Text("电子邮箱"),
                        //onTap: () => launchURL(GITHUB_URL),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.assignment_ind, color: Colors.black),
                        title: Text("用户名"),
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
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
