// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_offer_fire_extinguisher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainOfferFireExtinguisher _$MainOfferFireExtinguisherFromJson(
        Map<String, dynamic> json) =>
    MainOfferFireExtinguisher(
      consumerRequest: json['consumerRequest'] as String?,
      responsibleEmployee: json['responsibleEmployee'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduleJob: json['scheduleJob'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MainOfferFireExtinguisherToJson(
        MainOfferFireExtinguisher instance) =>
    <String, dynamic>{
      'consumerRequest': instance.consumerRequest,
      'responsibleEmployee': instance.responsibleEmployee,
      'items': instance.items,
      'scheduleJob': instance.scheduleJob,
      'price': instance.price,
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
