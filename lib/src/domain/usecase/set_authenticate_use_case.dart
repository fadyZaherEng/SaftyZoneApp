import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetAuthenticateUseCase {
  final SharedPreferences sharedPreferences;

  SetAuthenticateUseCase(this.sharedPreferences);

  Future<bool> call(bool authenticate) async {
    return await sharedPreferences.setBool(
      SharedPreferenceKeys.isAuthenticated,
      authenticate,
    );
  }
}
