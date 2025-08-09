// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_maintainance_offer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMaintainanceOfferRequest _$CreateMaintainanceOfferRequestFromJson(
        Map<String, dynamic> json) =>
    CreateMaintainanceOfferRequest(
      maintenanceOffer: json['maintenanceOffer'] as String?,
      scheduleJob: json['scheduleJob'] as String?,
      consumerRequest: json['consumerRequest'] as String?,
      responsibleEmployee: json['responsibleEmployee'] as String?,
      item: json['item'] as String?,
      price: json['price'] as String?,
      billURL: json['billURL'] as String?,
      offerNumber: json['offerNumber'] as String?,
      itemSupplyPrice: json['itemSupplyPrice'] as String?,
      installationPrice: json['installationPrice'] as String?,
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
