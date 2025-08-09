// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_certificate_installation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestCertificateInstallation _$RequestCertificateInstallationFromJson(
        Map<String, dynamic> json) =>
    RequestCertificateInstallation(
      branch: json['branch'] as String?,
      consumer: json['consumer'] as String?,
      scheduleJob: json['scheduleJob'] as String?,
      file: json['file'] as String?,
    );

Map<String, dynamic> _$RequestCertificateInstallationToJson(
        RequestCertificateInstallation instance) =>
    <String, dynamic>{
      'branch': instance.branch,
      'consumer': instance.consumer,
      'scheduleJob': instance.scheduleJob,
      'file': instance.file,
    };
