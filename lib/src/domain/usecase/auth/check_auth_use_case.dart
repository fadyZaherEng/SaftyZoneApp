import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';

class CheckAuthUseCase {
  final AuthenticationRepository _authenticationRepository;

  CheckAuthUseCase(this._authenticationRepository);

  Future<DataState<CheckAuth>> call() async {
    return await _authenticationRepository.checkAuth();
  }
}
