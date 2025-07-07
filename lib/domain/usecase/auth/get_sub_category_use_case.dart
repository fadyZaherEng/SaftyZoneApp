import 'package:hatif_mobile/core/resources/data_state.dart';
import 'package:hatif_mobile/domain/entities/auth/control_panel.dart';
import 'package:hatif_mobile/domain/repositories/authentication_repository.dart';

class GetBySubCategoryUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetBySubCategoryUseCase(this._authenticationRepository);

  Future<DataState<ControlPanel>> call() async {
    return await _authenticationRepository.getSubCategory();
  }
}
