import 'package:json_annotation/json_annotation.dart';

part 'maintainance_reports.g.dart';

@JsonSerializable()
class MaintainanceReports {
  @JsonKey(name: '_id')
  final String? Id;
  final String? provider;
  final String? consumer;
  final String? consumerRequest;
  final String? branch;
  final String? offer;
  final String? responsibleEmployee;
  final String? scheduleJob;
  final List<AlarmItem>? alarmItem;
  final List<FireSystemItem>? fireSystemItem;
  final String? safetyStatus;
  final String? details;
  final String? description;
  final String? maintenanceOfferStatus;
  final dynamic MaintenanceOffer;
  final int? visitDate;
  final int? createdAt;
  @JsonKey(name: '__v')
  final int? V;

  const MaintainanceReports({
    this.Id,
    this.provider,
    this.consumer,
    this.consumerRequest,
    this.branch,
    this.offer,
    this.responsibleEmployee,
    this.scheduleJob,
    this.alarmItem,
    this.fireSystemItem,
    this.safetyStatus,
    this.details,
    this.description,
    this.maintenanceOfferStatus,
    this.MaintenanceOffer,
    this.visitDate,
    this.createdAt,
    this.V,
  });

  factory MaintainanceReports.fromJson(Map<String, dynamic> json) =>
      _$MaintainanceReportsFromJson(json);

  Map<String, dynamic> toJson() => _$MaintainanceReportsToJson(this);
}

@JsonSerializable()
class AlarmItem {
  final String? item;
  final int? quantity;
  final int? malfunctionsNumber;
  @JsonKey(name: '_id')
  final String? Id;
  final bool? status;

  const AlarmItem({
    this.item,
    this.quantity,
    this.malfunctionsNumber,
    this.Id,
    this.status,
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
  @JsonKey(name: '_id')
  final String? Id;
  final bool? status;

  const FireSystemItem({
    this.item,
    this.quantity,
    this.malfunctionsNumber,
    this.Id,
    this.status,
  });

  factory FireSystemItem.fromJson(Map<String, dynamic> json) =>
      _$FireSystemItemFromJson(json);

  Map<String, dynamic> toJson() => _$FireSystemItemToJson(this);
}
