import 'package:json_annotation/json_annotation.dart';

part 'send_price_request.g.dart';

@JsonSerializable()
class SendPriceRequest {
  final String? consumerRequest;
  final String? responsibleEmployee;
  final int? price;

  const SendPriceRequest({
    this.consumerRequest,
    this.responsibleEmployee,
    this.price,
  });

  factory SendPriceRequest.fromJson(Map<String, dynamic> json) =>
      _$SendPriceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendPriceRequestToJson(this);
}
