import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/bloc/bloc_provider.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/model/user.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_todo_list/pages/labels/label_db.dart';
import 'package:flutter_todo_list/pages/projects/project_db.dart';
import 'package:flutter_todo_list/pages/projects/project.dart';
import 'package:flutter_todo_list/pages/about/about_us.dart';
import 'package:flutter_todo_list/pages/home/home_bloc.dart';
import 'package:flutter_todo_list/pages/labels/label_bloc.dart';
import 'package:flutter_todo_list/pages/labels/label_widget.dart';
import 'package:flutter_todo_list/pages/projects/project_bloc.dart';
import 'package:flutter_todo_list/pages/projects/project_widget.dart';
import 'package:flutter_todo_list/pages/user/views/userpage.dart';
import 'package:flutter_todo_list/pages/login/login_page.dart';
import 'package:flutter_todo_list/pages/settings/settings_page.dart';
import 'package:flutter_todo_list/utils/loading.dart';


///侧滑栏的UI
class SideDrawer extends StatelessWidget {
  static bool loginStatus =false;
  //static user userShow= GetInfo.userShow;
  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(GetInfo.userShow == null?"登录以查看更多":GetInfo.userShow.username),
            onDetailsPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<bool>(builder: (context) => UserScreen()),
              );
            },
            accountEmail: Text(GetInfo.userShow==null?"行知":GetInfo.userShow.userSignature),
            otherAccountsPictures: <Widget>[

              IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                          builder: (context) => SettingsScreen()),
                    );
                  })

            ],
             currentAccountPicture:
             IconButton(
                 icon:
                 new CircleAvatar(
                   radius: 36.0,
                   backgroundImage:NetworkImage(Api.BaseUrl_com+GetInfo.userShow.userAvatar),
//                   AssetImage(
////                       "assets/profile_pics.jpg",
////                   ),
                 ),
                 onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute<bool>(
                         builder: (context) => UserScreen()),
                   );
                 })
//             CircleAvatar(
//              backgroundColor: Theme.of(context).accentColor,
//              backgroundImage: AssetImage("assets/profile_pics.jpg"),
//            ),
//              new Container(
//                padding: EdgeInsets.only(left: MediaQueryData.fromWindow(window).size.width/6),
//                child: new Image.asset("assets/profile_pics.jpg"),
//              )

          ),
          ListTile(
              leading: Icon(Icons.inbox),
              title: Text("默认收集箱"),
              onTap: () {
                var project = Project.getInbox();
                homeBloc.applyFilter(
                    project.name, Filter.byProject(project.id));
                Navigator.pop(context);
              }),
          ListTile(
              onTap: () {
                homeBloc.applyFilter("今天", Filter.byToday());
                Navigator.pop(context);
              },
              leading: Icon(Icons.calendar_today),
              title: Text("今天")),
          ListTile(
            onTap: () {
              homeBloc.applyFilter("未来一周", Filter.byNextWeek());
              Navigator.pop(context);
            },
            leading: Icon(Icons.calendar_today),
            title: Text("未来一周"),
          ),
          BlocProvider(
            bloc: ProjectBloc(ProjectDB.get()),
            child: ProjectPage(),
          ),
          BlocProvider(
            bloc: LabelBloc(LabelDB.get()),
            child: LabelPage(),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQueryData.fromWindow(window).size.height / 4.2),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<bool>(
                      builder: (context) => (LoginPage())),

                );
//                Navigator.push<String>(context,
//                    new MaterialPageRoute(builder: (BuildContext context){
//                  return new LoginPage();
//                })).then( (String result){
//                  //处理代码
//                  print('!!!!!!!!!!!!!!!!!!!!!!!');
//                  print(result);
//
//                });
              },
//            onTap: () {
//              homeBloc.applyFilter("关于", Filter.byNextWeek());
//              Navigator.pop(context);
//            },
              leading: Icon(Icons.add_circle_outline),
              title: Text("登录"),
            )
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<bool>(
                    builder: (context) => AboutUsScreen()),
              );
            },
//            onTap: () {
//              homeBloc.applyFilter("关于", Filter.byNextWeek());
//              Navigator.pop(context);
//            },
            leading: Icon(Icons.info_outline),
            title: Text("关于"),
          )
        ],
      ),
    );
  }
}
