import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class MainOfferUseCase {
  final HomeRepository _homeRepository;

  MainOfferUseCase(this._homeRepository);

  Future<DataState<RemoteMainOfferFireExtinguisher>> call({
    required MainOfferFireExtinguisher mainOfferFireExtinguisher,
  }) async {
    return await _homeRepository.fireExtinguisherMainOffer(
      mainOfferFireExtinguisher: mainOfferFireExtinguisher,
    );
  }
}
