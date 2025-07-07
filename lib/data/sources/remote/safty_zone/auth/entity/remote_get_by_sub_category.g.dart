// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_get_by_sub_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteGetBySubCategory _$RemoteGetBySubCategoryFromJson(
        Map<String, dynamic> json) =>
    RemoteGetBySubCategory(
      Id: json['_id'] as String? ?? "",
      provider: json['provider'] as String? ?? "",
      item: json['item'] == null
          ? const RemoteItem()
          : RemoteItem.fromJson(json['item'] as Map<String, dynamic>),
      isDeleted: json['isDeleted'] as bool? ?? false,
      price: (json['price'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
      V: (json['__v'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteGetBySubCategoryToJson(
        RemoteGetBySubCategory instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'provider': instance.provider,
      'item': instance.item,
      'isDeleted': instance.isDeleted,
      'price': instance.price,
      'createdAt': instance.createdAt,
      '__v': instance.V,
    };
