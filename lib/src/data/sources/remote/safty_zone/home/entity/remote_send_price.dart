import 'package:json_annotation/json_annotation.dart';

part 'remote_send_price.g.dart';

@JsonSerializable()
class RemoteSendPrice {
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

  const RemoteSendPrice({
    this.provider,
    this.consumerRequest,
    this.price,
    this.status,
    this.responsibleEmployee,
    this.createdAt,
    this.Id,
    this.V,
  });

  factory RemoteSendPrice.fromJson(Map<String, dynamic> json) =>
      _$RemoteSendPriceFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSendPriceToJson(this);
}
