import 'package:json_annotation/json_annotation.dart';

part 'remote_second_and_third_schedule.g.dart';

@JsonSerializable()
class RemoteSecondAndThirdSchedule {
  final String? message;
  final Data? data;

  const RemoteSecondAndThirdSchedule({
    this.message,
    this.data,
  });

  factory RemoteSecondAndThirdSchedule.fromJson(Map<String, dynamic> json) =>
      _$RemoteSecondAndThirdScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSecondAndThirdScheduleToJson(this);
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
  final ItemId? itemId;
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

@JsonSerializable()
class ItemId {
  @JsonKey(name: '_id')
  final String? Id;
  final String? itemName;
  final String? image;
  final String? type;
  final String? subCategory;

  const ItemId({
    this.Id,
    this.itemName,
    this.image,
    this.type,
    this.subCategory,
  });

  factory ItemId.fromJson(Map<String, dynamic> json) =>
      _$ItemIdFromJson(json);

  Map<String, dynamic> toJson() => _$ItemIdToJson(this);
}
