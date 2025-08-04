import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';

class MaintainanceInProgressScreen extends BaseStatefulWidget {
  final ScheduleJop scheduleJop;

  const MaintainanceInProgressScreen({
    super.key,
    required this.scheduleJop,
  });

  @override
  BaseState<MaintainanceInProgressScreen> baseCreateState() =>
      _MaintainanceInProgressScreenState();
}

class _MaintainanceInProgressScreenState
    extends BaseState<MaintainanceInProgressScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildItem(String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      color: ColorSchemes.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImagePaths.priceTag,
                  height: 16.h,
                  width: 16.w,
                  color: ColorSchemes.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorSchemes.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: S.of(context).available,
                    value: 1,
                    path: ImagePaths.quality,
                    isReadOnly: false,
                    controller: TextEditingController(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInputField(
                    label: S.of(context).required,
                    value: 1,
                    path: ImagePaths.technical,
                    isReadOnly: true,
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),
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
        const SizedBox(height: 16),
        SizedBox(
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
      ],
    );
  }

  Widget buildSection(
    String title,
    List<String> items,
    void Function(int) onTap,
    String path, {
    bool isButton = true,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                path,
                height: 22.h,
                width: 22.w,
                color: ColorSchemes.primary,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(buildItem),
          if (isButton) const SizedBox(height: 40),
          if (isButton)
            CustomButtonWidget(
              onTap: () {
                if (_currentIndex < 3) {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                }
                if (_currentIndex == 3) {
                  onTap(_currentIndex);
                }
              },
              text: S.of(context).next,
              backgroundColor: ColorSchemes.primary,
              textColor: Colors.white,
            ),
          if (isButton) const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: 40,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.red[900] : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        title: Text(S.of(context).report_title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          buildPageIndicator(),
          const SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: onPageChanged,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSection(
                        S.of(context).control_panel,
                        [
                          S.of(context).zone_loop,
                          S.of(context).control_panel,
                        ],
                        (p0) {},
                        ImagePaths.controlPanel,
                        isButton: false,
                      ),
                      buildSection(
                        S.of(context).fireDetector,
                        [
                          S.of(context).fire_detector,
                        ],
                        (p0) {},
                        ImagePaths.smokeDetector,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSection(
                        S.of(context).alarm_bell,
                        [
                          S.of(context).external_bell,
                          S.of(context).bell_with_flasher,
                        ],
                        (p1) {},
                        ImagePaths.alarmBell,
                        isButton: false,
                      ),
                      buildSection(
                        S.of(context).broken_glass,
                        [
                          S.of(context).internal_glass,
                          S.of(context).external_glass,
                        ],
                        (p1) {},
                        ImagePaths.breakGlass,
                      ),
                    ],
                  ),
                ),
                buildSection(
                  S.of(context).emergency_lights,
                  [
                    S.of(context).internal_light,
                    S.of(context).emergency_exit,
                  ],
                  (p2) {},
                  ImagePaths.lighting,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSection(
                        S.of(context).pumps,
                        [
                          S.of(context).pumps,
                        ],
                        (p3) {},
                        ImagePaths.fireHydrant,
                        isButton: false,
                      ),
                      buildSection(
                        S.of(context).external_sprinkler,
                        [
                          S.of(context).sprinkler_amer,
                        ],
                        (p3) {},
                        ImagePaths.irrigation,
                        isButton: false,
                      ),
                      buildSection(
                        S.of(context).fireBoxes,
                        [
                          S.of(context).internal_box,
                          S.of(context).foam_box,
                        ],
                        (p3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SystemReportsPage(),
                            ),
                          );
                        },
                        ImagePaths.fireBox,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class SystemReportsPage extends StatefulWidget {
  const SystemReportsPage({super.key});

  @override
  State<SystemReportsPage> createState() => _SystemReportsPageState();
}

class _SystemReportsPageState extends State<SystemReportsPage> {
  List<String> itemsFirstSectionIcon = [];
  List<String> itemsSecondSectionIcon = [];

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
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7B0000),
        title: Text(
          s.systemReportsTitle,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          systemSection(
            title: s.earlyWarningSystem,
            icon: ImagePaths.riskManagement,
            items: [
              s.controlPanel,
              s.smokeDetector,
              s.alarmBell,
              s.glassBreaker,
              s.emergencyLight,
            ],
            isFirst: true,
          ),
          const SizedBox(height: 24),
          systemSection(
            title: s.fireExtinguisherSystem,
            icon: ImagePaths.fireExtinguishers,
            items: [
              s.fireExtinguishers,
              s.extinguishingSystems,
              s.fireBoxes,
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B0000),
              minimumSize: const Size(double.infinity, 42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MaintenanceReportScreen(),
                ),
              );
            },
            child: Text(s.next),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  Widget systemSection({
    required String title,
    required String icon,
    required List<String> items,
    bool isFirst = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                icon,
                width: 50,
                height: 50,
                color: const Color(0xFF7B0000),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (e) => Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    children: [
                      isFirst
                          ? SvgPicture.asset(
                              itemsFirstSectionIcon[items.indexOf(e)],
                              width: 20,
                              height: 20,
                              color: ColorSchemes.secondary,
                            )
                          : SvgPicture.asset(
                              itemsSecondSectionIcon[items.indexOf(e)],
                              width: 20,
                              height: 20,
                              color: ColorSchemes.secondary,
                            ),
                      const SizedBox(width: 8),
                      Text(e, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  trailing: SvgPicture.asset(
                    ImagePaths.arrowLeft,
                    width: 24,
                    height: 24,
                    color: const Color(0xFF7B0000),
                  ),
                  leading:
                      const Icon(Icons.check_box, color: Color(0xFF7B0000)),
                ),
                const Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MaintenanceReportScreen extends StatelessWidget {
  const MaintenanceReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.maintenance_report),
        backgroundColor: ColorSchemes.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImagePaths.priceSending,
                  width: 22,
                  height: 22,
                ),
                const SizedBox(width: 16),
                Text(
                  t.post_visit_report,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 3,
              color: ColorSchemes.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Transform.rotate(
                          angle: -pi / 2,
                          child: SvgPicture.asset(
                            ImagePaths.priceTag,
                            width: 18,
                            height: 18,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            t.system_safety_status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildSafetyOptions(t),
                ],
              ),
            ),
            SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 3,
              color: ColorSchemes.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Transform.rotate(
                          angle: -pi / 2,
                          child: SvgPicture.asset(
                            ImagePaths.priceTag,
                            width: 18,
                            height: 18,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(child: _buildSectionTitle(t.add_notes)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'اكتب هنا...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 3,
              color: ColorSchemes.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Transform.rotate(
                          angle: -pi / 2,
                          child: SvgPicture.asset(
                            ImagePaths.priceTag,
                            width: 18,
                            height: 18,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(child: _buildSectionTitle("${t.alarm_type}*")),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'ادخل نوع النظام الإنذار العادي',
                          border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 3,
              color: ColorSchemes.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImagePaths.person,
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 16),
                        _buildSectionTitle(t.report_prepared_by),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'محمد أحمد علي',
                          border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            CustomButtonWidget(
              text: t.submit_report,
              backgroundColor: ColorSchemes.primary,
              textColor: ColorSchemes.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SystemErrorScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSafetyOptions(t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: CheckboxListTile(
              value: true,
              contentPadding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (_) {},
              title: Text(t.very_safe),
            ),
          ),
          Expanded(
            child: CheckboxListTile(
              value: false,
              contentPadding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (_) {},
              title: Text(t.moderate),
            ),
          ),
          Expanded(
            child: CheckboxListTile(
              value: false,
              contentPadding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (_) {},
              title: Text(t.danger),
            ),
          ),
        ],
      ),
    );
  }
}

class SystemErrorScreen extends StatelessWidget {
  const SystemErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.maintenance_report),
        backgroundColor: ColorSchemes.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImagePaths.priceSending,
                  width: 22,
                  height: 22,
                ),
                const SizedBox(width: 16),
                Text(
                  t.post_visit_report,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
            Image.asset(
              ImagePaths.systemError,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              t.system_error_detected,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Text(
              t.navigate_to_maintenance_reports,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 30),
            CustomButtonWidget(
              text: t.go_to_maintenance_needed,
              backgroundColor: ColorSchemes.primary,
              textColor: ColorSchemes.white,
              onTap: () {
                // Navigate to reports page
              },
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
