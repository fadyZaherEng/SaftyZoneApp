import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularIcon extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadows;
  final double iconSize;
  final Color borderColor;
  final double borderWidth;
  final bool isNetworkImage;
  final Color? iconColor;

  const CircularIcon({
    super.key,
    required this.imagePath,
    required this.backgroundColor,
    this.boxShadows,
    required this.iconSize,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.isNetworkImage = false,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: boxShadows,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: isNetworkImage
          ? SvgPicture.network(
              imagePath,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.scaleDown,
              color: iconColor,
            )
          : SvgPicture.asset(
              imagePath,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.scaleDown,
              color: iconColor,
            ),
    );
  }
}
