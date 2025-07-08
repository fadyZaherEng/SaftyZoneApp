import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetFirebaseNotificationTokenUseCase {
  final SharedPreferences sharedPreferences;

  GetFirebaseNotificationTokenUseCase(this.sharedPreferences);

  String call() {
    return sharedPreferences.getString(SharedPreferenceKeys.firebaseToken) ?? '';
  }
}
