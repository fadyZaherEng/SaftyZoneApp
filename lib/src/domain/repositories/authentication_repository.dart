import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_create_employee.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_register.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_send_otp.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_term_conditions.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_verify_otp.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/entities/auth/control_panel.dart';
import 'package:safety_zone/src/domain/entities/auth/create_employee.dart';
import 'package:safety_zone/src/domain/entities/auth/get_installations_status.dart';
import 'package:safety_zone/src/domain/entities/auth/register.dart';
import 'package:safety_zone/src/domain/entities/auth/term_conditions.dart';
import 'package:safety_zone/src/domain/entities/auth/verify_otp.dart';

abstract class AuthenticationRepository {
  Future<DataState<Register>> register({
    required RequestRegister request,
  });

  Future<DataState<String>> sendOtp({
    required RequestSendOtp request,
  });

  Future<DataState<String>> reSendOtp({
    required RequestSendOtp request,
  });

  Future<DataState<VerifyOtp>> verifyOtp({
    required RequestVerifyOtp request,
  });

  Future<DataState<CheckAuth>> checkAuth();

  // Future<DataState<InstallationFees>> getInstallationFees({
  //   required RequestInstallationsFees request,
  // });

  Future<DataState<ControlPanel>> getSubCategory();

  Future<DataState<GetInstallationsStatus>> getInstallationStatus();

  Future<DataState<Employee>> getFirstEmployee({
    required RequestCreateEmployee request,
  });

  Future<DataState<TermConditions>> getTermConditions({
    required RequestTermConditions request,
  });
  Future<DataState<List<RemoteGenerateUrl>>> generateImageUrl();
  Future<DataState<List<RemoteGenerateUrl>>> generateFileUrl();


}
