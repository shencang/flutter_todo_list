// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_r.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskR _$TaskRFromJson(Map<String, dynamic> json) {
  return TaskR(
      json['taskId'] as int,
      json['taskTitles'] as String,
      json['taskComment'] as String,
      json['taskDueDate'] as int,
      json['taskPriority'] as int,
      json['taskProjectId'] as String,
      json['taskUserId'] as String,
      json['taskStatus'] as int);
}

Map<String, dynamic> _$TaskRToJson(TaskR instance) => <String, dynamic>{
      'taskId': instance.taskId,
      'taskTitles': instance.taskTitles,
      'taskComment': instance.taskComment,
      'taskDueDate': instance.taskDueDate,
      'taskPriority': instance.taskPriority,
      'taskProjectId': instance.taskProjectId,
      'taskUserId': instance.taskUserId,
      'taskStatus': instance.taskStatus
    };
