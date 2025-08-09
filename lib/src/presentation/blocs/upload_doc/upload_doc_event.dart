part of 'upload_doc_bloc.dart';

@immutable
sealed class UploadDocEvent {}

final class EditDocEvent extends UploadDocEvent {
  final String docPath;

  EditDocEvent({
    required this.docPath,
  });
}

final class UploadDocumentEvent extends UploadDocEvent {
  final String docPath;

  UploadDocumentEvent({
    required this.docPath,
   });
}

final class UploadDocumentAPiEvent extends UploadDocEvent {
   final RequestCertificateInstallation request;

   UploadDocumentAPiEvent({
     required this.request,
  });
}

final class DeleteDocEvent extends UploadDocEvent {
  final String docPath;

  DeleteDocEvent({
    required this.docPath,
  });
}
