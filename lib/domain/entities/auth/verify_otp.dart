import 'package:equatable/equatable.dart';
import 'package:hatif_mobile/domain/entities/auth/check_auth.dart';

class VerifyOtp extends Equatable {
  final String token;
  final String status;
  final Onboarding onboarding;

  const VerifyOtp({
    this.token = "",
    this.status = "",
    this.onboarding = const Onboarding(),
  });

  @override
  List<Object?> get props => [token, status, onboarding];

  //toJson
  Map<String, dynamic> toJson() => {
        'token': token,
        'status': status,
        'onboarding': onboarding.toJson(),
      };

  //fromJson
  factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
        token: json['token'],
        status: json['status'],
        onboarding: Onboarding.fromJson(
          json['onboarding'],
        ),
      );
}
