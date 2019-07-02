import 'package:json_annotation/json_annotation.dart';

part 'task_r.g.dart';


@JsonSerializable()
class TaskR extends Object {

  @JsonKey(name: 'taskId')
  int taskId;

  @JsonKey(name: 'taskTitles')
  String taskTitles;

  @JsonKey(name: 'taskComment')
  String taskComment;

  @JsonKey(name: 'taskDueDate')
  int taskDueDate;

  @JsonKey(name: 'taskPriority')
  int taskPriority;

  @JsonKey(name: 'taskProjectId')
  String taskProjectId;

  @JsonKey(name: 'taskUserId')
  String taskUserId;

  @JsonKey(name: 'taskStatus')
  int taskStatus;

  TaskR(this.taskId,this.taskTitles,this.taskComment,this.taskDueDate,this.taskPriority,this.taskProjectId,this.taskUserId,this.taskStatus,);

  factory TaskR.fromJson(Map<String, dynamic> srcJson) => _$TaskRFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskRToJson(this);

}


