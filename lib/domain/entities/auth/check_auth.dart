import 'package:equatable/equatable.dart';

class CheckAuth extends Equatable {
  final String status;
  final Onboarding onboarding;
  final CompanyData companyData;
  final EmployeeDetails employeeDetails;

  const CheckAuth({
    this.status = "",
    this.onboarding = const Onboarding(),
    this.companyData = const CompanyData(),
    this.employeeDetails = const EmployeeDetails(),
  });

  @override
  List<Object?> get props => [
        status,
        onboarding,
        companyData,
      ];
}

class Onboarding extends Equatable {
  final bool employees;
  final bool installationFess;
  final bool termsAndConditions;

  const Onboarding({
    this.employees = false,
    this.installationFess = false,
    this.termsAndConditions = false,
  });

  @override
  List<Object?> get props => [
        employees,
        installationFess,
        termsAndConditions,
      ];

  toJson() => {
        'employees': employees,
        'installationFess': installationFess,
        'termsAndConditions': termsAndConditions,
      };

  factory Onboarding.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const Onboarding();
    return Onboarding(
      employees: json['employees'] ?? false,
      installationFess: json['installationFess'] ?? false,
      termsAndConditions: json['termsAndConditions'] ?? false,
    );
  }
}

class CompanyData extends Equatable {
  final String companyName;
  final String image;
  final String email;

  const CompanyData({
    this.companyName = "",
    this.image = "",
    this.email = "",
  });

  @override
  List<Object?> get props => [
        companyName,
        image,
        email,
      ];

  toJson() => {
        'companyName': companyName,
        'image': image,
        'email': email,
      };

//fromJson
  factory CompanyData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CompanyData();
    return CompanyData(
      companyName: json['companyName'] ?? "",
      image: json['image'] ?? "",
      email: json['email'] ?? "",
    );
  }
}

class EmployeeDetails extends Equatable {
  final String fullName;
  final String image;
  final String jobTitle;

  const EmployeeDetails({
    this.fullName = "",
    this.image = "",
    this.jobTitle = "",
  });

  @override
  List<Object?> get props => [
        fullName,
        image,
        jobTitle,
      ];

  toJson() => {
        'fullName': fullName,
        'image': image,
        'jobTitle': jobTitle,
      };

//fromJson
  factory EmployeeDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const EmployeeDetails();
    return EmployeeDetails(
      fullName: json['fullName'] ?? "",
      image: json['image'] ?? "",
      jobTitle: json['jobTitle'] ?? "",
    );
  }
}
