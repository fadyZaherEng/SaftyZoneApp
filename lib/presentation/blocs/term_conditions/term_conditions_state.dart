part of 'term_conditions_bloc.dart';

@immutable
sealed class TermConditionsState {}

final class TermConditionsInitial extends TermConditionsState {}

final class GetTermConditionsLoadingState extends TermConditionsState {}

final class GetTermConditionsSuccessState extends TermConditionsState {
  final TermConditions termConditions;

  GetTermConditionsSuccessState({required this.termConditions});
}

final class GetTermConditionsErrorState extends TermConditionsState {
  final String message;

  GetTermConditionsErrorState({required this.message});
}
