import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';


@JsonSerializable()
class Task extends Object {

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
  int taskProjectId;

  @JsonKey(name: 'taskUserId')
  int taskUserId;

  @JsonKey(name: 'taskStatus')
  int taskStatus;

  Task(this.taskId,this.taskTitles,this.taskComment,this.taskDueDate,this.taskPriority,this.taskProjectId,this.taskUserId,this.taskStatus,);

  factory Task.fromJson(Map<String, dynamic> srcJson) => _$TaskFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

}


