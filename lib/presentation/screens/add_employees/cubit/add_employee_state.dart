
import 'package:hatif_mobile/domain/entities/auth/create_employee.dart';


enum AddEmployeeStep { basicInfo, assignRole, review }

class AddEmployeeState {
  final AddEmployeeStep step;
  final Employee employee;
  final bool isLoading;
  final String? error;
  final bool canGoNext;
  final bool canGoPrevious;
  final bool isSaved;

  AddEmployeeState({
    required this.step,
    required this.employee,
    this.isLoading = false,
    this.error,
    this.canGoNext = false,
    this.canGoPrevious = false,
    this.isSaved = false,
  });

  AddEmployeeState copyWith({
    AddEmployeeStep? step,
    Employee? employee,
    bool? isLoading,
    String? error,
    bool? canGoNext,
    bool? canGoPrevious,
    bool? isSaved,
  }) {
    return AddEmployeeState(
      step: step ?? this.step,
      employee: employee ?? this.employee,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      canGoNext: canGoNext ?? this.canGoNext,
      canGoPrevious: canGoPrevious ?? this.canGoPrevious,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
