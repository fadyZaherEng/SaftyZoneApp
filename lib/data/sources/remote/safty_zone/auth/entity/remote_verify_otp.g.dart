// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_verify_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteVerifyOtp _$RemoteVerifyOtpFromJson(Map<String, dynamic> json) =>
    RemoteVerifyOtp(
      token: json['token'] as String? ?? "",
      status: json['status'] as String? ?? "",
      onboarding: json['onboarding'] == null
          ? const RemoteOnboarding()
          : RemoteOnboarding.fromJson(
              json['onboarding'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteVerifyOtpToJson(RemoteVerifyOtp instance) =>
    <String, dynamic>{
      'token': instance.token,
      'status': instance.status,
      'onboarding': instance.onboarding,
    };
