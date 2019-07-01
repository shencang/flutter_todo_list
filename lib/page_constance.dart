import 'package:flutter_todo_list/pages/login/login_bloc.dart';
import 'package:flutter_todo_list/pages/login/login_page.dart';
import 'package:flutter_todo_list/todo_list.dart';
import 'package:flutter/material.dart';

class PageConstance {
  // ignore: non_constant_identifier_names
  static String WELCOME_PAGE = '/';
  // ignore: non_constant_identifier_names
  static String HOME_PAGE = '/home';
  // ignore: non_constant_identifier_names
  static String LOGIN_PAGE = '/login';

  static Map<String, WidgetBuilder> getRoutes() {
    var route = {
      HOME_PAGE: (BuildContext context) {
        return MyApp();
      },
      LOGIN_PAGE: (BuildContext context) {
      return LoginPage();
    }
    };

    return route;
  }
}
