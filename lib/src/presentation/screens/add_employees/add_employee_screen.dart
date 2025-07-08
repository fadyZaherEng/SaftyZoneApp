import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'cubit/add_employee_cubit.dart';
import 'cubit/add_employee_state.dart';
import 'widgets/add_employee_basic_info.dart';
import 'widgets/add_employee_assign_role.dart';
import 'widgets/add_employee_review.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEmployeeCubit(injector()),
      child: BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFFF8F8F8),
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Header
                        _AddEmployeeHeader(),
                        // Title, subtitle, and icon
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 20.h,
                            bottom: 0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).createEmployeeProfile,
                                      style: TextStyle(
                                        color: const Color(0xFF333333),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                        fontFamily: 'SF Pro',
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      S.of(context).startAddingEmployee,
                                      style: TextStyle(
                                        color: const Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.sp,
                                        fontFamily: 'SF Pro',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12.w),
                              SvgPicture.asset(
                                ImagePaths.person,
                                width: 48.w,
                                height: 48.h,
                                color: const Color(0xFFA50000),
                              ),
                            ],
                          ),
                        ),
                        // Stepper and card in unified padding
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 12.h,
                                  ),
                                  child: _AddEmployeeStepper(step: state.step),
                                ),
                                // Step content
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: _buildStepContent(state.step),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepContent(AddEmployeeStep step) {
    switch (step) {
      case AddEmployeeStep.basicInfo:
        return const AddEmployeeBasicInfo();
      case AddEmployeeStep.assignRole:
        return const AddEmployeeAssignRole();
      case AddEmployeeStep.review:
        return const AddEmployeeReview();
    }
  }
}

class _AddEmployeeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      color: const Color(0xFFA50000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Center(
            child: Text(
              S.of(context).addEmployees,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                fontFamily: 'SF Pro',
              ),
            ),
          ),
          SizedBox.shrink(),
          SizedBox.shrink()
        ],
      ),
    );
  }
}

class _AddEmployeeStepper extends StatelessWidget {
  final AddEmployeeStep step;

  const _AddEmployeeStepper({required this.step});

  @override
  Widget build(BuildContext context) {
    final steps = [
      S.of(context).basicInformation,
      S.of(context).assignJobRole,
      S.of(context).reviewAndConfirm,
    ];
    return Container(
      height: 40.h,
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(steps.length, (i) {
          final isActive = i == step.index;
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  steps[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFFA50000)
                        : const Color(0xFF666666),
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13.sp,
                    fontFamily: 'SF Pro',
                  ),
                ),
                SizedBox(height: 4.h),
                if (isActive)
                  Container(
                    height: 3,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA50000),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                if (!isActive)
                  Container(
                    height: 3,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCCCCC),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
