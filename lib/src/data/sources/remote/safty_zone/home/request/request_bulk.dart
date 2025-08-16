import 'package:json_annotation/json_annotation.dart';

part 'request_bulk.g.dart';

@JsonSerializable()
class RequestBulk {
  final List<InstallationFees>? installationFees;

  const RequestBulk({
    this.installationFees,
  });

  factory RequestBulk.fromJson(Map<String, dynamic> json) =>
      _$RequestBulkFromJson(json);

  Map<String, dynamic> toJson() => _$RequestBulkToJson(this);

  @override
  String toString() {
    return 'RequestBulk{installationFees: $installationFees}';
  }
}

@JsonSerializable()
class InstallationFees {
  final String? item;
  final int? price;

  const InstallationFees({
    this.item,
    this.price,
  });

  factory InstallationFees.fromJson(Map<String, dynamic> json) =>
      _$InstallationFeesFromJson(json);

  Map<String, dynamic> toJson() => _$InstallationFeesToJson(this);

  @override
  String toString() {
    return 'InstallationFees{item: $item, price: $price}';
  }
}
