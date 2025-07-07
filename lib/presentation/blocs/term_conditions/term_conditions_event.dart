part of 'term_conditions_bloc.dart';

@immutable
sealed class TermConditionsEvent {}

class GetTermConditionsEvent extends TermConditionsEvent {
  final RequestTermConditions requestTermConditions;

  GetTermConditionsEvent({
    required this.requestTermConditions,
  });
}
