// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_maintainance_offer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMaintainanceOfferRequest _$CreateMaintainanceOfferRequestFromJson(
        Map<String, dynamic> json) =>
    CreateMaintainanceOfferRequest(
      maintenanceOffer: json['maintenanceOffer'] as String? ?? '',
      scheduleJob: json['scheduleJob'] as String? ?? '',
      consumerRequest: json['consumerRequest'] as String? ?? '',
      responsibleEmployee: json['responsibleEmployee'] as String? ?? '',
      item: (json['item'] as List<dynamic>?)
              ?.map((e) => ItemOffer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      price: (json['price'] as num?)?.toInt() ?? 0,
      billURL: json['billURL'] as String? ?? '',
      offerNumber: (json['offerNumber'] as num?)?.toInt() ?? 0,
      itemSupplyPrice: (json['itemSupplyPrice'] as num?)?.toInt() ?? 0,
      installationPrice: (json['installationPrice'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CreateMaintainanceOfferRequestToJson(
        CreateMaintainanceOfferRequest instance) =>
    <String, dynamic>{
      'maintenanceOffer': instance.maintenanceOffer,
      'scheduleJob': instance.scheduleJob,
      'consumerRequest': instance.consumerRequest,
      'responsibleEmployee': instance.responsibleEmployee,
      'item': instance.item,
      'price': instance.price,
      'billURL': instance.billURL,
      'offerNumber': instance.offerNumber,
      'itemSupplyPrice': instance.itemSupplyPrice,
      'installationPrice': instance.installationPrice,
    };

ItemOffer _$ItemOfferFromJson(Map<String, dynamic> json) => ItemOffer(
      ItemId: json['ItemId'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ItemOfferToJson(ItemOffer instance) => <String, dynamic>{
      'ItemId': instance.ItemId,
      'price': instance.price,
      'quantity': instance.quantity,
    };
