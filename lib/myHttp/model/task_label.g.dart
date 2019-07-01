// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskLabel _$TaskLabelFromJson(Map<String, dynamic> json) {
  return TaskLabel(json['taskLabelId'] as int, json['taskId'] as int,
      json['labelId'] as int);
}

Map<String, dynamic> _$TaskLabelToJson(TaskLabel instance) => <String, dynamic>{
      'taskLabelId': instance.taskLabelId,
      'taskId': instance.taskId,
      'labelId': instance.labelId
    };
