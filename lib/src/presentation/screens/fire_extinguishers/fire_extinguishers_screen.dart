import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FireExtinguishersScreen extends BaseStatefulWidget {
  final ScheduleJop scheduleJop;

  const FireExtinguishersScreen({
    super.key,
    required this.scheduleJop,
  });

  @override
  BaseState<FireExtinguishersScreen> baseCreateState() =>
      _FireExtinguishersScreenState();
}

class _FireExtinguishersScreenState extends BaseState<FireExtinguishersScreen> {
  bool _isLoading = true;
  TextEditingController _price6KiloController = TextEditingController();
  TextEditingController _price12KiloController = TextEditingController();
  TextEditingController _priceCo2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget baseBuild(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          s.workingInProgress,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Skeletonizer(
          enabled: _isLoading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardHeader(s),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButtonWidget(
                    text: S.of(context).save,
                    backgroundColor: ColorSchemes.primary,
                    textColor: Colors.white,
                    onTap: () {
                     },
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader(S s) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.scheduleJop.status,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor:
                      _isLoading ? Colors.grey.shade300 : ColorSchemes.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.scheduleJop.requestNumber,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.scheduleJop.branch.branchName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    const Icon(Icons.location_pin, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      widget.scheduleJop.branch.address.split(" ").last,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).viewMoreInfo,
              style: TextStyle(
                color: ColorSchemes.primary,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showValidationError(String locationSelected, bool bool) {
    showSnackBar(
      context: context,
      message: locationSelected,
      color: !bool ? ColorSchemes.warning : ColorSchemes.success,
      icon: !bool ? ImagePaths.error : ImagePaths.success,
    );
  }
}
