import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/core/utils/show_snack_bar.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/models/installation_fee_model.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/providers/installation_fee_provider.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/widgets/installation_fees_detail_widget.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/widgets/installation_fees_page_sequance_widget.dart';

class InstallationOptionsScreen extends StatefulWidget {
  const InstallationOptionsScreen({super.key});

  @override
  State<InstallationOptionsScreen> createState() =>
      _InstallationOptionsScreenState();
}

class _InstallationOptionsScreenState extends State<InstallationOptionsScreen> {
  bool _isEarlyWarningSelected = false;
  bool _isFireSuppressionSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                S.of(context).enterSafetySystemFees,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF222222),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                S.of(context).pleaseEnterSpecificFees,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF888888),
                  height: 1.4,
                ),
                maxLines: 3,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: _buildSelectableCard(
                      title: S.of(context).earlyWarningSystemFees,
                      isSelected: _isEarlyWarningSelected,
                      iconPath: ImagePaths.earlyWarning,
                      onTap: () {
                        setState(() {
                          _isEarlyWarningSelected = !_isEarlyWarningSelected;
                        });
                      },
                      semanticsLabel: 'Early Warning Icon',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildSelectableCard(
                      title: S.of(context).fireSuppressionSystemFees,
                      isSelected: _isFireSuppressionSelected,
                      iconPath: ImagePaths.fireExting,
                      onTap: () {
                        setState(() {
                          _isFireSuppressionSelected =
                              !_isFireSuppressionSelected;
                        });
                      },
                      semanticsLabel: 'Fire Suppression Icon',
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Next Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _isAnyCardSelected()
                      ? () => _navigateToFeeDetailsScreen()
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isAnyCardSelected()
                        ? ColorSchemes.red
                        : const Color(0xFFCCCCCC),
                    foregroundColor: ColorSchemes.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    S.of(context).next,
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
    );
  }

  Widget _buildSelectableCard({
    required String title,
    required bool isSelected,
    required String iconPath,
    required VoidCallback onTap,
    required String semanticsLabel,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Semantics(
        label: title,
        selected: isSelected,
        child: Container(
          height: 180.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => onTap(),
                  activeColor: const Color(0xFF8B0000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        iconPath,
                        width: 48.w,
                        height: 48.h,
                        semanticsLabel: semanticsLabel,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isAnyCardSelected() {
    return _isEarlyWarningSelected || _isFireSuppressionSelected;
  }

  void _navigateToFeeDetailsScreen() {
    // Prepare selected systems
    List<SystemType> selectedSystems = [];
    if (_isEarlyWarningSelected) {
      selectedSystems.add(SystemType.earlyWarning);
    }
    if (_isFireSuppressionSelected) {
      selectedSystems.add(SystemType.fireSuppression);
    }

    // If both systems are selected, start with early warning first and auto-navigate to fire suppression
    if (_isEarlyWarningSelected && _isFireSuppressionSelected) {
      _navigateToPageViewSequence(selectedSystems);
    } else {
      // Navigate to details page for single system
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InstallationFeesDetailContent(
              selectedSystems: selectedSystems,
              title: _isEarlyWarningSelected
                  ? S.of(context).earlyWarningSystemFees
                  : S.of(context).fireSuppressionSystemFees),
        ),
      );
    }
  }

  void _navigateToPageViewSequence(List<SystemType> selectedSystems) async {
    final provider = InstallationFeeProvider();
    provider.initialize(selectedSystems);

    // Start with early warning system
    final earlyWarningComponents =
        provider.systemComponents[SystemType.earlyWarning] ?? [];
    final earlyWarningSystemName =
        provider.getSystemName(SystemType.earlyWarning);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InstallationFeesPageSequanceWidget(
          components: earlyWarningComponents,
          systemName: earlyWarningSystemName,
          systemType: SystemType.earlyWarning,
          selectedSystems: selectedSystems,
        ),
      ),
    );

    // If completed successfully, both systems are now processed
    if (result == true) {
      // Show success message or navigate back
      showSnackBar(
        context: context,
        message: S.of(context).installationFeeSaved,
        color: ColorSchemes.success,
        icon: ImagePaths.success,
      );
    }
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorSchemes.red,
      foregroundColor: ColorSchemes.white,
      elevation: 0,
      title: Text(
        S.of(context).addInstallationFees,
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
    );
  }
}
