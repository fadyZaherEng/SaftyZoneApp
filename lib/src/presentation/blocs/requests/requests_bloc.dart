import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_send_price.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/get_consumer_requests_details_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/get_consumer_requests_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:safety_zone/src/domain/entities/auth/create_employee.dart'
    as employee;
import 'package:safety_zone/src/domain/usecase/home/send_offer_price_use_case.dart';

part 'requests_event.dart';

part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  final GetConsumerRequestDetailsUseCase _getConsumerRequestDetailsUseCase;
  final GetConsumerRequestsUseCase _getConsumerRequestsUseCase;
  final SendOfferPriceUseCase _sendOfferPriceUseCase;

  RequestsBloc(
    this._getConsumerRequestDetailsUseCase,
    this._getConsumerRequestsUseCase,
    this._sendOfferPriceUseCase,
  ) : super(RequestsInitial()) {
    on<GetConsumerRequestsEvent>(_onGetConsumerRequestsEvent);
    on<GetConsumerRequestsDetailsEvent>(_onGetConsumerRequestsDetailsEvent);
    on<GetEmployeesEvent>(_onGetEmployeesEvent);
    on<SendPriceOfferEvent>(_onSendPriceOfferEvent);
  }

  FutureOr<void> _onGetConsumerRequestsEvent(
      GetConsumerRequestsEvent event, Emitter<RequestsState> emit) async {
    emit(GetConsumerRequestsLoadingState());
    final resultRecent = await _getConsumerRequestsUseCase(
        providerStatus: RequestStatus.active.name);
    final resultAccept = await _getConsumerRequestsUseCase(
        providerStatus: RequestStatus.accepted.name);

    if (resultRecent is DataSuccess<List<Requests>> ||
        resultAccept is DataSuccess<List<Requests>>) {
      emit(GetConsumerRequestsSuccessState(
          resultRecent.data ?? [], resultAccept.data ?? []));
    } else {
      emit(GetConsumerRequestsErrorState(resultRecent.message ?? ''));
    }
  }

  FutureOr<void> _onGetConsumerRequestsDetailsEvent(
      GetConsumerRequestsDetailsEvent event,
      Emitter<RequestsState> emit) async {
    emit(GetConsumerRequestDetailsLoadingState());
    final result = await _getConsumerRequestDetailsUseCase(
      id: event.requestId,
    );
    if (result is DataSuccess<RequestDetails>) {
      emit(GetConsumerRequestDetailsSuccessState(
          result.data ?? RequestDetails()));
    } else {
      emit(GetConsumerRequestDetailsErrorState(result.message ?? ''));
    }
  }

  FutureOr<void> _onGetEmployeesEvent(
      GetEmployeesEvent event, Emitter<RequestsState> emit) async {
    try {
      final url = Uri.parse(
          '${APIKeys.baseUrl}/api/provider/employee/permission/Contract Signing?page=1&limit=10');
      final token = GetTokenUseCase(injector())();
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Fetching employees from: ${response.body}');
      print('response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final List<employee.Employee> employees = (data['result'] as List)
            .map((e) => employee.Employee.fromJsonTerms(e))
            .toList();
        emit(GetEmployeesSuccessState(employees));
      } else {
        emit(GetEmployeesErrorState('Failed to load employees'));
      }
    } catch (e) {
      emit(GetEmployeesErrorState(e.toString()));
    }
  }

  FutureOr<void> _onSendPriceOfferEvent(
      SendPriceOfferEvent event, Emitter<RequestsState> emit) async {
    emit(SendPriceOfferLoadingState());
    final result = await _sendOfferPriceUseCase(
      request: event.request,
    );
    if (result is DataSuccess<RemoteSendPrice>) {
      emit(SendPriceOfferSuccessState(result.data ?? RemoteSendPrice()));
    } else {
      emit(SendPriceOfferErrorState(result.message ?? ''));
    }
  }
}
