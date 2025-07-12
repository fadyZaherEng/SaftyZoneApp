import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class GetConsumerRequestDetailsUseCase {
  final HomeRepository _homeRepository;

  GetConsumerRequestDetailsUseCase(this._homeRepository);

  Future<DataState<RequestDetails>> call({
    required String id,
  }) async {
    return await _homeRepository.getConsumerRequestDetails(id: id);
  }
}
