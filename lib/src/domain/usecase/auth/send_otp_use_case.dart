import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_send_otp.dart';
import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';

class SendOtpUseCase {
  final AuthenticationRepository _authenticationRepository;

  SendOtpUseCase(this._authenticationRepository);

  Future<DataState<String>> call({
    required RequestSendOtp request,
  }) async {
    return await _authenticationRepository.sendOtp(request: request);
  }
}
