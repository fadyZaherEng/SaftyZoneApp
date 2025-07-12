import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/schedule_jop_request.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class ScheduleJobAllUseCase {
  final HomeRepository _homeRepository;

  ScheduleJobAllUseCase(this._homeRepository);

  Future<DataState<List<ScheduleJop>>> call({
    required ScheduleJopRequest request,
  }) async {
    return await _homeRepository.getScheduleJobAll(
      request: request,
    );
  }
}
