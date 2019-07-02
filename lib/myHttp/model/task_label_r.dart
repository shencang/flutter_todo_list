import 'package:json_annotation/json_annotation.dart';

part 'task_label_r.g.dart';


@JsonSerializable()
class TaskLabelR extends Object {

  @JsonKey(name: 'taskLabelId')
  int taskLabelId;

  @JsonKey(name: 'taskId')
  String taskId;

  @JsonKey(name: 'labelId')
  String labelId;

  TaskLabelR(this.taskLabelId,this.taskId,this.labelId,);

  factory TaskLabelR.fromJson(Map<String, dynamic> srcJson) => _$TaskLabelRFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskLabelRToJson(this);

}


