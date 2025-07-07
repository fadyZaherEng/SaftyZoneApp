import 'package:flutter/material.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/presentation/widgets/bottom_sheet_widget.dart';
import 'package:hatif_mobile/presentation/widgets/circular_icon.dart';
import '../../../generated/l10n.dart';

class UploadMediaWidget extends StatefulWidget {
  final Function() onTapCamera;
  final Function() onTapGallery;

  const UploadMediaWidget({
    super.key,
    required this.onTapCamera,
    required this.onTapGallery,
  });

  @override
  State<UploadMediaWidget> createState() => _UploadMediaWidgetState();
}

class _UploadMediaWidgetState extends State<UploadMediaWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      height: 270,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.onTapGallery,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularIcon(
                  boxShadows: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: ColorSchemes.white,
                      blurRadius: 24,
                      blurStyle: BlurStyle.normal,
                      spreadRadius: 5,
                    ),
                  ],
                  imagePath: ImagePaths.uploadMediaGallery,
                  backgroundColor: ColorSchemes.primary,
                  iconSize: 24,
                  iconColor: ColorSchemes.white,
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context).gallery,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 13,
                      letterSpacing: -0.24,
                      color: ColorSchemes.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 71,
          ),
          GestureDetector(
            onTap: widget.onTapCamera,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularIcon(
                  boxShadows: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: ColorSchemes.white,
                      blurRadius: 24,
                      blurStyle: BlurStyle.normal,
                      spreadRadius: 5,
                    ),
                  ],
                  imagePath: ImagePaths.cameraTwo,
                  backgroundColor: ColorSchemes.primary,
                  iconSize: 24,
                  iconColor: ColorSchemes.white,
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context).camera,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 13,
                        letterSpacing: -0.24,
                        color: ColorSchemes.black,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      titleLabel: S.of(context).uploadMedia,
    );
  }
}
