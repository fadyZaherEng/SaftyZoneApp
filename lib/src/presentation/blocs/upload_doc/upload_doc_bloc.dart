import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/utils/upload_file_to_server.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_certificate_insatllation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';
 import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/request_certificate_installation.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/usecase/auth/generate_file_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/generate_image_use_case.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:safety_zone/src/domain/entities/auth/create_employee.dart'
    as employee;

import 'package:flutter/material.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/certificate_installation_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/first_screen_shedule_use_case.dart';

part 'upload_doc_event.dart';

part 'upload_doc_state.dart';

class UploadDocBloc extends Bloc<UploadDocEvent, UploadDocState> {
  final GenerateFileUrlUseCase _generateFileUrlUseCase;
  final GenerateImageUrlUseCase _generateImageUrlUseCase;
  final CertificateInstallationsUseCase _certificateInstallationsUseCase;
  final FirstScreenScheduleUseCase _getScheduleJopDetailsDetailsUseCase;

  UploadDocBloc(
    this._generateFileUrlUseCase,
    this._generateImageUrlUseCase,
    this._certificateInstallationsUseCase,
    this._getScheduleJopDetailsDetailsUseCase,
  ) : super(UploadDocInitial()) {
    on<UploadDocumentEvent>(_onUploadDocumentEvent);
    on<UploadDocumentAPiEvent>(_onUploadDocumentAPiEvent);
    on<DeleteDocEvent>(_onDeleteDocEvent);
    on<GetEmployeesEvent>(_onGetEmployeesEvent);
    on<EditDocEvent>(_onEditDocEvent);
    on<GetScheduleJopDetailsEvent>(_onGetConsumerRequestsDetailsEvent);
  }

  FutureOr<void> _onGetEmployeesEvent(
      GetEmployeesEvent event, Emitter<UploadDocState> emit) async {
    // try {
    final url = Uri.parse(
        '${APIKeys.baseUrl}/api/provider/employee/permission/Contract Signing?page=1&limit=10');
    final token = GetTokenUseCase(injector())();
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print('Fetching employees from: ${response.body}');
    print('response.statusCode: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      final List<employee.Employee> employees = (data['result'] as List)
          .map((e) => employee.Employee.fromJsonTerms(e))
          .toList();
      emit(GetEmployeesSuccessState(employees));
    } else {
      emit(GetEmployeesErrorState('Failed to load employees'));
    }
    // } catch (e) {
    //   emit(GetEmployeesErrorState(e.toString()));
    // }
  }

  FutureOr<void> _onUploadDocumentEvent(
      UploadDocumentEvent event, Emitter<UploadDocState> emit) async {
    emit(UploadDocLoadingState());
    final result = await _generateFileUrlUseCase();
    debugPrint("result: $result");
    if (result is DataSuccess<List<RemoteGenerateUrl>>) {
      debugPrint("url: ${result.data?.first.presignedURL}");
      bool isSuccess = await uploadFileToServer(
        File(event.docPath),
        result.data?.first.presignedURL ?? '',
      );
      if (isSuccess) {
        emit(UploadDocSuccessState(
          url: result.data?.first.mediaUrl ?? '',
        ));
      } else {
        emit(UploadDocErrorState(message: "Upload failed"));
      }
    } else {
      emit(UploadDocErrorState(message: "Upload failed"));
    }
  }

  FutureOr<void> _onDeleteDocEvent(
      DeleteDocEvent event, Emitter<UploadDocState> emit) {
    emit(UploadDocDeleteSuccessState(url: event.docPath));
  }

  FutureOr<void> _onEditDocEvent(
      EditDocEvent event, Emitter<UploadDocState> emit) {}

  FutureOr<void> _onUploadDocumentAPiEvent(
      UploadDocumentAPiEvent event, Emitter<UploadDocState> emit) async {
    final resultUpload = await _certificateInstallationsUseCase(
      request: event.request,
    );
    if (resultUpload is DataFailed) {
      emit(UploadDocErrorState(message: resultUpload.message ?? ''));
      return;
    }
    emit(UploadDocApiSuccessState(
      remoteCertificateInsatllation:
          resultUpload.data ?? RemoteCertificateInsatllation(),
    ));
  }

  FutureOr<void> _onGetConsumerRequestsDetailsEvent(
      GetScheduleJopDetailsEvent event, Emitter<UploadDocState> emit) async {
    // emit(GetScheduleJopDetailsLoadingState());
    final result = await _getScheduleJopDetailsDetailsUseCase(
      id: event.requestId,
    );
    if (result is DataSuccess<RemoteFirstScreenSchedule>) {
      emit(GetScheduleJopDetailsSuccessState(
          request: result?.data ?? RemoteFirstScreenSchedule()));
    } else {
      emit(GetScheduleJopDetailsErrorState(message: result.message ?? ''));
    }
  }
}
