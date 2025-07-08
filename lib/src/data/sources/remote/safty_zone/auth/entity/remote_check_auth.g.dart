// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_check_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCheckAuth _$RemoteCheckAuthFromJson(Map<String, dynamic> json) =>
    RemoteCheckAuth(
      status: json['status'] as String? ?? "",
      onboarding: json['onboarding'] == null
          ? const RemoteOnboarding()
          : RemoteOnboarding.fromJson(
              json['onboarding'] as Map<String, dynamic>),
      companyData: json['companyData'] == null
          ? const RemoteCompanyData()
          : RemoteCompanyData.fromJson(
              json['companyData'] as Map<String, dynamic>),
      employeeDetails: json['employeeDetails'] == null
          ? const RemoteEmpCheckAuth()
          : RemoteEmpCheckAuth.fromJson(
              json['employeeDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteCheckAuthToJson(RemoteCheckAuth instance) =>
    <String, dynamic>{
      'status': instance.status,
      'onboarding': instance.onboarding,
      'companyData': instance.companyData,
      'employeeDetails': instance.employeeDetails,
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

RemoteCompanyData _$RemoteCompanyDataFromJson(Map<String, dynamic> json) =>
    RemoteCompanyData(
      companyName: json['companyName'] as String? ?? "",
      image: json['image'] as String? ?? "",
      email: json['email'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteCompanyDataToJson(RemoteCompanyData instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'image': instance.image,
      'email': instance.email,
    };
