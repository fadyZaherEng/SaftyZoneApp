import 'package:json_annotation/json_annotation.dart';

part 'remote_certificate_insatllation.g.dart';

@JsonSerializable()
class RemoteCertificateInsatllation {
  final Result? result;
  final ScheduleJob? scheduleJob;

  const RemoteCertificateInsatllation({
    this.result,
    this.scheduleJob,
  });

  factory RemoteCertificateInsatllation.fromJson(Map<String, dynamic> json) =>
      _$RemoteCertificateInsatllationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCertificateInsatllationToJson(this);
}

@JsonSerializable()
class Result {
  final String? provider;
  final String? consumer;
  final String? branch;
  final String? scheduleJob;
  final String? file;
  final int? createdAt;
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: '__v')
  final int? V;

  const Result({
    this.provider,
    this.consumer,
    this.branch,
    this.scheduleJob,
    this.file,
    this.createdAt,
    this.Id,
    this.V,
  });

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class ScheduleJob {
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

  const ScheduleJob({
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

  factory ScheduleJob.fromJson(Map<String, dynamic> json) =>
      _$ScheduleJobFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleJobToJson(this);
}
