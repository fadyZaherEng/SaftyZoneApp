import 'package:json_annotation/json_annotation.dart';

part 'schedule_jop_request.g.dart';

@JsonSerializable()
class ScheduleJopRequest {
  final String? phoneNumber;
  final String? code;

  const ScheduleJopRequest({
    this.phoneNumber,
    this.code,
  });

  factory ScheduleJopRequest.fromJson(Map<String, dynamic> json) =>
      _$ScheduleJopRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleJopRequestToJson(this);
}
