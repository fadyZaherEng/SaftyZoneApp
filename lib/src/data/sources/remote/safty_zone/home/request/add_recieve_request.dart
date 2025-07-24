import 'package:json_annotation/json_annotation.dart';

part 'add_recieve_request.g.dart';

@JsonSerializable()
class AddRecieveRequest {
  final List<RequestFireExtinguisher>? fireExtinguisher;
  final String? consumer;
  final String? branch;
  final String? consumerRequest;
  final String? scheduleJob;

  const AddRecieveRequest({
    this.fireExtinguisher,
    this.consumer,
    this.branch,
    this.consumerRequest,
    this.scheduleJob,
  });

  factory AddRecieveRequest.fromJson(Map<String, dynamic> json) =>
      _$AddRecieveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddRecieveRequestToJson(this);

  toString() {
    return 'AddRecieveRequest{fireExtinguisher: $fireExtinguisher, consumer: $consumer, branch: $branch, consumerRequest: $consumerRequest, scheduleJob: $scheduleJob}';
  }
}

@JsonSerializable()
class RequestFireExtinguisher {
  @JsonKey(name: 'item_id')
  final String? itemId;
  final int? receivedQuantity;

  const RequestFireExtinguisher({
    required this.itemId,
    required this.receivedQuantity,
  });

  factory RequestFireExtinguisher.fromJson(Map<String, dynamic> json) =>
      _$RequestFireExtinguisherFromJson(json);

  Map<String, dynamic> toJson() => _$RequestFireExtinguisherToJson(this);

  toString() {
    return 'RequestFireExtinguisher{itemId: $itemId, receivedQuantity: $receivedQuantity}';
  }
}
