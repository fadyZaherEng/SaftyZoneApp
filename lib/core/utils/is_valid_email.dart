bool isValidEmail(String email) {
  // Updated regex with length constraints
  final regex = RegExp(
    r'^[a-zA-Z0-9._-]{3,30}@[a-zA-Z0-9.-]{3,30}\.[a-zA-Z]{2,}$',
  );
  return regex.hasMatch(email);
}
