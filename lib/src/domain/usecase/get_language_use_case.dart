import 'dart:ui';
import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLanguageUseCase {
  final SharedPreferences sharedPreferences;

  GetLanguageUseCase(this.sharedPreferences);

  String call() {
    return sharedPreferences.getString(SharedPreferenceKeys.language) ??
        window.locale.languageCode;
  }
}
