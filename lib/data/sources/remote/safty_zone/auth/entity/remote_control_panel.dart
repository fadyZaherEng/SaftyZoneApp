import 'package:hatif_mobile/domain/entities/auth/control_panel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_control_panel.g.dart';

@JsonSerializable()
class RemoteControlPanel {
  @JsonKey(name: '_id')
  final String? Id;
  final String? provider;
  final RemoteItem? item;
  final bool? isDeleted;
  final List<int>? price;
  final int? createdAt;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteControlPanel({
    this.Id = "",
    this.provider = "",
    this.item = const RemoteItem(),
    this.isDeleted = false,
    this.price = const [],
    this.createdAt = 0,
    this.V = 0,
  });

  factory RemoteControlPanel.fromJson(Map<String, dynamic> json) =>
      _$RemoteControlPanelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteControlPanelToJson(this);
}

extension RemoteControlPanelExtension on RemoteControlPanel {
  ControlPanel mapToDomain() => ControlPanel(
        Id: Id ?? "",
        provider: provider ?? "",
        item: item?.mapToDomain() ?? const Item(),
        isDeleted: isDeleted ?? false,
        price: price ?? [],
        createdAt: createdAt ?? 0,
        V: V ?? 0,
      );
}

@JsonSerializable()
class RemoteItem {
  @JsonKey(name: '_id')
  final String? Id;
  final String? itemName;
  final String? itemCode;
  final String? image;
  final String? supplierName;
  final int? supplyPrice;
  final bool? isDeleted;
  final String? admin;
  final String? type;
  final String? alarmType;
  final String? subCategory;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteItem({
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

  factory RemoteItem.fromJson(Map<String, dynamic> json) =>
      _$RemoteItemFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteItemToJson(this);
}

extension RemoteItemExtension on RemoteItem {
  Item mapToDomain() => Item(
        Id: Id ?? "",
        itemName: itemName ?? "",
        itemCode: itemCode ?? "",
        image: image ?? "",
        supplierName: supplierName ?? "",
        supplyPrice: supplyPrice ?? 0,
        isDeleted: isDeleted ?? false,
        admin: admin ?? "",
        type: type ?? "",
        alarmType: alarmType ?? "",
        subCategory: subCategory ?? "",
        createdAt: createdAt ?? "",
        updatedAt: updatedAt ?? "",
        V: V ?? 0,
      );
}
