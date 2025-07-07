import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
 import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/widgets/custom_button_widget.dart';

class NoInternetWidget extends StatelessWidget {
  final Function() onTapTryAgain;

  const NoInternetWidget({required this.onTapTryAgain, super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorSchemes.searchBackground,
                offset: const Offset(0, 0),
                blurRadius: 15,
              ),
            ],
            color: ColorSchemes.white,
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImagePaths.noInternet,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
                color: ColorSchemes.primary,
                colorFilter: ColorFilter.mode(
                  ColorSchemes.primary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).opps,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: ColorSchemes.black),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  S.of(context).noInternetConnectionFoundCheckYourConnection,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: ColorSchemes.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              CustomButtonWidget(
                text: S.of(context).tryAgain,
                onTap: () {
                  onTapTryAgain();
                },
                backgroundColor: ColorSchemes.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
