// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_create_employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCreateEmployee _$RemoteCreateEmployeeFromJson(
        Map<String, dynamic> json) =>
    RemoteCreateEmployee(
      fullName: json['fullName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '',
      isDeleted: json['isDeleted'] as bool? ?? false,
      jobTitle: json['jobTitle'] as String? ?? '',
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
      Id: json['_id'] as String? ?? '',
      employeeType: json['employeeType'] as String? ?? '',
      permission: json['permission'] as String? ?? '',
      company: json['company'] as String? ?? '',
      V: (json['__v'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteCreateEmployeeToJson(
        RemoteCreateEmployee instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'profileImage': instance.profileImage,
      'isDeleted': instance.isDeleted,
      'jobTitle': instance.jobTitle,
      'createdAt': instance.createdAt,
      '_id': instance.Id,
      'employeeType': instance.employeeType,
      'permission': instance.permission,
      'company': instance.company,
      '__v': instance.V,
    };
