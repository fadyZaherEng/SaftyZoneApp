import 'package:json_annotation/json_annotation.dart';

part 'request_send_otp.g.dart';

@JsonSerializable()
class RequestSendOtp {
  final String? phoneNumber;

  const RequestSendOtp({
    this.phoneNumber,
  });

  factory RequestSendOtp.fromJson(Map<String, dynamic> json) =>
      _$RequestSendOtpFromJson(json);

  Map<String, dynamic> toJson() => _$RequestSendOtpToJson(this);
}
