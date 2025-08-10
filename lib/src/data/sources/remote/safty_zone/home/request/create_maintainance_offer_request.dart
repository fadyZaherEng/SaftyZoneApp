import 'package:json_annotation/json_annotation.dart';

part 'create_maintainance_offer_request.g.dart';

@JsonSerializable()
class CreateMaintainanceOfferRequest {
  final String? maintenanceOffer;
  final String? scheduleJob;
  final String? consumerRequest;
  final String? responsibleEmployee;
  final List<ItemOffer>? item;
  final int? price;
  final String? billURL;
  final int? offerNumber;
  final int? itemSupplyPrice;
  final int? installationPrice;

  const CreateMaintainanceOfferRequest({
    this.maintenanceOffer = '',
    this.scheduleJob = '',
    this.consumerRequest = '',
    this.responsibleEmployee = '',
    this.item = const [],
    this.price = 0,
    this.billURL = '',
    this.offerNumber = 1,
    this.itemSupplyPrice = 0,
    this.installationPrice = 0,
  });

  factory CreateMaintainanceOfferRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMaintainanceOfferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMaintainanceOfferRequestToJson(this);

  //copyWith
  CreateMaintainanceOfferRequest copyWith({
    String? maintenanceOffer,
    String? scheduleJob,
    String? consumerRequest,
    String? responsibleEmployee,
    List<ItemOffer>? item,
    int? price,
    String? billURL,
    int? offerNumber,
    int? itemSupplyPrice,
    int? installationPrice,
  }) {
    return CreateMaintainanceOfferRequest(
      maintenanceOffer: maintenanceOffer ?? this.maintenanceOffer,
      scheduleJob: scheduleJob ?? this.scheduleJob,
      consumerRequest: consumerRequest ?? this.consumerRequest,
      responsibleEmployee: responsibleEmployee ?? this.responsibleEmployee,
      item: item ?? this.item,
      price: price ?? this.price,
      billURL: billURL ?? this.billURL,
      offerNumber: offerNumber ?? this.offerNumber,
      itemSupplyPrice: itemSupplyPrice ?? this.itemSupplyPrice,
      installationPrice: installationPrice ?? this.installationPrice,
    );
  }
}

@JsonSerializable()
class ItemOffer {
  final String? ItemId;
  final int? price;
  final int? quantity;

  const ItemOffer({
    this.ItemId = '',
    this.price = 0,
    this.quantity = 0,
  });

  factory ItemOffer.fromJson(Map<String, dynamic> json) => _$ItemOfferFromJson(json);

  Map<String, dynamic> toJson() => _$ItemOfferToJson(this);
}

