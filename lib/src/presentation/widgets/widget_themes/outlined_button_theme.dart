import 'package:flutter/material.dart';

import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/utils/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ColorSchemes.textDark,
      side: const BorderSide(color: ColorSchemes.primary),
      textStyle: const TextStyle(
          fontSize: 16, color: ColorSchemes.textDark, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: TSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColorSchemes.textLight,
      side: const BorderSide(color: ColorSchemes.primary),
      textStyle: const TextStyle(
          fontSize: 16, color: ColorSchemes.textLight, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: TSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),
  );
}
