import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/maintainance_report_request.dart'
    as maintainance_report_request;
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/usecase/auth/check_auth_use_case.dart';
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

  RemoteFirstScreenSchedule firstScreenSchedule = RemoteFirstScreenSchedule();
  List<AlarmItems> items = [];
  List<AlarmItems> changedItems = [];
  List<TextEditingController> itemsEnterByUserController = [];
  List<TextEditingController> itemsQuantityController = [];
  Map<String, double> changeQuantity = {};
  List<GlobalKey<FormState>> formKey = [];
  List<String?> quantityError = [];

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

          for (final item in items) {
            formKey.add(GlobalKey<FormState>());
            quantityError.add(null);
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
                    _buildPage(
                      [
                        _buildSection(S.of(context).control_panel,
                            "control panel", ImagePaths.controlPanel, false),
                        _buildSection(
                          S.of(context).fireDetector,
                          "fire detector",
                          ImagePaths.smokeDetector,
                          true,
                        ),
                      ],
                    ),
                    _buildPage(
                      [
                        _buildSection(S.of(context).alarm_bell, "alarm bell",
                            ImagePaths.alarmBell, false),
                        _buildSection(
                          S.of(context).broken_glass,
                          "glass breaker",
                          ImagePaths.breakGlass,
                          true,
                        ),
                      ],
                    ),
                    _buildPage(
                      [
                        _buildSection(
                          S.of(context).emergency_lights,
                          "Emergency Lighting",
                          ImagePaths.lighting,
                          true,
                          extraSub: "Emergency Exit",
                        ),
                      ],
                    ),
                    _buildPage(
                      [
                        _buildSection(S.of(context).pumps, "Fire pumps",
                            ImagePaths.fireHydrant, false),
                        _buildSection(
                          S.of(context).external_sprinkler,
                          "Automatic Sprinklers",
                          ImagePaths.irrigation,
                          false,
                        ),
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
                          isLastPage: true,
                        ),
                      ],
                    ),
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
                // for (final key in formKey) {
                //   final formState = key.currentState;
                //   if (formState == null || !formState.validate()) {
                //     return;
                //   }
                // }
                for (int i = 0; i < quantityError.length; i++) {
                  if (quantityError[i] != null) {
                    return;
                  }
                }
                if (_currentIndex < 3) {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                }
                if (isLastPage) {
                  if (widget.isRepair) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RepairEstimateScreen(
                          repairComplete: true,
                          changeQuantity: {},
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SystemReportsPage(
                          changedItems: changedItems,
                          changeQuantity: changeQuantity,
                          alarmItemLength: firstScreenSchedule
                                  .data?.consumerRequest?.alarmItems?.length ??
                              0,
                          fireSystemItemLength: firstScreenSchedule.data
                                  ?.consumerRequest?.fireSystemItem?.length ??
                              0,
                          branch: widget.scheduleJop.branch.Id,
                          consumer: widget.scheduleJop.consumer,
                          consumerRequest: widget.scheduleJop.consumerRequest,
                          offer: widget.scheduleJop.offer,
                          scheduleJob: widget.scheduleJop.Id,
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
                    compareValue:
                        int.parse(itemsQuantityController[index].text),
                    index: index,
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
                              .copyWith(malfunctionsNumber: int.parse(value));
                        }
                      });
                    },
                    compareValue:
                        int.parse(itemsQuantityController[index].text),
                    index: index,
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
    required int compareValue,
    required int index,
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
          height: quantityError[index] == null ? 34.h : 90.h,
          child: TextFormField(
            controller: controller,
            readOnly: isReadOnly,
            onChanged: (value) {
              controller.text = value;
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.length));
              onChanged(value);
              if (!isReadOnly) {
                debugPrint('isReadOnly: $isReadOnly');
                debugPrint('compareValue: $compareValue');
                debugPrint('controller.text: ${controller.text}');
                setState(() {
                  if (controller.text.isNotEmpty) {
                    if ((int.tryParse(controller.text) ?? 0) > compareValue) {
                      quantityError[index] = S.of(context).quantity_exceed;
                    } else if ((int.tryParse(controller.text) ?? 0) < 0) {
                      quantityError[index] = S.of(context).quantity_less;
                    } else {
                      quantityError[index] = null;
                    }
                  }
                });
              }
            },
            // validator: (value) {
            //   if (isReadOnly) return null;
            //   if (value != null && value.isNotEmpty) {
            //     if ((int.tryParse(value) ?? 0) > compareValue) {
            //       setState(() {});
            //       return S.of(context).quantity_exceed;
            //     } else if ((int.tryParse(value) ?? 0) < 0) {
            //       setState(() {});
            //       return S.of(context).quantity_less;
            //     } else {
            //       return null;
            //     }
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              fillColor: ColorSchemes.white,
              filled: true,
              errorText: isReadOnly ? null : quantityError[index],
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

