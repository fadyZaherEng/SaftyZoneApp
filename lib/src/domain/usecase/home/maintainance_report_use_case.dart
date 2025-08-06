import 'package:safety_zone/src/core/resources/data_state.dart';
 import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_maintainance_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/maintainance_report_request.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class MaintainanceReportUseCase {
  final HomeRepository _homeRepository;

  MaintainanceReportUseCase(this._homeRepository);

  Future<DataState<RemoteMaintainanceReport>> call({
    required MaintainanceReportRequest maintenanceReport,
  }) async {
    return await _homeRepository.createMaintenanceReport(
      maintenanceReport: maintenanceReport,
    );
  }
}
