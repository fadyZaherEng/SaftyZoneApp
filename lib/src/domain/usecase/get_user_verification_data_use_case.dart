import 'dart:convert';

import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:safety_zone/src/domain/entities/auth/verify_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserVerificationDataUseCase {
  final SharedPreferences sharedPreferences;

  const GetUserVerificationDataUseCase(this.sharedPreferences);

  Future<VerifyOtp?> call() async {
    final data = sharedPreferences.getString(SharedPreferenceKeys.userData);
    if (data != null) {
      return VerifyOtp.fromJson(jsonDecode(data));
    }
    return null;
  }
}
