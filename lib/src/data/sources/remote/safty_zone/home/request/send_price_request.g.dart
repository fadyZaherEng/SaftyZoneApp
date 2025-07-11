// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_price_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendPriceRequest _$SendPriceRequestFromJson(Map<String, dynamic> json) =>
    SendPriceRequest(
      consumerRequest: json['consumerRequest'] as String?,
      responsibleEmployee: json['responsibleEmployee'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SendPriceRequestToJson(SendPriceRequest instance) =>
    <String, dynamic>{
      'consumerRequest': instance.consumerRequest,
      'responsibleEmployee': instance.responsibleEmployee,
      'price': instance.price,
    };
