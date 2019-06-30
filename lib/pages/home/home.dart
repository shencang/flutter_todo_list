import 'package:flutter/material.dart';
import 'package:flutter_todo_list/bloc/bloc_provider.dart';
import 'package:flutter_todo_list/pages/labels/label_db.dart';
import 'package:flutter_todo_list/pages/projects/project_db.dart';
import 'package:flutter_todo_list/pages/tasks/bloc/add_task_bloc.dart';
import 'package:flutter_todo_list/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_todo_list/pages/tasks/task_db.dart';
import 'package:flutter_todo_list/pages/home/home_bloc.dart';
import 'package:flutter_todo_list/pages/home/side_drawer.dart';
import 'package:flutter_todo_list/pages/tasks/add_task.dart';
import 'package:flutter_todo_list/pages/tasks/task_completed/task_complted.dart';
import 'package:flutter_todo_list/pages/tasks/task_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

///主页的UI
class HomePage extends StatelessWidget {
  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());

  @override
  Widget build(BuildContext context) {
    bool permissionIsTrue;
    final HomeBloc homeBloc = BlocProvider.of(context);
    requestPermission(permissionIsTrue);
    homeBloc.filter.listen((filter) {
      _taskBloc.updateFilters(filter);
    });
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
            initialData: '今天',
            stream: homeBloc.title,
            builder: (context, snapshot) {
              return Text(snapshot.data);
            }),
        actions: <Widget>[buildPopupMenu(context)],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          var blocProviderAddTask = BlocProvider(
            bloc: AddTaskBloc(TaskDB.get(), ProjectDB.get(), LabelDB.get()),
            child: AddTaskScreen(),
          );
          await Navigator.push(
            context,
            MaterialPageRoute<bool>(builder: (context) => blocProviderAddTask),
          );
          _taskBloc.refresh();
        },
      ),
      drawer: SideDrawer(),
      body: BlocProvider(
        bloc: _taskBloc,
        child: TasksPage(),
      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.taskCompleted:
            await Navigator.push(
              context,
              MaterialPageRoute<bool>(
                  builder: (context) => TaskCompletedPage()),
            );
            _taskBloc.refresh();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
            const PopupMenuItem<MenuItem>(
              value: MenuItem.taskCompleted,
              child: const Text('完成的任务'),
            )
          ],
    );
  }
}

Future requestPermission(bool permissionIsTrue) async {
  // 申请权限

  Map<PermissionGroup, PermissionStatus> permissions =
      await PermissionHandler().requestPermissions([
    PermissionGroup.storage,
    PermissionGroup.phone,
  ]);

  // 申请结果

  PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

  if (permission == PermissionStatus.granted) {
    permissionIsTrue =true;
     if(!permissionIsTrue){
       Fluttertoast.showToast(msg: "权限申请通过");
     }
  } else {
    Fluttertoast.showToast(msg: "权限申请被拒绝");
    permissionIsTrue=false;
  }
}

// This is the type used by the popup menu below.
enum MenuItem { taskCompleted }
