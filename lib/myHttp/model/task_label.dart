import 'package:json_annotation/json_annotation.dart';

part 'task_label.g.dart';


@JsonSerializable()
class TaskLabel extends Object {

  @JsonKey(name: 'taskLabelId')
  int taskLabelId;

  @JsonKey(name: 'taskId')
  int taskId;

  @JsonKey(name: 'labelId')
  int labelId;

  TaskLabel(this.taskLabelId,this.taskId,this.labelId,);

  factory TaskLabel.fromJson(Map<String, dynamic> srcJson) => _$TaskLabelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskLabelToJson(this);

}


