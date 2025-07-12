import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/usecase/auth/check_auth_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_authenticate_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/screens/add_employees/add_employee_screen.dart';

class CompleteInfoView extends StatefulWidget {
  const CompleteInfoView({super.key});

  @override
  State<CompleteInfoView> createState() => _CompleteInfoViewState();
}

class _CompleteInfoViewState extends State<CompleteInfoView> {
  // Track completion status for each item
  bool _installationFeesCompleted = false;
  bool _employeesCompleted = false;
  bool _termsCompleted = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAuthStatus();
  }

  Future<void> _fetchAuthStatus() async {
    setState(() {
      _isLoading = false;
    });

    final authResponse = await CheckAuthUseCase(injector())();

    if (authResponse != null) {
      final onboarding = authResponse.data?.onboarding;
      setState(() {
        _employeesCompleted = onboarding?.employees ?? false;
        _installationFeesCompleted = onboarding?.installationFess ?? false;
        _termsCompleted = onboarding?.termsAndConditions ?? false;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF8B0000),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            S.of(context).receiveRequests,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.all(12.w),
            constraints: BoxConstraints(minWidth: 44.w, minHeight: 44.w),
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF8B0000)))
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),

                      // Warning message
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0xFF222222),
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text: S.of(context).youCannot,
                            ),
                            TextSpan(
                              text: S.of(context).receiveRequestsHighlight,
                              style: const TextStyle(
                                color: Color(0xFF8B0000),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: S.of(context).untilCompleted,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // Tasks list
                      Expanded(
                        child: Column(
                          children: [
                            // Add installation fees
                            _buildTaskItem(
                              title: S.of(context).addInstallationFees,
                              iconPath: ImagePaths.installationFees,
                              isCompleted: _installationFeesCompleted,
                              onTap: () => _navigateToInstallationFees(),
                            ),

                            SizedBox(height: 24.h),

                            // Add employees
                            _buildTaskItem(
                              title: S.of(context).addEmployees,
                              iconPath: ImagePaths.addEmployees,
                              isCompleted: _employeesCompleted,
                              onTap: () => _handleEmployees(),
                            ),

                            SizedBox(height: 24.h),

                            // Terms and conditions
                            _buildTaskItem(
                              title: S.of(context).termsAndConditions,
                              iconPath: ImagePaths.termsAndConditions,
                              isCompleted: _termsCompleted,
                              onTap: () => _handleTermsAndConditions(),
                            ),
                          ],
                        ),
                      ),

                      // Complete button
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: _areAllTasksCompleted()
                              ? () => _completeInformation(context)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _areAllTasksCompleted()
                                ? const Color(0xFF8B0000)
                                : const Color(0xFFCCCCCC),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            S.of(context).completeInformation,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTaskItem({
    required String title,
    required String iconPath,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color:
                    isCompleted ? const Color(0xFF8B0000) : Colors.transparent,
                border: Border.all(
                  color: isCompleted
                      ? const Color(0xFF8B0000)
                      : const Color(0xFFCCCCCC),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: isCompleted
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.w,
                    )
                  : null,
            ),

            SizedBox(width: 16.w),

            // Task title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF222222),
                ),
              ),
            ),

            SizedBox(width: 16.w),

            // Icon with status indicator
            Stack(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 38.w,
                  height: 38.w,
                ),
                if (isCompleted)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 10.w,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToInstallationFees() async {
    Navigator.pushNamed(context, Routes.installationFees).then((value) {
      _fetchAuthStatus();
    });
  }

  void _handleEmployees() async {
    // Navigate to Add Employee screen (MVVM + Cubit)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddEmployeeScreen()),
    ).then((value) => _fetchAuthStatus());
  }

  void _handleTermsAndConditions() async {
    // Use AppRouter route for Terms and Conditions
    Navigator.pushNamed(context, Routes.termConditionsScreen)
        .then((result) => _fetchAuthStatus());
  }

  bool _areAllTasksCompleted() {
    return _installationFeesCompleted && _employeesCompleted && _termsCompleted;
  }

  void _completeInformation(context) async {
    // TODO: Handle completion of all information
    DataState<CheckAuth> authResponse = await CheckAuthUseCase(injector())();
    showSnackBar(
      context: context,
      message: S.of(context).informationCompletedSuccessfully,
      color: ColorSchemes.success,
      icon: ImagePaths.success,
    );

    if (authResponse is DataSuccess) {
      if (authResponse.data?.status == RegisterStatus.Pending.name) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.revisionScreen,
          (route) => false,
        );
      } else if (authResponse.data?.status == RegisterStatus.Home_Page.name) {
        await SetRememberMeUseCase(injector())(true);
        await SetAuthenticateUseCase(injector())(true);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.main,
          (route) => false,
        );
      } else {
        Navigator.pushNamed(
          context,
          Routes.completeInfo,
        );
      }
    }
  }
}
