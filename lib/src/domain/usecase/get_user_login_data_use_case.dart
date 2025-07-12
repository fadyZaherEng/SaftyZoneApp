import 'dart:convert';

import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:safety_zone/src/domain/entities/auth/verify_otp.dart';
import 'package:safety_zone/src/domain/entities/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserLoginDataUseCase {
  final SharedPreferences sharedPreferences;

  const GetUserLoginDataUseCase(this.sharedPreferences);

  Future<Login?> call() async {
    final data = sharedPreferences.getString(SharedPreferenceKeys.userLogin);
    if (data != null) {
      return Login.fromJson(jsonDecode(data));
    }
    return null;
  }
}
