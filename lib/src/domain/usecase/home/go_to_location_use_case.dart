import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_go_to_location.dart';
 import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class GoToLocationUseCase {
  final HomeRepository _homeRepository;

  GoToLocationUseCase(this._homeRepository);

  Future<DataState<RemoteGoToLocation>> call({
    required String id,
  }) async {
    return await _homeRepository.goToLocation(id: id);
  }
}
