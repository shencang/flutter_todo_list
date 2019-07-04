import 'dart:async';

import 'package:flutter/material.dart';
///添加评论
class AddCommentDialog extends StatefulWidget {
  @override
  _AddCommentDialogState createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<String> showCommentDialog(BuildContext context) async {
  return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController commController;
        return AlertDialog(
          title: Text("输入评论"),
          content: TextField(
            controller: commController = TextEditingController(),
            decoration: InputDecoration(
              icon: Icon(Icons.text_fields),
              labelText: '评论',
            ),

          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context,"");
                },
                child: Text("取消",
                    style:
                        TextStyle(color: Theme.of(context).accentColor))),
            FlatButton(
                onPressed:() {
                  if(commController.text.length>100||commController.text.length==0){
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('请输入内容并保存在100字以下'),
                        ));
                  }else{
                    Navigator.pop(context,commController.text);
                  }
                },
                child: Text("保存",
                    style: TextStyle(color: Theme.of(context).accentColor)))
          ],
        );
      });
}
