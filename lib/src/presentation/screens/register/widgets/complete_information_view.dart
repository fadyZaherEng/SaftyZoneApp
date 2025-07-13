import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/entities/vendor_registration_model.dart';
import 'package:safety_zone/src/domain/usecase/auth/check_auth_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/screens/add_employees/add_employee_screen.dart';
import 'package:safety_zone/src/presentation/screens/welcome/welcome_screen.dart';

class CompleteInformationView extends StatefulWidget {
  final VendorRegistrationModel vendorData;

  const CompleteInformationView({
    super.key,
    required this.vendorData,
  });

  @override
  State<CompleteInformationView> createState() =>
      _CompleteInformationViewState();
}

class _CompleteInformationViewState extends State<CompleteInformationView> {
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  // Onboarding status
  bool _installationFeesAdded = false;
  bool _employeesAdded = false;
  bool _termsAccepted = false;

  // Company data

  @override
  void initState() {
    super.initState();
    // Use Future.microtask to avoid calling provider during build
    Future.microtask(() => _fetchOnboardingStatus());
  }

  @override
  void didUpdateWidget(CompleteInformationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Use Future.microtask to avoid calling provider during build
    Future.microtask(() => _fetchOnboardingStatus());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Use Future.microtask to avoid calling provider during build
    Future.microtask(() => _fetchOnboardingStatus());
  }

  Future<void> _fetchOnboardingStatus() async {
    // Get provider instance outside of build method

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      DataState<CheckAuth> result = await CheckAuthUseCase(injector())();

      if (!mounted) return;

      if (result is DataSuccess) {
        final onboarding = result.data?.onboarding;

        setState(() {
          _isLoading = false;
          _installationFeesAdded = onboarding?.installationFess ?? false;
          _employeesAdded = onboarding?.employees ?? false;
          _termsAccepted = onboarding?.termsAndConditions ?? false;
        });
      } else {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = result.message ?? 'Failed to load data';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF990000),
          foregroundColor: Colors.white,
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => WelcomeScreen()),
            ),
          ),
        ),
        body: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF990000)))
              : _hasError
                  ? _buildErrorView()
                  : _buildContentView(),
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Color(0xFF990000),
              size: 64,
            ),
            SizedBox(height: 16.h),
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _fetchOnboardingStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF990000),
                foregroundColor: Colors.white,
              ),
              child: Text(
                S.of(context).retry,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentView() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Warning message with partial bold red text
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: S.of(context).youCannot),
                TextSpan(
                  text: S.of(context).receiveRequestsHighlight,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF990000),
                  ),
                ),
                TextSpan(text: S.of(context).untilCompleted),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Checklist items from API
          _buildChecklistItemCard(
            context: context,
            title: S.of(context).addInstallationFees,
            isCompleted: _installationFeesAdded,
            svgIconPath: ImagePaths.installationFees,
            iconBackground: Colors.blue.shade50,
            iconColor: Colors.red,
            onTap: ()async {
              // Navigate to installation fees page
              print('Navigating to installation fees page');
             await Navigator.pushNamed(
                context,
                Routes.installationFees,
              ).then((value) {
                _fetchOnboardingStatus();
              });
            },
          ),

          SizedBox(height: 16.h),

          _buildChecklistItemCard(
            context: context,
            title: S.of(context).addEmployees,
            isCompleted: _employeesAdded,
            svgIconPath: ImagePaths.addEmployees,
            iconBackground: Colors.red.shade50,
            iconColor: Colors.red,
            onTap: () {
              // Navigate to employees page
              _handleEmployees();
            },
          ),

          SizedBox(height: 16.h),

          _buildChecklistItemCard(
            context: context,
            title: S.of(context).termsAndConditions,
            isCompleted: _termsAccepted,
            svgIconPath: ImagePaths.termsAndConditions,
            iconBackground: Colors.green.shade50,
            iconColor: Colors.green,
            onTap: () {
              // Navigate to terms and conditions
              _handleTermsAndConditions();
            },
          ),

          const Spacer(),

          // Complete information button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.installationFees,
                  arguments: widget.vendorData,
                ).then((value) => _fetchOnboardingStatus());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF990000),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 0,
              ),
              child: Text(
                S.of(context).completeInformation,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItemCard({
    required BuildContext context,
    required String title,
    required bool isCompleted,
    required String svgIconPath,
    required Color iconBackground,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Checkbox
              SizedBox(
                width: 24.w,
                height: 24.h,
                child: Checkbox(
                  value: isCompleted,
                  onChanged: null, // Read-only
                  activeColor: const Color(0xFF990000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // Label
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // SVG Icon
              Center(
                child: SvgPicture.asset(
                  svgIconPath,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleEmployees() {
    // Navigate to Add Employee screen (MVVM + Cubit)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddEmployeeScreen()),
    ).then((value) => _fetchOnboardingStatus());
  }

  void _handleTermsAndConditions() {
    Navigator.pushNamed(context, Routes.termConditionsScreen)
        .then((value) => _fetchOnboardingStatus());
  }
}
