import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_register.dart';
import 'package:safety_zone/src/domain/entities/auth/register.dart';
import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';

class RegisterUseCase {
  final AuthenticationRepository _authenticationRepository;

  RegisterUseCase(this._authenticationRepository);

  Future<DataState<Register>> call({
    required RequestRegister request,
  }) async {
    return await _authenticationRepository.register(request: request);
  }
}
