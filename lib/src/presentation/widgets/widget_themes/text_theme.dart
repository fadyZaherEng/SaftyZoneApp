import 'package:flutter/material.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';

/// Custom Class for Light & Dark Text Themes
class TTextTheme {
  TTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: ColorSchemes.textDark),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: ColorSchemes.textDark),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: ColorSchemes.textDark),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorSchemes.textDark),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: ColorSchemes.textDark),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: ColorSchemes.textDark),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.w500, color: ColorSchemes.textDark),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: ColorSchemes.textDark),
    bodySmall: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: ColorSchemes.textDark.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: ColorSchemes.textDark),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: ColorSchemes.textDark.withOpacity(0.5)),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: ColorSchemes.textLight),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: ColorSchemes.textLight),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: ColorSchemes.textLight),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorSchemes.textLight),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: ColorSchemes.textLight),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: ColorSchemes.textLight),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.w500, color: ColorSchemes.textLight),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: ColorSchemes.textLight),
    bodySmall: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: ColorSchemes.textLight.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: ColorSchemes.textLight),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: ColorSchemes.textLight.withOpacity(0.5)),
  );
}
