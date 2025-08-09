import 'package:json_annotation/json_annotation.dart';

part 'remote_add_recieve.g.dart';

@JsonSerializable()
class RemoteAddRecieve {
  final String? message;
  final Data? data;

  const RemoteAddRecieve({
    this.message,
    this.data,
  });

  factory RemoteAddRecieve.fromJson(Map<String, dynamic> json) =>
      _$RemoteAddRecieveFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteAddRecieveToJson(this);
}

@JsonSerializable()
class Data {
  final List<FireExtinguisher>? fireExtinguisher;
  final String? providerEmployee;
  final String? consumer;
  final String? branch;
  final String? provider;
  final String? consumerRequest;
  final String? status;
  final int? createdAt;
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: '__v')
  final int? V;

  const Data({
    this.fireExtinguisher,
    this.providerEmployee,
    this.consumer,
    this.branch,
    this.provider,
    this.consumerRequest,
    this.status,
    this.createdAt,
    this.Id,
    this.V,
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class FireExtinguisher {
  @JsonKey(name: 'item_id')
  final String? itemId;
  final int? existQuantity;
  final int? receivedQuantity;

  const FireExtinguisher({
    this.itemId,
    this.existQuantity,
    this.receivedQuantity,
  });

  factory FireExtinguisher.fromJson(Map<String, dynamic> json) =>
      _$FireExtinguisherFromJson(json);

  Map<String, dynamic> toJson() => _$FireExtinguisherToJson(this);
}
