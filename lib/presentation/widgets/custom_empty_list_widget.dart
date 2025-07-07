import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hatif_mobile/config/theme/color_schemes.dart';

class CustomEmptyListWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final Function()? onRefresh;
  final bool isRefreshable;
  final bool isPng;

  const CustomEmptyListWidget({
    required this.imagePath,
    required this.text,
    this.isRefreshable = true,
    this.isPng = false,
    this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isPng)
            SvgPicture.asset(
              imagePath,
              width: 120,
              height: 120,
              fit: BoxFit.fill,
              // color: ColorSchemes.primary,
              matchTextDirection: true,
            ),
          if (isPng)
            Image.asset(
              imagePath,
              width: 120,
              height: 120,
              fit: BoxFit.fill,
              matchTextDirection: true,
            ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorSchemes.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 16),
                if (isRefreshable)
                  InkWell(
                    onTap: onRefresh,
                    child: const Icon(
                      Icons.refresh,
                      color: ColorSchemes.primary,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
