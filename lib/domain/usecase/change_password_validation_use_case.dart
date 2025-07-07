
import 'package:hatif_mobile/core/utils/validation/change_password_validator.dart';

class ChangePasswordValidationUseCase {
  List<ChangePasswordValidationState> validateFormUseCase({
    required String newPassword,
    required String oldPassword,
    required String confirmPassword,
  }) {
    List<ChangePasswordValidationState> validations =
        List.empty(growable: true);
    ChangePasswordValidationState validation;
    validation = validateOldPassword(oldPassword);
    if (validation != ChangePasswordValidationState.valid) {
      validations.add(validation);
    }
    validation = validateNewPassword(newPassword);
    if (validation != ChangePasswordValidationState.valid) {
      validations.add(
        validation,
      );
    }
    validation = validateConfirmPassword(newPassword, confirmPassword);
    if (validation != ChangePasswordValidationState.valid) {
      validations.add(
        validation,
      );
    }
    return validations;
  }

  ChangePasswordValidationState validateOldPassword(
    String oldPassword,
  ) {
    return ChangePasswordValidator.validateOldPassword(
      oldPassword,
    );
  }

  ChangePasswordValidationState validateNewPassword(
    String newPassword,
  ) {
    return ChangePasswordValidator.validateNewPassword(
      newPassword,
    );
  }

  ChangePasswordValidationState validateConfirmPassword(
    String newPassword,
    String confirmPassword,
  ) {
    return ChangePasswordValidator.validateConfirmPassword(
      newPassword,
      confirmPassword,
    );
  }
}
