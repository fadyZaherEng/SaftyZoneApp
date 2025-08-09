import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_maintainance_item_prices_offer.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class MaintainanceRequestOfferUseCase {
  final HomeRepository _homeRepository;

  MaintainanceRequestOfferUseCase(this._homeRepository);

  Future<DataState<RemoteMaintainanceItemPricesOffer>> call({
    required String id,
  }) async {
    return await _homeRepository.maintenanceReportItems(id: id);
  }
}
