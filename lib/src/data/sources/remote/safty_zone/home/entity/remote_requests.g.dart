// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteRequests _$RemoteRequestsFromJson(Map<String, dynamic> json) =>
    RemoteRequests(
      Id: json['_id'] as String? ?? "",
      branch: json['branch'] == null
          ? const RemoteBranch()
          : RemoteBranch.fromJson(json['branch'] as Map<String, dynamic>),
      providers: (json['providers'] as List<dynamic>?)
              ?.map((e) => RemoteProviders.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      requestNumber: json['requestNumber'] as String? ?? "",
      requestType: json['requestType'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteRequestsToJson(RemoteRequests instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'branch': instance.branch,
      'requestNumber': instance.requestNumber,
      'requestType': instance.requestType,
      'providers': instance.providers,
    };

RemoteBranch _$RemoteBranchFromJson(Map<String, dynamic> json) => RemoteBranch(
      location: json['location'] == null
          ? const RemoteLocation()
          : RemoteLocation.fromJson(json['location'] as Map<String, dynamic>),
      Id: json['_id'] as String? ?? "",
      branchName: json['branchName'] as String? ?? "",
      employee: json['employee'] == null
          ? const RemoteEmployee()
          : RemoteEmployee.fromJson(json['employee'] as Map<String, dynamic>),
      address: json['address'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteBranchToJson(RemoteBranch instance) =>
    <String, dynamic>{
      'location': instance.location,
      '_id': instance.Id,
      'branchName': instance.branchName,
      'employee': instance.employee,
      'address': instance.address,
    };

RemoteLocation _$RemoteLocationFromJson(Map<String, dynamic> json) =>
    RemoteLocation(
      type: json['type'] as String? ?? "",
      coordinates: (json['coordinates'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteLocationToJson(RemoteLocation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

RemoteEmployee _$RemoteEmployeeFromJson(Map<String, dynamic> json) =>
    RemoteEmployee(
      Id: json['_id'] as String? ?? "",
      fullName: json['fullName'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as String? ?? "",
      profileImage: json['profileImage'] as String? ?? "",
      employeeType: json['employeeType'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteEmployeeToJson(RemoteEmployee instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'profileImage': instance.profileImage,
      'employeeType': instance.employeeType,
    };

RemoteProviders _$RemoteProvidersFromJson(Map<String, dynamic> json) =>
    RemoteProviders(
      provider: json['provider'] as String? ?? "",
      status: json['status'] as String? ?? "",
      Id: json['_id'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteProvidersToJson(RemoteProviders instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'status': instance.status,
      '_id': instance.Id,
    };
