import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/models/installation_fee_model.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/providers/installation_fee_provider.dart';
import 'package:provider/provider.dart';

class SystemTypeSelector extends StatefulWidget {
  final List<SystemType> selectedSystems;

  const SystemTypeSelector({
    super.key,
    required this.selectedSystems,
  });

  @override
  State<SystemTypeSelector> createState() => _SystemTypeSelectorState();
}

class _SystemTypeSelectorState extends State<SystemTypeSelector> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<InstallationFeeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            S.of(context).selectComponents,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF444444),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.selectedSystems.length,
            itemBuilder: (context, index) {
              final systemType = widget.selectedSystems[index];
              return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  title: Text(
                    bloc.getSystemName(systemType),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    semanticLabel: S.of(context).selectComponents,
                  ),
                  onTap: () => bloc.setCurrentSystemType(systemType),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
