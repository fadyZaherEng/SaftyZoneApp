 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  required Color color,
  String? icon,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (icon != null && icon.isNotEmpty)
            SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              color: ColorSchemes.white,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: ColorSchemes.white),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: color,
    ),
  );
}
