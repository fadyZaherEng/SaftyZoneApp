import 'package:dio/dio.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_certificate_insatllation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_go_to_location.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_maintainance_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_request_details.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_requests.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_schedule_jop.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_second_and_third_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_send_price.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_update_status_deliver.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/maintainance_report_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/request_certificate_installation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/schedule_jop_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/update_recieve_request.dart';

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
    @Header("Authorization") String token,
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

  @POST(APIKeys.certificateOfEquipmentInstallations)
  Future<HttpResponse<RemoteCertificateInsatllation>>
      certificateOfEquipmentInstallations(
    @Header("Authorization") String token,
    @Body() RequestCertificateInstallation request,
  );

  @PUT(APIKeys.goToLocation)
  Future<HttpResponse<RemoteGoToLocation>> goToLocation(
    @Header("Authorization") String token,
    @Path("id") String id,
  );

  @PUT(APIKeys.receiveDeliverById)
  Future<HttpResponse<RemoteUpdateStatusDeliver>> receiveDeliverById(
    @Header("Authorization") String token,
    @Path("id") String id,
    @Body() UpdateRecieveRequest request,
  );

  @POST(APIKeys.receiveDeliver)
  Future<HttpResponse<RemoteAddRecieve>> receiveDeliver(
    @Header("Authorization") String token,
    @Body() AddRecieveRequest request,
  );

  @POST(APIKeys.fireExtinguisherMainOffer)
  Future<HttpResponse<RemoteMainOfferFireExtinguisher>>
      fireExtinguisherMainOffer(
    @Body() MainOfferFireExtinguisher mainOfferFireExtinguisher,
  );

  @GET(APIKeys.firstScreenScheduleJob)
  Future<HttpResponse<RemoteFirstScreenSchedule>> firstScreenScheduleJob(
    @Path("id") String id,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.secondAndThirdScreenScheduleJob)
  Future<HttpResponse<RemoteSecondAndThirdSchedule>>
      secondAndThirdScreenScheduleJob(
    @Path("id") String id,
  );

  @POST(APIKeys.createMaintenanceReport)
  Future<HttpResponse<RemoteMaintainanceReport>> createMaintenanceReport(
    @Header("Authorization") String token,
    @Body() MaintainanceReportRequest maintenanceReport,
  );
}
