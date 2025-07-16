part of 'upload_doc_bloc.dart';

@immutable
sealed class UploadDocState {}

final class UploadDocInitial extends UploadDocState {}

final class UploadDocLoadingState extends UploadDocState {}

final class UploadDocSuccessState extends UploadDocState {
  final String url;

  UploadDocSuccessState({
    required this.url,
   });
}

final class UploadDocApiSuccessState extends UploadDocState {
  final RemoteCertificateInsatllation remoteCertificateInsatllation;

  UploadDocApiSuccessState({
    required this.remoteCertificateInsatllation,
  });
}

final class UploadDocErrorState extends UploadDocState {
  final String message;

  UploadDocErrorState({required this.message});
}

//delete
final class UploadDocDeleteLoadingState extends UploadDocState {}

final class UploadDocDeleteSuccessState extends UploadDocState {
  final String url;

  UploadDocDeleteSuccessState({required this.url});
}

final class UploadDocDeleteErrorState extends UploadDocState {
  final String message;

  UploadDocDeleteErrorState({required this.message});
}

//update
final class UploadDocUpdateLoadingState extends UploadDocState {}

final class UploadDocUpdateSuccessState extends UploadDocState {
  final String url;

  UploadDocUpdateSuccessState({required this.url});
}


final class UploadDocUpdateErrorState extends UploadDocState {
  final String message;

  UploadDocUpdateErrorState({required this.message});
}
