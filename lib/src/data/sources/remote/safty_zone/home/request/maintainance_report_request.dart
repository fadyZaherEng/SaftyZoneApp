import 'package:json_annotation/json_annotation.dart';

part 'maintainance_report_request.g.dart';

@JsonSerializable()
class MaintainanceReportRequest {
  final String? scheduleJob;
  final String? consumerRequest;
  final String? consumer;
  final String? branch;
  final String? offer;
  final List<AlarmItem>? alarmItem;
  final List<FireSystemItem>? fireSystemItem;
  final String? safetyStatus;
  final String? details;
  final String? description;

  const MaintainanceReportRequest({
    this.scheduleJob,
    this.consumerRequest,
    this.consumer,
    this.branch,
    this.offer,
    this.alarmItem,
    this.fireSystemItem,
    this.safetyStatus,
    this.details,
    this.description,
  });

  factory MaintainanceReportRequest.fromJson(Map<String, dynamic> json) =>
      _$MaintainanceReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MaintainanceReportRequestToJson(this);
}

@JsonSerializable()
class AlarmItem {
  final String? item;
  final int? quantity;
  final int? malfunctionsNumber;

  const AlarmItem({
    this.item,
    this.quantity,
    this.malfunctionsNumber,
  });

  factory AlarmItem.fromJson(Map<String, dynamic> json) =>
      _$AlarmItemFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmItemToJson(this);
}

@JsonSerializable()
class FireSystemItem {
  final String? item;
  final int? quantity;
  final int? malfunctionsNumber;

  const FireSystemItem({
    this.item,
    this.quantity,
    this.malfunctionsNumber,
  });

  factory FireSystemItem.fromJson(Map<String, dynamic> json) =>
      _$FireSystemItemFromJson(json);

  Map<String, dynamic> toJson() => _$FireSystemItemToJson(this);
}
