import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/schedule_jop_request.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class ScheduleJopUseCase {
  final HomeRepository _homeRepository;

  ScheduleJopUseCase(this._homeRepository);

  Future<DataState<List<ScheduleJop>>> call({
    required ScheduleJopRequest request,
    required String status,
  }) async {
    return await _homeRepository.getScheduleJob(
      request: request,
      status: status,
    );
  }
}
