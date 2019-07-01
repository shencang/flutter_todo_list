// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
      json['projectId'] as int,
      json['projectName'] as String,
      json['projectColorName'] as String,
      json['projectColorCode'] as int,
      json['projectUser'] as int);
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'projectColorName': instance.projectColorName,
      'projectColorCode': instance.projectColorCode,
      'projectUser': instance.projectUser
    };
