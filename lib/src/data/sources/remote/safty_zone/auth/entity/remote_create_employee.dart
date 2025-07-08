import 'package:safety_zone/src/domain/entities/auth/create_employee.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_create_employee.g.dart';

@JsonSerializable()
class RemoteCreateEmployee {
  final String? fullName;
  final String? phoneNumber;
  final String? profileImage;
  final bool? isDeleted;
  final String? jobTitle;
  final int? createdAt;
  @JsonKey(name: '_id')
  final String? Id;
  final String? employeeType;
  final String? permission;
  final String? company;
  @JsonKey(name: '__v')
  final int? V;

  const RemoteCreateEmployee({
    this.fullName = '',
    this.phoneNumber = '',
    this.profileImage = '',
    this.isDeleted = false,
    this.jobTitle = '',
    this.createdAt = 0,
    this.Id = '',
    this.employeeType = '',
    this.permission = '',
    this.company = '',
    this.V = 0,
  });

  factory RemoteCreateEmployee.fromJson(Map<String, dynamic> json) =>
      _$RemoteCreateEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCreateEmployeeToJson(this);
}

extension RemoteCreateEmployeeExt on RemoteCreateEmployee {
  Employee toDomain() => Employee(
        fullName: fullName ?? '',
        phoneNumber: phoneNumber ?? '',
        profileImage: profileImage ?? '',
        isDeleted: isDeleted ?? false,
        jobTitle: jobTitle ?? '',
        createdAt: createdAt ?? 0,
        Id: Id ?? '',
        employeeType: employeeType ?? '',
        permission: permission ?? '',
        company: company ?? '',
        V: V ?? 0,
      );
}
