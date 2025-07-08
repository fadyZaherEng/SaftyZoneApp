import 'package:flutter/material.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: ColorSchemes.textGrey.withOpacity(0.4),
    labelStyle: const TextStyle(color: ColorSchemes.textDark),
    selectedColor: ColorSchemes.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: ColorSchemes.textLight,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: ColorSchemes.dark,
    labelStyle: TextStyle(color: ColorSchemes.textLight),
    selectedColor: ColorSchemes.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: ColorSchemes.textLight,
  );
}