class SystemReportsPage extends StatefulWidget {
  final List<AlarmItems> changedItems;
  final Map<String, double> changeQuantity;
  final int alarmItemLength;
  final int fireSystemItemLength;
  final String scheduleJob;
  final String consumerRequest;
  final String consumer;
  final String branch;
  final String offer;

  const SystemReportsPage({
    super.key,
    required this.changedItems,
    required this.changeQuantity,
    required this.alarmItemLength,
    required this.fireSystemItemLength,
    required this.scheduleJob,
    required this.consumerRequest,
    required this.consumer,
    required this.branch,
    required this.offer,
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
                  builder: (context) => MaintenanceReportScreen(
                    changedItems: widget.changedItems,
                    changeQuantity: widget.changeQuantity,
                    alarmItemLength: widget.alarmItemLength,
                    fireSystemItemLength: widget.fireSystemItemLength,
                    scheduleJob: widget.scheduleJob,
                    consumerRequest: widget.consumerRequest,
                    consumer: widget.consumer,
                    branch: widget.branch,
                    offer: widget.offer,
                  ),
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

class MaintenanceReportScreen extends BaseStatefulWidget {
  final List<AlarmItems> changedItems;
  final Map<String, double> changeQuantity;
  final int alarmItemLength;
  final int fireSystemItemLength;
  final String scheduleJob;
  final String consumerRequest;
  final String consumer;
  final String branch;
  final String offer;

  const MaintenanceReportScreen({
    super.key,
    required this.changedItems,
    required this.changeQuantity,
    required this.alarmItemLength,
    required this.fireSystemItemLength,
    required this.scheduleJob,
    required this.consumerRequest,
    required this.consumer,
    required this.branch,
    required this.offer,
  });

  @override
  BaseState<MaintenanceReportScreen> baseCreateState() =>
      _MaintenanceReportScreenState();
}

enum MaintenanceStatus {
  needMaintenance,
  notNeedMaintenance,
  offerSend,
  offerAccepted,
  offerRejected,
  maintenanceInProgress,
  maintenanceDone,
}

enum SafetyStatus {
  safe,
  normal,
  dangerous,
}

class _MaintenanceReportScreenState extends BaseState<MaintenanceReportScreen> {
  FireExtinguishersBloc get _bloc =>
      BlocProvider.of<FireExtinguishersBloc>(context);
  List<maintainance_report_request.AlarmItem> alarmItems = [];
  List<maintainance_report_request.FireSystemItem> fireSystemItems = [];
  String selectedStatus = MaintenanceStatus.needMaintenance.name;
  String selectedSafetyStatus = SafetyStatus.safe.name;
  String anyDetails = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.alarmItemLength; i++) {
      alarmItems.add(maintainance_report_request.AlarmItem(
        item: widget.changedItems[i].Id,
        quantity: widget.changedItems[i].quantity,
        malfunctionsNumber: widget.changedItems[i].malfunctionsNumber,
      ));
    }

    for (var i = widget.alarmItemLength; i < widget.changedItems.length; i++) {
      fireSystemItems.add(maintainance_report_request.FireSystemItem(
        item: widget.changedItems[i].Id,
        quantity: widget.changedItems[i].quantity,
        malfunctionsNumber: widget.changedItems[i].malfunctionsNumber,
      ));
    }
  }

  DataState<CheckAuth>? result;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    result = (await CheckAuthUseCase(injector())());
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<FireExtinguishersBloc, FireExtinguishersState>(
        listener: (context, state) {
      if (state is MaintainanceReportLoadingState) {
        showLoading();
      } else if (state is MaintainanceReportSuccessState) {
        hideLoading();
        showSuccessToast(S.of(context).success);
        if (state.remoteMaintainanceReport.maintenanceOfferStatus
                ?.toLowerCase() ==
            MaintenanceStatus.needMaintenance.name.toLowerCase()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SystemErrorScreen(
                changeQuantity: widget.changeQuantity,
              ),
            ),
          );
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      } else if (state is MaintainanceReportErrorState) {
        hideLoading();
        showErrorToast(state.message);
      }
    }, builder: (context, state) {
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
                        style: TextStyle(
                          color: ColorSchemes.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        },
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
                          Expanded(
                              child: _buildSectionTitle("${t.alarm_type}*")),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        style: TextStyle(
                          color: ColorSchemes.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'ادخل نوع النظام الإنذار العادي',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            anyDetails = value;
                          });
                        },
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
                        enabled: false,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: ColorSchemes.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: result?.data?.employeeDetails.fullName,
                          border: OutlineInputBorder(),
                        ),
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
                  _bloc.add(
                    MaintainanceReportEvent(
                      maintainanceReportRequest:
                          maintainance_report_request.MaintainanceReportRequest(
                        branch: widget.branch,
                        safetyStatus: selectedSafetyStatus,
                        description: description,
                        details: anyDetails,
                        consumerRequest: widget.consumerRequest,
                        alarmItem: alarmItems,
                        fireSystemItem: fireSystemItems,
                        consumer: widget.consumer,
                        offer: widget.offer,
                        scheduleJob: widget.scheduleJob,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      );
    });
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
              value: selectedSafetyStatus == SafetyStatus.safe.name,
              contentPadding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (_) {
                setState(() {
                  selectedSafetyStatus = SafetyStatus.safe.name;
                });
              },
              title: Text(t.very_safe),
            ),
          ),
          Expanded(
            child: CheckboxListTile(
              value: selectedSafetyStatus == SafetyStatus.normal.name,
              contentPadding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (_) {
                setState(() {
                  selectedSafetyStatus = SafetyStatus.normal.name;
                });
              },
              title: Text(t.moderate),
            ),
          ),
          Expanded(
            child: CheckboxListTile(
              value: selectedSafetyStatus == SafetyStatus.dangerous.name,
              contentPadding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (_) {
                setState(() {
                  selectedSafetyStatus = SafetyStatus.dangerous.name;
                });
              },
              title: Text(t.danger),
            ),
          ),
        ],
      ),
    );
  }

  void showErrorToast(String message) {
    showSnackBar(
      context: context,
      message: message,
      color: ColorSchemes.warning,
      icon: ImagePaths.error,
    );
  }

  void showSuccessToast(message) {
    showSnackBar(
      context: context,
      message: message,
      color: ColorSchemes.success,
      icon: ImagePaths.success,
    );
  }
}

class SystemErrorScreen extends StatefulWidget {
  final Map<String, double> changeQuantity;

  const SystemErrorScreen({
    super.key,
    required this.changeQuantity,
  });

  @override
  State<SystemErrorScreen> createState() => _SystemErrorScreenState();
}

class _SystemErrorScreenState extends State<SystemErrorScreen> {
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
                      changeQuantity: widget.changeQuantity,
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
