 import 'dart:io';

import 'package:flutter_todo_list/myHttp/api.dart';

class StatusImage {
  static File regImage = File.fromUri(Uri.http(Api.BaseUrl, "media/media/man.png"));
 }