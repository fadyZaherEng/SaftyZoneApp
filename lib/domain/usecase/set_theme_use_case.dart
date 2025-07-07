import 'package:hatif_mobile/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetThemeUseCase {
  final SharedPreferences sharedPreferences;

  const SetThemeUseCase(this.sharedPreferences);

  Future<bool> call(bool isDark) async {
    return await sharedPreferences.setBool(SharedPreferenceKeys.isDark, isDark);
  }
}
