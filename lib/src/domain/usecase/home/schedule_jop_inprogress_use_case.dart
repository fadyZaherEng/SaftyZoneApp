import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class ScheduleJopInProgressUseCase {
  final HomeRepository _homeRepository;

  ScheduleJopInProgressUseCase(this._homeRepository);

  Future<DataState<List<ScheduleJop>>> call({
    required String status,
    required int limit,
    required int page,
  }) async {
    return await _homeRepository.getScheduleJobByStatusDate(
      status: status,
      limit: limit,
      page: page,
    );
  }
}
