import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/maintainance_reports.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_maintainance_item_prices_offer.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_maintainance_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_second_and_third_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_update_status_deliver.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/create_maintainance_offer_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/maintainance_report_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/update_recieve_request.dart';
import 'package:safety_zone/src/domain/usecase/home/add_reciever_river_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/create_mainatinace_offer_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/first_screen_shedule_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/main_offer_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/mainatinace_reports_offers_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/mainatinace_reports_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/maintainance_report_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/second_and_third_screen_shedule_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/update_reciever_river_use_case.dart';

part 'fire_extinguishers_event.dart';

part 'fire_extinguishers_state.dart';

class FireExtinguishersBloc
    extends Bloc<FireExtinguishersEvent, FireExtinguishersState> {
  final UpdateReceiverDriverUseCase _updateReceiverDriverUseCase;
  final AddReceiverDriverUseCase _addReceiveToDeliverUseCase;
  final SecondThirdScreenScheduleUseCase _secondThirdScreenScheduleUseCase;
  final FirstScreenScheduleUseCase _firstScreenScheduleUseCase;
  final MainOfferUseCase _mainOfferUseCase;
  final MaintainanceReportUseCase _maintainanceReportUseCase;
  final CreateMaintainanceOfferUseCase _createMaintainanceOfferUseCase;
  final MaintainanceRequestOfferUseCase _maintainanceRequestOfferUseCase;
  final MaintainanceReportsUseCase _maintainanceReportsUseCase;

  FireExtinguishersBloc(
    this._updateReceiverDriverUseCase,
    this._addReceiveToDeliverUseCase,
    this._secondThirdScreenScheduleUseCase,
    this._firstScreenScheduleUseCase,
    this._mainOfferUseCase,
    this._maintainanceReportUseCase,
    this._createMaintainanceOfferUseCase,
    this._maintainanceRequestOfferUseCase,
    this._maintainanceReportsUseCase,
  ) : super(FireExtinguishersInitial()) {
    on<GetFirstScreenScheduleEvent>(_getFirstScreenSchedule);
    on<MainOfferFireExtinguishersEvent>(_getMainOfferFireExtinguishers);
    on<AddReceiveToDeliverEvent>(_addReceiveToDeliver);
    on<UpdateStatusToDeliverEvent>(_updateStatusToDeliver);
    on<GetSecondAndThirdScreenScheduleEvent>(_getSecondAndThirdSchedule);
    on<MaintainanceReportEvent>(_onMaintainanceReportEvent);
    on<CreateMaintainanceOfferEvent>(_onCreateMaintainanceOfferEvent);
    on<MaintainanceRequestOfferEvent>(_onMaintainanceRequestOfferEvent);
    on<MaintainanceReportsEvent>(_onMaintainanceReportsEvent);
  }

  FutureOr<void> _onMaintainanceReportsEvent(MaintainanceReportsEvent event,
      Emitter<FireExtinguishersState> emit) async {
    emit(MaintainanceReportsLoadingState());
    final result = await _maintainanceReportsUseCase();
    if (result is DataSuccess<List<MaintainanceReports>>) {
      emit(MaintainanceReportsSuccessState(
          maintainanceReports: result.data ?? []));
    } else {
      emit(MaintainanceReportsErrorState(message: result.message ?? ''));
    }
  }

  FutureOr<void> _onMaintainanceRequestOfferEvent(
      MaintainanceRequestOfferEvent event,
      Emitter<FireExtinguishersState> emit) async {
    emit(MaintainanceRequestOfferLoadingState());
    final result =
        await _maintainanceRequestOfferUseCase(id: event.maintainanceReportId);
    if (result is DataSuccess) {
      emit(
        MaintainanceRequestOfferSuccessState(
            remoteMaintainanceItemPricesOffer:
                result.data ?? RemoteMaintainanceItemPricesOffer()),
      );
    } else {
      emit(MaintainanceRequestOfferErrorState(message: result.message ?? ''));
    }
  }

  FutureOr<void> _onCreateMaintainanceOfferEvent(
      CreateMaintainanceOfferEvent event,
      Emitter<FireExtinguishersState> emit) async {
    emit(CreateMaintainanceReportLoadingState());
    final result = await _createMaintainanceOfferUseCase(
        request: event.createMaintainanceOfferRequest);
    if (result is DataSuccess<RemoteMaintainanceItemPricesOffer>) {
      emit(CreateMaintainanceReportSuccessState(message: S.current.success));
    } else {
      emit(CreateMaintainanceReportErrorState(
          message: result.message ?? S.current.badResponse));
    }
  }

  FutureOr<void> _getFirstScreenSchedule(GetFirstScreenScheduleEvent event,
      Emitter<FireExtinguishersState> emit) async {
    emit(GetFirstScreenScheduleLoadingState());
    final result = await _firstScreenScheduleUseCase(id: event.id);
    if (result is DataSuccess<RemoteFirstScreenSchedule>) {
      emit(GetFirstScreenScheduleSuccessState(
          remoteFirstScreenSchedule:
              result.data ?? RemoteFirstScreenSchedule()));
    } else {
      emit(GetFirstScreenScheduleErrorState(message: result.message ?? ''));
    }
  }

  FutureOr<void> _getMainOfferFireExtinguishers(
      MainOfferFireExtinguishersEvent event,
      Emitter<FireExtinguishersState> emit) async {
    emit(MainOfferFireExtinguishersLoadingState());
    final result = await _mainOfferUseCase(
        mainOfferFireExtinguisher: event.mainOfferFireExtinguisher);
    if (result is DataSuccess) {
      emit(MainOfferFireExtinguishersSuccessState(
          remoteMainOfferFireExtinguisher:
              result.data ?? RemoteMainOfferFireExtinguisher()));
    } else {
      emit(MainOfferFireExtinguishersErrorState(message: result.message ?? ''));
    }
  }

  FutureOr<void> _addReceiveToDeliver(AddReceiveToDeliverEvent event,
      Emitter<FireExtinguishersState> emit) async {
    emit(AddReceiveToDeliverLoadingState());
    final result = await _addReceiveToDeliverUseCase(request: event.request);
    if (result is DataSuccess<RemoteAddRecieve>) {
      emit(AddReceiveToDeliverSuccessState(
          remoteAddRecieve: result.data ?? RemoteAddRecieve()));
    } else {
      emit(AddReceiveToDeliverErrorState(message: result.message ?? ''));
    }
  }

  FutureOr<void> _updateStatusToDeliver(UpdateStatusToDeliverEvent event,
      Emitter<FireExtinguishersState> emit) async {
    emit(UpdateStatusToReceiveLoadingState());
    final result = await _updateReceiverDriverUseCase(
      request: UpdateRecieveRequest(
        scheduleJobId: event.scheduleJopId,
      ),
      id: event.receiverId,
    );
    if (result is DataSuccess<RemoteUpdateStatusDeliver>) {
      emit(UpdateStatusToReceiveSuccessState(
          remoteUpdateStatusDeliver:
              result.data ?? RemoteUpdateStatusDeliver()));
    } else {
      emit(UpdateStatusToReceiveErrorState(message: result.message ?? ''));
    }
  }

  FutureOr<void> _getSecondAndThirdSchedule(
      GetSecondAndThirdScreenScheduleEvent event,
      Emitter<FireExtinguishersState> emit) async {
    emit(GetSecondAndThirdScreenScheduleLoadingState());
    final result = await _secondThirdScreenScheduleUseCase(id: event.id);
    if (result is DataSuccess<RemoteSecondAndThirdSchedule>) {
      emit(GetSecondAndThirdScreenScheduleSuccessState(
          remoteSecondAndThirdSchedule:
              result.data ?? RemoteSecondAndThirdSchedule()));
    } else {
      emit(GetSecondAndThirdScreenScheduleErrorState(
          message: result.message ?? ''));
    }
  }

  FutureOr<void> _onMaintainanceReportEvent(MaintainanceReportEvent event,
      Emitter<FireExtinguishersState> emit) async {
    emit(MaintainanceReportLoadingState());
    final result = await _maintainanceReportUseCase(
        maintenanceReport: event.maintainanceReportRequest);
    if (result is DataSuccess<RemoteMaintainanceReport>) {
      emit(MaintainanceReportSuccessState(
          remoteMaintainanceReport: result.data ?? RemoteMaintainanceReport()));
    } else {
      emit(MaintainanceReportErrorState(message: result.message ?? ''));
    }
  }
}
