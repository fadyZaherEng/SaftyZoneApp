part of 'fire_extinguishers_bloc.dart';

@immutable
sealed class FireExtinguishersState {}

final class FireExtinguishersInitial extends FireExtinguishersState {}

final class GetFirstScreenScheduleLoadingState extends FireExtinguishersState {}

final class GetFirstScreenScheduleSuccessState extends FireExtinguishersState {
  final RemoteFirstScreenSchedule remoteFirstScreenSchedule;

  GetFirstScreenScheduleSuccessState({required this.remoteFirstScreenSchedule});
}

final class GetFirstScreenScheduleErrorState extends FireExtinguishersState {
  final String message;

  GetFirstScreenScheduleErrorState({required this.message});
}

final class GetSecondAndThirdScreenScheduleLoadingState
    extends FireExtinguishersState {}

final class GetSecondAndThirdScreenScheduleSuccessState
    extends FireExtinguishersState {
  final RemoteSecondAndThirdSchedule remoteSecondAndThirdSchedule;

  GetSecondAndThirdScreenScheduleSuccessState(
      {required this.remoteSecondAndThirdSchedule});
}

final class GetSecondAndThirdScreenScheduleErrorState
    extends FireExtinguishersState {
  final String message;

  GetSecondAndThirdScreenScheduleErrorState({required this.message});
}

final class UpdateStatusToReceiveLoadingState extends FireExtinguishersState {}

final class UpdateStatusToReceiveSuccessState extends FireExtinguishersState {
  final RemoteUpdateStatusDeliver remoteUpdateStatusDeliver;

  UpdateStatusToReceiveSuccessState({required this.remoteUpdateStatusDeliver});
}

final class UpdateStatusToReceiveErrorState extends FireExtinguishersState {
  final String message;

  UpdateStatusToReceiveErrorState({required this.message});
}

final class AddReceiveToDeliverLoadingState extends FireExtinguishersState {}

final class AddReceiveToDeliverSuccessState extends FireExtinguishersState {
  final RemoteAddRecieve remoteAddRecieve;

  AddReceiveToDeliverSuccessState({required this.remoteAddRecieve});
}

final class AddReceiveToDeliverErrorState extends FireExtinguishersState {
  final String message;

  AddReceiveToDeliverErrorState({required this.message});
}

final class MainOfferFireExtinguishersLoadingState
    extends FireExtinguishersState {}

final class MainOfferFireExtinguishersSuccessState
    extends FireExtinguishersState {
  final RemoteMainOfferFireExtinguisher remoteMainOfferFireExtinguisher;

  MainOfferFireExtinguishersSuccessState(
      {required this.remoteMainOfferFireExtinguisher});
}

final class MainOfferFireExtinguishersErrorState
    extends FireExtinguishersState {
  final String message;

  MainOfferFireExtinguishersErrorState({required this.message});
}

final class MaintainanceReportLoadingState extends FireExtinguishersState {}

final class MaintainanceReportSuccessState extends FireExtinguishersState {
  final RemoteMaintainanceReport remoteMaintainanceReport;

  MaintainanceReportSuccessState({required this.remoteMaintainanceReport});
}

final class MaintainanceReportErrorState extends FireExtinguishersState {
  final String message;

  MaintainanceReportErrorState({required this.message});
}

final class CreateMaintainanceReportLoadingState
    extends FireExtinguishersState {}

final class CreateMaintainanceReportSuccessState
    extends FireExtinguishersState {
  final String message;

  CreateMaintainanceReportSuccessState({required this.message});
}

final class CreateMaintainanceReportErrorState extends FireExtinguishersState {
  final String message;

  CreateMaintainanceReportErrorState({required this.message});
}

final class MaintainanceRequestOfferLoadingState
    extends FireExtinguishersState {}

final class MaintainanceRequestOfferSuccessState
    extends FireExtinguishersState {
  final RemoteMaintainanceItemPricesOffer remoteMaintainanceItemPricesOffer;

  MaintainanceRequestOfferSuccessState({
    required this.remoteMaintainanceItemPricesOffer,
  });
}

final class MaintainanceRequestOfferErrorState extends FireExtinguishersState {
  final String message;

  MaintainanceRequestOfferErrorState({required this.message});
}

final class MaintainanceReportsLoadingState extends FireExtinguishersState {}

final class MaintainanceReportsSuccessState extends FireExtinguishersState {
  final List<MaintainanceReports> maintainanceReports;

  MaintainanceReportsSuccessState({required this.maintainanceReports});
}

final class MaintainanceReportsErrorState extends FireExtinguishersState {
  final String message;

  MaintainanceReportsErrorState({required this.message});
}
