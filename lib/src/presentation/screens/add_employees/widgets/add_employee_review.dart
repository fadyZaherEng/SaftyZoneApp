import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../cubit/add_employee_cubit.dart';

const Map<String, String> taskKeyToBackendRole = {
  'systemAdministrator': 'System administrator',
  'contractSigning': 'Contract Signing',
  'quotationSubmission': 'Quotation Submission',
  'reportWriting': 'Report Writing',
  "fawryService": "Fawry Service",
};

class AddEmployeeReview extends StatelessWidget {
  const AddEmployeeReview({super.key});

  Future<List<dynamic>> _fetchEmployees(BuildContext context) async {
    final baseUrl = APIKeys.baseUrl;
    final token = GetTokenUseCase(injector())();
    final url = Uri.parse('$baseUrl/api/provider/employee?limit=10&page=1');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result'] as List<dynamic>;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddEmployeeCubit>().state;
    final emp = state.employee;
    return FutureBuilder<List<dynamic>>(
      future: _fetchEmployees(context),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).reviewAndConfirm,
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    fontFamily: 'SF Pro',
                  ),
                ),
                SizedBox(height: 24.h),
                _buildProfileCard(emp, context),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildButton(
                        label: S.of(context).previous,
                        enabled: true,
                        color: Colors.white,
                        textColor: const Color(0xFFA50000),
                        borderColor: const Color(0xFFA50000),
                        onTap: () =>
                            context.read<AddEmployeeCubit>().previousStep(),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _buildButton(
                        label: state.isLoading
                            ? S.of(context).saving
                            : S.of(context).saveEmployee,
                        enabled: !state.isLoading,
                        color: const Color(0xFFA50000),
                        textColor: Colors.white,
                        onTap: !state.isLoading
                            ? () async {
                                final cubit = context.read<AddEmployeeCubit>();
                                final baseUrl = APIKeys.baseUrl;
                                final isFirst =
                                    await cubit.checkIsFirstEmployee(baseUrl);
                                await cubit.saveEmployee(
                                  isFirstEmployee: isFirst,
                                  baseUrl: baseUrl,
                                );
                                if (context.mounted && cubit.state.isSaved) {
                                  // Navigate to EmployeesListScreen
                                  await Navigator.pushReplacementNamed(
                                    context,
                                    Routes.employeesList,
                                  );
                                } else {
                                  showSnackBar(
                                    context: context,
                                    message: S.of(context).missingData,
                                    color: ColorSchemes.warning,
                                    icon: ImagePaths.error,
                                  );
                                }
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Center(
                  child: TextButton.icon(
                    onPressed: () => context.read<AddEmployeeCubit>().reset(),
                    icon: Icon(Icons.add_circle, color: Color(0xFF1C3D80)),
                    label: Text(
                      S.of(context).addAnotherEmployee,
                      style: TextStyle(
                        color: Color(0xFF1C3D80),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF1C3D80),
                      textStyle: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                if (state.isSaved)
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Text(
                      S.of(context).employeeSavedSuccessfully,
                      style: TextStyle(
                        color: const Color(0xFFA50000),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileCard(emp, context) {
    final taskKeyToLabel = {
      'System administrator': S.of(context).systemAdministrator,
      'Contract Signing': S.of(context).contractSigning,
      'Quotation Submission': S.of(context).quotationSubmission,
      'Report Writing': S.of(context).reportWriting,
      'Fawry Service': S.of(context).fawryService
    };
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: emp.photoPath != null
                    ? FileImage(File(emp.photoPath))
                    : NetworkImage(emp.photoPath ?? ''),
                backgroundColor: const Color(0xFFDDDDDD),
                child: emp.photoPath == null
                    ? Icon(Icons.person, color: Colors.white, size: 32)
                    : null,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            emp.fullName,
                            style: TextStyle(
                              color: const Color(0xFF333333),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                        ),
                        Text(
                          emp.jobTitle,
                          style: TextStyle(
                            color: const Color(0xFFA50000),
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      emp.phoneNumber,
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
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFFE0E0E0), thickness: 1),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).functionalTitleRole,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      emp.functionalTitle ?? '',
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
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).tasksSelection,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: (emp.tasks ?? [])
                          .map<Widget>((t) => Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1C3D80),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Text(
                                  taskKeyToLabel[t] ?? t,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontFamily: 'SF Pro',
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            S.of(context).notes,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              fontFamily: 'SF Pro',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            (emp.notes != null && emp.notes.isNotEmpty) ? emp.notes : '-',
            style: TextStyle(
              color: const Color(0xFF888888),
              fontSize: 13.sp,
              fontFamily: 'SF Pro',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required bool enabled,
    required Color color,
    required Color textColor,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      height: 48.h,
      child: CustomButtonWidget(
        textColor: textColor,
        onTap: onTap ?? () {},
        backgroundColor: color,
        text: label,
        borderColor: borderColor ?? Colors.transparent,
      ),
    );
  }
}
