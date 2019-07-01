// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
      json['taskId'] as int,
      json['taskTitles'] as String,
      json['taskComment'] as String,
      json['taskDueDate'] as int,
      json['taskPriority'] as int,
      json['taskProjectId'] as int,
      json['taskUserId'] as int,
      json['taskStatus'] as int);
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'taskId': instance.taskId,
      'taskTitles': instance.taskTitles,
      'taskComment': instance.taskComment,
      'taskDueDate': instance.taskDueDate,
      'taskPriority': instance.taskPriority,
      'taskProjectId': instance.taskProjectId,
      'taskUserId': instance.taskUserId,
      'taskStatus': instance.taskStatus
    };
