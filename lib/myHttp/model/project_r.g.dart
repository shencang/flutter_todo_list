// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_r.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectR _$ProjectRFromJson(Map<String, dynamic> json) {
  return ProjectR(
      json['projectId'] as int,
      json['projectName'] as String,
      json['projectColorName'] as String,
      json['projectColorCode'] as int,
      json['projectUser'] as String);
}

Map<String, dynamic> _$ProjectRToJson(ProjectR instance) => <String, dynamic>{
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'projectColorName': instance.projectColorName,
      'projectColorCode': instance.projectColorCode,
      'projectUser': instance.projectUser
    };
