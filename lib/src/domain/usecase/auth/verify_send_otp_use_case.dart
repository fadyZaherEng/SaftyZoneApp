import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_verify_otp.dart';
import 'package:safety_zone/src/domain/entities/auth/verify_otp.dart';
import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';

class VerifySendOtpUseCase {
  final AuthenticationRepository _authenticationRepository;

  VerifySendOtpUseCase(this._authenticationRepository);

  Future<DataState<VerifyOtp>> call({
    required RequestVerifyOtp request,
  }) async {
    return await _authenticationRepository.verifyOtp(request: request);
  }
}
