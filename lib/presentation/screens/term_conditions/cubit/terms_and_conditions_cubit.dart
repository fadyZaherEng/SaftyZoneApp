import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/data/sources/remote/api_key.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/entities/auth/create_employee.dart';
import 'package:hatif_mobile/domain/usecase/get_token_use_case.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TermsAndConditionsState {
  final TextEditingController contractSigningController;
  final List<String> terms;
  final bool addingTerm;
  final List<int> selectedDays;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool loading;
  final List<Employee> employees;
  final Employee? selectedEmployee;
  final bool employeesLoading;
  final String? employeesError;

  TermsAndConditionsState({
    required this.contractSigningController,
    required this.terms,
    required this.addingTerm,
    required this.selectedDays,
    required this.startTime,
    required this.endTime,
    required this.loading,
    this.employees = const [],
    this.selectedEmployee,
    this.employeesLoading = false,
    this.employeesError,
  });

  bool get isValid {
    // Debug print for all fields
    final hasEmployee = selectedEmployee != null;
    final hasTerms = terms.isNotEmpty;
    final hasDays = selectedDays.isNotEmpty;
    final hasStart = startTime != null;
    final hasEnd = endTime != null;

    int? startMinutes =
        hasStart ? (startTime!.hour * 60 + startTime!.minute) : null;
    int? endMinutes = hasEnd ? (endTime!.hour * 60 + endTime!.minute) : null;
    final timeOrder = (startMinutes != null && endMinutes != null)
        ? (startMinutes < endMinutes)
        : false;
    print('--- isValid Debug ---');
    print('hasEmployee: $hasEmployee');
    print('hasTerms: $hasTerms');
    print('hasDays: $hasDays');
    print('hasStart: $hasStart');
    print('hasEnd: $hasEnd');
    print('startMinutes: $startMinutes');
    print('endMinutes: $endMinutes');
    print('timeOrder: $timeOrder');
    print('selectedEmployee: $selectedEmployee');
    print('terms: $terms');
    print('selectedDays: $selectedDays');
    print('startTime: $startTime');
    print('endTime: $endTime');
    print('----------------------');
    return hasEmployee &&
        hasTerms &&
        hasDays &&
        hasStart &&
        hasEnd &&
        timeOrder;
  }

  TermsAndConditionsState copyWith({
    TextEditingController? contractSigningController,
    TextEditingController? trainingController,
    List<String>? terms,
    bool? addingTerm,
    List<int>? selectedDays,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? loading,
    List<Employee>? employees,
    Employee? selectedEmployee,
    bool? employeesLoading,
    String? employeesError,
  }) {
    return TermsAndConditionsState(
      contractSigningController:
          contractSigningController ?? this.contractSigningController,
      terms: terms ?? this.terms,
      addingTerm: addingTerm ?? this.addingTerm,
      selectedDays: selectedDays ?? this.selectedDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      loading: loading ?? this.loading,
      employees: employees ?? this.employees,
      selectedEmployee: selectedEmployee ?? this.selectedEmployee,
      employeesLoading: employeesLoading ?? this.employeesLoading,
      employeesError: employeesError ?? this.employeesError,
    );
  }
}

class TermsAndConditionsCubit extends Cubit<TermsAndConditionsState> {
  final contractSigningController = TextEditingController();
  final trainingController = TextEditingController();
  final addTermController = TextEditingController();

  final List<String> daysOfWeek = [
    S.current.saturday,
    S.current.sunday,
    S.current.monday,
    S.current.tuesday,
    S.current.wednesday,
    S.current.thursday,
    S.current.friday,
  ];

  TermsAndConditionsCubit()
      : super(
          TermsAndConditionsState(
            contractSigningController: TextEditingController(),
            terms: [],
            addingTerm: false,
            selectedDays: [],
            startTime: null,
            endTime: null,
            loading: false,
            employees: const [],
            selectedEmployee: null,
            employeesLoading: false,
            employeesError: null,
          ),
        ) {
    emit(state.copyWith(
      contractSigningController: contractSigningController,
      trainingController: trainingController,
    ));
    contractSigningController.addListener(_onFieldChanged);
    trainingController.addListener(_onFieldChanged);
    fetchEmployees();
  }

  void _onFieldChanged() => emit(state.copyWith());

  void onContractSigningChanged(String _) => emit(state.copyWith());

