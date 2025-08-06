import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/src/presentation/blocs/fire_extinguishers/fire_extinguishers_bloc.dart';
import 'package:safety_zone/src/presentation/screens/repair_rstimate/repair_estimate_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';

class MaintainanceInProgressScreen extends BaseStatefulWidget {
  final ScheduleJop scheduleJop;
  final bool isRepair;

  const MaintainanceInProgressScreen({
    super.key,
    required this.scheduleJop,
    this.isRepair = false,
  });

  @override
  BaseState<MaintainanceInProgressScreen> baseCreateState() =>
      _MaintainanceInProgressScreenState();
}

class _MaintainanceInProgressScreenState
    extends BaseState<MaintainanceInProgressScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // int _counter = 0;

  RemoteFirstScreenSchedule firstScreenSchedule = RemoteFirstScreenSchedule();
  List<AlarmItems> items = [];
  List<AlarmItems> changedItems = [];
  List<TextEditingController> itemsEnterByUserController = [];
  List<TextEditingController> itemsQuantityController = [];
  Map<String, double> changeQuantity = {};

  FireExtinguishersBloc get _bloc =>
      BlocProvider.of<FireExtinguishersBloc>(context);

  @override
  void initState() {
    super.initState();
    _bloc.add(GetFirstScreenScheduleEvent(id: widget.scheduleJop.Id));
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<FireExtinguishersBloc, FireExtinguishersState>(
      listener: (context, state) {
        if (state is GetFirstScreenScheduleLoadingState) {
          showLoading();
        } else if (state is GetFirstScreenScheduleSuccessState) {
          firstScreenSchedule = state.remoteFirstScreenSchedule;
          _showValidationError(
              state.remoteFirstScreenSchedule.message.toString(), true);

          items = [
            ...firstScreenSchedule
                    .data?.consumerRequest?.fireExtinguisherItem ??
                [],
            ...firstScreenSchedule.data?.consumerRequest?.alarmItems ?? [],
            ...firstScreenSchedule.data?.consumerRequest?.fireSystemItem ?? [],
          ];
          changedItems = [
            ...firstScreenSchedule
                    .data?.consumerRequest?.fireExtinguisherItem ??
                [],
            ...firstScreenSchedule.data?.consumerRequest?.alarmItems ?? [],
            ...firstScreenSchedule.data?.consumerRequest?.fireSystemItem ?? [],
          ];

          // Reset and add controllers properly
          itemsEnterByUserController.clear();
          itemsQuantityController.clear();
          changeQuantity.clear();
          // _counter = 0;

          for (final item in items) {
            final subCategory = item.itemId?.subCategory ?? "";
            changeQuantity[subCategory] = 0.0;

            itemsEnterByUserController.add(TextEditingController(text: "0"));
            itemsQuantityController
                .add(TextEditingController(text: item.quantity.toString()));
          }
          hideLoading();
        } else if (state is GetFirstScreenScheduleErrorState) {
          _showValidationError(state.message, false);
          hideLoading();
        }
      },
      builder: (context, state) {
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
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: onPageChanged,
                  children: [
                    _buildPage([
                      _buildSection(S.of(context).control_panel,
                          "control panel", ImagePaths.controlPanel, false),
                      _buildSection(S.of(context).fireDetector, "fire detector",
                          ImagePaths.smokeDetector, true),
                    ]),
                    _buildPage([
                      _buildSection(S.of(context).alarm_bell, "alarm bell",
                          ImagePaths.alarmBell, false),
                      _buildSection(S.of(context).broken_glass, "glass breaker",
                          ImagePaths.breakGlass, true),
                    ]),
                    _buildPage([
                      _buildSection(S.of(context).emergency_lights,
                          "Emergency Lighting", ImagePaths.lighting, true,
                          extraSub: "Emergency Exit"),
                    ]),
                    _buildPage([
                      _buildSection(S.of(context).pumps, "Fire pumps",
                          ImagePaths.fireHydrant, false),
                      _buildSection(S.of(context).external_sprinkler,
                          "Automatic Sprinklers", ImagePaths.irrigation, false),
                      _buildSection(
                          S.of(context).fireBoxes,
                          "fire Boxes", //equal to Fire Cabinets
                          ImagePaths.fireBox,
                          true,
                          excludeSubs: [
                            "control panel",
                            "fire detector",
                            "alarm bell",
                            "glass breaker",
                            "Emergency Lighting",
                            "Emergency Exit",
                            "Fire pumps",
                            "Automatic Sprinklers"
                          ],
                          isLastPage: true),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showValidationError(String message, bool isSuccess) {
    showSnackBar(
      context: context,
      message: message,
      color: isSuccess ? ColorSchemes.success : ColorSchemes.warning,
      icon: isSuccess ? ImagePaths.success : ImagePaths.error,
    );
  }

  Widget _buildPage(List<Widget> sections) {
    return SingleChildScrollView(
      child: Column(children: sections),
    );
  }

  Widget _buildSection(
    String title,
    String subCategory,
    String iconPath,
    bool showButton, {
    String? extraSub,
    List<String>? excludeSubs,
    bool isLastPage = false,
  }) {
    final filteredItems = items.asMap().entries.where((entry) {
      final sub = entry.value.itemId?.subCategory?.toLowerCase() ?? "";

      if (excludeSubs != null && excludeSubs.isNotEmpty) {
        return !excludeSubs.contains(entry.value.itemId?.subCategory);
      }
      if (extraSub != null) {
        return sub == subCategory.toLowerCase() ||
            sub == extraSub.toLowerCase();
      }
      return sub == subCategory.toLowerCase();
    }).toList();

    final widgets = filteredItems.map((entry) {
      final i = entry.key;
      final item = entry.value;
      final itemName = GetLanguageUseCase(injector())() == 'en'
          ? item.itemId?.itemName?.en ?? ''
          : item.itemId?.itemName?.ar ?? '';
      return buildItem(itemName, i,
          subCategory: item.itemId?.subCategory ?? '');
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(iconPath,
                  height: 22.h, width: 22.w, color: ColorSchemes.primary),
              const SizedBox(width: 12),
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ...widgets,
          if (showButton) const SizedBox(height: 40),
          if (showButton)
            CustomButtonWidget(
              onTap: () {
                if (_currentIndex < 3) {
                  // _counter += widgets.length;
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                  for (var item in changeQuantity.entries) {
                    print('${item.key} ${item.value}');
                  }
                }
                if (isLastPage) {
                  for (var item in changeQuantity.entries) {
                    print('${item.key} ${item.value}');
                  }
                  for (var item in changedItems) {
                    print('${item.quantity} ${item.itemId?.subCategory}');
                  }
                  if (widget.isRepair) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                RepairEstimateScreen(repairComplete: true)));
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SystemReportsPage(
                          changedItems: changedItems,
                          changeQuantity: changeQuantity,
                        ),
                      ),
                    );
                  }
                }
              },
              text: S.of(context).next,
              backgroundColor: ColorSchemes.primary,
              textColor: Colors.white,
            ),
          if (showButton) const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildItem(String title, int index, {required String subCategory}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: ColorSchemes.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(ImagePaths.priceTag,
                    height: 16.h, width: 16.w, color: ColorSchemes.primary),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorSchemes.secondary)),
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
                    isReadOnly: true,
                    controller: itemsQuantityController[index],
                    onChanged: (_) {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInputField(
                    label: S.of(context).required,
                    value: 1,
                    path: ImagePaths.technical,
                    isReadOnly: false,
                    controller: itemsEnterByUserController[index],
                    onChanged: (value) {
                      setState(() {
                        changeQuantity[subCategory] =
                            double.tryParse(value) ?? 0.0;
                        // Update the changedItems list
                        if (index < changedItems.length) {
                          changedItems[index] = changedItems[index]
                              .copyWith(quantity: int.parse(value));
                        }
                      });
                    },
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
    required void Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(path,
                height: 16.h, width: 16.w, color: ColorSchemes.black),
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
            onChanged: (value) {
              controller.text = value;
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.length));
              onChanged(value);
            },
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter quantity'
                : null,
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
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
        ),
      ],
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
}

