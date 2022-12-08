// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account()
  ..name = json['name'] as String?
  ..surname = json['surname'] as String?
  ..birthDate = json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String)
  ..sallary = (json['sallary'] as num?)?.toDouble()
  ..phoneNumber = json['phoneNumber'] as String?
  ..identity = json['identity'] as String?
  ..id = json['id'] as String?;

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'surname': instance.surname,
    'birthDate': instance.birthDate?.toIso8601String(),
    'sallary': instance.sallary,
    'phoneNumber': instance.phoneNumber,
    'identity': instance.identity,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
