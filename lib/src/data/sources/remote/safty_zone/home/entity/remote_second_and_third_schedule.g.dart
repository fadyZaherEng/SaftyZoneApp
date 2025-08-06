// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_second_and_third_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSecondAndThirdSchedule _$RemoteSecondAndThirdScheduleFromJson(
        Map<String, dynamic> json) =>
    RemoteSecondAndThirdSchedule(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteSecondAndThirdScheduleToJson(
        RemoteSecondAndThirdSchedule instance) =>
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
      itemId: json['item_id'] == null
          ? null
          : ItemId.fromJson(json['item_id'] as Map<String, dynamic>),
      existQuantity: (json['existQuantity'] as num?)?.toInt(),
      receivedQuantity: (json['receivedQuantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FireExtinguisherToJson(FireExtinguisher instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'existQuantity': instance.existQuantity,
      'receivedQuantity': instance.receivedQuantity,
    };

ItemId _$ItemIdFromJson(Map<String, dynamic> json) => ItemId(
      Id: json['_id'] as String?,
      itemName: json['itemName'] == null
          ? null
          : ItemName.fromJson(json['itemName'] as Map<String, dynamic>),
      image: json['image'] as String?,
      type: json['type'] as String?,
      subCategory: json['subCategory'] as String?,
    );

Map<String, dynamic> _$ItemIdToJson(ItemId instance) => <String, dynamic>{
      '_id': instance.Id,
      'itemName': instance.itemName,
      'image': instance.image,
      'type': instance.type,
      'subCategory': instance.subCategory,
    };
