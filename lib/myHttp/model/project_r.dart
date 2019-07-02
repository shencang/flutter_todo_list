import 'package:json_annotation/json_annotation.dart';

part 'project_r.g.dart';


List<ProjectR> getProjectRList(List<dynamic> list){
  List<ProjectR> result = [];
  list.forEach((item){
    result.add(ProjectR.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class ProjectR extends Object {

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'projectColorName')
  String projectColorName;

  @JsonKey(name: 'projectColorCode')
  int projectColorCode;

  @JsonKey(name: 'projectUser')
  String projectUser;

  ProjectR(this.projectId,this.projectName,this.projectColorName,this.projectColorCode,this.projectUser,);

  factory ProjectR.fromJson(Map<String, dynamic> srcJson) => _$ProjectRFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectRToJson(this);

}


