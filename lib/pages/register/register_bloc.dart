import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/fun.dart';

/// 自定义的性别选择组件。
class GenderSelection extends StatefulWidget {
  /// 选择性别时的回调函数。
  final Function selectCallback;

  GenderSelection({
    this.selectCallback,
  });

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

/// 与自定义的性别选择组件关联的状态子类。
class _GenderSelectionState extends State<GenderSelection> {
  /// 性别选择的控制器，0表示未选择，1表示男人，2表示女人。
  int _genderController = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      // 主轴对齐（`mainAxisAlignment`）属性，如何将子组件放在主轴上。
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        GestureDetector(
          onTap: () {
            // 选择男人时返回1并更新组件。
            setState(() {
              _genderController = 1;
              widget.selectCallback(_genderController);
            });
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                _genderController == 1
                    ? 'assets/choose/sex/man_seled.png'
                    : 'assets/choose/sex/man_sele.png',
                fit: BoxFit.contain,
                height: 90.0,
                width: 90.0,
              ),
              Text(
                '男',
                style: TextStyle(
                  fontSize: 16.0,
                  color: _genderController == 1
                      ? Color(0xFF25C6CA)
                      : Color(0xFF4A4A4A),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 36.0),
        GestureDetector(
          onTap: () {
            // 选择女人时返回2并更新组件。
            setState(() {
              _genderController = 2;
              widget.selectCallback(_genderController);
            });
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                _genderController == 2
                    ? 'assets/choose/sex/wo_seled.png'
                    : 'assets/choose/sex/wo_sele.png',
                fit: BoxFit.contain,
                height: 90.0,
                width: 90.0,
              ),
              Text(
                '女',
                style: TextStyle(
                  fontSize: 16.0,
                  color: _genderController == 2
                      ? Color(0xFFFF6B47)
                      : Color(0xFF4A4A4A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Register{

  Future<Response> registerR(String email , String password,String sex ,
      String username, File avatar) async {
    String imagePath = avatar.path;
    var name = imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    print(imagePath);
    print(name);
    print(suffix);
    Map<String, dynamic> register = {'userEmail':email,'userPassword':password,
      'username':username,'userSex':sex,'userAvatar':new UploadFileInfo(new File(imagePath), name,
      contentType: ContentType.parse('media/$suffix')),'userPhone':'','userIdentity':'0','userSignature':''};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();

    return await fun.messagePostR(Api.Register, register);
//    userEmail:33@qq.com
//    userPassword:12345
//    username:aaa
//    userPhone:
//    userIdentity:
//    userSex:
//    userSignature:
  }

  Future<Response> findEmailRepeatR(String email) async {
    Map<String, dynamic> emails = {'userEmail':email};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();
    return await fun.messagePostR(Api.FindEmailRepeat, emails);
//    userEmail:33@qq.com
//    userPassword:12345
//    username:aaa
//    userPhone:
//    userIdentity:
//    userSex:
//    userSignature:
  }

}
