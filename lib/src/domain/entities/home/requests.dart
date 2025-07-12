import 'package:equatable/equatable.dart';

class Requests extends Equatable {
  final String Id;
  final Branch branch;
  final String requestNumber;
  final String requestType;
  final List<Providers> providers;

  const Requests({
    this.Id = "",
    this.branch = const Branch(),
    this.providers = const [],
    this.requestNumber = "",
    this.requestType = "",
  });

  @override
  List<Object?> get props => [
        Id,
        branch,
        providers,
        requestNumber,
        requestType,
      ];
}

class Branch extends Equatable {
  final Location location;
  final String Id;
  final String branchName;
  final Employee employee;
  final String address;

  const Branch({
    this.location = const Location(),
    this.Id = "",
    this.branchName = "",
    this.employee = const Employee(),
    this.address = "",
  });

  @override
  List<Object?> get props => [
        location,
        Id,
        branchName,
        employee,
        address,
      ];
}

class Location extends Equatable {
  final String type;
  final List<double> coordinates;

  const Location({
    this.type = "",
    this.coordinates = const [],
  });

  @override
  List<Object?> get props => [
        type,
        coordinates,
      ];
}

class Employee extends Equatable {
  final String Id;
  final String fullName;
  final String phoneNumber;
  final String profileImage;
  final String employeeType;

  const Employee({
    this.Id = "",
    this.fullName = "",
    this.phoneNumber = "",
    this.profileImage = "",
    this.employeeType = "",
  });

  @override
  List<Object?> get props => [
        Id,
        fullName,
        phoneNumber,
        profileImage,
        employeeType,
      ];
}

class Providers extends Equatable {
  final String provider;
  final String status;
  final String Id;

  const Providers({
    this.provider = "",
    this.status = "",
    this.Id = "",
  });

  @override
  List<Object?> get props => [
        provider,
        status,
        Id,
      ];
}
