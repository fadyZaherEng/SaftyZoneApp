 import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetRememberMeUseCase {
  final SharedPreferences sharedPreferences;

  SetRememberMeUseCase(this.sharedPreferences);

  Future<bool> call(bool rememberMe) async {
    return await sharedPreferences.setBool(
      SharedPreferenceKeys.rememberMe,
      rememberMe,
    );
  }
}
