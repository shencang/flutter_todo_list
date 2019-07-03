import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/pages/login/login_page.dart';
import 'package:flutter_todo_list/pages/register/register_bloc.dart';
import 'package:flutter_todo_list/pages/user/user_bloc.dart';
import 'package:flutter_todo_list/utils/app_constant.dart';
import 'package:flutter_todo_list/utils/loading.dart';

///用户界面
class ModifySexScreen extends StatefulWidget {
  @override
  _ModifySexScreen createState() => new _ModifySexScreen();
}

class _ModifySexScreen extends State<ModifySexScreen> {
  String _password, _newPassword;
  bool _isObscure = true, _isModify = false;
  UserBloc _userBloc = new UserBloc();
  Color _eyeColor;
  final _formKey = GlobalKey<FormState>();

  //static user userShow = GetInfo.userShow;
  Image userHead = new Image.network(
    Api.BaseUrl_com + GetInfo.userShow.userAvatar,
  );

  bool _isRegister =false;

  bool _emailRepat = false;

  String _newvalue;

  var _genderSelect;

  String _sex;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(GetInfo.userShow.username),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
            ),
            buildTitle(),
            buildTitleLine(),
            SizedBox(height: 70.0),
            selectSex(),
            SizedBox(height: 30.0),
            buildUpdateButton(context),
            SizedBox(height: 20.0),
            buildTipText(),
            SizedBox(height: 30.0,)
          ],
        ),
      ),
    );
  }

  Align buildUpdateButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '修改',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              print(GetInfo.userShow.userEmail);
              print(_newPassword);
              //getLoginStatus();
              showDialog<Null>(
                context: context,
                builder: (BuildContext context) {
                  return new SimpleDialog(
                    title: new Text('正在执行'),
                    children: <Widget>[
                      FutureBuilder(
                          future: _userBloc.updateUserInfoR
                            (GetInfo.userShow.userId,
                              'userSex',
                              _sex),
                          builder: (BuildContext context,
                              AsyncSnapshot<Response> snapshot) {
                            /*表示数据成功返回*/
                            if (snapshot.hasData) {
                              Response response = snapshot.data;
                              print(response.toString());
                              if (response.data['id'] == '0') {
                                _isModify = true;
                                return Text(
                                  "${response.data['message']}",
                                  style: TextStyle(fontSize: 30),
                                  textAlign: TextAlign.center,
                                );
                              } else {
                                _isModify = false;
                                return Text(
                                  "${response.data['message']}",
                                  style: TextStyle(fontSize: 30),
                                  textAlign: TextAlign.center,
                                );
                              }
                            } else if (snapshot.hasError) {
                              _isModify = false;
                              return Text("发生错误");
                            } else {
                              return LoadingWidget();
                            }
                          }
                      )
//                                  Text(
//                                  "${response.data['message']}",
//                                  style: TextStyle(fontSize: 30),
//                                  textAlign: TextAlign.center,
//                                );


                    ],
                  );
                },
              ).then((val) {
                print(val);
                if (_isModify) {
                  print(GetInfo.userShow.userEmail);
                  Navigator.pop(context);

                  //Navigator.pop(context,_email);

                }
              });
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        } else {
          _password = value;
        }
      },
      decoration: InputDecoration(
          labelText: '密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '昵称',
      ),
      validator: (String value) {
        if (value.length<100&&value.length>0) {
          return '请输入正确的长度';
        }
      },
      onSaved: (String value) =>  _newvalue = value,
    );
  }

  TextFormField buildPasswordReTrueTextField(BuildContext context) {
    return TextFormField(
      //onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value != _password) {
          return '请再次输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: '重复密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '修改评论',
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }

  Align buildTipText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '修改评论会退出该页面',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  GenderSelection selectSex() {
    return GenderSelection(
      selectCallback: (genderSelect) {
        _genderSelect = genderSelect;
        print(_genderSelect);
        if (_genderSelect == '1') {
          _sex = '男';
        } else {
          _sex = '女';
        }
        setState(() {});
      },
    );
  }
}
