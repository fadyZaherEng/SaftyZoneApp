import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_term_conditions.dart';
import 'package:safety_zone/src/domain/entities/auth/term_conditions.dart';
import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';

class GetTermConditionsUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetTermConditionsUseCase(this._authenticationRepository);

  Future<DataState<TermConditions>> call({
    required RequestTermConditions request,
  }) async {
    return await _authenticationRepository.getTermConditions(request: request);
  }
}
