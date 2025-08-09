import 'package:json_annotation/json_annotation.dart';

part 'request_certificate_installation.g.dart';

@JsonSerializable()
class RequestCertificateInstallation {
  final String? branch;
  final String? consumer;
  final String? scheduleJob;
  final String? file;

  const RequestCertificateInstallation({
    this.branch,
    this.consumer,
    this.scheduleJob,
    this.file,
  });

  factory RequestCertificateInstallation.fromJson(Map<String, dynamic> json) =>
      _$RequestCertificateInstallationFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCertificateInstallationToJson(this);
  //copy with
  RequestCertificateInstallation copyWith({
    String? branch,
    String? consumer,
    String? scheduleJob,
    String? file,
  }) =>
      RequestCertificateInstallation(
        branch: branch ?? this.branch,
        consumer: consumer ?? this.consumer,
        scheduleJob: scheduleJob ?? this.scheduleJob,
        file: file ?? this.file,
      );
}
