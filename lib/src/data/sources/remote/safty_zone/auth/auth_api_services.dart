import 'package:dio/dio.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_check_auth.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_control_panel.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_create_employee.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_get_installations_status.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_installation_fees.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_register.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_term_conditions.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_verify_otp.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_create_employee.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_installations_fees.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_register.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_send_otp.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_term_conditions.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_verify_otp.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_services.g.dart';

@RestApi()
abstract class AuthApiServices {
  factory AuthApiServices(Dio dio) = _AuthApiServices;

  @POST(APIKeys.register)
  Future<HttpResponse<RemoteRegister>> register(
    @Body() RequestRegister request,
  );

  @POST(APIKeys.sendOtp)
  Future<HttpResponse<String>> sendOtp(
    @Body() RequestSendOtp request,
  );

  @POST(APIKeys.reSendOtp)
  Future<HttpResponse<String>> reSendOtp(
    @Body() RequestSendOtp request,
  );

  @POST(APIKeys.verifyOtp)
  Future<HttpResponse<RemoteVerifyOtp>> verifyOtp(
    @Body() RequestVerifyOtp request,
  );

  @GET(APIKeys.checkAuth)
  Future<HttpResponse<RemoteCheckAuth>> checkAuth(
    @Header("Authorization") String token,
  );

  @POST(APIKeys.installationsFees)
  Future<HttpResponse<RemoteInstallationFees>> getInstallationFees(
    @Body() RequestInstallationsFees request,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.controlPanel)
  Future<HttpResponse<RemoteControlPanel>> getSubCategory(
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getInstallationStatus)
  Future<HttpResponse<RemoteGetInstallationsStatus>> getInstallationStatus(
    @Header("Authorization") String token,
  );

  @POST(APIKeys.getFirstEmployee)
  Future<HttpResponse<RemoteCreateEmployee>> getFirstEmployee(
    @Body() RequestCreateEmployee request,
    @Header("Authorization") String token,
  );

  @POST(APIKeys.termAndConditions)
  Future<HttpResponse<RemoteTermConditions>> getTermConditions(
    @Body() RequestTermConditions request,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.generateImageUrl)
  Future<HttpResponse<Map<String, List<RemoteGenerateUrl>>>> generateImageUrl();

  @GET(APIKeys.generateFileUrl)
  Future<HttpResponse<Map<String, List<RemoteGenerateUrl>>>> generateFileUrl();
}
