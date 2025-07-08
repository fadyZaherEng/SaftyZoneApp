import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_term_conditions.dart';
import 'package:safety_zone/src/domain/entities/auth/term_conditions.dart';
import 'package:safety_zone/src/domain/usecase/auth/get_term_conditions_use_case.dart';
import 'package:meta/meta.dart';

part 'term_conditions_event.dart';

part 'term_conditions_state.dart';

class TermConditionsBloc
    extends Bloc<TermConditionsEvent, TermConditionsState> {
  final GetTermConditionsUseCase _getTermConditionsUseCase;

  TermConditionsBloc(
    this._getTermConditionsUseCase,
  ) : super(TermConditionsInitial()) {
    on<GetTermConditionsEvent>(_onGetTermConditionsEvent);
  }

  FutureOr<void> _onGetTermConditionsEvent(
      GetTermConditionsEvent event, Emitter<TermConditionsState> emit) async {
    emit(GetTermConditionsLoadingState());
    final result = await _getTermConditionsUseCase(
      request: event.requestTermConditions,
    );
    if (result is DataSuccess<TermConditions>) {
      emit(
        GetTermConditionsSuccessState(
          termConditions: result.data ?? TermConditions(),
        ),
      );
    } else {
      emit(GetTermConditionsErrorState(message: result.message ?? ''));
    }
  }
}
