// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_bulk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestBulk _$RequestBulkFromJson(Map<String, dynamic> json) => RequestBulk(
      installationFees: (json['installationFees'] as List<dynamic>?)
          ?.map((e) => InstallationFees.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestBulkToJson(RequestBulk instance) =>
    <String, dynamic>{
      'installationFees': instance.installationFees,
    };

InstallationFees _$InstallationFeesFromJson(Map<String, dynamic> json) =>
    InstallationFees(
      item: json['item'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InstallationFeesToJson(InstallationFees instance) =>
    <String, dynamic>{
      'item': instance.item,
      'price': instance.price,
    };
