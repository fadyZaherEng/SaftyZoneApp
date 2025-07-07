import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/usecase/auth/check_auth_use_case.dart';
import 'package:hatif_mobile/domain/usecase/get_token_use_case.dart';

class CustomInterceptors extends InterceptorsWrapper {
  String token = "";

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // أضف التوكن لو موجود
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    debugPrint(
      "REQUEST [${options.method}] URL: ${options.baseUrl + options.path} \n"
      "DATA: ${jsonEncode(options.data)} \n"
      "HEADERS: ${options.headers} \n"
      "QUERY: ${options.queryParameters}",
    );

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint(
        "RESPONSE [${response.statusCode}] \n${jsonEncode(response.data)}");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint(
      "ERROR [${err.response?.statusCode}] \n${err.response.toString()} \nHEADERS: ${err.requestOptions.headers}",
    );
    token = GetTokenUseCase(injector())();
    // في حالة 401 نعيد تنفيذ الطلب بعد تجديد التوكن
    if (err.response?.statusCode == 401) {
      try {
        // تجديد التوكن
        final responseToken = await CheckAuthUseCase(injector())();
        // إعادة إعدادات الطلب الأصلي
        final originalRequest = err.requestOptions;
        originalRequest.headers['Authorization'] = 'Bearer $token';

        // إعادة إرسال الطلب باستخدام نفس instance
        final dio = injector<Dio>();
        final response = await dio.fetch(originalRequest);

        return handler.resolve(response); // ✅ نعيد النتيجة للمستدعي
      } catch (e) {
        // لو فشل التجديد أو التنفيذ
        return handler.reject(DioError(
          requestOptions: err.requestOptions,
          error: e,
          type: DioErrorType.unknown,
        ));
      }
    }

    // في حالة خطأ غير 401
    return super.onError(err, handler);
  }
}
