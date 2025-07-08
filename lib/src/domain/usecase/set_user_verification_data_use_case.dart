import 'dart:convert';

import 'package:safety_zone/src/core/resources/shared_preferences_keys.dart';
import 'package:safety_zone/src/domain/entities/auth/verify_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUserVerificationDataUseCase {
  final SharedPreferences sharedPreferences;

  const SetUserVerificationDataUseCase(this.sharedPreferences);

  Future<bool> call(VerifyOtp verifyOtp) async {
    final userDataString = jsonEncode(verifyOtp.toJson());

    return await sharedPreferences.setString(
      SharedPreferenceKeys.userData,
      userDataString,
    );
  }
}
