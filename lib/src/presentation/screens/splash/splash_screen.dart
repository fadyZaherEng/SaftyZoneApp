import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/core/utils/helpers/helper_functions.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/usecase/auth/check_auth_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_isboarding_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_remember_me_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'package:safety_zone/src/domain/usecase/getauthenticate_use_case.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
          color:
              dark ? ColorSchemes.darkContainer : ColorSchemes.lightContainer,
        ),
        child: Center(
          child: Hero(
            tag: 'app_logo',
            child: Image.asset(
              ImagePaths.appLogo,
              fit: BoxFit.fill,
              width: 0.65.sw,
            ),
          ),
        ),
      ),
    );
  }

  bool _isAuthenticated() {
    final token = GetTokenUseCase(injector())();
    final isAuth = GetIsAuthenticationUseCase(injector())();
    return token.isNotEmpty && isAuth;
  }

  void _navigateToLogin() async {
    DataState<CheckAuth> result = (await CheckAuthUseCase(injector())());
    Future.delayed(const Duration(seconds: 3), () {
      final isAuthenticated = GetIsAuthenticationUseCase(injector())();
      final isRememberMe = GetRememberMeUseCase(injector())();
      final isShowOnboarding = GetIsBoardingUseCase(injector())();

      if (isAuthenticated &&
          isRememberMe &&
          result.data?.status == RegisterStatus.Home_Page.name) {
        Navigator.pushReplacementNamed(context, Routes.main);
      } else if (_isAuthenticated()) {
        Navigator.pushReplacementNamed(context, Routes.completeInfo);
      } else if (isShowOnboarding) {
        Navigator.pushReplacementNamed(context, Routes.languageSelection);
      } else {
        Navigator.pushReplacementNamed(context, Routes.onboarding);
      }
    });
  }
}
