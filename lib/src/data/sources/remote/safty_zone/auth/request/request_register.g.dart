// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestRegister _$RequestRegisterFromJson(Map<String, dynamic> json) =>
    RequestRegister(
      companyName: json['companyName'] as String?,
      commercialRegistrationNumber:
          json['commercialRegistrationNumber'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      commercialRegistration: json['commercialRegistration'] == null
          ? null
          : CommercialRegistration.fromJson(
              json['commercialRegistration'] as Map<String, dynamic>),
      civilDefensePermit: json['civilDefensePermit'] == null
          ? null
          : CivilDefensePermit.fromJson(
              json['civilDefensePermit'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      address: json['address'] as String?,
      bankName: json['bankName'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
    );

Map<String, dynamic> _$RequestRegisterToJson(RequestRegister instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'commercialRegistrationNumber': instance.commercialRegistrationNumber,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'commercialRegistration': instance.commercialRegistration,
      'civilDefensePermit': instance.civilDefensePermit,
      'location': instance.location,
      'address': instance.address,
      'bankName': instance.bankName,
      'bankAccountNumber': instance.bankAccountNumber,
    };

CommercialRegistration _$CommercialRegistrationFromJson(
        Map<String, dynamic> json) =>
    CommercialRegistration(
      filePath: json['filePath'] as String?,
      expiryDate: (json['expiryDate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommercialRegistrationToJson(
        CommercialRegistration instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'expiryDate': instance.expiryDate,
    };

CivilDefensePermit _$CivilDefensePermitFromJson(Map<String, dynamic> json) =>
    CivilDefensePermit(
      filePath: json['filePath'] as String?,
      expiryDate: (json['expiryDate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CivilDefensePermitToJson(CivilDefensePermit instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'expiryDate': instance.expiryDate,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
