// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_maintainance_item_prices_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteMaintainanceItemPricesOffer _$RemoteMaintainanceItemPricesOfferFromJson(
        Map<String, dynamic> json) =>
    RemoteMaintainanceItemPricesOffer(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RemoteMaintainanceItemPricesOfferToJson(
        RemoteMaintainanceItemPricesOffer instance) =>
    <String, dynamic>{
      'result': instance.result,
      'totalPrice': instance.totalPrice,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      subCategory: json['subCategory'] as String?,
      item: (json['item'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'subCategory': instance.subCategory,
      'item': instance.item,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      itemName: json['itemName'] == null
          ? null
          : ItemName.fromJson(json['itemName'] as Map<String, dynamic>),
      itemPrice: (json['itemPrice'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'itemName': instance.itemName,
      'itemPrice': instance.itemPrice,
      'quantity': instance.quantity,
    };

ItemName _$ItemNameFromJson(Map<String, dynamic> json) => ItemName(
      en: json['en'] as String?,
      ar: json['ar'] as String?,
    );

Map<String, dynamic> _$ItemNameToJson(ItemName instance) => <String, dynamic>{
      'en': instance.en,
      'ar': instance.ar,
    };
