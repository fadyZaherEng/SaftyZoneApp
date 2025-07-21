// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_recieve_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRecieveRequest _$AddRecieveRequestFromJson(Map<String, dynamic> json) =>
    AddRecieveRequest(
      fireExtinguisher: (json['fireExtinguisher'] as List<dynamic>?)
          ?.map((e) => FireExtinguisher.fromJson(e as Map<String, dynamic>))
          .toList(),
      consumer: json['consumer'] as String?,
      branch: json['branch'] as String?,
      consumerRequest: json['consumerRequest'] as String?,
    );

Map<String, dynamic> _$AddRecieveRequestToJson(AddRecieveRequest instance) =>
    <String, dynamic>{
      'fireExtinguisher': instance.fireExtinguisher,
      'consumer': instance.consumer,
      'branch': instance.branch,
      'consumerRequest': instance.consumerRequest,
    };

FireExtinguisher _$FireExtinguisherFromJson(Map<String, dynamic> json) =>
    FireExtinguisher(
      itemId: json['item_id'] as String?,
      receivedQuantity: (json['receivedQuantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FireExtinguisherToJson(FireExtinguisher instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'receivedQuantity': instance.receivedQuantity,
    };
