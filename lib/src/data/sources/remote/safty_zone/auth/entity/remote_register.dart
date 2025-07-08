import 'package:safety_zone/src/domain/entities/auth/register.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_register.g.dart';

@JsonSerializable()
class RemoteRegister {
  final String? token;
  final String? status;
  final RemoteOnboarding? onboarding;

  const RemoteRegister({
    this.token = "",
    this.status = "",
    this.onboarding = const RemoteOnboarding(),
  });

  factory RemoteRegister.fromJson(Map<String, dynamic> json) =>
      _$RemoteRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteRegisterToJson(this);
}

extension RemoteRegisterExt on RemoteRegister {
  Register toDomain() => Register(
        token: token ?? "",
        status: status ?? "",
        onboarding: onboarding?.toDomain() ?? const Onboarding(),
      );
}

@JsonSerializable()
class RemoteOnboarding {
  final bool? employees;
  final bool? installationFess;
  final bool? termsAndConditions;

  const RemoteOnboarding(
      {this.employees = false,
      this.installationFess = false,
      this.termsAndConditions = false});

  factory RemoteOnboarding.fromJson(Map<String, dynamic> json) =>
      _$RemoteOnboardingFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteOnboardingToJson(this);
}

extension RemoteOnboardingExt on RemoteOnboarding {
  Onboarding toDomain() => Onboarding(
        employees: employees ?? false,
        installationFess: installationFess ?? false,
        termsAndConditions: termsAndConditions ?? false,
      );
}
