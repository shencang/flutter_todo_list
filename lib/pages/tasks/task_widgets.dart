import 'package:flutter/material.dart';
import 'package:flutter_todo_list/bloc/bloc_provider.dart';
import 'package:flutter_todo_list/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_todo_list/pages/tasks/models/tasks.dart';
import 'package:flutter_todo_list/pages/tasks/row_task.dart';
import 'package:flutter_todo_list/utils/app_util.dart';


class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskBloc _tasksBloc = BlocProvider.of(context);
    return StreamBuilder<List<Tasks>>(
      stream: _tasksBloc.tasks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildTaskList(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildTaskList(List<Tasks> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: list.length == 0
          ? MessageInCenterWidget("没有添加任务")
          : Container(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        key: ObjectKey(list[index]),
                        onDismissed: (DismissDirection direction) {
                          var taskID = list[index].id;
                          final TaskBloc _tasksBloc =
                              BlocProvider.of<TaskBloc>(context);
                          String message = "";
                          if (direction == DismissDirection.endToStart) {
                            _tasksBloc.updateStatus(
                                taskID, TaskStatus.COMPLETE);
                            message = "任务完成";
                          } else {
                            _tasksBloc.delete(taskID);
                            message = "任务删除";
                          }
                          SnackBar snackbar =
                              SnackBar(content: Text(message));
                          Scaffold.of(context).showSnackBar(snackbar);
                        },
                        background: Container(
                          color: Colors.red,
                          child: ListTile(
                            leading:
                                Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.green,
                          child: ListTile(
                            trailing:
                                Icon(Icons.check, color: Colors.white),
                          ),
                        ),
                        child: TaskRow(list[index]));
                  }),
            ),
    );
  }
}
