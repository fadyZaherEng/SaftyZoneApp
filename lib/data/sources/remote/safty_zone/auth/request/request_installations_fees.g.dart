// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_installations_fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestInstallationsFees _$RequestInstallationsFeesFromJson(
        Map<String, dynamic> json) =>
    RequestInstallationsFees(
      item: json['item'] as String?,
      price: (json['price'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      isComplete: json['isComplete'] as bool?,
    );

Map<String, dynamic> _$RequestInstallationsFeesToJson(
        RequestInstallationsFees instance) =>
    <String, dynamic>{
      'item': instance.item,
      'price': instance.price,
      'isComplete': instance.isComplete,
    };
