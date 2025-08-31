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

final class InstallationFeeBulkLoadingState extends HomeState {}

final class InstallationFeeBulkSuccessState extends HomeState {
  final String message;

  InstallationFeeBulkSuccessState({required this.message});
}

final class InstallationFeeBulkErrorState extends HomeState {
  final String message;

  InstallationFeeBulkErrorState(this.message);
}
class InstallationFeeTempState extends HomeState {
  final Map<String, String> fees; // id -> price
  InstallationFeeTempState(this.fees);
}
