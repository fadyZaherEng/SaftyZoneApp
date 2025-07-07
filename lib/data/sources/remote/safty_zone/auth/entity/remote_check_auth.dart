import 'package:hatif_mobile/data/sources/remote/safty_zone/auth/entity/remote_emp_check_auth.dart';
import 'package:hatif_mobile/domain/entities/auth/check_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_check_auth.g.dart';

@JsonSerializable()
class RemoteCheckAuth {
  final String? status;
  final RemoteOnboarding? onboarding;
  final RemoteCompanyData? companyData;
  final RemoteEmpCheckAuth? employeeDetails;

  const RemoteCheckAuth({
    this.status = "",
    this.onboarding = const RemoteOnboarding(),
    this.companyData = const RemoteCompanyData(),
    this.employeeDetails = const RemoteEmpCheckAuth(),
  });

  factory RemoteCheckAuth.fromJson(Map<String, dynamic> json) =>
      _$RemoteCheckAuthFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCheckAuthToJson(this);
}

extension RemoteCheckAuthExtension on RemoteCheckAuth {
  CheckAuth toDomain() => CheckAuth(
        status: status ?? "",
        onboarding: onboarding?.toDomain() ?? const Onboarding(),
        companyData: companyData?.toDomain() ?? const CompanyData(),
        employeeDetails:
            employeeDetails?.toEmployee() ?? const EmployeeDetails(),
      );
}

@JsonSerializable()
class RemoteOnboarding {
  final bool? employees;
  final bool? installationFess;
  final bool? termsAndConditions;

  const RemoteOnboarding({
    this.employees = false,
    this.installationFess = false,
    this.termsAndConditions = false,
  });

  factory RemoteOnboarding.fromJson(Map<String, dynamic> json) =>
      _$RemoteOnboardingFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteOnboardingToJson(this);
}

extension RemoteOnboardingExtension on RemoteOnboarding {
  Onboarding toDomain() => Onboarding(
        employees: employees ?? false,
        installationFess: installationFess ?? false,
        termsAndConditions: termsAndConditions ?? false,
      );
}

@JsonSerializable()
class RemoteCompanyData {
  final String? companyName;
  final String? image;
  final String? email;

  const RemoteCompanyData({
    this.companyName = "",
    this.image = "",
    this.email = "",
  });

  factory RemoteCompanyData.fromJson(Map<String, dynamic> json) =>
      _$RemoteCompanyDataFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCompanyDataToJson(this);
}

extension RemoteCompanyDataExtension on RemoteCompanyData {
  CompanyData toDomain() => CompanyData(
        companyName: companyName ?? "",
        image: image ?? "",
        email: email ?? "",
      );
}
