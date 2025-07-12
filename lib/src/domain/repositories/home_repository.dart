import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_send_price.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';

abstract class HomeRepository {
  Future<DataState<List<Requests>>> getConsumerRequests({
    required String providerStatus,
  });

  Future<DataState<RequestDetails>> getConsumerRequestDetails({
    required String id,
  });

  Future<DataState<RemoteSendPrice>> sendPrice({
    required SendPriceRequest request,
  });
}
