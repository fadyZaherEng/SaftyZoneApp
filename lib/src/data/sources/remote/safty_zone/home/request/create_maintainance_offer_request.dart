import 'package:json_annotation/json_annotation.dart';

part 'create_maintainance_offer_request.g.dart';

@JsonSerializable()
class CreateMaintainanceOfferRequest {
  final String? maintenanceOffer;
  final String? scheduleJob;
  final String? consumerRequest;
  final String? responsibleEmployee;
  final String? item;
  final String? price;
  final String? billURL;
  final String? offerNumber;
  final String? itemSupplyPrice;
  final String? installationPrice;

  const CreateMaintainanceOfferRequest({
    this.maintenanceOffer,
    this.scheduleJob,
    this.consumerRequest,
    this.responsibleEmployee,
    this.item,
    this.price,
    this.billURL,
    this.offerNumber,
    this.itemSupplyPrice,
    this.installationPrice,
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
    String? item,
    String? price,
    String? billURL,
    String? offerNumber,
    String? itemSupplyPrice,
    String? installationPrice,
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
