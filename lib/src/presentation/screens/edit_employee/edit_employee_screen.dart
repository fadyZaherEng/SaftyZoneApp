import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'package:safety_zone/src/presentation/screens/add_employees/add_employee_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:http/http.dart' as http;

class EditEmployeeScreen extends StatefulWidget {
  final dynamic employee;

  const EditEmployeeScreen({
    super.key,
    required this.employee,
  });

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        title: Text(
          S.of(context).editEmployee,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: SpinKitDoubleBounce(color: ColorSchemes.primary))
          : _buildEmployeeCard(widget.employee),
    );
  }

  Widget _buildEmployeeCard(dynamic emp) {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: 12.h,
            left: 12.w,
            right: 12.w,
            top: 12.h,
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: const Color(0xFFE0E0E0)),
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.r),
                      child: Image.network(
                        emp['profileImage'] ?? '',
                        width: 48.w,
                        height: 48.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 48.sp,
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            emp['fullName'] ?? '',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF333333),
                              fontFamily: 'SF Pro',
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(Icons.phone,
                                  color: Colors.black54, size: 16.sp),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  emp['phoneNumber'] ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xFF888888),
                                    fontFamily: 'SF Pro',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          (emp['permission'] as List?)?.join(', ') ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(
                            color: Color(0xFF8C0000),
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Divider(),
                SizedBox(height: 12.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       S.of(context).mission,
                //       style: TextStyle(
                //         fontSize: 16.sp,
                //         color: ColorSchemes.black,
                //         fontFamily: 'SF Pro',
                //       ),
                //     ),
                //     Container(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                //       decoration: BoxDecoration(
                //         color: ColorSchemes.secondary,
                //         borderRadius: BorderRadius.circular(16.r),
                //       ),
                //       child: Text(
                //         "عقود صيانه",
                //         style: TextStyle(
                //           color: ColorSchemes.white,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 13.sp,
                //           fontFamily: 'SF Pro',
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // SizedBox(height: 12.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomButtonWidget(
                          text: S.of(context).editEmployeeInformation,
                          backgroundColor: ColorSchemes.primary,
                          textStyle: TextStyle(
                            fontSize: 15.sp,
                            color: ColorSchemes.white,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddEmployeeScreen(
                                  isEditMode: true,
                                  employeeId: emp['_id'],
                                  employeeName: emp['fullName'],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomButtonWidget(
                          text: S.of(context).delete,
                          backgroundColor: ColorSchemes.white,
                          borderColor: ColorSchemes.border,
                          textStyle: TextStyle(
                            fontSize: 15.sp,
                            color: ColorSchemes.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () {
                            // Implement delete functionality here
                            deleteEmployee(
                              baseUrl: APIKeys.baseUrl,
                              employeeId: emp['_id'],
                              fullName: emp['fullName'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool isLoading = false;

  Future<void> deleteEmployee({
    required String baseUrl,
    required String employeeId,
    required String fullName,
  }) async {
    isLoading = true;
    final url = Uri.parse('$baseUrl/api/provider/employee/$employeeId');

    final body = {
      "fullName": fullName,
    };

    debugPrint("\n===== [AddEmployeeCubit] Deleting employee =====");
    debugPrint("URL: $url");
    debugPrint("Body: ${jsonEncode(body)}");

    try {
      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetTokenUseCase(injector())()}",
        },
        body: jsonEncode(body),
      );

      debugPrint("Status: ${response.statusCode}");
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // هنا تقدر تاخد الـ OTP لو محتاجه
        final otp = result['otp']?['code'];
        debugPrint("OTP: $otp");
        isLoading = false;
        //delete success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).employeeDeletedSuccessfully),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Close the edit screen

        // emit(state.copyWith(isLoading: false, isDeleted: true));
      } else {
        // emit(state.copyWith(isLoading: false));
      }
    } catch (e, s) {
      isLoading = false;
      debugPrint("\n===== [AddEmployeeCubit] Delete Error =====");
      debugPrint(e.toString());
      debugPrint(s.toString());
      // emit(state.copyWith(isLoading: false));
    }
  }
}
