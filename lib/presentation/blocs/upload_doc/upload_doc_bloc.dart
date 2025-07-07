import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hatif_mobile/core/resources/data_state.dart';
import 'package:hatif_mobile/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';
import 'package:hatif_mobile/domain/usecase/auth/generate_file_use_case.dart';
import 'package:hatif_mobile/domain/usecase/auth/generate_image_use_case.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

part 'upload_doc_event.dart';

part 'upload_doc_state.dart';

class UploadDocBloc extends Bloc<UploadDocEvent, UploadDocState> {
  final GenerateFileUrlUseCase _generateFileUrlUseCase;
  final GenerateImageUrlUseCase _generateImageUrlUseCase;

  UploadDocBloc(
    this._generateFileUrlUseCase,
    this._generateImageUrlUseCase,
  ) : super(UploadDocInitial()) {
    on<UploadDocumentEvent>(_onUploadDocumentEvent);
    on<DeleteDocEvent>(_onDeleteDocEvent);
    on<EditDocEvent>(_onEditDocEvent);
  }

  FutureOr<void> _onUploadDocumentEvent(
      UploadDocumentEvent event, Emitter<UploadDocState> emit) async {
    emit(UploadDocLoadingState());
    final result = await _generateImageUrlUseCase();
    if (result is DataSuccess<RemoteGenerateUrl>) {
      bool isSuccess = await _pickAndUploadImage(
        File(event.docPath),
        result.data?.first.presignedURL ?? '',
      );
      if (isSuccess) {
        emit(UploadDocSuccessState(url: result.data?.first.mediaUrl ?? ''));
      }else {
        emit(UploadDocErrorState(message: "Upload failed"));
      }
    }
  }

  Future<bool> _pickAndUploadImage(File pickedFile, String uploadUrl) async {
    try {
      final bytes = await pickedFile.readAsBytes();

      final response = await http.put(
        Uri.parse(uploadUrl),
        headers: {'Content-Type': 'text/plain'},
        body: bytes,
      );

      if (response.statusCode == 200) {
        debugPrint("✅ Upload success");
        return true;
      } else {
        debugPrint("❌ Upload failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("❌ Error: $e");
    }
    return false;
  }

  FutureOr<void> _onDeleteDocEvent(
      DeleteDocEvent event, Emitter<UploadDocState> emit) {
    emit(UploadDocInitial());
    emit(UploadDocDeleteSuccessState(url: event.docPath));
  }

  FutureOr<void> _onEditDocEvent(
      EditDocEvent event, Emitter<UploadDocState> emit) {}
}
