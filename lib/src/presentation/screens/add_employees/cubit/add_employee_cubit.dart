import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/utils/upload_image_to_server.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/create_employee.dart';
import 'package:safety_zone/src/domain/usecase/auth/generate_image_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'add_employee_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final GenerateImageUrlUseCase _generateImageUrlUseCase;

  AddEmployeeCubit(
    this._generateImageUrlUseCase,
  ) : super(
          AddEmployeeState(
            step: AddEmployeeStep.basicInfo,
            employee: Employee(
              fullName: '',
              jobTitle: '',
              phoneNumber: '',
            ),
          ),
        );

  void updateBasicInfo({
    required String fullName,
    required String jobTitle,
    required String phoneNumber,
    String? photoPath,
  }) {
    final updated = state.employee.copyWith(
      fullName: fullName,
      jobTitle: jobTitle,
      phoneNumber: "+966$phoneNumber",
      photoPath: photoPath,
    );
    emit(
      state.copyWith(
        employee: updated,
        canGoNext: _validateBasicInfo(updated),
      ),
    );
  }

  void updatePhoto(String photoPath) async {
    DataState<List<RemoteGenerateUrl>> result = await _generateImageUrlUseCase();
    bool isSuccess = await uploadImageToServer(
      File(photoPath),
      result.data?.first.presignedURL ?? '',
    );
    if (isSuccess) {
      final updated = state.employee
          .copyWith(photoPath: result.data?.first.mediaUrl ?? photoPath);
      emit(state.copyWith(employee: updated));
    } else {
      emit(
        state.copyWith(
          employee: state.employee.copyWith(
            photoPath: photoPath,
          ),
        ),
      );
    }
  }

  void nextStep() {
    if (state.step == AddEmployeeStep.basicInfo &&
        _validateBasicInfo(state.employee)) {
      emit(state.copyWith(
          step: AddEmployeeStep.assignRole,
          canGoPrevious: true,
          canGoNext: false));
    } else if (state.step == AddEmployeeStep.assignRole) {
      emit(state.copyWith(step: AddEmployeeStep.review, canGoNext: false));
    }
  }

  void previousStep() {
    if (state.step == AddEmployeeStep.assignRole) {
      emit(
        state.copyWith(
          step: AddEmployeeStep.basicInfo,
          canGoPrevious: false,
          canGoNext: _validateBasicInfo(state.employee),
        ),
      );
    } else if (state.step == AddEmployeeStep.review) {
      emit(state.copyWith(
          step: AddEmployeeStep.assignRole,
          canGoPrevious: true,
          canGoNext: true));
    }
  }

  Future<void> updateRole({
    required String functionalTitle,
    required List<String> tasks,
    String? notes,
  }) async {
    final updated = state.employee.copyWith(
      functionalTitle: functionalTitle,
      tasks: tasks,
      notes: notes,
    );
    emit(state.copyWith(employee: updated, canGoNext: true));
  }

  Future<bool> checkIsFirstEmployee(String baseUrl) async {
    final url = Uri.parse(
        '$baseUrl/api/provider/employee/first-employee?limit=10&page=1');
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetTokenUseCase(injector())()}",
        },
      );
      debugPrint(
          "\n===== [AddEmployeeCubit] Check First Employee Response =====");
      debugPrint("Status: ${response.statusCode}");
      // debugPrint(const JsonEncoder.withIndent('  ')
      //     .convert(jsonDecode(response.body)));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['count'] ?? 0) == 0;
      }
    } catch (e, s) {
      debugPrint("\n===== [AddEmployeeCubit] Check First Employee Error =====");
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return false;
  }

  Future<void> saveEmployee({
    required bool isFirstEmployee,
    required String baseUrl,
  }) async {
    emit(state.copyWith(isLoading: true));
    final emp = state.employee;
    final endpoint = '$baseUrl/api/provider/employee/first-employee';
    final url = Uri.parse(endpoint);
    String? permission;
    if (emp.tasks.isNotEmpty) {
      permission = emp.tasks.first;
    }
    final data = {
      "fullName": emp.fullName,
      "phoneNumber": emp.phoneNumber,
      "permission": permission,
      "profileImage": emp.photoPath,
      "jobTitle": emp.jobTitle,
    };
    debugPrint("\n===== [AddEmployeeCubit] Sending employee data =====");
    debugPrint(const JsonEncoder.withIndent('  ').convert(data));
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetTokenUseCase(injector())()}",
        },
        body: jsonEncode(data),
      );
      debugPrint("\n===== [AddEmployeeCubit] Response =====");
      debugPrint("Status: ${response.statusCode}");
      debugPrint(const JsonEncoder.withIndent('  ')
          .convert(jsonDecode(response.body)));
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(state.copyWith(isLoading: false, isSaved: true));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e, s) {
      debugPrint("\n===== [AddEmployeeCubit] Error =====");
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(state.copyWith(isLoading: false));
    }
  }

  void reset() {
    emit(AddEmployeeState(
      step: AddEmployeeStep.basicInfo,
      employee: Employee(fullName: '', jobTitle: '', phoneNumber: ''),
    ));
  }

  bool _validateBasicInfo(Employee emp) {
    return emp.fullName.isNotEmpty &&
        emp.jobTitle.isNotEmpty &&
        emp.phoneNumber.length >= 8;
  }
}
