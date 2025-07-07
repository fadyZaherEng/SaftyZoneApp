import 'package:hatif_mobile/core/resources/data_state.dart';
 import 'package:hatif_mobile/domain/entities/auth/get_installations_status.dart';
 import 'package:hatif_mobile/domain/repositories/authentication_repository.dart';

class GetInstallationsStatusUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetInstallationsStatusUseCase(this._authenticationRepository);

  Future<DataState<GetInstallationsStatus>> call() async {
    return await _authenticationRepository.getInstallationStatus();
  }
}
