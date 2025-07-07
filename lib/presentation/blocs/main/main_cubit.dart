import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatif_mobile/domain/usecase/get_language_use_case.dart';
import 'package:hatif_mobile/domain/usecase/set_language_use_case.dart';

class MainCubit extends Cubit<Locale> {
  final GetLanguageUseCase _getLanguageUseCase;
  final SetLanguageUseCase _setLanguageUseCase;

  MainCubit(
    this._getLanguageUseCase,
    this._setLanguageUseCase,
  ) : super(Locale(window.locale.languageCode)) {
    getLanguage();
  }

  void getLanguage() async {
    final language = _getLanguageUseCase();
    await _setLanguageUseCase(language);
    emit(Locale(language));
  }
  void changeLanguage(String languageCode) async {
    await _setLanguageUseCase(languageCode);
    emit(Locale(languageCode));
  }
}
