import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_control_panel.dart';
import 'package:safety_zone/src/domain/entities/auth/control_panel.dart';
import 'package:safety_zone/src/domain/entities/auth/get_by_sub_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_get_by_sub_category.g.dart';

@JsonSerializable()
class RemoteGetBySubCategory {
  @JsonKey(name: '_id')
  final String? Id;
  final String? provider;
  final RemoteItem? item;
  final bool? isDeleted;
  final List<int>? price;
  final int? createdAt;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteGetBySubCategory({
    this.Id = "",
    this.provider = "",
    this.item = const RemoteItem(),
    this.isDeleted = false,
    this.price = const [],
    this.createdAt = 0,
    this.V = 0,
  });

  factory RemoteGetBySubCategory.fromJson(Map<String, dynamic> json) =>
      _$RemoteGetBySubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteGetBySubCategoryToJson(this);
}

extension RemoteGetBySubCategoryExtension on RemoteGetBySubCategory {
  GetBySubCategory toDomain() => GetBySubCategory(
        Id: Id ?? "",
        provider: provider ?? "",
        item: item?.mapToDomain() ?? const Item(),
        isDeleted: isDeleted ?? false,
        price: price ?? const [],
        createdAt: createdAt ?? 0,
        V: V ?? 0,
      );
}
