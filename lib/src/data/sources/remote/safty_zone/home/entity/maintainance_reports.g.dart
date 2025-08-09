// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintainance_reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintainanceReports _$MaintainanceReportsFromJson(Map<String, dynamic> json) =>
    MaintainanceReports(
      Id: json['_id'] as String?,
      provider: json['provider'] as String?,
      consumer: json['consumer'] as String?,
      consumerRequest: json['consumerRequest'] as String?,
      branch: json['branch'] as String?,
      offer: json['offer'] as String?,
      responsibleEmployee: json['responsibleEmployee'] as String?,
      scheduleJob: json['scheduleJob'] as String?,
      alarmItem: (json['alarmItem'] as List<dynamic>?)
          ?.map((e) => AlarmItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      fireSystemItem: (json['fireSystemItem'] as List<dynamic>?)
          ?.map((e) => FireSystemItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      safetyStatus: json['safetyStatus'] as String?,
      details: json['details'] as String?,
      description: json['description'] as String?,
      maintenanceOfferStatus: json['maintenanceOfferStatus'] as String?,
      MaintenanceOffer: json['MaintenanceOffer'],
      visitDate: (json['visitDate'] as num?)?.toInt(),
      createdAt: (json['createdAt'] as num?)?.toInt(),
      V: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MaintainanceReportsToJson(
        MaintainanceReports instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'provider': instance.provider,
      'consumer': instance.consumer,
      'consumerRequest': instance.consumerRequest,
      'branch': instance.branch,
      'offer': instance.offer,
      'responsibleEmployee': instance.responsibleEmployee,
      'scheduleJob': instance.scheduleJob,
      'alarmItem': instance.alarmItem,
      'fireSystemItem': instance.fireSystemItem,
      'safetyStatus': instance.safetyStatus,
      'details': instance.details,
      'description': instance.description,
      'maintenanceOfferStatus': instance.maintenanceOfferStatus,
      'MaintenanceOffer': instance.MaintenanceOffer,
      'visitDate': instance.visitDate,
      'createdAt': instance.createdAt,
      '__v': instance.V,
    };

AlarmItem _$AlarmItemFromJson(Map<String, dynamic> json) => AlarmItem(
      item: json['item'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      malfunctionsNumber: (json['malfunctionsNumber'] as num?)?.toInt(),
      Id: json['_id'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$AlarmItemToJson(AlarmItem instance) => <String, dynamic>{
      'item': instance.item,
      'quantity': instance.quantity,
      'malfunctionsNumber': instance.malfunctionsNumber,
      '_id': instance.Id,
      'status': instance.status,
    };

FireSystemItem _$FireSystemItemFromJson(Map<String, dynamic> json) =>
    FireSystemItem(
      item: json['item'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      malfunctionsNumber: (json['malfunctionsNumber'] as num?)?.toInt(),
      Id: json['_id'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$FireSystemItemToJson(FireSystemItem instance) =>
    <String, dynamic>{
      'item': instance.item,
      'quantity': instance.quantity,
      'malfunctionsNumber': instance.malfunctionsNumber,
      '_id': instance.Id,
      'status': instance.status,
    };
