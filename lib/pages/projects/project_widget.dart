import 'package:flutter/material.dart';
import 'package:flutter_todo_list/bloc/bloc_provider.dart';
import 'package:flutter_todo_list/pages/home/home_bloc.dart';
import 'package:flutter_todo_list/pages/projects/add_project.dart';
import 'package:flutter_todo_list/pages/projects/project.dart';
import 'package:flutter_todo_list/pages/projects/project_bloc.dart';
import 'package:flutter_todo_list/pages/projects/project_db.dart';
import 'package:flutter_todo_list/pages/tasks/bloc/task_bloc.dart';

///项目子页面的UI
class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectBloc projectBloc = BlocProvider.of<ProjectBloc>(context);
    return StreamBuilder<List<Project>>(
      stream: projectBloc.projects,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProjectExpansionTileWidget(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class ProjectExpansionTileWidget extends StatelessWidget {
  final List<Project> _projects;

  ProjectExpansionTileWidget(this._projects);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.book),
      title: Text("项目",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildProjects(context),
    );
  }

  List<Widget> buildProjects(BuildContext context) {
    List<Widget> projectWidgetList = List();
    _projects.forEach((project) => projectWidgetList.add(ProjectRow(project)));
    projectWidgetList.add(ListTile(
      leading: Icon(Icons.add),
      title: Text("添加项目"),
      onTap: () async {
        Navigator.pop(context);
        ProjectBloc projectBloc = BlocProvider.of<ProjectBloc>(context);
        Widget addProject = BlocProvider(
          bloc: ProjectBloc(ProjectDB.get()),
          child: AddProject(),
        );
        await Navigator.push(
            context,
            MaterialPageRoute<bool>(
              builder: (context) => addProject,
            ));
        projectBloc.refresh();
      },
    ));
    return projectWidgetList;
  }
}

class ProjectRow extends StatelessWidget {
  final Project project;

  ProjectRow(this.project);

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      onTap: () {
        homeBloc.applyFilter(project.name, Filter.byProject(project.id));
        Navigator.pop(context);
      },
      onLongPress: (){
        ProjectBloc projectBloc = BlocProvider.of<ProjectBloc>(context);
        projectBloc.deleteProject(project);
        projectBloc.refresh();
        Navigator.pop(context);
        print(project.name);
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text(project.name),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: CircleAvatar(
          backgroundColor: Color(project.colorValue),
        ),
      ),
    );
  }
}
