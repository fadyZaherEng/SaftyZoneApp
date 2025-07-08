import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/utils/constants.dart';
import 'package:safety_zone/generated/l10n.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double? height;
  final double? width;
  final double borderWidth;
  final double buttonBorderRadius;
  final FontWeight fontWeight;
  final TextStyle? textStyle;

  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
    this.textColor = ColorSchemes.white,
    this.height = 50,
    this.width = double.infinity,
    this.borderWidth = 1,
    this.borderColor = Colors.transparent,
    this.buttonBorderRadius = 8,
    this.fontWeight = Constants.fontWeightSemiBold,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius),
          ),
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor, width: borderWidth),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            text,
            style: textStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      fontSize: 13.sp,
                      fontWeight: fontWeight,
                    ),
          ),
        ),
      ),
    );
  }
}
