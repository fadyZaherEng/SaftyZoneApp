import 'package:hatif_mobile/core/resources/data_state.dart';
import 'package:hatif_mobile/data/sources/remote/safty_zone/auth/request/request_verify_otp.dart';
import 'package:hatif_mobile/domain/entities/auth/verify_otp.dart';
import 'package:hatif_mobile/domain/repositories/authentication_repository.dart';

class VerifySendOtpUseCase {
  final AuthenticationRepository _authenticationRepository;

  VerifySendOtpUseCase(this._authenticationRepository);

  Future<DataState<VerifyOtp>> call({
    required RequestVerifyOtp request,
  }) async {
    return await _authenticationRepository.verifyOtp(request: request);
  }
}
