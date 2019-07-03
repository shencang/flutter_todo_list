import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/fun.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/myHttp/model/user.dart';

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
  Future<Response> updateUserInfoR(int userId, String keyName,String key) async {
    Map<String, dynamic> info = {'userId': userId, keyName: key};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    print(info);
    Fun fun = new Fun();
    return await fun.messagePostR(Api.UpdateUser, info);
  }

  Future<Response> findEmailRepeatR(String email) async {
    Map<String, dynamic> emails = {'userEmail':email};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();
    return await fun.messagePostR(Api.FindEmailRepeat, emails);

  }
  Future<Response> modifyAvatarR(int  userId,File avatar) async {
    String imagePath = avatar.path;
    var name = imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

    print(imagePath);
    print(name);
    print(suffix);
    var pathG = imagePath+ 'media/';
    var nameG = 'media/'+name;
    print(nameG);
    Map<String, dynamic> mod = {'userId':userId,'userAvatar':new UploadFileInfo(new File(imagePath), name,
          contentType: ContentType.parse('media$suffix'))};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();

    return await fun.messagePostR(Api.UpdateUser, mod);


  }

  Future findUserInfoRE(String email) async {
    Map<String, dynamic> emails = {'userEmail': email};
    //Map<String, dynamic> user = {'userEmail':email,'password':password};
    Fun fun = new Fun();
    Response response =  await fun.userPostR(Api.GetUserInfo, emails);
    GetInfo.userShow = user.fromJson(response.data);
    print(GetInfo.userShow.userEmail);

  }
}