// class _MaintainanceInProgressScreenState
//     extends BaseState<MaintainanceInProgressScreen> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;
//
//   RemoteFirstScreenSchedule firstScreenSchedule = RemoteFirstScreenSchedule();
//   List<AlarmItems> items = [];
//   List<TextEditingController> itemsEnterByUserController = [];
//   List<TextEditingController> itemsQuantityController = [];
//   Map<String, double> changeQuantity = {};
//
//   FireExtinguishersBloc get _bloc =>
//       BlocProvider.of<FireExtinguishersBloc>(context);
//
//   @override
//   void initState() {
//     super.initState();
//     _bloc.add(GetFirstScreenScheduleEvent(id: widget.scheduleJop.Id));
//   }
//
//   @override
//   Widget baseBuild(BuildContext context) {
//     return BlocConsumer<FireExtinguishersBloc, FireExtinguishersState>(
//       listener: (context, state) {
//         if (state is GetFirstScreenScheduleSuccessState) {
//           firstScreenSchedule = state.remoteFirstScreenSchedule;
//           _showValidationError(
//               state.remoteFirstScreenSchedule.message.toString(), true);
//
//           items = [
//             ...firstScreenSchedule
//                     .data?.consumerRequest?.fireExtinguisherItem ??
//                 [],
//             ...firstScreenSchedule.data?.consumerRequest?.alarmItems ?? [],
//             ...firstScreenSchedule.data?.consumerRequest?.fireSystemItem ?? [],
//           ];
//           // Add controllers before building the list
//           itemsEnterByUserController.clear(); // Optional: reset if needed
//           itemsQuantityController.clear();
//           _counter = 0;
//           changeQuantity = {};
//           for (int i = 0; i < items.length; i++) {
//             changeQuantity[items[i].itemId?.subCategory ?? ""] = 0.0;
//             TextEditingController enterByUserController =
//                 TextEditingController();
//             enterByUserController.text = "0";
//             itemsEnterByUserController.add(enterByUserController);
//             if (items[i].itemId?.subCategory == "control panel") {
//               TextEditingController quantityController =
//                   TextEditingController();
//               quantityController.text = items[i].quantity.toString();
//               itemsQuantityController.add(quantityController);
//             } else if (items[i].itemId?.subCategory == "fire detector") {
//               TextEditingController quantityController =
//                   TextEditingController();
//               quantityController.text = items[i].quantity.toString();
//               itemsQuantityController.add(quantityController);
//             } else if (items[i].itemId?.subCategory == "alarm bell") {
//               TextEditingController quantityController =
//                   TextEditingController();
//               quantityController.text = items[i].quantity.toString();
//               itemsQuantityController.add(quantityController);
//             } else if (items[i].itemId?.subCategory == "glass breaker") {
//               TextEditingController quantityController =
//                   TextEditingController();
//               quantityController.text = items[i].quantity.toString();
//               itemsQuantityController.add(quantityController);
//             } else if (items[i].itemId?.subCategory == "Emergency Lighting" ||
//                 items[i].itemId?.subCategory == "Emergency Exit") {
//               TextEditingController quantityController =
//                   TextEditingController();
//               quantityController.text = items[i].quantity.toString();
//               itemsQuantityController.add(quantityController);
//             } else if (items[i].itemId?.subCategory == "Automatic Sprinklers") {
//               TextEditingController quantityController =
//                   TextEditingController();
//               quantityController.text = items[i].quantity.toString();
//               itemsQuantityController.add(quantityController);
//             } else if (items[i].itemId?.subCategory == "Fire pumps") {
//               TextEditingController quantityController =
//                   TextEditingController();
//               quantityController.text = items[i].quantity.toString();
//               itemsQuantityController.add(quantityController);
//             } else {
//               TextEditingController quantityController =
//                   TextEditingController();
//               quantityController.text = items[i].quantity.toString();
//               itemsQuantityController.add(quantityController);
//             }
//           }
//         } else if (state is GetFirstScreenScheduleErrorState) {
//           _showValidationError(state.message, false);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorSchemes.primary,
//             title: Text(S.of(context).report_title),
//             centerTitle: true,
//           ),
//           body: Column(
//             children: [
//               const SizedBox(height: 16),
//               buildPageIndicator(),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: PageView(
//                   controller: _pageController,
//                   physics: const NeverScrollableScrollPhysics(),
//                   onPageChanged: onPageChanged,
//                   children: [
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           buildSection(
//                             S.of(context).control_panel,
//                             "control panel",
//                             [
//                               for (int i = 0; i < items.length; i++)
//                                 if (items[i].itemId?.subCategory ==
//                                     "control panel") ...[
//                                   GetLanguageUseCase(injector())() == 'en'
//                                       ? items[i].itemId?.itemName?.en ?? ''
//                                       : items[i].itemId?.itemName?.ar ?? '',
//                                 ],
//                             ],
//                             (p0) {},
//                             ImagePaths.controlPanel,
//                             isButton: false,
//                             length: 0,
//                           ),
//                           buildSection(
//                             S.of(context).fireDetector,
//                             "fire detector",
//                             [
//                               for (int i = 0; i < items.length; i++)
//                                 if (items[i].itemId?.subCategory ==
//                                     "fire detector") ...[
//                                   GetLanguageUseCase(injector())() == 'en'
//                                       ? items[i].itemId?.itemName?.en ?? ''
//                                       : items[i].itemId?.itemName?.ar ?? '',
//                                 ],
//                             ],
//                             (p0) {},
//                             ImagePaths.smokeDetector,
//                             length: items
//                                 .where((element) =>
//                                     element.itemId?.subCategory ==
//                                         "fire detector" ||
//                                     element.itemId?.subCategory ==
//                                         "control panel")
//                                 .length,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           buildSection(
//                             S.of(context).alarm_bell,
//                             "alarm bell",
//                             [
//                               for (int i = 0; i < items.length; i++)
//                                 if (items[i].itemId?.subCategory ==
//                                     "alarm bell") ...[
//                                   GetLanguageUseCase(injector())() == 'en'
//                                       ? items[i].itemId?.itemName?.en ?? ''
//                                       : items[i].itemId?.itemName?.ar ?? '',
//                                 ],
//                             ],
//                             (p1) {},
//                             ImagePaths.alarmBell,
//                             isButton: false,
//                             length: 0,
//                           ),
//                           buildSection(
//                             S.of(context).broken_glass,
//                             "glass breaker",
//                             [
//                               for (int i = 0; i < items.length; i++)
//                                 if (items[i].itemId?.subCategory ==
//                                     "glass breaker") ...[
//                                   GetLanguageUseCase(injector())() == 'en'
//                                       ? items[i].itemId?.itemName?.en ?? ''
//                                       : items[i].itemId?.itemName?.ar ?? '',
//                                 ],
//                             ],
//                             (p1) {},
//                             ImagePaths.breakGlass,
//                             length: items
//                                 .where((element) =>
//                                     element.itemId?.subCategory ==
//                                         "glass breaker" ||
//                                     element.itemId?.subCategory == "alarm bell")
//                                 .length,
//                           ),
//                         ],
//                       ),
//                     ),
//                     buildSection(
//                       S.of(context).emergency_lights,
//                       "emergency lighting",
//                       [
//                         for (int i = 0; i < items.length; i++)
//                           if (items[i].itemId?.subCategory ==
//                                   "Emergency Lighting" ||
//                               items[i].itemId?.subCategory ==
//                                   "Emergency Exit") ...[
//                             GetLanguageUseCase(injector())() == 'en'
//                                 ? items[i].itemId?.itemName?.en ?? ''
//                                 : items[i].itemId?.itemName?.ar ?? '',
//                           ],
//                       ],
//                       (p2) {},
//                       ImagePaths.lighting,
//                       length: items
//                           .where((element) =>
//                               element.itemId?.subCategory ==
//                                   "Emergency Lighting" ||
//                               element.itemId?.subCategory == "Emergency Exit")
//                           .length,
//                     ),
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           buildSection(
//                             S.of(context).pumps,
//                             "Fire pumps",
//                             [
//                               for (int i = 0; i < items.length; i++)
//                                 if (items[i].itemId?.subCategory ==
//                                     "Fire pumps") ...[
//                                   GetLanguageUseCase(injector())() == 'en'
//                                       ? items[i].itemId?.itemName?.en ?? ''
//                                       : items[i].itemId?.itemName?.ar ?? '',
//                                 ],
//                             ],
//                             (p3) {},
//                             ImagePaths.fireHydrant,
//                             isButton: false,
//                             length: 0,
//                           ),
//                           buildSection(
//                             S.of(context).external_sprinkler,
//                             "Automatic Sprinklers",
//                             [
//                               for (int i = 0; i < items.length; i++)
//                                 if (items[i].itemId?.subCategory ==
//                                     "Automatic Sprinklers") ...[
//                                   GetLanguageUseCase(injector())() == 'en'
//                                       ? items[i].itemId?.itemName?.en ?? ''
//                                       : items[i].itemId?.itemName?.ar ?? '',
//                                 ],
//                             ],
//                             (p3) {},
//                             ImagePaths.irrigation,
//                             isButton: false,
//                             length: 0,
//                           ),
//                           buildSection(
//                             S.of(context).fireBoxes,
//                             "fire Boxes",
//                             [
//                               //if not above item is not in the list
//                               for (int i = 0; i < items.length; i++)
//                                 if (items[i].itemId?.subCategory != "control panel" &&
//                                     items[i].itemId?.subCategory !=
//                                         "fire detector" &&
//                                     items[i].itemId?.subCategory !=
//                                         "alarm bell" &&
//                                     items[i].itemId?.subCategory !=
//                                         "glass breaker" &&
//                                     items[i].itemId?.subCategory !=
//                                         "Emergency Lighting" &&
//                                     items[i].itemId?.subCategory !=
//                                         "Emergency Exit" &&
//                                     items[i].itemId?.subCategory !=
//                                         "Fire pumps" &&
//                                     items[i].itemId?.subCategory !=
//                                         "Automatic Sprinklers") ...[
//                                   GetLanguageUseCase(injector())() == 'en'
//                                       ? items[i].itemId?.itemName?.en ?? ''
//                                       : items[i].itemId?.itemName?.ar ?? '',
//                                 ],
//                             ],
//                             (p3) {
//                               if (widget.isRepair) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => RepairEstimateScreen(
//                                         repairComplete: true),
//                                   ),
//                                 );
//                               } else {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         const SystemReportsPage(),
//                                   ),
//                                 );
//                               }
//                             },
//                             ImagePaths.fireBox,
//                             length: items
//                                 .where((element) =>
//                                     element.itemId?.subCategory != "control panel" &&
//                                     element.itemId?.subCategory !=
//                                         "fire detector" &&
//                                     element.itemId?.subCategory !=
//                                         "alarm bell" &&
//                                     element.itemId?.subCategory !=
//                                         "glass breaker" &&
//                                     element.itemId?.subCategory !=
//                                         "Emergency Lighting" &&
//                                     element.itemId?.subCategory !=
//                                         "Emergency Exit")
//                                 .length,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void onPageChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   void _showValidationError(String locationSelected, bool bool) {
//     showSnackBar(
//       context: context,
//       message: locationSelected,
//       color: !bool ? ColorSchemes.warning : ColorSchemes.success,
//       icon: !bool ? ImagePaths.error : ImagePaths.success,
//     );
//   }
//
//   Widget buildItem(String title, int index, {required String subCategory}) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       color: ColorSchemes.white,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 SvgPicture.asset(
//                   ImagePaths.priceTag,
//                   height: 16.h,
//                   width: 16.w,
//                   color: ColorSchemes.primary,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: ColorSchemes.secondary,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: S.of(context).available,
//                     value: 1,
//                     path: ImagePaths.quality,
//                     isReadOnly: true,
//                     controller: itemsQuantityController[index],
//                     onChanged: (value) {},
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: _buildInputField(
//                     label: S.of(context).required,
//                     value: 1,
//                     path: ImagePaths.technical,
//                     isReadOnly: false,
//                     controller: itemsEnterByUserController[index],
//                     onChanged: (value) {
//                       setState(() {
//                         changeQuantity[subCategory] = double.parse(value);
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInputField({
//     required String label,
//     required int value,
//     required String path,
//     required bool isReadOnly,
//     required TextEditingController controller,
//     required void Function(String) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             SvgPicture.asset(
//               path,
//               height: 16.h,
//               width: 16.w,
//               color: ColorSchemes.black,
//             ),
//             const SizedBox(width: 8),
//             Text(label, style: const TextStyle(fontSize: 14)),
//           ],
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 34.h,
//           child: TextFormField(
//             controller: controller,
//             readOnly: isReadOnly,
//             onChanged: (value) {
//               setState(() {
//                 controller.text = value;
//                 controller.selection = TextSelection.fromPosition(
//                   TextPosition(offset: value.length),
//                 );
//                 onChanged(value);
//               });
//               if (int.tryParse(value) != null) {
//                 int.parse(value);
//               }
//             },
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter quantity';
//               }
//               return null;
//             },
//             keyboardType: TextInputType.number,
//             style: const TextStyle(fontSize: 14),
//             decoration: InputDecoration(
//               fillColor: ColorSchemes.white,
//               filled: true,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(2),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(2),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(2),
//                 borderSide: const BorderSide(color: Colors.red),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(2),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 12,
//                 vertical: 6,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   int _counter = 0;
//
//   Widget buildSection(
//     String title,
//     String subCategory,
//     List<String> items,
//     void Function(int) onTap,
//     String path, {
//     bool isButton = true,
//     required int length,
//   }) {
//     print(_counter);
//     Widget buildSection = SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               SvgPicture.asset(
//                 path,
//                 height: 22.h,
//                 width: 22.w,
//                 color: ColorSchemes.primary,
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           ...items.asMap().entries.map(
//                 (entry) => buildItem(
//                   entry.value,
//                   entry.key + _counter,
//                   subCategory: subCategory,
//                 ),
//               ),
//           if (isButton) const SizedBox(height: 40),
//           if (isButton)
//             CustomButtonWidget(
//               onTap: () {
//                 if (_currentIndex < 3) {
//                   _counter += length;
//                   _pageController.nextPage(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.ease);
//                 }
//                 if (_currentIndex == 3) {
//                   for(var item in changeQuantity.entries){
//                     print('${item.key} ${item.value}');
//                   }
//                   onTap(_currentIndex);
//                 }
//               },
//               text: S.of(context).next,
//               backgroundColor: ColorSchemes.primary,
//               textColor: Colors.white,
//             ),
//           if (isButton) const SizedBox(height: 40),
//         ],
//       ),
//     );
//     return buildSection;
//   }
//
//   Widget buildPageIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(4, (index) {
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           height: 6,
//           width: 40,
//           decoration: BoxDecoration(
//             color: _currentIndex == index ? Colors.red[900] : Colors.grey[300],
//             borderRadius: BorderRadius.circular(4),
//           ),
//         );
//       }),
//     );
//   }
// }
//

class SystemReportsPage extends StatefulWidget {
  final List<AlarmItems> changedItems;
  final Map<String, double> changeQuantity;

  const SystemReportsPage({
    super.key,
    required this.changedItems,
    required this.changeQuantity,
  });

  @override
  State<SystemReportsPage> createState() => _SystemReportsPageState();
}

class _SystemReportsPageState extends State<SystemReportsPage> {
  List<String> itemsSectionIcon = [];
  double emergencyExitValue = 0.0;

  @override
  void initState() {
    super.initState();
    itemsSectionIcon = [
      ImagePaths.controlPanel,
      ImagePaths.smokeDetector,
      ImagePaths.alarmBell,
      ImagePaths.breakGlass,
      ImagePaths.lighting,
      ImagePaths.fireHydrant,
      ImagePaths.irrigation,
      ImagePaths.fireBox,
    ];
    emergencyExitValue = widget.changeQuantity['Emergency Exit'] ?? 0.0;
    widget.changeQuantity.removeWhere(
      (key, value) => key == 'Emergency Exit',
    );
  }

  String getSystemType(String item) {
    switch (item) {
      case 'Emergency Lighting':
        return S.of(context).emergency_lights;
      case 'glass breaker':
        return S.of(context).glass_breaker;
      case 'control panel':
        return S.of(context).control_panel;
      case 'alarm bell':
        return S.of(context).alarm_bell;
      case 'fire detector':
        return S.of(context).fireDetector;
      case 'Fire pumps':
        return S.of(context).fire_pumps;
      case 'Automatic Sprinklers':
        return S.of(context).autoSprinkler;
      case 'Fire Cabinets':
        return S.of(context).fireBoxes;
      default:
        return S.of(context).fireBoxes;
    }
  }

  Map<String, bool> generateFilteredItems() {
    return widget.changeQuantity.map((key, value) {
      final isEmergencyLighting = key == 'Emergency Lighting';
      final shouldShow = (!isEmergencyLighting && value > 0.0) ||
          (isEmergencyLighting && (value > 0.0 || emergencyExitValue > 0.0));

      return MapEntry(key, shouldShow);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorSchemes.white,
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
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
            items: generateFilteredItems(),
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
    required String icon,
    required Map<String, bool> items,
    String? title,
  }) {
    bool showSecondHeader = true;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Main section header
          Row(
            children: [
              Expanded(
                child: Text(
                  title ?? '',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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

          // Items
          ...items.entries.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            List<Widget> widgets = [];

            // Optional second section title after 5 items
            if (index == 5 && showSecondHeader) {
              widgets.addAll([
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title ?? '',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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
              ]);
              showSecondHeader = false;
            }

            widgets.add(
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    SvgPicture.asset(
                      index < itemsSectionIcon.length
                          ? itemsSectionIcon[index]
                          : ImagePaths.error, // fallback icon
                      width: 20,
                      height: 20,
                      color: ColorSchemes.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text(getSystemType(item.key),
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                trailing: SvgPicture.asset(
                  ImagePaths.arrowLeft,
                  width: 24,
                  height: 24,
                  color: const Color(0xFF7B0000),
                ),
                leading: Icon(
                  !item.value ? Icons.check_box : Icons.check_box_outline_blank,
                  color: !item.value
                      ? const Color(0xFF7B0000)
                      : ColorSchemes.border,
                ),
              ),
            );

            widgets.add(const Divider());

            return Column(children: widgets);
          }),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RepairEstimateScreen(
                      repairComplete: false,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
