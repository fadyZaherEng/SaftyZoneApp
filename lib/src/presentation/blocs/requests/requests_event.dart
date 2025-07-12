part of 'requests_bloc.dart';

@immutable
sealed class RequestsEvent {}

final class GetConsumerRequestsEvent extends RequestsEvent {}

final class GetConsumerRequestsDetailsEvent extends RequestsEvent {
  final String requestId;

  GetConsumerRequestsDetailsEvent({required this.requestId});
}

final class GetEmployeesEvent extends RequestsEvent {}
final class SendPriceOfferEvent extends RequestsEvent {
  final SendPriceRequest request;

  SendPriceOfferEvent({required this.request});
}
final class GetScheduleJobEvent extends RequestsEvent {
   final String status;

  GetScheduleJobEvent({required this.status});
}
final class GetScheduleJobInProgressEvent extends RequestsEvent {
  final String status;

  GetScheduleJobInProgressEvent({required this.status});
}