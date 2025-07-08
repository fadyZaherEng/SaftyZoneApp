import 'package:json_annotation/json_annotation.dart';

part 'remote_installation_fees.g.dart';

@JsonSerializable()
class RemoteInstallationFees {
  final String? provider;
  final String? item;
  final bool? isDeleted;
  final List<int>? price;
  final int? createdAt;
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteInstallationFees({
    this.provider = "",
    this.item = "",
    this.isDeleted = false,
    this.price = const [],
    this.createdAt = 0,
    this.Id = "",
    this.V = 0,
  });

  factory RemoteInstallationFees.fromJson(Map<String, dynamic> json) =>
      _$RemoteInstallationFeesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteInstallationFeesToJson(this);
}
