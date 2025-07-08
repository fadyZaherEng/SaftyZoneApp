import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:safety_zone/src/core/utils/app_config.dart';
import 'package:safety_zone/src/core/utils/network/interceptor.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/auth_api_services.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chucker_flutter/chucker_flutter.dart';

final injector = GetIt.instance;

Future<void> initializeDataDependencies() async {
  AppConfig appConfig = AppConfig();
  await appConfig.init();

  injector.registerLazySingleton(() => Dio()
    ..options.baseUrl = APIKeys.baseUrl
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['Accept'] = '*/*'
    ..options.headers['Authorization'] =
        'Bearer ${GetTokenUseCase(injector())()}'
    ..interceptors.add(CustomInterceptors())
    ..interceptors.add(ChuckerDioInterceptor())
    ..interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    )));

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  injector.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  injector.registerLazySingleton<AuthApiServices>(
      () => AuthApiServices(injector()));
}
