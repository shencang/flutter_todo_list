import 'package:flutter/material.dart';
import 'package:flutter_todo_list/bloc/bloc_provider.dart';
import 'package:flutter_todo_list/pages/projects/project.dart';
import 'package:flutter_todo_list/pages/projects/project_bloc.dart';
import 'package:flutter_todo_list/utils/collapsable_expand_tile.dart';
import 'package:flutter_todo_list/utils/color_utils.dart';


///项目添加页面的UI
class AddProject extends StatelessWidget {
  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProjectBloc _projectBloc = BlocProvider.of(context);
    ColorPalette currentSelectedPalette;
    String projectName = "";
    return Scaffold(
      appBar: AppBar(
        title: Text("添加项目"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              var project = Project.create(
                  projectName,
                  currentSelectedPalette.colorValue,
                  currentSelectedPalette.colorName);
              _projectBloc.createProject(project);
              Navigator.pop(context, true);
            }
          }),
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "项目名"),
                maxLength: 20,
                validator: (value) {
                  return value.isEmpty ? "项目名不能为空" : null;
                },
                onSaved: (value) {
                  projectName = value;
                },
              ),
            ),
            key: _formState,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: StreamBuilder(
              stream: _projectBloc.colorSelection,
              initialData: ColorPalette("灰", Colors.grey.value),
              builder: (context, snapshot) {
                currentSelectedPalette = snapshot.data;
                return CollapsibleExpansionTile(
                  key: expansionTile,
                  leading: Container(
                    width: 12.0,
                    height: 12.0,
                    child: CircleAvatar(
                      backgroundColor: Color(snapshot.data.colorValue),
                    ),
                  ),
                  title: Text(snapshot.data.colorName),
                  children: buildMaterialColors(_projectBloc),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildMaterialColors(ProjectBloc projectBloc) {
    List<Widget> projectWidgetList = List();
    colorsPalettes.forEach((colors) {
      projectWidgetList.add(ListTile(
        leading: Container(
          width: 12.0,
          height: 12.0,
          child: CircleAvatar(
            backgroundColor: Color(colors.colorValue),
          ),
        ),
        title: Text(colors.colorName),
        onTap: () {
          expansionTile.currentState.collapse();
          projectBloc.updateColorSelection(
            ColorPalette(colors.colorName, colors.colorValue),
          );
        },
      ));
    });
    return projectWidgetList;
  }
}
