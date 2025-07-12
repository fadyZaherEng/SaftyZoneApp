part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetHomeDashboardErrorState extends HomeState {
  final String message;

  GetHomeDashboardErrorState(this.message);
}

final class GetHomeDashboardSuccessState extends HomeState {
  final List<DashboardItem> dashboardItems;

  GetHomeDashboardSuccessState(this.dashboardItems);
}

final class GetHomeDashboardLoadingState extends HomeState {}