 import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetIsAuthenticationUseCase {
  final SharedPreferences sharedPreferences;

  const GetIsAuthenticationUseCase(this.sharedPreferences);

  bool call() {
    return sharedPreferences.getBool(SharedPreferenceKeys.isAuthenticated) ?? false;
  }
}
