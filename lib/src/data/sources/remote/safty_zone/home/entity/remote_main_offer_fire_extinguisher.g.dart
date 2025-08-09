// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_main_offer_fire_extinguisher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteMainOfferFireExtinguisher _$RemoteMainOfferFireExtinguisherFromJson(
        Map<String, dynamic> json) =>
    RemoteMainOfferFireExtinguisher(
      provider: json['provider'] as String?,
      consumerRequest: json['consumerRequest'] as String?,
      price: (json['price'] as num?)?.toInt(),
      status: json['status'] as String?,
      responsibleEmployee: json['responsibleEmployee'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      Id: json['_id'] as String?,
      V: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RemoteMainOfferFireExtinguisherToJson(
        RemoteMainOfferFireExtinguisher instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'consumerRequest': instance.consumerRequest,
      'price': instance.price,
      'status': instance.status,
      'responsibleEmployee': instance.responsibleEmployee,
      'createdAt': instance.createdAt,
      '_id': instance.Id,
      '__v': instance.V,
    };
