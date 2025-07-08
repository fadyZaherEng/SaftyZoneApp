import 'package:flutter/material.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/presentation/widgets/widget_themes/appbar_theme.dart';
import 'package:safety_zone/src/presentation/widgets/widget_themes/bottom_sheet_theme.dart';
import 'package:safety_zone/src/presentation/widgets/widget_themes/checkbox_theme.dart';
import 'package:safety_zone/src/presentation/widgets/widget_themes/chip_theme.dart';
import 'package:safety_zone/src/presentation/widgets/widget_themes/elevated_button_theme.dart';
import 'package:safety_zone/src/presentation/widgets/widget_themes/outlined_button_theme.dart';
import 'package:safety_zone/src/presentation/widgets/widget_themes/text_field_theme.dart';
import 'package:safety_zone/src/presentation/widgets/widget_themes/text_theme.dart';

class AppTheme {
  String language;

  AppTheme(this.language);

  ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      disabledColor: ColorSchemes.textGrey,
      brightness: Brightness.light,
      primaryColor: ColorSchemes.primary,
      textTheme: TTextTheme.lightTextTheme,
      chipTheme: TChipTheme.lightChipTheme,
      scaffoldBackgroundColor: ColorSchemes.light,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    );
  }

  ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      disabledColor: ColorSchemes.textGrey,
      brightness: Brightness.dark,
      primaryColor: ColorSchemes.primary,
      textTheme: TTextTheme.darkTextTheme,
      chipTheme: TChipTheme.darkChipTheme,
      scaffoldBackgroundColor: ColorSchemes.black,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    );
  }
}
