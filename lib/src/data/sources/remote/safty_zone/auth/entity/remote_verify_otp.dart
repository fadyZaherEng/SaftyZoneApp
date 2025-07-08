import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_check_auth.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/entities/auth/verify_otp.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_verify_otp.g.dart';

@JsonSerializable()
class RemoteVerifyOtp {
  final String? token;
  final String? status;
  final RemoteOnboarding? onboarding;

  const RemoteVerifyOtp({
    this.token = "",
    this.status = "",
    this.onboarding = const RemoteOnboarding(),
  });

  factory RemoteVerifyOtp.fromJson(Map<String, dynamic> json) =>
      _$RemoteVerifyOtpFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteVerifyOtpToJson(this);
}

extension RemoteVerifyOtpExtension on RemoteVerifyOtp {
  VerifyOtp mapToDomain() => VerifyOtp(
        token: token ?? "",
        status: status ?? "",
        onboarding: onboarding?.toDomain() ?? const Onboarding(),
      );
}
