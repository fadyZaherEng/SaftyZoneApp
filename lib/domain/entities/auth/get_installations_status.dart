import 'package:equatable/equatable.dart';

class GetInstallationsStatus extends Equatable {
  final bool alarmItemCompleted;
  final bool fireSystemItemCompleted;
  final bool allCompleted;
  final List<dynamic> remainingAlarmSubCategories;
  final List<String> remainingFireSystemSubCategories;

  const GetInstallationsStatus({
    this.alarmItemCompleted = false,
    this.fireSystemItemCompleted = false,
    this.allCompleted = false,
    this.remainingAlarmSubCategories = const [],
    this.remainingFireSystemSubCategories = const [],
  });

  @override
  List<Object?> get props => [
        alarmItemCompleted,
        fireSystemItemCompleted,
        allCompleted,
        remainingAlarmSubCategories,
        remainingFireSystemSubCategories,
      ];
}
