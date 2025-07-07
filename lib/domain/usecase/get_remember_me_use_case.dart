 import 'package:hatif_mobile/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetRememberMeUseCase {
  final SharedPreferences sharedPreferences;

  const GetRememberMeUseCase(this.sharedPreferences);

  bool call() {
    return sharedPreferences.getBool(SharedPreferenceKeys.rememberMe) ?? false;
  }
}
