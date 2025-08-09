import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
 import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class AddReceiverDriverUseCase {
  final HomeRepository _homeRepository;

  AddReceiverDriverUseCase(this._homeRepository);

  Future<DataState<RemoteAddRecieve>> call({
    required AddRecieveRequest request,
  }) async {
    return await _homeRepository.receiveDeliver(request: request);
  }
}
