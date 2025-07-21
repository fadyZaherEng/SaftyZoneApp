import 'package:json_annotation/json_annotation.dart';

part 'add_recieve_request.g.dart';

@JsonSerializable()
class AddRecieveRequest {
  final List<FireExtinguisher>? fireExtinguisher;
  final String? consumer;
  final String? branch;
  final String? consumerRequest;

  const AddRecieveRequest({
    this.fireExtinguisher,
    this.consumer,
    this.branch,
    this.consumerRequest,
  });

  factory AddRecieveRequest.fromJson(Map<String, dynamic> json) =>
      _$AddRecieveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddRecieveRequestToJson(this);
}

@JsonSerializable()
class FireExtinguisher {
  @JsonKey(name: 'item_id')
  final String? itemId;
  final int? receivedQuantity;

  const FireExtinguisher({
    this.itemId,
    this.receivedQuantity,
  });

  factory FireExtinguisher.fromJson(Map<String, dynamic> json) =>
      _$FireExtinguisherFromJson(json);

  Map<String, dynamic> toJson() => _$FireExtinguisherToJson(this);
}
