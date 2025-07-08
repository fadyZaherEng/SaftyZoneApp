// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_control_panel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteControlPanel _$RemoteControlPanelFromJson(Map<String, dynamic> json) =>
    RemoteControlPanel(
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

Map<String, dynamic> _$RemoteControlPanelToJson(RemoteControlPanel instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'provider': instance.provider,
      'item': instance.item,
      'isDeleted': instance.isDeleted,
      'price': instance.price,
      'createdAt': instance.createdAt,
      '__v': instance.V,
    };

RemoteItem _$RemoteItemFromJson(Map<String, dynamic> json) => RemoteItem(
      Id: json['_id'] as String? ?? "",
      itemName: json['itemName'] as String? ?? "",
      itemCode: json['itemCode'] as String? ?? "",
      image: json['image'] as String? ?? "",
      supplierName: json['supplierName'] as String? ?? "",
      supplyPrice: (json['supplyPrice'] as num?)?.toInt() ?? 0,
      isDeleted: json['isDeleted'] as bool? ?? false,
      admin: json['admin'] as String? ?? "",
      type: json['type'] as String? ?? "",
      alarmType: json['alarmType'] as String? ?? "",
      subCategory: json['subCategory'] as String? ?? "",
      createdAt: json['createdAt'] as String? ?? "",
      updatedAt: json['updatedAt'] as String? ?? "",
      V: (json['__v'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteItemToJson(RemoteItem instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'itemName': instance.itemName,
      'itemCode': instance.itemCode,
      'image': instance.image,
      'supplierName': instance.supplierName,
      'supplyPrice': instance.supplyPrice,
      'isDeleted': instance.isDeleted,
      'admin': instance.admin,
      'type': instance.type,
      'alarmType': instance.alarmType,
      'subCategory': instance.subCategory,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.V,
    };
