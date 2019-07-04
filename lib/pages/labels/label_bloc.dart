import 'dart:async';

import 'package:flutter_todo_list/bloc/bloc_provider.dart';
import 'package:flutter_todo_list/pages/labels/label.dart';
import 'package:flutter_todo_list/pages/labels/label_db.dart';
import 'package:flutter_todo_list/utils/color_utils.dart';


///标签的动画以及控制器
class LabelBloc implements BlocBase {
  StreamController<List<Label>> _labelController =
      StreamController<List<Label>>.broadcast();

  Stream<List<Label>> get labels => _labelController.stream;

  StreamController<bool> _labelExistController =
      StreamController<bool>.broadcast();

  Stream<bool> get labelsExist => _labelExistController.stream;

  StreamController<ColorPalette> _colorController =
      StreamController<ColorPalette>.broadcast();

  Stream<ColorPalette> get colorSelection => _colorController.stream;

  LabelDB _labelDB;

  LabelBloc(this._labelDB) {
    _loadLabels();
  }

  @override
  void dispose() {
    _labelController.close();
    _labelExistController.close();
    _colorController.close();
  }

  void _loadLabels() {
    _labelDB.getLabels().then((labels) {
      _labelController.sink.add(List.unmodifiable(labels));
    });
  }

  void refresh() {
    _loadLabels();
  }

  void checkIfLabelExist(Label label) async {
    _labelDB.isLabelExits(label).then((isExist) {
      _labelExistController.sink.add(isExist);
    });
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }
  void deleteProject(Label label){
    _labelDB.deleteLabel(label.id).then((onValue){
      if (onValue == null) return;
      _loadLabels();
    });
  }
}
