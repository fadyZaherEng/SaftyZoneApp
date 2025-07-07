String englishNumbers(String input) {
  Map<String, String> arabicToEnglish = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
  };

  String output = '';

  for (int i = 0; i < input.length; i++) {
    String char = input[i];
    if (arabicToEnglish.containsKey(char)) {
      output += arabicToEnglish[char]!;
    } else {
      output += char;
    }
  }

  return output;
}
