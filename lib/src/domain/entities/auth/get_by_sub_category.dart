import 'package:equatable/equatable.dart';
import 'package:safety_zone/src/domain/entities/auth/control_panel.dart';

class GetBySubCategory extends Equatable {
  final String Id;
  final String provider;
  final Item item;
  final bool isDeleted;
  final List<int> price;
  final int createdAt;
  final int V;

  const GetBySubCategory({
    this.Id = "",
    this.provider = "",
    this.item = const Item(),
    this.isDeleted = false,
    this.price = const [],
    this.createdAt = 0,
    this.V = 0,
  });

  @override
  List<Object> get props => [
        Id,
        provider,
        item,
        isDeleted,
        price,
        createdAt,
        V,
      ];
}
