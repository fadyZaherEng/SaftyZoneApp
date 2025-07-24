import 'package:json_annotation/json_annotation.dart';

part 'remote_main_offer_fire_extinguisher.g.dart';

@JsonSerializable()
class RemoteMainOfferFireExtinguisher {
  final String? provider;
  final String? consumerRequest;
  final int? price;
  final String? status;
  final String? responsibleEmployee;
  final int? createdAt;
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteMainOfferFireExtinguisher({
    this.provider,
    this.consumerRequest,
    this.price,
    this.status,
    this.responsibleEmployee,
    this.createdAt,
    this.Id,
    this.V,
  });

  factory RemoteMainOfferFireExtinguisher.fromJson(Map<String, dynamic> json) =>
      _$RemoteMainOfferFireExtinguisherFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMainOfferFireExtinguisherToJson(this);
}
