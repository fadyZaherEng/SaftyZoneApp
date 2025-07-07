import 'package:hatif_mobile/core/resources/data_state.dart';
import 'package:hatif_mobile/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';

import 'package:hatif_mobile/domain/repositories/authentication_repository.dart';

class GenerateImageUrlUseCase {
  final AuthenticationRepository _authenticationRepository;

  GenerateImageUrlUseCase(this._authenticationRepository);

  Future<DataState<List<RemoteGenerateUrl>>> call() async {
    return await _authenticationRepository.generateImageUrl();
  }
}
