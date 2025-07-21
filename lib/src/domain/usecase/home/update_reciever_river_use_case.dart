import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/update_recieve_request.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class UpdateReceiverDriverUseCase {
  final HomeRepository _homeRepository;

  UpdateReceiverDriverUseCase(this._homeRepository);

  Future<DataState> call({
    required UpdateRecieveRequest request,
    required String id,
  }) async {
    return await _homeRepository.receiveDeliverById(
      id: id,
      request: request,
    );
  }
}
