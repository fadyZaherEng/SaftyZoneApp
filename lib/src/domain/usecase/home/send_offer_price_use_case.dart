import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_send_price.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

class SendOfferPriceUseCase {
  final HomeRepository _homeRepository;

  SendOfferPriceUseCase(this._homeRepository);

  Future<DataState<RemoteSendPrice>> call({
    required SendPriceRequest request,
  }) async {
    return await _homeRepository.sendPrice(
      request: request,
    );
  }
}
