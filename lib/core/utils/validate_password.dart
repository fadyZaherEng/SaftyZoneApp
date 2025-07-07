import 'package:hatif_mobile/generated/l10n.dart';

String validatePassword(String password) {
  String unmetConditions = "";

  if (password.length < 8 || password.length > 16) {
    unmetConditions +=
    "• ${S.current
        .passwordLengthRequirement}\n"; // "Password must be 8-16 characters long."
  }
  if (!RegExp(r'(?=.*[a-z])').hasMatch(password)) {
    unmetConditions +=
    "• ${S.current.lowercaseRequirement}\n"; // "At least one lowercase letter."
  }
  if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
    unmetConditions +=
    "• ${S.current.uppercaseRequirement}\n"; // "At least one uppercase letter."
  }
  if (!RegExp(r'(?=.*\d)').hasMatch(password)) {
    unmetConditions +=
    "• ${S.current.digitRequirement}\n"; // "At least one digit."
  }
  if (!RegExp(r'(?=.*[!@#$%^&*_=+-])').hasMatch(password)) {
    unmetConditions +=
    "• ${S.current
        .specialCharacterRequirement}\n"; // "At least one special character (!@#$%^&*_=+-)."
  }

  return unmetConditions.trim(); // Trim to remove any trailing newline
}
