import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/screens/welcome/welcome_screen.dart';
import '../../../../domain/entities/vendor_registration_model.dart';
import 'complete_information_view.dart';
import 'dart:math' as math;

class RegistrationSuccessView extends StatelessWidget {
  final VendorRegistrationModel vendorData;

  const RegistrationSuccessView({
    super.key,
    required this.vendorData,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorSchemes.primary,
          foregroundColor: Colors.white,
          title: Text(
            S.of(context).signup,
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WelcomeScreen(),
              ),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 1),

                  // Success animation
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Sparkle effects (simplified)
                        ...List.generate(8, (index) {
                          final angle = index * (3.14159 * 2 / 8);
                          return Positioned(
                            left: 60.w + 50.w * cos(angle),
                            top: 60.w + 50.w * sin(angle),
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16.sp,
                            ),
                          );
                        }),

                        // Check mark
                        Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 60.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Success message
                  Text(
                    S.of(context).registrationSuccessTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorSchemes.dark,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  Text(
                    S.of(context).registrationSuccessMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                    ),
                  ),

                  Spacer(flex: 1),

                  // Complete information button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CompleteInformationView(vendorData: vendorData),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorSchemes.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        S.of(context).completeInformation,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double cos(double value) => math.cos(value);

  double sin(double value) => math.sin(value);
}

// Import at the top