  void onTrainingChanged(String _) => emit(state.copyWith());

  void startAddTerm() {
    addTermController.clear();
    emit(state.copyWith(addingTerm: true));
  }

  void cancelAddTerm() {
    addTermController.clear();
    emit(state.copyWith(addingTerm: false));
  }

  void addCustomTerm() {
    final text = addTermController.text.trim();
    if (text.isNotEmpty) {
      final newTerms = List<String>.from(state.terms)..add(text);
      addTermController.clear();
      emit(state.copyWith(terms: newTerms, addingTerm: false));
    }
  }

  void toggleDay(int index) {
    final days = List<int>.from(state.selectedDays);
    if (days.contains(index)) {
      days.remove(index);
    } else {
      days.add(index);
    }
    emit(state.copyWith(selectedDays: days));
  }

  Future<void> pickTime(BuildContext context, bool isStart) async {
    final initial = isStart
        ? state.startTime ?? TimeOfDay(hour: 9, minute: 0)
        : state.endTime ?? TimeOfDay(hour: 17, minute: 0);
    final picked = await showTimePicker(
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: ColorSchemes.primary,
              ),
        ),
        child: child ?? const SizedBox(),
      ),
      context: context,
      initialTime: initial,
    );
    if (picked != null) {
      if (isStart) {
        emit(state.copyWith(startTime: picked));
      } else {
        emit(state.copyWith(endTime: picked));
      }
    }
  }

  Future<void> fetchEmployees() async {
    emit(state.copyWith(employeesLoading: true, employeesError: null));
    try {
      final url = Uri.parse(
          '${APIKeys.baseUrl}/api/provider/employee/permission/Contract Signing?page=1&limit=10');
      final token = await getToken();
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Fetching employees from: ${response.body}');
      print('response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200|| response.statusCode == 201) {
        final data = json.decode(response.body);
        final List<Employee> employees =
            (data['result'] as List).map((e) => Employee.fromJsonTerms(e)).toList();
        emit(state.copyWith(employees: employees, employeesLoading: false));
      } else {
        emit(state.copyWith(
            employeesLoading: false,
            employeesError: 'Failed to load employees'));
      }
    } catch (e) {
      emit(state.copyWith(
          employeesLoading: false, employeesError: e.toString()));
    }
  }

  void selectEmployee(Employee? employee) {
    emit(state.copyWith(selectedEmployee: employee));
  }

  Future<bool> submit() async {
    emit(state.copyWith(loading: true));
    try {
      final token = await getToken();
      if (token == null || state.selectedEmployee == null) {
        emit(state.copyWith(loading: false));
        return false;
      }
      // 1. Submit terms and conditions
      final termsUrl =
          Uri.parse('${APIKeys.baseUrl}/api/provider/terms-and-condition');
      final termsBody = json.encode({
        "employee": state.selectedEmployee!.Id,
        "responsibleEmployeeName": state.selectedEmployee!.fullName,
        "clauses": state.terms.map((t) => {"text": t}).toList(),
        "isFirstTime": true
      });
      final termsResp = await http.post(
        termsUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: termsBody,
      );
      if (termsResp.statusCode != 200 && termsResp.statusCode != 201) {
        emit(state.copyWith(loading: false));
        return false;
      }
      // 2. Submit working hours
      final workingTimeUrl =
          Uri.parse('${APIKeys.baseUrl}/api/provider/working-time');
      final start = state.startTime;
      final end = state.endTime;
      final workingDays = state.selectedDays
          .map((i) => {
                "day": daysOfWeek[i],
                "startHour": start?.hour ?? 0,
                "startMinute": start?.minute ?? 0,
                "endHour": end?.hour ?? 0,
                "endMinute": end?.minute ?? 0,
              })
          .toList();
      final workingTimeBody = json.encode({"workingDays": workingDays});
      final workingResp = await http.post(
        workingTimeUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: workingTimeBody,
      );
      emit(state.copyWith(loading: false));
      return workingResp.statusCode == 200 || workingResp.statusCode == 201;
    } catch (e) {
      emit(state.copyWith(loading: false));
      return false;
    }
  }

  Future<String?> getToken() async {
    return GetTokenUseCase(injector())();
  }

  @override
  Future<void> close() {
    contractSigningController.dispose();
    trainingController.dispose();
    addTermController.dispose();
    return super.close();
  }
}
