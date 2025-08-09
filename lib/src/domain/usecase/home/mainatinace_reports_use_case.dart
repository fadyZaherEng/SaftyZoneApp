import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/maintainance_reports.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
 import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class MaintainanceReportsUseCase {
  final HomeRepository _homeRepository;

  MaintainanceReportsUseCase(this._homeRepository);

  Future<DataState<List<MaintainanceReports>>> call() async {
    return await _homeRepository.getMaintenanceReports();
  }
}
