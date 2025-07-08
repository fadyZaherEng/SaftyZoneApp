import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/models/installation_fee_model.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/providers/installation_fee_provider.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/widgets/component_pageview_list.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/widgets/system_type_selector.dart';
import 'package:provider/provider.dart';

class InstallationFeesDetailContent extends StatefulWidget {
  final String? title;
  final List<SystemType> selectedSystems;

  const InstallationFeesDetailContent({
    super.key,
    this.title,
    required this.selectedSystems,
  });

  @override
  State<InstallationFeesDetailContent> createState() =>
      _InstallationFeesDetailContentState();
}

class _InstallationFeesDetailContentState
    extends State<InstallationFeesDetailContent> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = InstallationFeeProvider();
        provider.initialize(widget.selectedSystems);
        return provider;
      },
      child: _InstallationFeesDetailContent(
        title: widget.title,
        selectedSystems: widget.selectedSystems,
      ),
    );
  }
}

class _InstallationFeesDetailContent extends StatelessWidget {
  final String? title;
  final List<SystemType> selectedSystems;

  const _InstallationFeesDetailContent({
    super.key,
    this.title,
    required this.selectedSystems,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InstallationFeeProvider>(context);

    final screenTitle = title ?? S.of(context).installationFees;
    return ChangeNotifierProvider(
      create: (_) {
        final provider = InstallationFeeProvider();
        provider.initialize(selectedSystems);
        return provider;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF8B0000),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            screenTitle,
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
            tooltip: S.of(context).backToHome,
            padding: EdgeInsets.all(12.w),
            constraints: BoxConstraints(minWidth: 44.w, minHeight: 44.w),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructions with money icon
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).enterInstallationPrices,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF222222),
                        ),
                      ),
                    ),
                    Tooltip(
                      message: S.of(context).installationMaterialsPrice,
                      child: SvgPicture.asset(
                        'assets/images/price-down.svg',
                        width: 50.w,
                        height: 50.w,
                        semanticsLabel:
                            S.of(context).installationMaterialsPrice,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Component selection list or system type selector
                Expanded(
                  child: provider.currentSystemType != null
                      ? const ComponentPageViewList()
                      : SystemTypeSelector(
                          selectedSystems: selectedSystems,
                        ),
                ),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: provider.hasSelectedComponents()
                        ? () => _navigateToSummary(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: provider.hasSelectedComponents()
                          ? const Color(0xFF8B0000)
                          : const Color(0xFFCCCCCC),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: provider.isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
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
      ),
    );
  }

  void _navigateToSummary(BuildContext context) {
    final provider =
        Provider.of<InstallationFeeProvider>(context, listen: false);
    provider.setSubmitting(true);

    // Get selected component fees
    final selectedComponentFees = provider.getSelectedComponentFees();

    // Navigate back with result
    Navigator.pop(context, selectedComponentFees);
  }
}
