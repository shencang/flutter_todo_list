import 'package:flutter_todo_list/todo_list.dart';
import 'package:flutter/material.dart';

class PageConstance {
  // ignore: non_constant_identifier_names
  static String WELCOME_PAGE = '/';
  // ignore: non_constant_identifier_names
  static String HOME_PAGE = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    var route = {
      HOME_PAGE: (BuildContext context) {
        return MyApp();
      }
    };

    return route;
  }
}
