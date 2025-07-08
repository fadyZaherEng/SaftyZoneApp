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

    if (cleared) {
      await SetLanguageUseCase(injector())(languageValue);
    }
    return cleared;
  }
}
