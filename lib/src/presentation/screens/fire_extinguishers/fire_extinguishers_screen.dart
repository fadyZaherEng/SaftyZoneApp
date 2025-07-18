import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/android_date_picker.dart';
import '../../../core/utils/ios_date_picker.dart';

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
  bool _isFirstPage = true;
  bool _isSecondPage = false;
  bool _isThirdPage = false;

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
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      Text(
                        _getPageTitle(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        ImagePaths.priceSending,
                        color: ColorSchemes.primary,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: SizedBox(
                    width: 130,
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: _isFirstPage
                                ? ColorSchemes.primary
                                : ColorSchemes.border,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: _isSecondPage
                                ? ColorSchemes.primary
                                : ColorSchemes.border,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: _isThirdPage
                                ? ColorSchemes.primary
                                : ColorSchemes.border,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildItem(
                      context,
                      imagePath: ImagePaths.firePng1,
                      title: s.powder6Kg,
                      clientCount: "4",
                      receivedCount: "4",
                    ),
                    const SizedBox(height: 16),
                    _buildItem(
                      context,
                      imagePath: ImagePaths.firePng2,
                      title: s.powder12Kg,
                      clientCount: "4",
                      receivedCount: "4",
                    ),
                    const SizedBox(height: 16),
                    _buildItem(
                      context,
                      imagePath: ImagePaths.firePng3,
                      title: s.co2Extinguisher,
                      clientCount: "4",
                      receivedCount: "4",
                    ),
                  ],
                ),
                if (_isSecondPage) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButtonWidget(
                      text: S.of(context).sendPriceOffer,
                      backgroundColor: ColorSchemes.primary,
                      textColor: Colors.white,
                      onTap: () {
                        setState(() {
                          _isSecondPage = false;
                          _isFirstPage = false;
                          _isThirdPage = true;
                        });
                      },
                    ),
                  ),
                ],
                if (_isThirdPage) ...[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButtonWidget(
                          text: S.of(context).expiryDate,
                          backgroundColor: ColorSchemes.white,
                          textColor: ColorSchemes.primary,
                          borderColor: ColorSchemes.border,
                          onTap: () {
                            if (Platform.isAndroid) {
                              androidDatePicker(
                                context: context,
                                firstDate: DateTime.now()
                                    .add(const Duration(days: 180)),
                                selectedDate: DateTime.now()
                                    .add(const Duration(days: 180)),
                                onSelectDate: (picked) {
                                  setState(() {});
                                  // Navigator.pop(context);
                                  if (picked != null) {}
                                },
                              );
                            } else {
                              DateTime? picked;
                              iosDatePicker(
                                context: context,
                                selectedDate: DateTime.now()
                                    .add(const Duration(days: 180)),
                                onChange: (date) => picked = date,
                                onCancel: () => Navigator.pop(context),
                                onDone: () {
                                  setState(() {});
                                  // Navigator.pop(context);
                                  if (picked != null) {}
                                },
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButtonWidget(
                          text: S.of(context).fireExtinguishersDelivery,
                          backgroundColor: ColorSchemes.primary,
                          textColor: Colors.white,
                          onTap: () {
                            // setState(() {
                            //   _isSecondPage = false;
                            //   _isFirstPage = false;
                            //   _isThirdPage = false;
                            // });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                if (_isFirstPage) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButtonWidget(
                      text: S.of(context).save,
                      backgroundColor: ColorSchemes.primary,
                      textColor: Colors.white,
                      onTap: () {
                        setState(() {
                          _isSecondPage = true;
                          _isFirstPage = false;
                          _isThirdPage = false;
                        });
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String clientCount,
    required String receivedCount,
  }) {
    final s = S.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.3,
      color: ColorSchemes.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImagePaths.fire,
                  height: 24.h,
                  width: 24.w,
                  color: ColorSchemes.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorSchemes.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _buildInputField(
                        label: _isSecondPage
                            ? s.repairCost
                            : _isThirdPage
                                ? s.numberOfMaintainanceCompleted
                                : s.availableAtClient,
                        value: clientCount,
                        path: ImagePaths.quality,
                      ),
                      const SizedBox(height: 8),
                      _buildInputField(
                        label: _isThirdPage
                            ? s.numberArrivedForClient
                            : s.receivedCount,
                        value: receivedCount,
                        path: ImagePaths.technical,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Image.asset(imagePath),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String value,
    required String path,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              path,
              height: 16.h,
              width: 16.w,
              color: ColorSchemes.black,
            ),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 34.h,
          child: TextFormField(
            initialValue: value,
            readOnly: true,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              fillColor: ColorSchemes.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: Colors.red),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
            ),
          ),
        ),
      ],
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

  String _getPageTitle() {
    if (_isFirstPage) {
      return S.of(context).fireExtinguisherReportTitle;
    } else {
      return S.of(context).fireExtinguishersRepairOffer;
    }
  }
}
