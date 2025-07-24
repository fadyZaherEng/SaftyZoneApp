import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_second_and_third_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_update_status_deliver.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/update_recieve_request.dart';
import 'package:safety_zone/src/domain/usecase/home/add_reciever_river_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/first_screen_shedule_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/main_offer_use_case.dart';
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

  FireExtinguishersBloc(
    this._updateReceiverDriverUseCase,
    this._addReceiveToDeliverUseCase,
    this._secondThirdScreenScheduleUseCase,
    this._firstScreenScheduleUseCase,
    this._mainOfferUseCase,
  ) : super(FireExtinguishersInitial()) {
    on<GetFirstScreenScheduleEvent>(_getFirstScreenSchedule);
    on<MainOfferFireExtinguishersEvent>(_getMainOfferFireExtinguishers);
    on<AddReceiveToDeliverEvent>(_addReceiveToDeliver);
    on<UpdateStatusToDeliverEvent>(_updateStatusToDeliver);
    on<GetSecondAndThirdScreenScheduleEvent>(_getSecondAndThirdSchedule);
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
}
