// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_send_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSendPrice _$RemoteSendPriceFromJson(Map<String, dynamic> json) =>
    RemoteSendPrice(
      provider: json['provider'] as String?,
      consumerRequest: json['consumerRequest'] as String?,
      price: (json['price'] as num?)?.toInt(),
      status: json['status'] as String?,
      responsibleEmployee: json['responsibleEmployee'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      Id: json['_id'] as String?,
      V: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RemoteSendPriceToJson(RemoteSendPrice instance) =>
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
