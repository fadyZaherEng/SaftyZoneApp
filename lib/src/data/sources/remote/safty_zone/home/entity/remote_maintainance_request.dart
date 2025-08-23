import 'package:json_annotation/json_annotation.dart';

part 'remote_maintainance_request.g.dart';

@JsonSerializable()
class RemoteMaintainanceReport {
  final String? scheduleJob;
  final String? consumerRequest;
  final String? consumer;
  final String? branch;
  final String? offer;
  final List<AlarmItem>? alarmItem;
  final List<FireSystemItem>? fireSystemItem;
  final String? maintenanceOfferStatus;
  final String? safetyStatus;
  final String? details;
  final String? description;
  final String? provider;
  final String? responsibleEmployee;
  final String? MaintenanceOffer;
  @JsonKey(name: 'visitDate')
  final int? visitDate;
  @JsonKey(name: 'createdAt')
  final int? createdAt;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: '__v')
  final int? v;

  const RemoteMaintainanceReport({
    this.scheduleJob,
    this.consumerRequest,
    this.consumer,
    this.branch,
    this.offer,
    this.alarmItem,
    this.fireSystemItem,
    this.maintenanceOfferStatus,
    this.safetyStatus,
    this.details,
    this.description,
    this.provider,
    this.responsibleEmployee,
    this.visitDate,
    this.createdAt,
    this.id,
    this.v,
    this.MaintenanceOffer,
  });

  factory RemoteMaintainanceReport.fromJson(Map<String, dynamic> json) =>
      _$RemoteMaintainanceReportFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMaintainanceReportToJson(this);
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
