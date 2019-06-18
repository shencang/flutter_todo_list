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
  Image userHead = new Image.asset(
    "assets/profile_pics.jpg",
    width: MediaQueryData.fromWindow(window).size.width,
    height: 300,
    fit: BoxFit.fitHeight,
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
                        userHead,
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
                                Image.asset(
                                  "assets/profile_pics.jpg",
                                  width: 200,
                                  fit: BoxFit.fitWidth,
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
            ],
          ),
        ),
      ),
    );
  }
}
