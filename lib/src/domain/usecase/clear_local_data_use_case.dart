import 'package:safety_zone/src/di/injector.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_language_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClearLocalDataUseCase {
  final SharedPreferences sharedPreferences;

  ClearLocalDataUseCase(this.sharedPreferences);

  Future<bool> call() async {
    final languageValue = GetLanguageUseCase(injector())();
    bool cleared = await sharedPreferences.clear();
    try {
      // Clear the SharedPreferences
      cleared = await sharedPreferences.clear();
      SharedPreferences prefs = injector<SharedPreferences>();
      // Clear specific keys if needed
      await prefs.remove('remember_me');
      await prefs.remove('auth_token');
      await prefs.remove('token');
      await prefs.remove('employee_details');
      await prefs.remove('reports');
      await prefs.remove('language');
      await prefs.remove('is_dark_mode');
      await prefs.clear();
    } catch (e) {
      cleared = false;
    }

    if (cleared) {
      await SetLanguageUseCase(injector())(languageValue);
    }
    return cleared;
  }
}
