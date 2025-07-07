import 'package:hatif_mobile/domain/entities/auth/check_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_emp_check_auth.g.dart';

@JsonSerializable()
class RemoteEmpCheckAuth {
  final String? fullName;
  final String? image;
  final String? jobTitle;

  const RemoteEmpCheckAuth({
    this.fullName,
    this.image,
    this.jobTitle,
  });

  factory RemoteEmpCheckAuth.fromJson(Map<String, dynamic> json) =>
      _$RemoteEmpCheckAuthFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteEmpCheckAuthToJson(this);
}

extension RemoteEmpCheckAuthMapper on RemoteEmpCheckAuth {
  EmployeeDetails toEmployee() => EmployeeDetails(
        fullName: fullName ?? "",
        image: image ?? "",
        jobTitle: jobTitle ?? "",
      );
}
