import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/myHttp/model/user.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/utils/loading.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter_todo_list/pages/register/register_page.dart';

import '../../todo_list.dart';
import 'login_bloc.dart';

///登录页面UI
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static bool loginStatus = false;
  Login _login = new Login();
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObscure = true;
  Color _eyeColor;
  List _loginMethod = [
    {
      "title": "facebook",
      "icon": GroovinMaterialIcons.facebook,
    },
    {
      "title": "google",
      "icon": GroovinMaterialIcons.google,
    },
    {
      "title": "twitter",
      "icon": GroovinMaterialIcons.twitter,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            buildEmailTextField(),
            SizedBox(height: 30.0),
            buildPasswordTextField(context),
            buildForgetPasswordText(context),
            SizedBox(height: 60.0),
            buildLoginButton(context),
            SizedBox(height: 30.0),
            buildOtherLoginText(),
            buildOtherMethod(context),
            buildRegisterText(context),
          ],
        ),
      ),
    );
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有账号？'),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                print('去注册');
                RegisterUIRouter.pushRefreshDetail(context);

//                Navigator.of(context).push(new MaterialPageRoute(builder: (_){
//                   return new RegisterPage();
//                }));
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
                builder: (context) {
                  return IconButton(
                      icon: Icon(item['icon'],
                          color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        //TODO : 第三方登录方法
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("${item['title']}登录"),
                          action: new SnackBarAction(
                            label: "取消",
                            onPressed: () {},
                          ),
                        ));
                      });
                },
              ))
          .toList(),
    );
  }

  Align buildOtherLoginText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  Align buildLoginButton(BuildContext context) {
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
              //TODO 执行登录方法
              print('email:$_email , assword:$_password');
              //getLoginStatus();
              showDialog<Null>(
                context: context,
                builder: (BuildContext context) {
                  return new SimpleDialog(
                    title: new Text('正在登录'),
                    children: <Widget>[
                      FutureBuilder(
                          future: _login.loginEmailR(_email, _password),
                          builder: (BuildContext context,
                              AsyncSnapshot<Response> snapshot) {
                            /*表示数据成功返回*/
                            if (snapshot.hasData) {
                              Response response = snapshot.data;
                              print(response.toString());
                              if (response.data['id'] == '1') {
                                loginStatus = true;
                                String tip = response.data['message'];
                                return FutureBuilder(
                                    future: _login.findUserInfoR(_email),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Response> snapshot) {
                                      /*表示数据成功返回*/
                                      if (snapshot.hasData) {
                                        Response response = snapshot.data;
                                        print(response.toString());
                                        GetInfo.userShow =
                                            user.fromJson(snapshot.data.data);
                                        return Text(
                                          tip,
                                          style: TextStyle(fontSize: 30),
                                          textAlign: TextAlign.center,
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text("发生错误");
                                      } else {
                                        return LoadingWidget();
                                      }
                                    });

//                                  Text(
//                                  "${response.data['message']}",
//                                  style: TextStyle(fontSize: 30),
//                                  textAlign: TextAlign.center,
//                                );
                              } else {
                                loginStatus = false;
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
                if (loginStatus) {
                  print(GetInfo.userShow.userEmail);
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new MyApp();
                  }));
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

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
        '立刻知行合一',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
}
