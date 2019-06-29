import 'package:json_annotation/json_annotation.dart';

part 'package:flutter_todo_list/http/model/user.g.dart';


@JsonSerializable()
class user extends Object {

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'userEmail')
  String userEmail;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'userPassword')
  String userPassword;

  @JsonKey(name: 'userPhone')
  String userPhone;

  @JsonKey(name: 'userIdentity')
  String userIdentity;

  @JsonKey(name: 'userSex')
  String userSex;

  @JsonKey(name: 'userAvatar')
  String userAvatar;

  @JsonKey(name: 'userSignature')
  String userSignature;

  user(this.userId,this.userEmail,this.username,this.userPassword,this.userPhone,this.userIdentity,this.userSex,this.userAvatar,this.userSignature,);

  factory user.fromJson(Map<String, dynamic> srcJson) => _$userFromJson(srcJson);

  Map<String, dynamic> toJson() => _$userToJson(this);

}


