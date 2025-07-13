import 'dart:convert';

import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:safety_zone/src/domain/entities/auth/verify_otp.dart';
import 'package:safety_zone/src/domain/entities/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUserLoginDataUseCase {
  final SharedPreferences sharedPreferences;

  const SetUserLoginDataUseCase(this.sharedPreferences);

  Future<bool> call(Login login) async {
    final userDataString = jsonEncode(login.toJson());

    return await sharedPreferences.setString(
      SharedPreferenceKeys.userLogin,
      userDataString,
    );
  }
}
