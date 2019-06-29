import 'package:dio/dio.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/model/user.dart';

class Fun {
    Dio dio;
  Fun() {
    dio = new Dio();
  }

 Future post(String apiString, Map<String, dynamic> postData) async {
    FormData formData = new FormData.from(postData);
    Response<Map> response;
    response = await dio.post(Api.BaseUrl+apiString,data: formData);
    user users = user.fromJson(response.data);

  }
}


//import 'package:dio/dio.dart';
//import 'package:flutter_http_study/model/User.dart';
//
//class NetTools {
//  Dio dio;
//  static const String BaseUrl = "http://shencangblue.com/";
//
//  NetTools() {
//    dio = new Dio();
//  }
//
//  Future getHttp() async {
//    try {
//      Response response = await Dio().get(BaseUrl);
//      print("==========================>");
//      print(response);
//      return response.data.toString();
//    } catch (e) {
//      print("==========================>");
//      print(e);
//    }
//  }
//
//  get() async {
//    Response response;
//    response = await dio.get(BaseUrl + "user/");
//    print(response.data.toString());
//  }
//
//  post() async {
//    FormData formData =
//    new FormData.from({'userEmail': "2630610009@qq.com",});
//    Response<Map> response;
//    response = await dio.post(BaseUrl+"getUserInfo/", data: formData);
//    User user = User.fromJson(response.data);
//    print(response.data.toString());
//    print(user.userAvatar);
//  }
//}
