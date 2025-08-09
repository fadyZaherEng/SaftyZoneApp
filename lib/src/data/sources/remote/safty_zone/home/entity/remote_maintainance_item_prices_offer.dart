import 'package:json_annotation/json_annotation.dart';

part 'remote_maintainance_item_prices_offer.g.dart';

@JsonSerializable()
class RemoteMaintainanceItemPricesOffer {
  final List<Result>? result;
  final int? totalPrice;

  const RemoteMaintainanceItemPricesOffer({
    this.result,
    this.totalPrice,
  });

  factory RemoteMaintainanceItemPricesOffer.fromJson(Map<String, dynamic> json) =>
      _$RemoteMaintainanceItemPricesOfferFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMaintainanceItemPricesOfferToJson(this);
}

@JsonSerializable()
class Result {
  final String? subCategory;
  final List<Item>? item;

  const Result({
    this.subCategory,
    this.item,
  });

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Item {
  final ItemName? itemName;
  final int? itemPrice;
  final int? quantity;

  const Item({
    this.itemName,
    this.itemPrice,
    this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class ItemName {
  final String? en;
  final String? ar;

  const ItemName({
    this.en,
    this.ar,
  });

  factory ItemName.fromJson(Map<String, dynamic> json) =>
      _$ItemNameFromJson(json);

  Map<String, dynamic> toJson() => _$ItemNameToJson(this);
}
