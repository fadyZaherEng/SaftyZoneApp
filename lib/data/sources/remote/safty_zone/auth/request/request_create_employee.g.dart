// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_create_employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestCreateEmployee _$RequestCreateEmployeeFromJson(
        Map<String, dynamic> json) =>
    RequestCreateEmployee(
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      permission: json['permission'] as String?,
      profileImage: json['profileImage'] as String?,
      jobTitle: json['jobTitle'] as String?,
    );

Map<String, dynamic> _$RequestCreateEmployeeToJson(
        RequestCreateEmployee instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'permission': instance.permission,
      'profileImage': instance.profileImage,
      'jobTitle': instance.jobTitle,
    };
