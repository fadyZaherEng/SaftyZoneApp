import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/helpers/helper_functions.dart';
import 'package:safety_zone/generated/l10n.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: isDarkMode
              ? ColorSchemes.darkContainer
              : ColorSchemes.lightContainer,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  /// Logo
                  Hero(
                    tag: 'app_logo',
                    child: AnimatedScale(
                      scale: 1,
                      duration: const Duration(milliseconds: 500),
                      child: Image.asset(
                        ImagePaths.appLogo,
                        width: 0.65.sw,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  /// Register Button
                  _buildButton(
                    context: context,
                    label: S.of(context).registerAsNewVendor,
                    isPrimary: true,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.register);
                    },
                  ),

                  SizedBox(height: 16.h),

                  /// Login Button
                  _buildButton(
                    context: context,
                    label: S.of(context).login,
                    isPrimary: false,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                  ),

                  SizedBox(height: 24.h),

                  /// Contact Us
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.contactUs);
                    },
                    child: Text(
                      S.of(context).contactUs,
                      style: TextStyle(
                        color: ColorSchemes.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),

                  SizedBox(height: 48.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    final buttonStyle = isPrimary
        ? ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          )
        : OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          );

    final buttonChild = Text(
      label,
      style: TextStyle(fontSize: 16.sp),
    );

    return SizedBox(
      width: 1.sw,
      height: 52.h,
      child: isPrimary
          ? ElevatedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: buttonChild,
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: buttonChild,
            ),
    );
  }
}
