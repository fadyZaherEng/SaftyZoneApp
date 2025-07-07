import 'package:hatif_mobile/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetIsBoardingUseCase {
  final SharedPreferences sharedPreferences;

  const GetIsBoardingUseCase(this.sharedPreferences);

  bool call() {
    return sharedPreferences
            .getBool(SharedPreferenceKeys.isOnboardingComplete) ??
        false;
  }
}
