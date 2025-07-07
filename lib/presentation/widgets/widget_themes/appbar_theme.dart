import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/utils/sizes.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: ColorSchemes.white,
      size: TSizes.iconMd,
    ),
    actionsIconTheme: IconThemeData(
      color: ColorSchemes.textDark,
      size: TSizes.iconMd,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: ColorSchemes.textLight,
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: ColorSchemes.textLight,
      size: TSizes.iconMd,
    ),
    actionsIconTheme: IconThemeData(
      color: ColorSchemes.textLight,
      size: TSizes.iconMd,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: ColorSchemes.textDark,
    ),
  );
}
