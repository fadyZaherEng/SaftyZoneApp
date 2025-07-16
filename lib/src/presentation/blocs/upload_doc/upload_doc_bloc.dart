import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/utils/upload_file_to_server.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_certificate_insatllation.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/request_certificate_installation.dart';
import 'package:safety_zone/src/domain/usecase/auth/generate_file_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/generate_image_use_case.dart';
import 'package:meta/meta.dart';

import 'package:flutter/material.dart';
import 'package:safety_zone/src/domain/usecase/home/certificate_installation_use_case.dart';

part 'upload_doc_event.dart';

part 'upload_doc_state.dart';

class UploadDocBloc extends Bloc<UploadDocEvent, UploadDocState> {
  final GenerateFileUrlUseCase _generateFileUrlUseCase;
  final GenerateImageUrlUseCase _generateImageUrlUseCase;
  final CertificateInstallationsUseCase _certificateInstallationsUseCase;

  UploadDocBloc(
    this._generateFileUrlUseCase,
    this._generateImageUrlUseCase,
    this._certificateInstallationsUseCase,
  ) : super(UploadDocInitial()) {
    on<UploadDocumentEvent>(_onUploadDocumentEvent);
    on<UploadDocumentAPiEvent>(_onUploadDocumentAPiEvent);
    on<DeleteDocEvent>(_onDeleteDocEvent);
    on<EditDocEvent>(_onEditDocEvent);
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
}
