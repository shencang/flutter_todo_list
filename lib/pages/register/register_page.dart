import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/pages/register/register_bloc.dart';
import 'package:flutter_todo_list/pages/register/status_image.dart';
import 'package:flutter_todo_list/utils/loading.dart';
import 'package:flutter_todo_list/utils/upload_avatar.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

///注册页面UI
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  StatusImage  imageS = new StatusImage();
  Register _register = new Register();
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _name;
  String _passwordTemp;
  bool _isObscure = true;
  String _sex = '';
  Color _eyeColor;
  bool _emailRepat = false, _isRegister = false;

  var _genderSelect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 20.0),
                UploadAvatar(),
                SizedBox(height: 40.0),
                buildEmailTextField(),
                SizedBox(height: 30.0),
                buildPasswordTextField(context),
                SizedBox(height: 30.0),
                buildPasswordReTrueTextField(context),
                SizedBox(height: 30.0),
                buildNameTextField(),
                SizedBox(height: 30.0),
                selectSex(),
                // buildForgetPasswordText(context),
                SizedBox(height: 60.0),
                buildLoginButton(context),
                SizedBox(height: 30.0),
                // buildOtherLoginText(),
                // buildOtherMethod(context),
                buildRegisterText(context),
                SizedBox(height: 30.0),
              ],
            )));
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('不想注册？'),
            GestureDetector(
              child: Text(
                '有缘下次再见',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                print('去注册');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
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

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '注册',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              //TODO 执行注册方法
              print(
                  'email:$_email , password:$_password , name = $_name , sex = $_sex');
              print('avatar = ');
              print(StatusImage.regImage.path);

              showDialog<Null>(
                context: context,
                builder: (BuildContext context) {
                  return new SimpleDialog(
                    title: new Text('注册'),
                    children: <Widget>[
                      FutureBuilder(
                          future: _register.findEmailRepeatR(_email),
                          builder: (BuildContext context,
                              AsyncSnapshot<Response> snapshot) {
                            /*表示数据成功返回*/
                            if (snapshot.hasData) {
                              Response response = snapshot.data;
                              print(response.toString());
                              if (response.data['id'] == '0') {
                                _emailRepat = true;
                                _isRegister = true;
                                return
                                    FutureBuilder(
                                        future: _register.registerR(
                                            _email,
                                            _password,
                                            _sex,
                                            _name,
                                            StatusImage.regImage),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<Response> snapshot) {
                                          /*表示数据成功返回*/
                                          if (snapshot.hasData) {
                                            Response response = snapshot.data;
                                            print(response.toString());
                                            if (response.data['id'] == '1') {
                                              return Text(
                                                "${response.data['message']}",
                                                style: TextStyle(fontSize: 30),
                                                textAlign: TextAlign.center,
                                              );
                                            } else {
                                              return Text(
                                                "${response.data['message']}",
                                                style: TextStyle(fontSize: 30),
                                                textAlign: TextAlign.center,
                                              );
                                            }
                                          } else if (snapshot.hasError) {
                                            return Text("发生错误");
                                          } else {
                                            return LoadingWidget();
                                          }
                                        }
                                );
//                                  Text(
//                                  "${response.data['message']}",
//                                  style: TextStyle(fontSize: 30),
//                                  textAlign: TextAlign.center,
//                                );
                              } else {
                                _isRegister = false;
                                _emailRepat = false;
                                return Text(
                                  "${response.data['message']}",
                                  style: TextStyle(fontSize: 30),
                                  textAlign: TextAlign.center,
                                );
                              }
                            } else if (snapshot.hasError) {
                              return Text("发生错误");
                            } else {
                              return LoadingWidget();
                            }
                          }),
                    ],
                  );
                },
              ).then((val) {
                print('=========================!==');
                print(val);
                if (_isRegister) {
                  print('===!=====================!==');
                  Navigator.pop(context);
                }
              });
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  TextFormField buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '昵称',
      ),
      validator: (String value) {
        if (value.length > 100) {
          return '昵称太长啦';
        }
        if (value.isEmpty) {
          return '昵称不能为空';
        }
      },
      onSaved: (String value) => _name = value,
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
          _passwordTemp = value;
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
        if (value != _passwordTemp) {
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

  TextFormField buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '电子邮件',
      ),
      validator: (String value) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(value)) {
          return '请输入正确的邮箱地址';
        }
      },
      onSaved: (String value) => _email = value,
    );
  }

//  Row avatarRowContainer() {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Container(
//          width: 120.0,
//          height: 120.0,
//          decoration: BoxDecoration(
//            shape: BoxShape.circle,
//            image: DecorationImage(
//                fit: BoxFit.cover,
//                image: AssetImage(
//                    "assets/avatar/man.png")),
//          ),)
//      ],
//
//    );
//  }

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
        '欢迎使用',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
}
