 import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetTokenUseCase {
  final SharedPreferences sharedPreferences;

  SetTokenUseCase(this.sharedPreferences);

  Future<bool> call(String token) async {
    return await sharedPreferences.setString(SharedPreferenceKeys.token, token);
  }
}
