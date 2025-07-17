// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_go_to_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteGoToLocation _$RemoteGoToLocationFromJson(Map<String, dynamic> json) =>
    RemoteGoToLocation(
      Id: json['_id'] as String?,
      provider: json['provider'] as String?,
      consumer: json['consumer'] as String?,
      branch: json['branch'] as String?,
      offer: json['offer'] as String?,
      responseEmployee: json['responseEmployee'] as String?,
      requestNumber: json['requestNumber'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      visitDate: (json['visitDate'] as num?)?.toInt(),
      createdAt: (json['createdAt'] as num?)?.toInt(),
      V: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RemoteGoToLocationToJson(RemoteGoToLocation instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'provider': instance.provider,
      'consumer': instance.consumer,
      'branch': instance.branch,
      'offer': instance.offer,
      'responseEmployee': instance.responseEmployee,
      'requestNumber': instance.requestNumber,
      'type': instance.type,
      'status': instance.status,
      'visitDate': instance.visitDate,
      'createdAt': instance.createdAt,
      '__v': instance.V,
    };
