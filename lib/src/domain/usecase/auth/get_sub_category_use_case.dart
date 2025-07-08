import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/domain/entities/auth/control_panel.dart';
import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';

class GetBySubCategoryUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetBySubCategoryUseCase(this._authenticationRepository);

  Future<DataState<ControlPanel>> call() async {
    return await _authenticationRepository.getSubCategory();
  }
}
