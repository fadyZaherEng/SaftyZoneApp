import 'package:hatif_mobile/core/resources/data_state.dart';
import 'package:hatif_mobile/domain/entities/auth/check_auth.dart';
import 'package:hatif_mobile/domain/repositories/authentication_repository.dart';

class CheckAuthUseCase {
  final AuthenticationRepository _authenticationRepository;

  CheckAuthUseCase(this._authenticationRepository);

  Future<DataState<CheckAuth>> call() async {
    return await _authenticationRepository.checkAuth();
  }
}
