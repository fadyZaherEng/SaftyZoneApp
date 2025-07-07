 import 'package:hatif_mobile/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetThemeUseCase {
  final SharedPreferences sharedPreferences;

  const GetThemeUseCase(this.sharedPreferences);

  bool call() {
    return sharedPreferences.getBool(SharedPreferenceKeys.isDark) ?? false;
  }
}
