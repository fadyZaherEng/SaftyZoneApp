import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/presentation/screens/maintainance_inprogress/maintainance_inprogress_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';

class RepairEstimateScreen extends StatefulWidget {
  final bool repairComplete;

  const RepairEstimateScreen({
    super.key,
    required this.repairComplete,
  });

  @override
  _RepairEstimateScreenState createState() => _RepairEstimateScreenState();
}

class _RepairEstimateScreenState extends State<RepairEstimateScreen> {
  bool needsParts = true;
  TextEditingController priceController = TextEditingController(text: "2000");
  List<String> itemsFirstSectionIcon = [];
  List<String> itemsSecondSectionIcon = [];
  List<String> items = [];
  List<String> itemsTitle = [];
  bool isYes = true;

  @override
  void initState() {
    super.initState();
    itemsFirstSectionIcon = [
      ImagePaths.controlPanel,
      ImagePaths.smokeDetector,
      ImagePaths.alarmBell,
      ImagePaths.breakGlass,
      ImagePaths.lighting,
    ];
    itemsSecondSectionIcon = [
      ImagePaths.fireHydrant,
      ImagePaths.irrigation,
      ImagePaths.fireBox,
    ];
    items = [...itemsFirstSectionIcon, ...itemsSecondSectionIcon];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    itemsTitle = [
      S.of(context).control_panel,
      S.of(context).fire_detector,
      S.of(context).alarm_bell,
      S.of(context).glass_breaker,
      S.of(context).emergency_lights,
      S.of(context).fire_pumps,
      S.of(context).warning_labels,
      S.of(context).fire_boxes,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        title: Text(t.system_repair_price),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.system_repair_price_title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              t.repair_description,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              color: ColorSchemes.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildSectionTitle(t.need_spare_parts),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            activeColor: ColorSchemes.primary,
                            title: Text(
                              t.yes,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isYes
                                    ? ColorSchemes.primary
                                    : ColorSchemes.gray,
                                fontSize: 16,
                              ),
                            ),
                            value: isYes,
                            groupValue: needsParts,
                            onChanged: (val) => setState(() {
                              needsParts = val!;
                              isYes = isYes;
                            }),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            activeColor: ColorSchemes.primary,
                            title: Text(
                              t.no,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isYes
                                    ? ColorSchemes.gray
                                    : ColorSchemes.primary,
                                fontSize: 16,
                              ),
                            ),
                            value: !isYes,
                            groupValue: needsParts,
                            onChanged: (val) => setState(() {
                              needsParts = val!;
                              isYes = !isYes;
                            }),
                          ),
                        ),
                      ],
                    ),
                    if (needsParts) ...[
                      _buildInputField(
                        label: t.part_price,
                        path: "",
                        isReadOnly: false,
                        controller: priceController,
                        value: 2000,
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const MaintainanceInProgressScreen(
                                scheduleJop: ScheduleJop(),
                              ),
                            ),
                          );
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                            color: ColorSchemes.white,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            t.upload_invoice,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorSchemes.primary,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          SvgPicture.asset(
                                            ImagePaths.addProgress,
                                            height: 20.h,
                                            width: 20.w,
                                            color: ColorSchemes.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            systemSection(),
            const SizedBox(height: 20),
            if (widget.repairComplete) _buildPriceSection(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required int value,
    required String path,
    required bool isReadOnly,
    required TextEditingController controller,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Row(
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
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 34.h,
            child: TextFormField(
              controller: controller,
              readOnly: isReadOnly,
              keyboardType: TextInputType.number,
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
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Transform.rotate(
            angle: -pi / 2,
            child: SvgPicture.asset(
              ImagePaths.priceTag,
              width: 18,
              height: 18,
              color: ColorSchemes.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget systemSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorSchemes.border.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 12),
          ...items.asMap().entries.map(
                (e) => Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        children: [
                          SvgPicture.asset(
                            items[e.key],
                            width: 20,
                            height: 20,
                            color: widget.repairComplete
                                ? ColorSchemes.secondary
                                : ColorSchemes.gray,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            itemsTitle[e.key],
                            style: TextStyle(
                              fontSize: widget.repairComplete ? 16 : 14,
                              color: widget.repairComplete
                                  ? ColorSchemes.black
                                  : ColorSchemes.gray,
                            ),
                          ),
                        ],
                      ),
                      trailing: SvgPicture.asset(
                        ImagePaths.arrowLeft,
                        width: 24,
                        height: 24,
                        color: const Color(0xFF7B0000),
                      ),
                      leading: Icon(
                        widget.repairComplete
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: widget.repairComplete
                            ? ColorSchemes.primary
                            : ColorSchemes.border,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              )
        ],
      ),
    );
  }

  final double materialCost = 1000;
  final double repairCost = 2000;
  final double installCost = 3000;
  final double tax = 500;

  _buildPriceSection() {
    double total = materialCost + repairCost + installCost + tax;

    final t = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.rotate(
              angle: -pi / 2,
              child: SvgPicture.asset(
                ImagePaths.priceTag,
                width: 18,
                height: 18,
                color: ColorSchemes.secondary,
              ),
            ),
            SizedBox(width: 8),
            Text(t.total_after_report,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 12),
        _buildRow(t.materials_cost, materialCost),
        _buildRow(t.repair_cost, repairCost),
        _buildRow(t.installation_cost, installCost),
        _buildRow(t.tax, tax),
        Divider(),
        _buildRow(
          t.total,
          total,
          color: ColorSchemes.secondary,
          isBold: true,
          valueColor: ColorSchemes.primary,
        ),
        SizedBox(height: 16),
        CustomButtonWidget(
          text: t.confirm,
          backgroundColor: ColorSchemes.primary,
          textColor: ColorSchemes.white,
          onTap: () {},
        )
      ],
    );
  }

  Widget _buildRow(
    String label,
    double value, {
    Color? color,
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
          Text(
            "${value.toInt()} ر.س",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
