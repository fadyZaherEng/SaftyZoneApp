import 'package:flutter/material.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/utils/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: ColorSchemes.textLight,
      backgroundColor: ColorSchemes.primary,
      disabledForegroundColor: ColorSchemes.textGrey,
      disabledBackgroundColor: ColorSchemes.textGrey.withOpacity(0.3),
      side: const BorderSide(color: ColorSchemes.primary),
      padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16, color: ColorSchemes.textLight, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: ColorSchemes.textLight,
      backgroundColor: ColorSchemes.primary,
      disabledForegroundColor: ColorSchemes.textGrey,
      disabledBackgroundColor: ColorSchemes.dark,
      side: const BorderSide(color: ColorSchemes.primary),
      padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16, color: ColorSchemes.textLight, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),
  );
}
