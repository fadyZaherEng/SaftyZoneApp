import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/models/installation_fee_model.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/providers/installation_fee_provider.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/widgets/installation_fees_page_sequance_widget.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/widgets/system_icon.dart';
import 'package:provider/provider.dart';

class ComponentPageViewList extends StatefulWidget {
  const ComponentPageViewList({super.key});

  @override
  State<ComponentPageViewList> createState() => _ComponentPageViewListState();
}

class _ComponentPageViewListState extends State<ComponentPageViewList> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<InstallationFeeProvider>(context);

    final currentSystemType = bloc.currentSystemType;
    final components = bloc.systemComponents[currentSystemType] ?? [];

    if (currentSystemType == null || components.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noComponentsSelected,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: components.length,
      itemBuilder: (context, index) {
        final component = components[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Material(
            borderRadius: BorderRadius.circular(12.r),
            color: const Color(0xFFF5F5F5),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () => _navigateToPageView(context, component, bloc),
              child: Container(
                height: 60.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    // Checkmark icon - show only if component is selected
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: bloc.selectedComponents[component.id] == true
                            ? const Color(0xFF8B0000)
                            : Colors.transparent,
                        border: bloc.selectedComponents[component.id] == true
                            ? null
                            : Border.all(
                                color: const Color(0xFFCCCCCC),
                                width: 2,
                              ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: bloc.selectedComponents[component.id] == true
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16.w,
                            )
                          : null,
                    ),
                    SizedBox(width: 12.w),
                    // Component icon
                    SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: LocalizedSystemIcon(
                        iconName: component.icon,
                        name: bloc.getSystemComponentNameLocalized(
                          component.id,
                          context,
                        ),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Component name
                    Expanded(
                      child: Text(
                        bloc.getSystemComponentNameLocalized(
                          component.id,
                          context,
                        ),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF444444),
                        ),
                      ),
                    ),

                    // Arrow icon
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.w,
                      color: const Color(0xFF8B0000),
                      semanticLabel: S.of(context).componentDetails,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToPageView(BuildContext context, SystemComponent component,
      InstallationFeeProvider provider) async {
    final currentSystemType = provider.currentSystemType;

    if (currentSystemType == null) return;

    final components = provider.systemComponents[currentSystemType] ?? [];
    final systemName = provider.getSystemName(currentSystemType);

    // Navigate to page view with all components
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InstallationFeesPageSequanceWidget(
          components: components,
          systemName: systemName,
          systemType: currentSystemType,
          selectedSystems: provider.selectedSystemTypes,
        ),
      ),
    );

    if (result == true) {
      for (final comp in components) {
        provider.updateComponentSelection(comp.id, true);
      }
      provider.markCurrentSystemAsCompleted();
    }
  }
}
