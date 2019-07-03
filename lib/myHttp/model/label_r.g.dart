// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_r.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelR _$LabelRFromJson(Map<String, dynamic> json) {
  return LabelR(
      json['labelId'] as int,
      json['labelName'] as String,
      json['labelColorName'] as String,
      json['labelColorCode'] as int,
      json['labelUser'] as String);
}

Map<String, dynamic> _$LabelRToJson(LabelR instance) => <String, dynamic>{
      'labelId': instance.labelId,
      'labelName': instance.labelName,
      'labelColorName': instance.labelColorName,
      'labelColorCode': instance.labelColorCode,
      'labelUser': instance.labelUser
    };
