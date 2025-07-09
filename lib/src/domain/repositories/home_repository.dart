import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';

abstract class HomeRepository {
  Future<DataState<List<Requests>>> getConsumerRequests({
    required String providerStatus,
  });

  Future<DataState<RequestDetails>> getConsumerRequestDetails({
    required String id,
  });
}
