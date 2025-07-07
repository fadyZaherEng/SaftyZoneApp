import 'package:flutter/material.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';

extension HexColorExtension on String {
  Color toColor() {
    String hex = replaceAll('#', '').toUpperCase();

    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    try {
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return ColorSchemes.primary;
    }
  }
}
