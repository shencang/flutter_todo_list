import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/fun.dart';
import 'package:flutter_todo_list/pages/register/register_page.dart';

class RegisterUIRouter{
  static void pushRefreshDetail(BuildContext context) {

    Navigator.of(context).push(new PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
          return new RegisterPage();
    }, transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      // 添加一个平移动画
      return RegisterUIRouter.createTransition(animation, child);
    }));
  }

  /// 创建一个平移变换
  /// 跳转过去查看源代码，可以看到有各种各样定义好的变换
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child, // child is the value returned by pageBuilder
    );
  }

}

class Login{
     Future<bool> loginEmail(String email , String password) async {
      Map<String, dynamic> login = {'userEmail':email,'password':password};
      //Map<String, dynamic> user = {'userEmail':email,'password':password};
      Fun fun = new Fun();
      Map getMessage;
      String result;
      getMessage =await fun.messagePost(Api.LoginEmail, login);
     // fun.get();
      result  = getMessage['id'];
      print(getMessage);
      print(result);
      if (result =='1'){
        return  true;
      }
      else{
        return  false;
      }


    }
     Future<Response> loginEmailR(String email , String password) async {
       Map<String, dynamic> login = {'userEmail':email,'password':password};
       //Map<String, dynamic> user = {'userEmail':email,'password':password};
       Fun fun = new Fun();

       return await fun.messagePostR(Api.LoginEmail, login);

     }
}
