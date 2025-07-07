import 'package:hatif_mobile/core/utils/is_valid_email.dart';

class SignInValidator {
  static SignInValidationState validateEmailAddress(String emailAddress) {
    if (emailAddress.isEmpty) {
      return SignInValidationState.emailEmpty;
    } else if (!isValidEmail(emailAddress)) {
      return SignInValidationState.emailFormatInvalid;
    } else {
      return SignInValidationState.valid;
    }
  }

  static SignInValidationState validatePassword(String password) {
    if (password.isEmpty) {
      return SignInValidationState.passwordEmpty;
    } else {
      return SignInValidationState.valid;
    }
  }
}

enum SignInValidationState {
  emailEmpty,
  emailFormatInvalid,
  passwordEmpty,
  valid,
}
