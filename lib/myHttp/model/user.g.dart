// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

user _$userFromJson(Map<String, dynamic> json) {
  return user(
      json['userId'] as int,
      json['userEmail'] as String,
      json['username'] as String,
      json['userPassword'] as String,
      json['userPhone'] as String,
      json['userIdentity'] as String,
      json['userSex'] as String,
      json['userAvatar'] as String,
      json['userSignature'] as String);
}

Map<String, dynamic> _$userToJson(user instance) => <String, dynamic>{
      'userId': instance.userId,
      'userEmail': instance.userEmail,
      'username': instance.username,
      'userPassword': instance.userPassword,
      'userPhone': instance.userPhone,
      'userIdentity': instance.userIdentity,
      'userSex': instance.userSex,
      'userAvatar': instance.userAvatar,
      'userSignature': instance.userSignature
    };
