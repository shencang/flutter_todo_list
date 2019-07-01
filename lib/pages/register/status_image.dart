 import 'dart:io';
 import 'package:flutter/material.dart';
 import 'package:http/http.dart' as http;
 import 'package:path/path.dart' as path;
 import 'package:image/image.dart' as img;
 import 'package:path_provider/path_provider.dart';

import 'package:flutter_todo_list/myHttp/api.dart';

class StatusImage {
  static File regImage;

  StatusImage(){
    this._fetchImage();
  }

  _fetchImage() async {
    final url = Api.BaseUrl+'media/media/man.png';
    final res = await http.get(url);
    final image = img.decodeImage(res.bodyBytes);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path; // 临时文件夹
    String appDocPath = appDocDir.path; // 应用文件夹

    final imageFile = File(path.join(appDocPath, 'man.png')); // 保存在应用文件夹内
    await imageFile.writeAsBytes(img.encodePng(image)); // 需要使用与图片格式对应的encode方法
    regImage = imageFile;


    // 打印各种属性以验证文件保存成功
    // print(imageFile.path);
    // print(imageFile.statSync());
  }

}

