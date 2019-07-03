// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_label_r.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskLabelR _$TaskLabelRFromJson(Map<String, dynamic> json) {
  return TaskLabelR(json['taskLabelId'] as int, json['taskId'] as String,
      json['labelId'] as String);
}

Map<String, dynamic> _$TaskLabelRToJson(TaskLabelR instance) =>
    <String, dynamic>{
      'taskLabelId': instance.taskLabelId,
      'taskId': instance.taskId,
      'labelId': instance.labelId
    };
