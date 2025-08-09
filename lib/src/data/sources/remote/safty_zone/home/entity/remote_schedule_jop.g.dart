// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_schedule_jop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteScheduleJop _$RemoteScheduleJopFromJson(Map<String, dynamic> json) =>
    RemoteScheduleJop(
      Id: json['_id'] as String? ?? "",
      provider: json['provider'] as String? ?? "",
      consumer: json['consumer'] as String? ?? "",
      branch: json['branch'] == null
          ? const RemoteBranch()
          : RemoteBranch.fromJson(json['branch'] as Map<String, dynamic>),
      offer: json['offer'] as String? ?? "",
      responseEmployee: json['responseEmployee'] == null
          ? const RemoteEmployee()
          : RemoteEmployee.fromJson(
              json['responseEmployee'] as Map<String, dynamic>),
      requestNumber: json['requestNumber'] as String? ?? "",
      type: json['type'] as String? ?? "",
      status: json['status'] as String? ?? "",
      visitDate: (json['visitDate'] as num?)?.toInt() ?? 0,
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
      V: (json['__v'] as num?)?.toInt() ?? 0,
      step: json['step'] as String? ?? "",
      receiveItem: json['receiveItem'] as String? ?? "",
      consumerRequest: json['consumerRequest'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteScheduleJopToJson(RemoteScheduleJop instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'provider': instance.provider,
      'consumer': instance.consumer,
      'consumerRequest': instance.consumerRequest,
      'branch': instance.branch,
      'offer': instance.offer,
      'responseEmployee': instance.responseEmployee,
      'requestNumber': instance.requestNumber,
      'type': instance.type,
      'status': instance.status,
      'receiveItem': instance.receiveItem,
      'step': instance.step,
      'visitDate': instance.visitDate,
      'createdAt': instance.createdAt,
      '__v': instance.V,
    };
