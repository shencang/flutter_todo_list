import 'package:json_annotation/json_annotation.dart';

part 'label.g.dart';


@JsonSerializable()
class Label extends Object {

  @JsonKey(name: 'labelId')
  int labelId;

  @JsonKey(name: 'labelName')
  String labelName;

  @JsonKey(name: 'labelColorName')
  String labelColorName;

  @JsonKey(name: 'labelColorCode')
  int labelColorCode;

  @JsonKey(name: 'labelUser')
  int labelUser;

  Label(this.labelId,this.labelName,this.labelColorName,this.labelColorCode,this.labelUser,);

  factory Label.fromJson(Map<String, dynamic> srcJson) => _$LabelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LabelToJson(this);

}


