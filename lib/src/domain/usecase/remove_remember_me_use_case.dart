 import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveRememberMeUseCase {
  final SharedPreferences sharedPreferences;

  RemoveRememberMeUseCase(this.sharedPreferences);

  Future<bool> call() async {
    if (sharedPreferences.getBool(SharedPreferenceKeys.rememberMe) != null) {
      return await sharedPreferences.remove(SharedPreferenceKeys.rememberMe);
    } else {
      return false;
    }
  }
}
