import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class FirstScreenScheduleUseCase {
  final HomeRepository _homeRepository;

  FirstScreenScheduleUseCase(this._homeRepository);

  Future<DataState<RemoteFirstScreenSchedule>> call({
    required String id,
  }) async {
    return await _homeRepository.firstScreenScheduleJob(id: id);
  }
}
