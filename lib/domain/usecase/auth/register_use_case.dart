import 'package:hatif_mobile/core/resources/data_state.dart';
import 'package:hatif_mobile/data/sources/remote/safty_zone/auth/request/request_register.dart';
import 'package:hatif_mobile/domain/entities/auth/register.dart';
import 'package:hatif_mobile/domain/repositories/authentication_repository.dart';

class RegisterUseCase {
  final AuthenticationRepository _authenticationRepository;

  RegisterUseCase(this._authenticationRepository);

  Future<DataState<Register>> call({
    required RequestRegister request,
  }) async {
    return await _authenticationRepository.register(request: request);
  }
}
