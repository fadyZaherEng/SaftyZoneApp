// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_add_recieve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteAddRecieve _$RemoteAddRecieveFromJson(Map<String, dynamic> json) =>
    RemoteAddRecieve(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteAddRecieveToJson(RemoteAddRecieve instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      fireExtinguisher: (json['fireExtinguisher'] as List<dynamic>?)
          ?.map((e) => FireExtinguisher.fromJson(e as Map<String, dynamic>))
          .toList(),
      providerEmployee: json['providerEmployee'] as String?,
      consumer: json['consumer'] as String?,
      branch: json['branch'] as String?,
      provider: json['provider'] as String?,
      consumerRequest: json['consumerRequest'] as String?,
      status: json['status'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      Id: json['_id'] as String?,
      V: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'fireExtinguisher': instance.fireExtinguisher,
      'providerEmployee': instance.providerEmployee,
      'consumer': instance.consumer,
      'branch': instance.branch,
      'provider': instance.provider,
      'consumerRequest': instance.consumerRequest,
      'status': instance.status,
      'createdAt': instance.createdAt,
      '_id': instance.Id,
      '__v': instance.V,
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
