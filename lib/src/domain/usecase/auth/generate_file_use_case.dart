import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';

import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';

class GenerateFileUrlUseCase {
  final AuthenticationRepository _authenticationRepository;

  GenerateFileUrlUseCase(this._authenticationRepository);

  Future<DataState<List<RemoteGenerateUrl>>> call() async {
    return await _authenticationRepository.generateFileUrl();
  }
}
