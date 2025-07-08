import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SveFirebaseNotificationTokenUseCase {
  final SharedPreferences sharedPreferences;

  SveFirebaseNotificationTokenUseCase(this.sharedPreferences);

  Future<bool> call({required String token}) async {
    return await sharedPreferences.setString(
        SharedPreferenceKeys.firebaseToken, token);
  }
}
