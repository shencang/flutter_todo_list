import 'package:flutter/material.dart';
import 'package:flutter_todo_list/utils/app_constant.dart';
import 'package:flutter_todo_list/utils/app_util.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[


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
