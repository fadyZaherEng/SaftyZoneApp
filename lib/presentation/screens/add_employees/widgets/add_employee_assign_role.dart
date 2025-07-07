import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/widgets/custom_button_widget.dart';
import '../cubit/add_employee_cubit.dart';

class AddEmployeeAssignRole extends StatefulWidget {
  const AddEmployeeAssignRole({super.key});

  @override
  State<AddEmployeeAssignRole> createState() => _AddEmployeeAssignRoleState();
}

class _AddEmployeeAssignRoleState extends State<AddEmployeeAssignRole> {
  final _functionalTitleController = TextEditingController();
  final _notesController = TextEditingController();

  Map<String, String> get _roleMapping => {
        'SystemAdministrator': 'System administrator',
        'ContractSigning': 'Contract Signing',
        'QuotationSubmission': 'Quotation Submission',
        'ReportWriting': 'Report Writing',
        'FawryService': 'Fawry Service',
      };

  List<String> _selectedTaskCodes = [];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEmployeeCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).assignJobRole,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                fontFamily: 'SF Pro',
              ),
            ),
            SizedBox(height: 20.h),
            _buildInput(
              label: S.of(context).functionalTitleRole,
              controller: _functionalTitleController,
              hint: S.of(context).functionalTitleHint,
              onChanged: (_) => _onChanged(cubit),
            ),
            SizedBox(height: 20.h),
            Text(
              S.of(context).tasksSelection,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                fontFamily: 'SF Pro',
              ),
            ),
            SizedBox(height: 8.h),
            if (_selectedTaskCodes.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFDDDDDD)),
                ),
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: _selectedTaskCodes
                      .map((code) => _buildSelectedChip(code))
                      .toList(),
                ),
              ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: _roleMapping.entries
                  .where((entry) => !_selectedTaskCodes.contains(entry.value))
                  .map((entry) => _buildTag(entry.key, entry.value))
                  .toList(),
            ),
            SizedBox(height: 24.h),
            Text(
              S.of(context).notes,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                fontFamily: 'SF Pro',
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              S.of(context).notesHint,
              style: TextStyle(
                color: const Color(0xFF888888),
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
                fontFamily: 'SF Pro',
              ),
            ),
            SizedBox(height: 8.h),
            _buildNotesInput(),
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
                    onTap: () => cubit.previousStep(),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildButton(
                    label: S.of(context).next,
                    enabled: _functionalTitleController.text.isNotEmpty &&
                        _selectedTaskCodes.isNotEmpty,
                    color: const Color(0xFFA50000),
                    textColor: Colors.white,
                    onTap: _functionalTitleController.text.isNotEmpty &&
                            _selectedTaskCodes.isNotEmpty
                        ? () async{
                           await cubit.updateRole(
                              functionalTitle: _functionalTitleController.text,
                              tasks: _selectedTaskCodes,
                              notes: _notesController.text,
                            );
                            cubit.nextStep();
                          }
                        : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  cubit.reset();
                  _functionalTitleController.clear();
                  _notesController.clear();
                  setState(() => _selectedTaskCodes = []);
                },
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
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    String? hint,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        color: const Color(0xFF333333),
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        fontFamily: 'SF Pro',
      ),
      decoration: InputDecoration(
        hintText: hint ?? label,
        hintStyle: TextStyle(
          color: const Color(0xFF999999),
          fontSize: 14.sp,
          fontFamily: 'SF Pro',
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFA50000)),
        ),
      ),
    );
  }

  Widget _buildSelectedChip(String code) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFA50000),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            code,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              fontFamily: 'SF Pro',
            ),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedTaskCodes.remove(code);
              });
            },
            child: Icon(Icons.close, color: Colors.white, size: 18.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String translationKey, String code) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTaskCodes.add(code);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFDDDDDD)),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          translationKey,
          style: TextStyle(
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            fontFamily: 'SF Pro',
          ),
        ),
      ),
    );
  }

  Widget _buildNotesInput() {
    return TextFormField(
      controller: _notesController,
      minLines: 3,
      maxLines: 6,
      style: TextStyle(
        color: const Color(0xFF333333),
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        fontFamily: 'SF Pro',
      ),
      decoration: InputDecoration(
        hintText: S.of(context).enterYourNotes,
        hintStyle: TextStyle(
          color: const Color(0xFF999999),
          fontSize: 14.sp,
          fontFamily: 'SF Pro',
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFA50000)),
        ),
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

  void _onChanged(AddEmployeeCubit cubit) {
    cubit.updateRole(
      functionalTitle: _functionalTitleController.text,
      tasks: _selectedTaskCodes,
      notes: _notesController.text,
    );
  }
}
