import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/generated/l10n.dart';

class BottomSheetWidget extends StatelessWidget {
  final Widget content;
  final String titleLabel;
  final double height;
  final bool isTitleVisible;
  final bool isTitleImage;
  final Widget? imageWidget;
  final bool isReset;
  final void Function()? onReset;
  final bool isPadding;

  const BottomSheetWidget({
    super.key,
    required this.content,
    required this.titleLabel,
    this.height = 382,
    this.isTitleVisible = true,
    this.isTitleImage = false,
    this.imageWidget,
    this.isReset = false,
    this.onReset,
    this.isPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: ColorSchemes.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: 62,
              color: ColorSchemes.primary,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: 4,
                        width: 59,
                        decoration: BoxDecoration(
                          color: ColorSchemes.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isTitleVisible,
                          child: Text(
                            titleLabel,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorSchemes.white,
                                      letterSpacing: -0.24,
                                    ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        if (isReset)
                          InkWell(
                            onTap: onReset,
                            child: Text(
                              "S.of(context).reset",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 13,
                                    color: ColorSchemes.redError,
                                    letterSpacing: -0.24,
                                  ),
                            ),
                          ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            ImagePaths.close,
                            height: 20,
                            width: 20,
                            color: ColorSchemes.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isTitleVisible,
              child: const SizedBox(height: 0),
            ),
            Expanded(
              child: isPadding
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),
                      child: content,
                    )
                  : content,
            ),
          ],
        ),
      ),
    );
  }
}
