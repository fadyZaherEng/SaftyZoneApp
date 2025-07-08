import 'package:equatable/equatable.dart';

class ControlPanel extends Equatable {
  final String Id;
  final String provider;
  final Item item;
  final bool isDeleted;
  final List<int> price;
  final int createdAt;
  final int V;

  const ControlPanel({
    this.Id = "",
    this.provider = "",
    this.item = const Item(),
    this.isDeleted = false,
    this.price = const [],
    this.createdAt = 0,
    this.V = 0,
  });

  @override
  List<Object?> get props => [
        Id,
        provider,
        item,
        isDeleted,
        price,
        createdAt,
        V,
      ];
}

class Item extends Equatable {
  final String Id;
  final String itemName;
  final String itemCode;
  final String image;
  final String supplierName;
  final int supplyPrice;
  final bool isDeleted;
  final String admin;
  final String type;
  final String alarmType;
  final String subCategory;
  final String createdAt;
  final String updatedAt;
  final int V;

  const Item({
    this.Id = "",
    this.itemName = "",
    this.itemCode = "",
    this.image = "",
    this.supplierName = "",
    this.supplyPrice = 0,
    this.isDeleted = false,
    this.admin = "",
    this.type = "",
    this.alarmType = "",
    this.subCategory = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.V = 0,
  });

  @override
  List<Object?> get props => [
        Id,
        itemName,
        itemCode,
        image,
        supplierName,
        supplyPrice,
        isDeleted,
        admin,
        type,
        alarmType,
        subCategory,
        createdAt,
        updatedAt,
        V,
      ];
}
