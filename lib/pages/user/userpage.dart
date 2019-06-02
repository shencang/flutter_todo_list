import 'package:flutter/material.dart';
import 'package:flutter_todo_list/utils/app_constant.dart';
import 'package:flutter_todo_list/utils/app_util.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.bug_report, color: Colors.black),
                        title: Text("报告问题"),
                        subtitle: Text("有什么问题？ 在此报告"),
                        onTap: () => launchURL(ISSUE_URL)),
                    ListTile(
                      leading: Icon(Icons.update, color: Colors.black),
                      title: Text("版本"),
                      subtitle: Text("0.0.1"),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("作者",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    ListTile(
                      leading: Icon(Icons.perm_identity, color: Colors.black),
                      title: Text("shencang"),
                      subtitle: Text("shencang"),
                      onTap: () => launchURL(GITHUB_URL),
                    ),
                    ListTile(
                        leading: Icon(Icons.bug_report, color: Colors.black),
                        title: Text("从 Github 分支"),
                        onTap: () => launchURL(PROJECT_URL)),
                    ListTile(
                        leading: Icon(Icons.email, color: Colors.black),
                        title: Text("发送邮件"),
                        subtitle: Text("2630610009@qq.com"),
                        onTap: () => launchURL(EMAIL_URL)),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("项目学习自：",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.wb_incandescent,
                                color: Colors.black),
                            title: Text("WhatTodo"),
                            subtitle: Text("burhanrashid52"),
                            onTap: () => launchURL(AUTHOR_URL),
                          ),
                        ],
                      ),
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
