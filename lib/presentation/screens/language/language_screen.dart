import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatif_mobile/config/routes/routes_manager.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/core/utils/helpers/helper_functions.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/usecase/get_isboarding_use_case.dart';
import 'package:hatif_mobile/domain/usecase/set_language_use_case.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/blocs/main/main_cubit.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color:
            darkMode ? ColorSchemes.darkContainer : ColorSchemes.lightContainer,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                const Spacer(),

                /// App Logo
                Center(
                  child: Hero(
                    tag: 'app_logo',
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 500),
                      scale: 1.0,
                      child: Image.asset(
                        ImagePaths.appLogo,
                        width: 0.65.sw,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                /// Title
                Text(
                  S.of(context).selectLanguage,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 32.h),

                /// English Button
                _buildLanguageButton(
                  context,
                  label: 'English',
                  onPressed: () => _selectLanguage(context, 'en'),
                  isPrimary: true,
                ),

                SizedBox(height: 16.h),

                /// Arabic Button
                _buildLanguageButton(
                  context,
                  label: 'العربية',
                  onPressed: () => _selectLanguage(context, 'ar'),
                  isPrimary: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    final ButtonStyle style = isPrimary
        ? ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          )
        : OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          );

    return SizedBox(
      width: 1.sw,
      height: 52.h,
      child: isPrimary
          ? ElevatedButton(
              onPressed: onPressed,
              style: style,
              child: Text(
                label,
                style: TextStyle(fontSize: 16.sp),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: style,
              child: Text(
                label,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
    );
  }

  void _selectLanguage(BuildContext context, String languageCode) {
    // Save language
    SetLanguageUseCase(injector())(languageCode);

    // Update app locale
    context.read<MainCubit>().changeLanguage(languageCode);

    // Determine next screen
    final isOnboardingComplete = GetIsBoardingUseCase(injector())();

    Navigator.pushNamed(
      context,
      isOnboardingComplete == true ? Routes.welcome : Routes.onboarding,
    );
  }
}
