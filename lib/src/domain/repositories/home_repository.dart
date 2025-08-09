import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_certificate_insatllation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_go_to_location.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_maintainance_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_second_and_third_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_send_price.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/maintainance_report_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/request_certificate_installation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/schedule_jop_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/update_recieve_request.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';

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

  Future<DataState<List<ScheduleJop>>> getScheduleJob({
    required String status,
    required ScheduleJopRequest request,
  });

  Future<DataState<List<ScheduleJop>>> getScheduleJobAll({
    required ScheduleJopRequest request,
  });

  Future<DataState<RemoteCertificateInsatllation>>
      certificateOfEquipmentInstallations({
    required RequestCertificateInstallation request,
  });

  Future<DataState<RemoteGoToLocation>> goToLocation({
    required String id,
  });

  Future<DataState> receiveDeliverById({
    required String id,
    required UpdateRecieveRequest request,
  });

  Future<DataState<RemoteAddRecieve>> receiveDeliver({
    required AddRecieveRequest request,
  });

  Future<DataState<RemoteMainOfferFireExtinguisher>> fireExtinguisherMainOffer({
    required MainOfferFireExtinguisher mainOfferFireExtinguisher,
  });

  Future<DataState<RemoteFirstScreenSchedule>> firstScreenScheduleJob({
    required String id,
  });

  Future<DataState<RemoteSecondAndThirdSchedule>>
      secondAndThirdScreenScheduleJob({
    required String id,
  });

  Future<DataState<RemoteMaintainanceReport>> createMaintenanceReport({
    required MaintainanceReportRequest maintenanceReport,
  });
}
