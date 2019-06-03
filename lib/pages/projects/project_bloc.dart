import 'dart:async';

import 'package:flutter_todo_list/bloc/bloc_provider.dart';
import 'package:flutter_todo_list/pages/projects/project.dart';
import 'package:flutter_todo_list/pages/projects/project_db.dart';
import 'package:flutter_todo_list/utils/color_utils.dart';


///项目的动画以及控制器
class ProjectBloc implements BlocBase {
  StreamController<List<Project>> _projectController =
      StreamController<List<Project>>.broadcast();

  Stream<List<Project>> get projects => _projectController.stream;

  StreamController<ColorPalette> _colorController =
      StreamController<ColorPalette>.broadcast();

  Stream<ColorPalette> get colorSelection => _colorController.stream;

  ProjectDB _projectDB;
  bool isInboxVisible;

  ProjectBloc(this._projectDB, {this.isInboxVisible = false}) {
    _loadProjects(isInboxVisible);
  }

  @override
  void dispose() {
    _projectController.close();
    _colorController.close();
  }

  void _loadProjects(bool isInboxVisible) {
    _projectDB.getProjects(isInboxVisible: isInboxVisible).then((projects) {
      _projectController.sink.add(projects);
    });
  }

  void createProject(Project project) {
    _projectDB.insertOrReplace(project).then((value) {
      if (value == null) return;
      _loadProjects(isInboxVisible);
    });
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }

  void refresh(){
    _loadProjects(isInboxVisible);
  }
}
