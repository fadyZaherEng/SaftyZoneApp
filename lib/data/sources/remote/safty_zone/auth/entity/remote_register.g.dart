// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteRegister _$RemoteRegisterFromJson(Map<String, dynamic> json) =>
    RemoteRegister(
      token: json['token'] as String? ?? "",
      status: json['status'] as String? ?? "",
      onboarding: json['onboarding'] == null
          ? const RemoteOnboarding()
          : RemoteOnboarding.fromJson(
              json['onboarding'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteRegisterToJson(RemoteRegister instance) =>
    <String, dynamic>{
      'token': instance.token,
      'status': instance.status,
      'onboarding': instance.onboarding,
    };

RemoteOnboarding _$RemoteOnboardingFromJson(Map<String, dynamic> json) =>
    RemoteOnboarding(
      employees: json['employees'] as bool? ?? false,
      installationFess: json['installationFess'] as bool? ?? false,
      termsAndConditions: json['termsAndConditions'] as bool? ?? false,
    );

Map<String, dynamic> _$RemoteOnboardingToJson(RemoteOnboarding instance) =>
    <String, dynamic>{
      'employees': instance.employees,
      'installationFess': instance.installationFess,
      'termsAndConditions': instance.termsAndConditions,
    };
