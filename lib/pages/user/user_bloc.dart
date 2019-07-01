import 'package:dio/dio.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/fun.dart';

class UserBloc {
  Future<Response> updatePasswordR(String email, String password) async {
    Map<String, dynamic> login = {'userEmail': email, 'userPassword': password};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    print(login);
    Fun fun = new Fun();
    return await fun.messagePostR(Api.UpdatePassword, login);
  }

  Future<Response> loginEmailR(String email, String password) async {
    Map<String, dynamic> login = {'userEmail': email, 'password': password};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();
    print(login);
    return await fun.messagePostR(Api.LoginEmail, login);
  }

}