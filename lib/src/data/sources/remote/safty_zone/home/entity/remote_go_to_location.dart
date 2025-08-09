import 'package:json_annotation/json_annotation.dart';

part 'remote_go_to_location.g.dart';

@JsonSerializable()
class RemoteGoToLocation {
  @JsonKey(name: '_id')
  final String? Id;
  final String? provider;
  final String? consumer;
  final String? branch;
  final String? offer;
  final String? responseEmployee;
  final String? requestNumber;
  final String? type;
  final String? status;
  final int? visitDate;
  final int? createdAt;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteGoToLocation({
    this.Id,
    this.provider,
    this.consumer,
    this.branch,
    this.offer,
    this.responseEmployee,
    this.requestNumber,
    this.type,
    this.status,
    this.visitDate,
    this.createdAt,
    this.V,
  });

  factory RemoteGoToLocation.fromJson(Map<String, dynamic> json) =>
      _$RemoteGoToLocationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteGoToLocationToJson(this);
}
