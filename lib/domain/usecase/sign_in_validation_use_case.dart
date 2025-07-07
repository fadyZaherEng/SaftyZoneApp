
import 'package:hatif_mobile/core/utils/validation/sign_in_validator.dart';

class SignInValidationUseCase {
  List<SignInValidationState> validateFormUseCase({
    required String email,
    required String password,
  }) {
    List<SignInValidationState> validations = List.empty(growable: true);
    SignInValidationState validation;
    validation = validateEmail(email.trim());
    if (validation != SignInValidationState.valid) {
      validations.add(validation);
    }
    validation = validatePassword(password.trim());
    if (validation != SignInValidationState.valid) {
      validations.add(
        validation,
      );
    }
    return validations;
  }

  SignInValidationState validateEmail(String email) {
    return SignInValidator.validateEmailAddress(email);
  }

  SignInValidationState validatePassword(String password) {
    return SignInValidator.validatePassword(password);
  }
}
