import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_certificate_insatllation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/request_certificate_installation.dart';
 import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class CertificateInstallationsUseCase {
  final HomeRepository _homeRepository;

  CertificateInstallationsUseCase(this._homeRepository);

  Future<DataState<RemoteCertificateInsatllation>> call({
    required RequestCertificateInstallation request,
  }) async {
    return await _homeRepository.certificateOfEquipmentInstallations(
      request: request,
    );
  }
}
