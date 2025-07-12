import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/domain/usecase/home/get_consumer_requests_use_case.dart';
import 'package:safety_zone/src/presentation/screens/home/home_screen.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetConsumerRequestsUseCase _getConsumerRequestsUseCase;

  List<DashboardItem> dashboardItems = [
    DashboardItem('30', S.current.newRequests, ImagePaths.news),
    DashboardItem('5', S.current.maintenanceReports, ImagePaths.technical),
    DashboardItem('10', S.current.pendingRequests, ImagePaths.requests),
    DashboardItem('8', S.current.priceOffers, ImagePaths.work),
    DashboardItem('12', S.current.todayTasks, ImagePaths.groups),
  ];

  HomeBloc(
    this._getConsumerRequestsUseCase,
  ) : super(HomeInitial()) {
    on<GetHomeDashboardEvent>(_onGetHomeDashboardEvent);
  }

  FutureOr<void> _onGetHomeDashboardEvent(
      GetHomeDashboardEvent event, Emitter<HomeState> emit) async {
    emit(GetHomeDashboardLoadingState());
    final result = await _getConsumerRequestsUseCase(
        providerStatus: RequestStatus.active.name);
    if (result is DataSuccess<List<Requests>>) {
      dashboardItems = [
        DashboardItem(S.current.newRequests,
            result.data?.length.toString() ?? '0', ImagePaths.news),
        DashboardItem(S.current.maintenanceReports, '5', ImagePaths.technical),
        DashboardItem(S.current.pendingRequests, '10', ImagePaths.requests),
        DashboardItem(S.current.priceOffers, '8', ImagePaths.work),
        DashboardItem(S.current.todayTasks, '12', ImagePaths.groups),
      ];
      emit(GetHomeDashboardSuccessState(dashboardItems));
    } else {
      emit(GetHomeDashboardErrorState(result.message ?? ''));
    }
  }
}
