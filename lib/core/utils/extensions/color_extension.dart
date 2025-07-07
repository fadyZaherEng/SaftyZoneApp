import 'package:hatif_mobile/config/theme/color_schemes.dart';
 import 'package:flutter/material.dart';

extension ColorExtension on String {
  Color toColor() {
    if (isEmpty) return ColorSchemes.primary;
    return Color(int.parse(replaceAll("#", "ff"), radix: 16) | 0xFF000000);
  }
}
