import 'package:dio/dio.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_request_details.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_requests.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_schedule_jop.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_send_price.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/home_api_services.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/schedule_jop_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';

class HomeRepositoryImplementations extends HomeRepository {
  final HomeApiServices _homeApiServices;

  HomeRepositoryImplementations(this._homeApiServices);

  @override
  Future<DataState<RequestDetails>> getConsumerRequestDetails(
      {required String id}) async {
    try {
      final httpResponse = await _homeApiServices.getConsumerRequestDetails(id);
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: httpResponse.data.mapToDomain(),
          message: httpResponse.response.statusMessage ?? "",
        );
      }

      return DataFailed(message: httpResponse.response.statusMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<Requests>>> getConsumerRequests({
    required String providerStatus,
  }) async {
    try {
      final httpResponse = await _homeApiServices.getConsumerRequests(
        GetTokenUseCase(injector())(),
        providerStatus,
      );
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: httpResponse.data.mapToDomain(),
          message: httpResponse.response.statusMessage ?? "",
        );
      }

      return DataFailed(message: httpResponse.response.statusMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<RemoteSendPrice>> sendPrice({
    required SendPriceRequest request,
  }) async {
    try {
      final httpResponse = await _homeApiServices.sendPrice(request);
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: httpResponse.data,
          message: httpResponse.response.statusMessage ?? "",
        );
      }

      return DataFailed(message: httpResponse.response.statusMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.thisProviderHasAlreadyMadeAnOfferForThisRequest,
      );
    }
  }

  @override
  Future<DataState<List<ScheduleJop>>> getScheduleJob({
    required String status,
    required ScheduleJopRequest request,
  }) async {
    try {
      final httpResponse = await _homeApiServices.scheduleJob(
        status,
        request,
      );
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: (httpResponse.data ?? []).mapToScheduleJop(),
          message: httpResponse.response.statusMessage ?? "",
        );
      }

      return DataFailed(message: httpResponse.response.statusMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<ScheduleJop>>> getScheduleJobAll({
    required ScheduleJopRequest request,
  }) async {
    try {
      final httpResponse = await _homeApiServices.scheduleJobAll(
        request,
      );
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: (httpResponse.data ?? []).mapToScheduleJop(),
          message: httpResponse.response.statusMessage ?? "",
        );
      }

      return DataFailed(message: httpResponse.response.statusMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }
}
