import 'package:json_annotation/json_annotation.dart';

part 'remote_update_status_deliver.g.dart';

@JsonSerializable()
class RemoteUpdateStatusDeliver {
  final String? message;
  final Data? data;

  const RemoteUpdateStatusDeliver({
    this.message,
    this.data,
  });

  factory RemoteUpdateStatusDeliver.fromJson(Map<String, dynamic> json) =>
      _$RemoteUpdateStatusDeliverFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteUpdateStatusDeliverToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: '_id')
  final String? Id;
  final List<FireExtinguisher>? fireExtinguisher;
  final String? providerEmployee;
  final String? consumer;
  final String? branch;
  final String? provider;
  final String? consumerRequest;
  final String? scheduleJob;
  final String? status;
  final int? createdAt;
  @JsonKey(name: '__v')
  final int? V;
  final int? expireAt;

  const Data({
    this.Id,
    this.fireExtinguisher,
    this.providerEmployee,
    this.consumer,
    this.branch,
    this.provider,
    this.consumerRequest,
    this.scheduleJob,
    this.status,
    this.createdAt,
    this.V,
    this.expireAt,
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
