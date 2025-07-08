// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_verify_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestVerifyOtp _$RequestVerifyOtpFromJson(Map<String, dynamic> json) =>
    RequestVerifyOtp(
      phoneNumber: json['phoneNumber'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$RequestVerifyOtpToJson(RequestVerifyOtp instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'code': instance.code,
    };
