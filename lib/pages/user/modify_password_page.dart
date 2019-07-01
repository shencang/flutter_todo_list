import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/pages/login/login_page.dart';
import 'package:flutter_todo_list/pages/user/user_bloc.dart';
import 'package:flutter_todo_list/utils/app_constant.dart';
import 'package:flutter_todo_list/utils/loading.dart';

///用户界面
class ModifyScreen extends StatefulWidget {
  @override
  _ModifyScreen createState() => new _ModifyScreen();
}

class _ModifyScreen extends State<ModifyScreen> {
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
            SizedBox(height: 30.0),
            buildPasswordTextField(context),
            SizedBox(height: 60.0),
            buildUpdateButton(context),
            SizedBox(height: 30.0),
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
            '登录',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              //getLoginStatus();
              showDialog<Null>(
                context: context,
                builder: (BuildContext context) {
                  return new SimpleDialog(
                    title: new Text('正在执行'),
                    children: <Widget>[
                      FutureBuilder(
                          future: _userBloc.loginEmailR(
                              GetInfo.userShow.userEmail, _password),
                          builder: (BuildContext context,
                              AsyncSnapshot<Response> snapshot) {
                            /*表示数据成功返回*/
                            if (snapshot.hasData) {
                              Response response = snapshot.data;
                              print(response.toString());
                              if (response.data['id'] == '1') {
                                return FutureBuilder(
                                    future: _userBloc.updatePasswordR(
                                        GetInfo.userShow.userEmail,
                                        _newPassword),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Response> snapshot) {
                                      /*表示数据成功返回*/
                                      if (snapshot.hasData) {
                                        Response response = snapshot.data;
                                        print(response.toString());
                                        if (response.data['id'] == '0') {
                                          _isModify = true;
                                          return new Text(
                                            "修改成功",
                                            style: TextStyle(fontSize: 30),
                                            textAlign: TextAlign.center,
                                          );
                                        } else {
                                          _isModify = false;
                                          return new Text(
                                            "修改失败",
                                            style: TextStyle(fontSize: 30),
                                            textAlign: TextAlign.center,
                                          );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text("发生错误");
                                      } else {
                                        return LoadingWidget();
                                      }
                                    });
                              } else {
                                return Text(
                                  "${response.data['message']}",
                                  style: TextStyle(fontSize: 30),
                                  textAlign: TextAlign.center,
                                );
                              }
                            } else {
                              return LoadingWidget();
                            }
                          })
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

  TextFormField buildNewPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
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
        '修改密码',
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }
}
