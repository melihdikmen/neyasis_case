import 'package:json_annotation/json_annotation.dart';
import '../base/base_model.dart';

part 'account.g.dart';

@JsonSerializable()
class Account extends BaseModel {
  String? name;

  String? surname;

  DateTime? birthDate;

  double? sallary;

  String? phoneNumber;

  String? identity;
  
  @JsonKey(includeIfNull: false)
  String? id;
  Account();

  @override
  fromJson(Map<String, dynamic> json) {
    return _$AccountFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AccountToJson(this);
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return _$AccountFromJson(json);
  }
}
