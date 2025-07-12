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

final class SendPriceOfferLoadingState extends RequestsState {}

final class SendPriceOfferSuccessState extends RequestsState {
  final RemoteSendPrice sendPrice;

  SendPriceOfferSuccessState(this.sendPrice);
}

final class SendPriceOfferErrorState extends RequestsState {
  final String message;

  SendPriceOfferErrorState(this.message);
}
final class ScheduleJobLoadingState extends RequestsState {}

final class ScheduleJobSuccessState extends RequestsState {
  final List<ScheduleJop> scheduleJob;

  ScheduleJobSuccessState(this.scheduleJob);
}

final class ScheduleJobErrorState extends RequestsState {
  final String message;

  ScheduleJobErrorState(this.message);
}
final class ScheduleJobInProgressLoadingState extends RequestsState {}

final class ScheduleJobInProgressSuccessState extends RequestsState {
  final List<ScheduleJop> scheduleJob;

  ScheduleJobInProgressSuccessState(this.scheduleJob);
}

final class ScheduleJobInProgressErrorState extends RequestsState {
  final String message;

  ScheduleJobInProgressErrorState(this.message);
}