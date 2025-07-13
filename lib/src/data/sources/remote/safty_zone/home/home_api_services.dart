import 'package:dio/dio.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_request_details.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_requests.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_schedule_jop.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_send_price.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/schedule_jop_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';

part 'home_api_services.g.dart';

@RestApi()
abstract class HomeApiServices {
  factory HomeApiServices(Dio dio) = _HomeApiServices;

  @GET(APIKeys.consumerRequests)
  Future<HttpResponse<List<RemoteRequests>>> getConsumerRequests(
      @Header("Authorization") String token,
      @Query("provider_status") String providerStatus,
  );

  @GET(APIKeys.getConsumerRequestDetails)
  Future<HttpResponse<RemoteRequestDetails>> getConsumerRequestDetails(
    @Path("id") String id,
  );

  @POST(APIKeys.sendPriceOffer)
  Future<HttpResponse<RemoteSendPrice>> sendPrice(
    @Body() SendPriceRequest request,
  );

  @GET(APIKeys.scheduleJob)
  Future<HttpResponse<List<RemoteScheduleJop>>> scheduleJob(
    @Query("status") String status,
    @Body() ScheduleJopRequest request,
  );

  @GET(APIKeys.scheduleJob)
  Future<HttpResponse<List<RemoteScheduleJop>>> scheduleJobAll(
    @Body() ScheduleJopRequest request,
  );
}
