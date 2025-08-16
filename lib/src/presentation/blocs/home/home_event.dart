part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetHomeDashboardEvent extends HomeEvent {}

class InstallationFeeBulkEvent extends HomeEvent {
  final RequestBulk request;

  InstallationFeeBulkEvent({required this.request});
}