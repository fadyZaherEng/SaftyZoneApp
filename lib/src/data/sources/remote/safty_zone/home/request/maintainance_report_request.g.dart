// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintainance_report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintainanceReportRequest _$MaintainanceReportRequestFromJson(
        Map<String, dynamic> json) =>
    MaintainanceReportRequest(
      scheduleJob: json['scheduleJob'] as String?,
      consumerRequest: json['consumerRequest'] as String?,
      consumer: json['consumer'] as String?,
      branch: json['branch'] as String?,
      offer: json['offer'] as String?,
      alarmItem: (json['alarmItem'] as List<dynamic>?)
          ?.map((e) => AlarmItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      fireSystemItem: (json['fireSystemItem'] as List<dynamic>?)
          ?.map((e) => FireSystemItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      safetyStatus: json['safetyStatus'] as String?,
      details: json['details'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$MaintainanceReportRequestToJson(
        MaintainanceReportRequest instance) =>
    <String, dynamic>{
      'scheduleJob': instance.scheduleJob,
      'consumerRequest': instance.consumerRequest,
      'consumer': instance.consumer,
      'branch': instance.branch,
      'offer': instance.offer,
      'alarmItem': instance.alarmItem,
      'fireSystemItem': instance.fireSystemItem,
      'safetyStatus': instance.safetyStatus,
      'details': instance.details,
      'description': instance.description,
    };

AlarmItem _$AlarmItemFromJson(Map<String, dynamic> json) => AlarmItem(
      item: json['item'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      malfunctionsNumber: (json['malfunctionsNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AlarmItemToJson(AlarmItem instance) => <String, dynamic>{
      'item': instance.item,
      'quantity': instance.quantity,
      'malfunctionsNumber': instance.malfunctionsNumber,
    };

FireSystemItem _$FireSystemItemFromJson(Map<String, dynamic> json) =>
    FireSystemItem(
      item: json['item'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      malfunctionsNumber: (json['malfunctionsNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FireSystemItemToJson(FireSystemItem instance) =>
    <String, dynamic>{
      'item': instance.item,
      'quantity': instance.quantity,
      'malfunctionsNumber': instance.malfunctionsNumber,
    };
