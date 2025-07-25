import 'package:json_annotation/json_annotation.dart';

part 'send_price_request.g.dart';

@JsonSerializable()
class SendPriceRequest {
  final String? consumerRequest;
  final String? responsibleEmployee;
  final int? price;
  final List<Item>? items;
  final bool? is_Primary;

  const SendPriceRequest({
    required this.consumerRequest,
    required this.responsibleEmployee,
    required this.price,
    required this.items,
    required this.is_Primary,
  });

  factory SendPriceRequest.fromJson(Map<String, dynamic> json) =>
      _$SendPriceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendPriceRequestToJson(this);
}

@JsonSerializable()
class Item {
  final String? ItemId;
  final int? price;
  final int? quantity;

  const Item({
    required this.ItemId,
    required this.price,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
