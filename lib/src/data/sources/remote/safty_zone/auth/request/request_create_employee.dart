import 'package:json_annotation/json_annotation.dart';

part 'request_create_employee.g.dart';

@JsonSerializable()
class RequestCreateEmployee {
  final String? fullName;
  final String? phoneNumber;
  final String? permission;
  final String? profileImage;
  final String? jobTitle;

  const RequestCreateEmployee({
    this.fullName,
    this.phoneNumber,
    this.permission,
    this.profileImage,
    this.jobTitle,
  });

  factory RequestCreateEmployee.fromJson(Map<String, dynamic> json) =>
      _$RequestCreateEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCreateEmployeeToJson(this);
}
