import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class GetConsumerRequestsUseCase {
  final HomeRepository _homeRepository;

  GetConsumerRequestsUseCase(this._homeRepository);

  Future<DataState<List<Requests>>> call({
    required String providerStatus,
  }) async {
    return await _homeRepository.getConsumerRequests(
      providerStatus: providerStatus,
    );
  }
}
