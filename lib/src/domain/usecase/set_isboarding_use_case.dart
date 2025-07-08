import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetIsBoardingUseCase {
  final SharedPreferences sharedPreferences;

  const SetIsBoardingUseCase(this.sharedPreferences);

  Future<bool> call(bool isOnboardingComplete) async {
    return await sharedPreferences.setBool(
        SharedPreferenceKeys.isOnboardingComplete, isOnboardingComplete);
  }
}
