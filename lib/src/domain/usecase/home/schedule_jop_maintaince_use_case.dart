import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class ScheduleJopInMaintainanceUseCase {
  final HomeRepository _homeRepository;

  ScheduleJopInMaintainanceUseCase(this._homeRepository);

  Future<DataState<List<ScheduleJop>>> call({
    required String? status,
    required int limit,
    required int page,
  }) async {
    return await _homeRepository.maintenanceAndExtinguisherDetails(
      status: status,
      limit: limit,
      page: page,
    );
  }
}
