import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatif_mobile/config/routes/routes_manager.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/usecase/set_isboarding_use_case.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import '../../../domain/entities/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  final List<OnboardingModel> _pages = OnboardingModel.onboardingPages;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPage() {
    if (_currentPage == _pages.length - 1) {
      _completeOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkip() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _completeOnboarding() {
    SetIsBoardingUseCase(injector())(true);
    Navigator.pushReplacementNamed(context, Routes.languageSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Pages
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) => OnboardingPageWidget(
              model: _pages[index],
              index: index,
            ),
          ),

          // Skip Button
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 16.h, right: 20.w),
                child: _currentPage < _pages.length - 1
                    ? TextButton(
                        onPressed: _onSkip,
                        child: Text(
                          S.of(context).skip,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorSchemes.black,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 70.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dots Indicator
                Row(
                  children: List.generate(_pages.length, (index) {
                    final isActive = _currentPage == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 10.h,
                      width: isActive ? 20.w : 10.w,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : Colors.grey[400],
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    );
                  }),
                ),

                // Next / Get Started Button
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: child,
                  ),
                  child: ElevatedButton(
                    key: ValueKey(_currentPage),
                    onPressed: _onNextPage,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 15.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? S.of(context).getStarted
                          : S.of(context).next,
                      style: TextStyle(fontSize: 16.sp),
                    ),
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

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingModel model;
  final int index;

  const OnboardingPageWidget({
    super.key,
    required this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Image.asset(
          model.image,
          fit: BoxFit.cover,
          height: 1.sh,
          width: 1.sw,
        ),

        // Gradient Overlay
        Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
        ),

        // Text Content
        Positioned(
          bottom: 160.h,
          left: 20.w,
          right: 20.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getTitle(context),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
              ),
              SizedBox(height: 10.h),
              Text(
                _getSubtitle(context),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                      fontSize: 16.sp,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getTitle(BuildContext context) {
    switch (index) {
      case 0:
        return S.of(context).welcomeTitle;
      case 1:
        return S.of(context).professionalTitle;
      case 2:
      default:
        return S.of(context).easyTitle;
    }
  }

  String _getSubtitle(BuildContext context) {
    switch (index) {
      case 0:
        return S.of(context).welcomeSubtitle;
      case 1:
        return S.of(context).professionalSubtitle;
      case 2:
      default:
        return S.of(context).easySubtitle;
    }
  }
}
