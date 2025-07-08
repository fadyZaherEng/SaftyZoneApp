import 'package:dio/dio.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/auth_api_services.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_check_auth.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_control_panel.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_create_employee.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_get_installations_status.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_register.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_term_conditions.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_verify_otp.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_create_employee.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_register.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_send_otp.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_term_conditions.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_verify_otp.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/entities/auth/control_panel.dart';
import 'package:safety_zone/src/domain/entities/auth/create_employee.dart';
import 'package:safety_zone/src/domain/entities/auth/get_installations_status.dart';
import 'package:safety_zone/src/domain/entities/auth/register.dart';
import 'package:safety_zone/src/domain/entities/auth/term_conditions.dart';
import 'package:safety_zone/src/domain/entities/auth/verify_otp.dart';
import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';

class AuthenticationRepositoryImplementations extends AuthenticationRepository {
  AuthApiServices _authApiServices;

  AuthenticationRepositoryImplementations(this._authApiServices);

  @override
  Future<DataState<CheckAuth>> checkAuth() async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _authApiServices.checkAuth(
        "Bearer $token",
      );
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: httpResponse.data.toDomain(),
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
  Future<DataState<Employee>> getFirstEmployee({
    required RequestCreateEmployee request,
  }) async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _authApiServices.getFirstEmployee(
        request,
        "Bearer $token",
      );
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: httpResponse.data.toDomain(),
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
  Future<DataState<GetInstallationsStatus>> getInstallationStatus() async {
    try {
      String token = GetTokenUseCase(injector())();

      final httpResponse = await _authApiServices.getInstallationStatus(token);
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: httpResponse.data.toDomain(),
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
  Future<DataState<ControlPanel>> getSubCategory() async {
    try {
      String token = GetTokenUseCase(injector())();

      final httpResponse = await _authApiServices.getSubCategory(token);
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
  Future<DataState<TermConditions>> getTermConditions({
    required RequestTermConditions request,
  }) async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _authApiServices.getTermConditions(
        request,
        "Bearer $token",
      );
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: httpResponse.data.toDomain(),
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
  Future<DataState<String>> reSendOtp({
    required RequestSendOtp request,
  }) async {
    try {
      final httpResponse = await _authApiServices.reSendOtp(
        request,
      );
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
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<Register>> register({
    required RequestRegister request,
  }) async {
    final httpResponse = await _authApiServices.register(
      request,
    );
    try {
      if (((httpResponse.response.statusCode ?? 400) == 201) ||
          (httpResponse.response.statusCode ?? 400) == 200) {
        return DataSuccess(
          data: httpResponse.data.toDomain(),
          message: httpResponse.response.statusMessage ?? "",
        );
      }

      return DataFailed(message: httpResponse.data.token ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: httpResponse.response.statusMessage ?? "",
      );
    }
  }

  @override
  Future<DataState<String>> sendOtp({
    required RequestSendOtp request,
  }) async {
    try {
      final httpResponse = await _authApiServices.sendOtp(
        request,
      );
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
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<VerifyOtp>> verifyOtp({
    required RequestVerifyOtp request,
  }) async {
    try {
      final httpResponse = await _authApiServices.verifyOtp(request);
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
  Future<DataState<List<RemoteGenerateUrl>>> generateFileUrl() async {
    final httpResponse = await _authApiServices.generateFileUrl();
    if ((httpResponse.response.statusCode ?? 400) == 200) {
      return DataSuccess(
        data: httpResponse.data["data"],
        message: httpResponse.response.statusMessage ?? "",
      );
    }

    return DataFailed(message: httpResponse.response.statusMessage ?? "");
  }

  @override
  Future<DataState<List<RemoteGenerateUrl>>> generateImageUrl() async {
    final httpResponse = await _authApiServices.generateImageUrl();
    if ((httpResponse.response.statusCode ?? 400) == 200) {
      return DataSuccess(
        data: httpResponse.data["data"],
        message: httpResponse.response.statusMessage ?? "",
      );
    }

    return DataFailed(message: httpResponse.response.statusMessage ?? "");
  }
}
