// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_installation_fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteInstallationFees _$RemoteInstallationFeesFromJson(
        Map<String, dynamic> json) =>
    RemoteInstallationFees(
      provider: json['provider'] as String? ?? "",
      item: json['item'] as String? ?? "",
      isDeleted: json['isDeleted'] as bool? ?? false,
      price: (json['price'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
      Id: json['_id'] as String? ?? "",
      V: (json['__v'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteInstallationFeesToJson(
        RemoteInstallationFees instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'item': instance.item,
      'isDeleted': instance.isDeleted,
      'price': instance.price,
      'createdAt': instance.createdAt,
      '_id': instance.Id,
      '__v': instance.V,
    };
