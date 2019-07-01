import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';


@JsonSerializable()
class Project extends Object {

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'projectColorName')
  String projectColorName;

  @JsonKey(name: 'projectColorCode')
  int projectColorCode;

  @JsonKey(name: 'projectUser')
  int projectUser;

  Project(this.projectId,this.projectName,this.projectColorName,this.projectColorCode,this.projectUser,);

  factory Project.fromJson(Map<String, dynamic> srcJson) => _$ProjectFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

}


