import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/core/utils/show_snack_bar.dart';
import 'package:hatif_mobile/domain/entities/auth/create_employee.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/screens/term_conditions/cubit/terms_and_conditions_cubit.dart';

class TermConditionsScreen extends StatefulWidget {
  const TermConditionsScreen({super.key});

  @override
  State<TermConditionsScreen> createState() => _TermConditionsScreenState();
}

class _TermConditionsScreenState extends State<TermConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TermsAndConditionsCubit()..fetchEmployees(),
      child: BlocBuilder<TermsAndConditionsCubit, TermsAndConditionsState>(
         builder: (context, state) {
          final cubit = context.read<TermsAndConditionsCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorSchemes.red,
              centerTitle: true,
              title: Text(
                S.of(context).termsAndConditions,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      ImagePaths.person,
                      S.of(context).responsibleContractors,
                    ),
                    SizedBox(height: 8.h),
                    _buildEmployeeInfo(context),
                    SizedBox(height: 8.h),
                    Builder(
                      builder: (context) {
                        if (state.employeesLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state.employeesError != null) {
                          return Text(
                            'Failed to load employees',
                            style: TextStyle(color: Colors.red),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            if (state.employees.isEmpty) {
                              showSnackBar(
                                context: context,
                                message: S.of(context).noEmployeesFound,
                                color: ColorSchemes.warning,
                                icon: ImagePaths.warning,
                              );
                            }
                          },
                          child: DropdownButtonFormField<Employee>(
                            value: state.selectedEmployee,
                            items: state.employees
                                .map((e) => DropdownMenuItem<Employee>(
                                      value: e,
                                      child: Text(e.fullName),
                                    ))
                                .toList(),
                            onChanged: (emp) => cubit.selectEmployee(emp),
                            decoration: InputDecoration(
                              hintText: S.of(context).selectEmployee,
                              hintStyle: TextStyle(
                                color: Color(0xFFA0A0A0),
                                fontSize: 14.sp,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 12.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Color(0xFFDADADA)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Color(0xFFA40000)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    _buildSectionHeader(
                      ImagePaths.info,
                      S.of(context).contractTerms,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(height: 8.h),
                    ...List.generate(state.terms.length, (i) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${i + 1}. ',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                state.terms[i],
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xFF4A4A4A),
                                    height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    if (state.addingTerm)
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: cubit.addTermController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: S.of(context).enterTerm,
                                hintStyle: TextStyle(
                                    color: Color(0xFFA0A0A0), fontSize: 14.sp),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 12.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDADADA)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide:
                                      BorderSide(color: Color(0xFFA40000)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onSubmitted: (val) => cubit.addCustomTerm(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.check, color: Color(0xFFA40000)),
                            onPressed: cubit.addCustomTerm,
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey),
                            onPressed: cubit.cancelAddTerm,
                          ),
                        ],
                      ),
                    TextButton.icon(
                      onPressed: cubit.startAddTerm,
                      icon: Icon(Icons.add, color: Color(0xFFA40000)),
                      label: Text(
                        S.of(context).addOtherTerm,
                        style: TextStyle(
                          color: Color(0xFFA40000),
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(height: 16.h),
                    _buildSectionHeader(
                      ImagePaths.conditions,
                      S.of(context).conditionsOfTheContract,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      S.of(context).selectDaysAndWorkingHours,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Column(
                      children: List.generate(
                        cubit.daysOfWeek.length,
                        (i) {
                          final day = cubit.daysOfWeek[i];
                          final checked = state.selectedDays.contains(i);
                          return _buildDayDropdown(day, checked,
                              cubit: cubit, i: i);
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      S.of(context).selectWorkingHours,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => cubit.pickTime(context, true),
                            child: Container(
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xFFDADADA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                state.startTime != null
                                    ? state.startTime!.format(context)
                                    : S.of(context).from,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: state.startTime != null
                                      ? Colors.black
                                      : Color(0xFFA0A0A0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => cubit.pickTime(context, false),
                            child: Container(
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xFFDADADA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                state.endTime != null
                                    ? state.endTime!.format(context)
                                    : S.of(context).to,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: state.endTime != null
                                      ? Colors.black
                                      : Color(0xFFA0A0A0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.isValid && !state.loading
                            ? () async {
                                final ok = await cubit.submit();
                                if (ok && context.mounted) {
                                  Navigator.pop(context, true);
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.isValid
                              ? const Color(0xFFA40000)
                              : const Color(0xFFCCCCCC),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 0,
                        ),
                        child: state.loading
                            ? SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                S.of(context).confirm,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: state.isValid
                                      ? Colors.white
                                      : Color(0xFFA0A0A0),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String iconPath, String title) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          color: const Color(0xFF133769),
          width: 24,
          height: 24,
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeInfo(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).responsibleEmployee,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '(',
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
        ),
        Text(
          S.of(context).contractSignature,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        Text(
          ')',
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildDayDropdown(
    String day,
    bool isSelected, {
    required int i,
    required cubit,
  }) {
    return InkWell(
      onTap: () => cubit.toggleDay(i),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: ColorSchemes.border,
                width: 1,
              ),
              top: BorderSide(
                color: Colors.white,
                width: 1,
              ),
              left: BorderSide(
                color: Colors.white,
                width: 1,
              ),
              right: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.white12,
                blurRadius: 0,
                spreadRadius: 32,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (value) {
                  cubit.toggleDay(i);
                },
              ),
              Text(
                day,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
              Spacer(),
              SvgPicture.asset(
                ImagePaths.arrowDown,
                color: ColorSchemes.red,
                width: 24,
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
