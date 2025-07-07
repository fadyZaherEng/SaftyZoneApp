
import 'package:hatif_mobile/core/utils/validate_password.dart';

class ChangePasswordValidator {
  static ChangePasswordValidationState validateOldPassword(String oldPassword) {
    if (oldPassword.isEmpty) {
      return ChangePasswordValidationState.oldPasswordEmpty;
    } else if (validatePassword(oldPassword).isNotEmpty) {
      return ChangePasswordValidationState.oldPasswordNotValid;
    } else {
      return ChangePasswordValidationState.valid;
    }
  }

  static ChangePasswordValidationState validateNewPassword(String newPassword) {
    if (newPassword.isEmpty) {
      return ChangePasswordValidationState.newPasswordEmpty;
    } else if (validatePassword(newPassword).isNotEmpty) {
      return ChangePasswordValidationState.newPasswordNotValid;
    } else {
      return ChangePasswordValidationState.valid;
    }
  }

  static ChangePasswordValidationState validateConfirmPassword(
      String newPassword, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return ChangePasswordValidationState.confirmPasswordEmpty;
    } else if (validatePassword(confirmPassword).isNotEmpty) {
      return ChangePasswordValidationState.confirmPasswordNotValid;
    } else if (newPassword != confirmPassword) {
      return ChangePasswordValidationState.confirmPasswordNotMatchNewPassword;
    } else {
      return ChangePasswordValidationState.valid;
    }
  }
}

enum ChangePasswordValidationState {
  oldPasswordEmpty,
  oldPasswordNotValid,
  newPasswordEmpty,
  newPasswordMustBeSixCharacter,
  newPasswordNotValid,
  confirmPasswordNotValid,
  confirmPasswordEmpty,
  confirmPasswordNotMatchNewPassword,
  valid,
}
