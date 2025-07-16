// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_certificate_insatllation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCertificateInsatllation _$RemoteCertificateInsatllationFromJson(
        Map<String, dynamic> json) =>
    RemoteCertificateInsatllation(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      scheduleJob: json['scheduleJob'] == null
          ? null
          : ScheduleJob.fromJson(json['scheduleJob'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteCertificateInsatllationToJson(
        RemoteCertificateInsatllation instance) =>
    <String, dynamic>{
      'result': instance.result,
      'scheduleJob': instance.scheduleJob,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      provider: json['provider'] as String?,
      consumer: json['consumer'] as String?,
      branch: json['branch'] as String?,
      scheduleJob: json['scheduleJob'] as String?,
      file: json['file'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      Id: json['_id'] as String?,
      V: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'provider': instance.provider,
      'consumer': instance.consumer,
      'branch': instance.branch,
      'scheduleJob': instance.scheduleJob,
      'file': instance.file,
      'createdAt': instance.createdAt,
      '_id': instance.Id,
      '__v': instance.V,
    };

ScheduleJob _$ScheduleJobFromJson(Map<String, dynamic> json) => ScheduleJob(
      Id: json['_id'] as String?,
      provider: json['provider'] as String?,
      consumer: json['consumer'] as String?,
      branch: json['branch'] as String?,
      offer: json['offer'] as String?,
      responseEmployee: json['responseEmployee'] as String?,
      requestNumber: json['requestNumber'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      visitDate: (json['visitDate'] as num?)?.toInt(),
      createdAt: (json['createdAt'] as num?)?.toInt(),
      V: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ScheduleJobToJson(ScheduleJob instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'provider': instance.provider,
      'consumer': instance.consumer,
      'branch': instance.branch,
      'offer': instance.offer,
      'responseEmployee': instance.responseEmployee,
      'requestNumber': instance.requestNumber,
      'type': instance.type,
      'status': instance.status,
      'visitDate': instance.visitDate,
      'createdAt': instance.createdAt,
      '__v': instance.V,
    };
