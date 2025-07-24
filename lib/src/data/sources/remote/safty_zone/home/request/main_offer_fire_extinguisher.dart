import 'package:json_annotation/json_annotation.dart';

part 'main_offer_fire_extinguisher.g.dart';

@JsonSerializable()
class MainOfferFireExtinguisher {
  final String? consumerRequest;
  final String? responsibleEmployee;
  final List<Item>? items;
  final String? scheduleJob;
  final int? price;

  const MainOfferFireExtinguisher({
    this.consumerRequest,
    this.responsibleEmployee,
    this.items,
    this.scheduleJob,
    this.price,
  });

  factory MainOfferFireExtinguisher.fromJson(Map<String, dynamic> json) =>
      _$MainOfferFireExtinguisherFromJson(json);

  Map<String, dynamic> toJson() => _$MainOfferFireExtinguisherToJson(this);
}

@JsonSerializable()
class Item {
  final String? ItemId;
  final int? price;
  final int? quantity;

  const Item({
    this.ItemId,
    this.price,
    this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
