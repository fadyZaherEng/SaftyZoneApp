import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/create_maintainance_offer_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/create_maintainance_offer_request.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class CreateMaintainanceOfferUseCase {
  final HomeRepository _homeRepository;

  CreateMaintainanceOfferUseCase(this._homeRepository);

  Future<DataState> call({
    required CreateMaintainanceOfferRequest request,
  }) async {
    return await _homeRepository.createMaintenanceOffer(
      createMaintainanceOfferRequest: request,
    );
  }
}
