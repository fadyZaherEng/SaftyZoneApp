import 'package:json_annotation/json_annotation.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';

part 'remote_requests.g.dart';

@JsonSerializable()
class RemoteRequests {
  @JsonKey(name: '_id')
  final String? Id;
  final RemoteBranch? branch;
  final String? requestNumber;
  final String? requestType;
  final List<RemoteProviders>? providers;

  const RemoteRequests({
    this.Id = "",
    this.branch = const RemoteBranch(),
    this.providers = const [],
    this.requestNumber = "",
    this.requestType = "",
  });

  factory RemoteRequests.fromJson(Map<String, dynamic> json) =>
      _$RemoteRequestsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteRequestsToJson(this);
}

extension RemoteRequestsExtension on RemoteRequests {
  Requests mapToDomain() => Requests(
        Id: Id ?? "",
        branch: branch?.mapToDomain() ?? const Branch(),
        providers: providers?.map((e) => e.mapToDomain()).toList() ?? [],
        requestNumber: requestNumber ?? "",
        requestType: requestType ?? "",
      );
}

extension RemoteListRequestsExtension on List<RemoteRequests> {
  List<Requests> mapToDomain() => map((e) => e.mapToDomain()).toList();
}

@JsonSerializable()
class RemoteBranch {
  final RemoteLocation? location;
  @JsonKey(name: '_id')
  final String? Id;
  final String? branchName;
  final RemoteEmployee? employee;
  final String? address;

  const RemoteBranch({
    this.location = const RemoteLocation(),
    this.Id = "",
    this.branchName = "",
    this.employee = const RemoteEmployee(),
    this.address = "",
  });

  factory RemoteBranch.fromJson(Map<String, dynamic> json) =>
      _$RemoteBranchFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteBranchToJson(this);
}

extension RemoteBranchExtension on RemoteBranch {
  Branch mapToDomain() => Branch(
        location: location?.mapToDomain() ?? const Location(),
        Id: Id ?? "",
        branchName: branchName ?? "",
        employee: employee?.mapToDomain() ?? const Employee(),
        address: address ?? "",
      );
}

@JsonSerializable()
class RemoteLocation {
  final String? type;
  final List<double>? coordinates;

  const RemoteLocation({
    this.type = "",
    this.coordinates = const [],
  });

  factory RemoteLocation.fromJson(Map<String, dynamic> json) =>
      _$RemoteLocationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteLocationToJson(this);
}

extension RemoteLocationExtension on RemoteLocation {
  Location mapToDomain() => Location(
        type: type ?? "",
        coordinates: coordinates ?? [],
      );
}

@JsonSerializable()
class RemoteEmployee {
  @JsonKey(name: '_id')
  final String? Id;
  final String? fullName;
  final String? phoneNumber;
  final String? profileImage;
  final String? employeeType;

  const RemoteEmployee({
    this.Id = "",
    this.fullName = "",
    this.phoneNumber = "",
    this.profileImage = "",
    this.employeeType = "",
  });

  factory RemoteEmployee.fromJson(Map<String, dynamic> json) =>
      _$RemoteEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteEmployeeToJson(this);
}

extension RemoteEmployeeExtension on RemoteEmployee {
  Employee mapToDomain() => Employee(
        Id: Id ?? "",
        fullName: fullName ?? "",
        phoneNumber: phoneNumber ?? "",
        profileImage: profileImage ?? "",
        employeeType: employeeType ?? "",
      );
}

@JsonSerializable()
class RemoteProviders {
  final String? provider;
  final String? status;
  @JsonKey(name: '_id')
  final String? Id;

  const RemoteProviders({
    this.provider = "",
    this.status = "",
    this.Id = "",
  });

  factory RemoteProviders.fromJson(Map<String, dynamic> json) =>
      _$RemoteProvidersFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProvidersToJson(this);
}

extension RemoteProvidersExtension on RemoteProviders {
  Providers mapToDomain() => Providers(
        Id: Id ?? "",
        provider: provider ?? "",
        status: status ?? "",
      );
}
