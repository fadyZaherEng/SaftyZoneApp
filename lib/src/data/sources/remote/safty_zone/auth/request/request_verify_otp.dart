import 'package:json_annotation/json_annotation.dart';

part 'request_verify_otp.g.dart';

@JsonSerializable()
class RequestVerifyOtp {
  final String? phoneNumber;
  final String? code;

  const RequestVerifyOtp({
    this.phoneNumber,
    this.code,
  });

  factory RequestVerifyOtp.fromJson(Map<String, dynamic> json) =>
      _$RequestVerifyOtpFromJson(json);

  Map<String, dynamic> toJson() => _$RequestVerifyOtpToJson(this);
}
