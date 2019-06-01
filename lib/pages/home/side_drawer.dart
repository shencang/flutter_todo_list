import 'package:flutter/material.dart';
import 'package:flutter_todo_list/bloc/bloc_provider.dart';
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

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("作者名字"),
            accountEmail: Text("作者邮箱"),
            otherAccountsPictures: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 36.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                          builder: (context) => AboutUsScreen()),
                    );
                  })
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              backgroundImage: AssetImage("assets/profile_pics.jpg"),
            ),
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
          )
        ],
      ),
    );
  }
}
