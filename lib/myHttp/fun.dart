import 'package:dio/dio.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/model/user.dart';

import 'model/project.dart';

class Fun {
    Dio dio;
  Fun() {
    dio = new Dio();
  }

 Future userPost(String apiString, Map<String, dynamic> postData) async {
    print(postData);
    FormData formData = new FormData.from(postData);
    Response<Map> response;
    response = await dio.post(Api.BaseUrl+apiString,data: formData);
    user userA = user.fromJson(response.data);
    print(userA.userId);
    return userA;
  }
//  Todo 等待改正该方法
//    Future projectPosts(String apiString, Map<String, dynamic> postData) async {
//      print(postData);
//      FormData formData = new FormData.from(postData);
//      Response<Map> response;
//      response = await dio.post(Api.BaseUrl+apiString,data: formData);
//      response.data.
//      //user userA = user.fromJson(response.data);
//      //Project project
//      //print(userA.userId);
//      //return userA;
//    }
    Future messagePost(String apiString, Map<String, dynamic> postData) async {
      print(postData);
      FormData formData = new FormData.from(postData);
      Response<Map> response;
      response = await dio.post(Api.BaseUrl+apiString,data: formData);
      return response.data;
    }
    Future get() async {
      Response response;
      response = await dio.get(Api.BaseUrl + "user/");
      print(response.data.toString());
    }

    Future messagePostR(String apiString, Map<String, dynamic> postData) async {
      print(postData);
      FormData formData = new FormData.from(postData);
      Response<Map> response;
      response = await dio.post(Api.BaseUrl+apiString,data: formData);
      return response;
    }
    Future userPostR(String apiString, Map<String, dynamic> postData) async {
      print(postData);
      FormData formData = new FormData.from(postData);
      Response<Map> response;
      response = await dio.post(Api.BaseUrl+apiString,data: formData);
      return response;
    }
}


