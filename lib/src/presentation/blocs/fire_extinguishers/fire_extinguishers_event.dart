part of 'fire_extinguishers_bloc.dart';

@immutable
sealed class FireExtinguishersEvent {}

final class GetFirstScreenScheduleEvent extends FireExtinguishersEvent {
  final String id;

  GetFirstScreenScheduleEvent({required this.id});
}

final class GetSecondAndThirdScreenScheduleEvent
    extends FireExtinguishersEvent {
  final String id;

  GetSecondAndThirdScreenScheduleEvent({required this.id});
}

final class UpdateStatusToDeliverEvent extends FireExtinguishersEvent {
  final String scheduleJopId;
  final String receiverId;

  UpdateStatusToDeliverEvent({
    required this.scheduleJopId,
    required this.receiverId,
  });
}

final class AddReceiveToDeliverEvent extends FireExtinguishersEvent {
  final AddRecieveRequest request;

  AddReceiveToDeliverEvent({required this.request});
}

final class MainOfferFireExtinguishersEvent extends FireExtinguishersEvent {
  final MainOfferFireExtinguisher mainOfferFireExtinguisher;

  MainOfferFireExtinguishersEvent({required this.mainOfferFireExtinguisher});
}

final class MaintainanceReportEvent extends FireExtinguishersEvent {
  final MaintainanceReportRequest maintainanceReportRequest;

  MaintainanceReportEvent({required this.maintainanceReportRequest});
}