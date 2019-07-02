import 'package:json_annotation/json_annotation.dart';

part 'label_r.g.dart';


@JsonSerializable()
class LabelR extends Object {

  @JsonKey(name: 'labelId')
  int labelId;

  @JsonKey(name: 'labelName')
  String labelName;

  @JsonKey(name: 'labelColorName')
  String labelColorName;

  @JsonKey(name: 'labelColorCode')
  int labelColorCode;

  @JsonKey(name: 'labelUser')
  String labelUser;

  LabelR(this.labelId,this.labelName,this.labelColorName,this.labelColorCode,this.labelUser,);

  factory LabelR.fromJson(Map<String, dynamic> srcJson) => _$LabelRFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LabelRToJson(this);

}


