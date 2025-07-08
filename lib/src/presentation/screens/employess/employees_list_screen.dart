import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/usecase/get_token_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/screens/add_employees/add_employee_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeesListScreen extends StatefulWidget {
  const EmployeesListScreen({super.key});

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  late Future<List<dynamic>> _employeesFuture;

  @override
  void initState() {
    super.initState();
    _employeesFuture = _fetchEmployees();
  }

  Future<List<dynamic>> _fetchEmployees() async {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: AppBar(
          backgroundColor: const Color(0xFF8C0000),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.sp),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            S.of(context).addEmployees,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              fontFamily: 'SF Pro',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildSectionHeader(),
            SizedBox(height: 16.h),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _employeesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final employees = snapshot.data ?? [];
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      ...employees.map((emp) => _buildEmployeeCard(emp)),
                      SizedBox(height: 16.h),
                      _buildAddAnotherButton(),
                      SizedBox(height: 24.h),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
              child: SizedBox(
                width: 343.w,
                child: CustomButtonWidget(
                  textColor: ColorSchemes.white,
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.completeInfo,
                      (route) => false,
                    );
                  },
                  backgroundColor: ColorSchemes.red,
                  text: S.of(context).next,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).createEmployeeProfile,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                    fontFamily: 'SF Pro',
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  S.of(context).startAddingEmployee,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF888888),
                    fontFamily: 'SF Pro',
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xFF8C0000),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Icon(Icons.person_add, color: Colors.white, size: 24.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(dynamic emp) {
    return Container(
      width: 343.w,
      height: 72.h,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE0E0E0)),
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
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
                    Icon(Icons.phone, color: Colors.black54, size: 16.sp),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              emp['permission'] ?? '',
              style: TextStyle(
                color: Color(0xFF8C0000),
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
                fontFamily: 'SF Pro',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAnotherButton() {
    return Center(
      child: TextButton.icon(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEmployeeScreen()),
          );
        },
        icon: Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: Color(0xFF1C3D80),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Icon(Icons.add, color: Colors.white, size: 18.sp),
        ),
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            S.of(context).addEmployees,
            style: TextStyle(
              color: Color(0xFF8C0000),
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              fontFamily: 'SF Pro',
            ),
          ),
        ),
        style: TextButton.styleFrom(
          foregroundColor: Color(0xFF8C0000),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        ),
      ),
    );
  }
}
