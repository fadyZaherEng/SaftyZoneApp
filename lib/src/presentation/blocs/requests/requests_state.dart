part of 'requests_bloc.dart';

@immutable
sealed class RequestsState {}

final class RequestsInitial extends RequestsState {}

final class GetConsumerRequestsLoadingState extends RequestsState {}

final class GetConsumerRequestsSuccessState extends RequestsState {
  final List<Requests> requestsRecent;
  final List<Requests> requestsOld;

  GetConsumerRequestsSuccessState(this.requestsRecent, this.requestsOld);
}

final class GetConsumerRequestsErrorState extends RequestsState {
  final String message;

  GetConsumerRequestsErrorState(this.message);
}

final class GetConsumerRequestDetailsLoadingState extends RequestsState {}

final class GetConsumerRequestDetailsSuccessState extends RequestsState {
  final RequestDetails requestDetails;

  GetConsumerRequestDetailsSuccessState(this.requestDetails);
}

final class GetConsumerRequestDetailsErrorState extends RequestsState {
  final String message;

  GetConsumerRequestDetailsErrorState(this.message);
}

final class GetEmployeesLoadingState extends RequestsState {}

final class GetEmployeesSuccessState extends RequestsState {
  final List<employee.Employee> employees;

  GetEmployeesSuccessState(this.employees);
}

final class GetEmployeesErrorState extends RequestsState {
  final String message;

  GetEmployeesErrorState(this.message);
}