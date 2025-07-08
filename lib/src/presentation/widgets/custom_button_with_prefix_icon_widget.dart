 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/utils/constants.dart';

class CustomButtonWithPrefixIconWidget extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;
  final double? height;
  final double? width;
  final double borderWidth;
  final double buttonBorderRadius;
  final FontWeight fontWeight;
  final TextStyle? textStyle;
  final String svgIcon;

  const CustomButtonWithPrefixIconWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
    required this.svgIcon,
    this.textColor = ColorSchemes.white,
    this.iconColor = ColorSchemes.white,
    this.height = 40,
    this.width,
    this.borderWidth = 1,
    this.borderColor = Colors.transparent,
    this.buttonBorderRadius = 6,
    this.fontWeight = Constants.fontWeightSemiBold,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                  letterSpacing: 0.24,
                  fontWeight: fontWeight,
                ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgIcon,
              width: 16,
              height: 16,
              color: iconColor,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: textStyle ??
                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: textColor,
                        letterSpacing: 0.24,
                        fontWeight: fontWeight,
                      ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
