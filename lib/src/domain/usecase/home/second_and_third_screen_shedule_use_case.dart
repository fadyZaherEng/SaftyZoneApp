import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_second_and_third_schedule.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class SecondThirdScreenScheduleUseCase {
  final HomeRepository _homeRepository;

  SecondThirdScreenScheduleUseCase(this._homeRepository);

  Future<DataState<RemoteSecondAndThirdSchedule>> call({
    required String id,
  }) async {
    return await _homeRepository.secondAndThirdScreenScheduleJob(
      id: id,
    );
  }
}
