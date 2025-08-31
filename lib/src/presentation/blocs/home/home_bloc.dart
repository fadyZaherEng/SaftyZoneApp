import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/request_bulk.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/domain/usecase/get_user_login_data_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/get_consumer_requests_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/request_bulk_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/schedule_all_jop_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/schedule_jop_inprogress_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/schedule_jop_maintaince_use_case.dart';
import 'package:safety_zone/src/presentation/screens/home/home_screen.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetConsumerRequestsUseCase _getConsumerRequestsUseCase;
  final ScheduleJobAllUseCase _scheduleJobAllUseCase;
  final GetUserLoginDataUseCase _getUserLoginDataUseCase;
  final RequestBulkUseCase _requestBulkUseCase;

  final ScheduleJopInProgressUseCase _scheduleJopInProgressUseCase;
  final ScheduleJopInMaintainanceUseCase _scheduleJopInMaintainanceUseCase;
  List<DashboardItem> dashboardItems = [
    DashboardItem('0', S.current.newRequests, ImagePaths.news),
    DashboardItem('0', S.current.maintenanceReports, ImagePaths.technical),
    DashboardItem('0', S.current.pendingRequests, ImagePaths.requests),
    DashboardItem('0', S.current.priceOffers, ImagePaths.work),
    DashboardItem('0', S.current.todayTasks, ImagePaths.groups),
  ];

  HomeBloc(
    this._getConsumerRequestsUseCase,
    this._scheduleJobAllUseCase,
    this._getUserLoginDataUseCase,
    this._requestBulkUseCase,
    this._scheduleJopInProgressUseCase,
    this._scheduleJopInMaintainanceUseCase,
  ) : super(HomeInitial()) {
    on<GetHomeDashboardEvent>(_onGetHomeDashboardEvent);
    on<InstallationFeeBulkEvent>(_onInstallationFeeBulkEvent);
    on<SaveTemporaryInstallationFeeEvent>((event, emit) {
      final currentState = state is InstallationFeeTempState
          ? (state as InstallationFeeTempState).fees
          : {};

      final updated = Map<String, String>.from(currentState);
      updated[event.id] = event.price;

      emit(InstallationFeeTempState(updated));
    });


  }

  FutureOr<void> _onGetHomeDashboardEvent(
      GetHomeDashboardEvent event, Emitter<HomeState> emit) async {
    emit(GetHomeDashboardLoadingState());
    final result = await _getConsumerRequestsUseCase(
      providerStatus: RequestStatus.active.name,
    );
    final result2 = await _scheduleJopInMaintainanceUseCase(
      // request: ScheduleJopRequest(
      //   phoneNumber: (await GetUserLoginDataUseCase(injector())())?.phone ?? '',
      //   code: (await GetUserLoginDataUseCase(injector())())?.code ?? '',
      // ),
      limit: 10,
      page: 1,
      status: null,
    );
    final pendingRequests = await _scheduleJopInProgressUseCase(
      // request: ScheduleJopRequest(
      // code: (await _getUserLoginDataUseCase())?.code ?? '',
      // phoneNumber: (await _getUserLoginDataUseCase())?.phone ?? '',
      limit: 10,
      page: 1,
      status: "inProgress",
    );
    if (result is DataSuccess<List<Requests>>) {
      dashboardItems = [
        DashboardItem(
          S.current.newRequests,
          result.data?.length.toString() ?? '0',
          ImagePaths.news,
        ),
        DashboardItem(
          S.current.maintenanceReports,
          '0',
          ImagePaths.technical,
        ),
        DashboardItem(
          S.current.pendingRequests,
          pendingRequests.data?.length.toString() ?? '0',
          ImagePaths.requests,
        ),
        DashboardItem(S.current.priceOffers, '0', ImagePaths.work),
        DashboardItem(
          S.current.todayTasks,
          result2.data?.length.toString() ?? '0',
          ImagePaths.groups,
        ),
      ];
      emit(GetHomeDashboardSuccessState(dashboardItems));
    } else {
      emit(GetHomeDashboardErrorState(result.message ?? ''));
    }
  }

  FutureOr<void> _onInstallationFeeBulkEvent(
      InstallationFeeBulkEvent event, Emitter<HomeState> emit) async {
    emit(InstallationFeeBulkLoadingState());
    final result = await _requestBulkUseCase(request: event.request);
    if (result is DataSuccess) {
      emit(InstallationFeeBulkSuccessState(message: S.current.success ?? ''));
    } else if (result is DataFailed) {
      emit(InstallationFeeBulkErrorState(result.message ?? ''));
    }
  }
}
