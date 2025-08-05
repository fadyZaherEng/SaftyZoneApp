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
      item: (json['item'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      is_Primary: json['is_Primary'] as bool?,
      emergencyVisitPrice: (json['emergencyVisitPrice'] as num?)?.toInt(),
      visitPrice: (json['visitPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SendPriceRequestToJson(SendPriceRequest instance) =>
    <String, dynamic>{
      'consumerRequest': instance.consumerRequest,
      'responsibleEmployee': instance.responsibleEmployee,
      'price': instance.price,
      'item': instance.item,
      'is_Primary': instance.is_Primary,
      'emergencyVisitPrice': instance.emergencyVisitPrice,
      'visitPrice': instance.visitPrice,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      ItemId: json['ItemId'] as String?,
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'ItemId': instance.ItemId,
      'price': instance.price,
      'quantity': instance.quantity,
    };
