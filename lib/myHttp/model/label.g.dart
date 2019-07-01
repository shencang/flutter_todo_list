// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Label _$LabelFromJson(Map<String, dynamic> json) {
  return Label(
      json['labelId'] as int,
      json['labelName'] as String,
      json['labelColorName'] as String,
      json['labelColorCode'] as int,
      json['labelUser'] as int);
}

Map<String, dynamic> _$LabelToJson(Label instance) => <String, dynamic>{
      'labelId': instance.labelId,
      'labelName': instance.labelName,
      'labelColorName': instance.labelColorName,
      'labelColorCode': instance.labelColorCode,
      'labelUser': instance.labelUser
    };
