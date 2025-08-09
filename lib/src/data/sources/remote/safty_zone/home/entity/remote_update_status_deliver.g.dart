// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_update_status_deliver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUpdateStatusDeliver _$RemoteUpdateStatusDeliverFromJson(
        Map<String, dynamic> json) =>
    RemoteUpdateStatusDeliver(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteUpdateStatusDeliverToJson(
        RemoteUpdateStatusDeliver instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      Id: json['_id'] as String?,
      fireExtinguisher: (json['fireExtinguisher'] as List<dynamic>?)
          ?.map((e) => FireExtinguisher.fromJson(e as Map<String, dynamic>))
          .toList(),
      providerEmployee: json['providerEmployee'] as String?,
      consumer: json['consumer'] as String?,
      branch: json['branch'] as String?,
      provider: json['provider'] as String?,
      consumerRequest: json['consumerRequest'] as String?,
      scheduleJob: json['scheduleJob'] as String?,
      status: json['status'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      V: (json['__v'] as num?)?.toInt(),
      expireAt: (json['expireAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      '_id': instance.Id,
      'fireExtinguisher': instance.fireExtinguisher,
      'providerEmployee': instance.providerEmployee,
      'consumer': instance.consumer,
      'branch': instance.branch,
      'provider': instance.provider,
      'consumerRequest': instance.consumerRequest,
      'scheduleJob': instance.scheduleJob,
      'status': instance.status,
      'createdAt': instance.createdAt,
      '__v': instance.V,
      'expireAt': instance.expireAt,
    };

FireExtinguisher _$FireExtinguisherFromJson(Map<String, dynamic> json) =>
    FireExtinguisher(
      itemId: json['item_id'] as String?,
      existQuantity: (json['existQuantity'] as num?)?.toInt(),
      receivedQuantity: (json['receivedQuantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FireExtinguisherToJson(FireExtinguisher instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'existQuantity': instance.existQuantity,
      'receivedQuantity': instance.receivedQuantity,
    };
