import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String token;
  final String status;
  final Onboarding onboarding;

  const Register({
    this.token = "",
    this.status = "",
    this.onboarding = const Onboarding(),
  });

  @override
  List<Object> get props => [token, status, onboarding];
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
  List<Object> get props => [employees, installationFess, termsAndConditions];
}
