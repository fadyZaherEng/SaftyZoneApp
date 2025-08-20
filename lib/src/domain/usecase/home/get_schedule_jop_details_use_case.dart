import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_schedule_job_details.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class GetScheduleJopDetailsDetailsUseCase {
  final HomeRepository _homeRepository;

  GetScheduleJopDetailsDetailsUseCase(this._homeRepository);

  Future<DataState<RemoteScheduleJobDetails>> call({
    required String id,
  }) async {
    return await _homeRepository.getScheduleJobDetails(id: id);
  }
}
