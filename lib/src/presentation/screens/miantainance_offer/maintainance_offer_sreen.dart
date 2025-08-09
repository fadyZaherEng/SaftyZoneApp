import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_maintainance_item_prices_offer.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/src/presentation/blocs/fire_extinguishers/fire_extinguishers_bloc.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';

class MaintainanceOfferScreen extends BaseStatefulWidget {
  final String maintenanceOffer;
  final String scheduleJob;
  final String consumerRequest;
  final String responsibleEmployee;
  final String maintainanceReportId;
  final String billURL;
  final String itemSupplyPrice;

  const MaintainanceOfferScreen({
    super.key,
    required this.maintenanceOffer,
    required this.scheduleJob,
    required this.consumerRequest,
    required this.responsibleEmployee,
    required this.maintainanceReportId,
    required this.billURL,
    required this.itemSupplyPrice,
  });

  @override
  BaseState<MaintainanceOfferScreen> baseCreateState() =>
      _MaintainanceOfferScreenState();
}

class _MaintainanceOfferScreenState extends BaseState<MaintainanceOfferScreen> {
  FireExtinguishersBloc get _bloc =>
      BlocProvider.of<FireExtinguishersBloc>(context);
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  List<Item> controlPanellist = <Item>[];
  List<Item> alarmBellList = <Item>[];
  List<Item> fireDetectorList = <Item>[];
  List<Item> firePumpList = <Item>[];
  List<Item> autoSprinklerList = <Item>[];
  List<Item> fireBoxList = <Item>[];
  List<Item> emergencyLightList = <Item>[];
  List<Item> glassBreakerList = <Item>[];

  bool _isFirst = true;
  bool _isSecond = false;

  RemoteMaintainanceItemPricesOffer _maintainanceItemPricesOffer =
      RemoteMaintainanceItemPricesOffer();

  @override
  void initState() {
    debugPrint(widget.maintainanceReportId);
    debugPrint(widget.billURL);
    debugPrint(widget.itemSupplyPrice);
    super.initState();
    _bloc.add(MaintainanceRequestOfferEvent(
      maintainanceReportId: widget.maintainanceReportId,
    ));
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<FireExtinguishersBloc, FireExtinguishersState>(
      listener: (context, state) {
        if (state is MaintainanceRequestOfferLoadingState) {
          showLoading();
        } else if (state is MaintainanceRequestOfferSuccessState) {
          hideLoading();
          _maintainanceItemPricesOffer =
              state.remoteMaintainanceItemPricesOffer;
          controlPanellist.clear();
          alarmBellList.clear();
          fireDetectorList.clear();
          firePumpList.clear();
          autoSprinklerList.clear();
          fireBoxList.clear();
          emergencyLightList.clear();
          glassBreakerList.clear();

          for (int i = 0;
              i < (_maintainanceItemPricesOffer.result?.length ?? 0);
              i++) {
            if (_maintainanceItemPricesOffer.result?[i].subCategory ==
                'control panel') {
              controlPanellist
                  .addAll(_maintainanceItemPricesOffer.result?[i].item ?? []);
            } else if (_maintainanceItemPricesOffer.result?[i].subCategory ==
                'alarm bell') {
              alarmBellList
                  .addAll(_maintainanceItemPricesOffer.result?[i].item ?? []);
            } else if (_maintainanceItemPricesOffer.result?[i].subCategory ==
                'fire detector') {
              fireDetectorList
                  .addAll(_maintainanceItemPricesOffer.result?[i].item ?? []);
            } else if (_maintainanceItemPricesOffer.result?[i].subCategory ==
                'Fire pumps') {
              firePumpList
                  .addAll(_maintainanceItemPricesOffer.result?[i].item ?? []);
            } else if (_maintainanceItemPricesOffer.result?[i].subCategory ==
                'Automatic Sprinklers') {
              autoSprinklerList
                  .addAll(_maintainanceItemPricesOffer.result?[i].item ?? []);
            } else if (_maintainanceItemPricesOffer.result?[i].subCategory ==
                'Fire Cabinets') {
              fireBoxList
                  .addAll(_maintainanceItemPricesOffer.result?[i].item ?? []);
            } else if (_maintainanceItemPricesOffer.result?[i].subCategory ==
                'Emergency Lighting') {
              emergencyLightList
                  .addAll(_maintainanceItemPricesOffer.result?[i].item ?? []);
            } else if (_maintainanceItemPricesOffer.result?[i].subCategory ==
                'glass breaker') {
              glassBreakerList
                  .addAll(_maintainanceItemPricesOffer.result?[i].item ?? []);
            } else {
              controlPanellist
                  .addAll(_maintainanceItemPricesOffer.result?[i].item ?? []);
            }
          }
        } else if (state is MaintainanceRequestOfferErrorState) {
          hideLoading();
          _showValidationError(state.message, false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorSchemes.primary,
            title: Text(S.of(context).report_title),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  buildPageIndicator(),
                  const SizedBox(height: 16),
                  buildFirstPage(),
                  if (controlPanellist.isNotEmpty ||
                      fireDetectorList.isNotEmpty ||
                      alarmBellList.isNotEmpty ||
                      glassBreakerList.isNotEmpty)
                    const SizedBox(height: 32),
                  if ((controlPanellist.isNotEmpty ||
                          fireDetectorList.isNotEmpty ||
                          alarmBellList.isNotEmpty ||
                          glassBreakerList.isNotEmpty) &&
                      _isFirst)
                    CustomButtonWidget(
                      text: (emergencyLightList.isEmpty &&
                              firePumpList.isEmpty &&
                              autoSprinklerList.isEmpty &&
                              fireBoxList.isEmpty)
                          ? S.of(context).confirm
                          : S.of(context).next,
                      onTap: () {
                        (emergencyLightList.isEmpty &&
                                firePumpList.isEmpty &&
                                autoSprinklerList.isEmpty &&
                                fireBoxList.isEmpty)
                            ? setState(() {
                                //Todo create offer
                              })
                            : setState(() {
                                _isSecond = true;
                                _isFirst = false;
                              });
                      },
                      backgroundColor: ColorSchemes.primary,
                      textColor: ColorSchemes.white,
                    ),
                  if ((controlPanellist.isEmpty &&
                          fireDetectorList.isEmpty &&
                          alarmBellList.isEmpty &&
                          glassBreakerList.isEmpty) ||
                      _isSecond)
                    buildSecondPage(),
                  if ((controlPanellist.isEmpty &&
                          fireDetectorList.isEmpty &&
                          alarmBellList.isEmpty &&
                          glassBreakerList.isEmpty) ||
                      _isSecond)
                    const SizedBox(height: 32),
                  if (emergencyLightList.isNotEmpty ||
                      firePumpList.isNotEmpty ||
                      autoSprinklerList.isNotEmpty ||
                      fireBoxList.isNotEmpty) ...[
                    if ((controlPanellist.isEmpty &&
                            fireDetectorList.isEmpty &&
                            alarmBellList.isEmpty &&
                            glassBreakerList.isEmpty) ||
                        _isSecond)
                      CustomButtonWidget(
                        text: S.of(context).confirm,
                        onTap: () {
                          //Todo create offer
                        },
                        backgroundColor: ColorSchemes.primary,
                        textColor: ColorSchemes.white,
                      ),
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildFirstPage() {
    return Column(
      children: [
        if (controlPanellist.isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagePaths.controlPanel,
                      height: 22.h, width: 22.w, color: ColorSchemes.primary),
                  const SizedBox(width: 12),
                  Text(S.of(context).control_panel,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: controlPanellist.map((e) {
                  return buildItem(
                    (GetLanguageUseCase(injector())() == 'en'
                            ? e.itemName?.en
                            : e.itemName?.ar) ??
                        '',
                    itemsQuantityController:
                        TextEditingController(text: e.quantity.toString()),
                    itemPriceController:
                        TextEditingController(text: e.itemPrice.toString()),
                  );
                }).toList(),
              )
            ],
          ),
        if (controlPanellist.isNotEmpty) const SizedBox(height: 16),
        if (fireDetectorList.isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagePaths.controlPanel,
                      height: 22.h, width: 22.w, color: ColorSchemes.primary),
                  const SizedBox(width: 12),
                  Text(S.of(context).smokeDetector,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: fireDetectorList.map((e) {
                  return buildItem(
                    (GetLanguageUseCase(injector())() == 'en'
                            ? e.itemName?.en
                            : e.itemName?.ar) ??
                        '',
                    itemsQuantityController:
                        TextEditingController(text: e.quantity.toString()),
                    itemPriceController:
                        TextEditingController(text: e.itemPrice.toString()),
                  );
                }).toList(),
              )
            ],
          ),
        if (fireDetectorList.isNotEmpty) const SizedBox(height: 16),
        if (alarmBellList.isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagePaths.alarmBell,
                      height: 22.h, width: 22.w, color: ColorSchemes.primary),
                  const SizedBox(width: 12),
                  Text(S.of(context).alarm_bell,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: alarmBellList.map((e) {
                  return buildItem(
                    (GetLanguageUseCase(injector())() == 'en'
                            ? e.itemName?.en
                            : e.itemName?.ar) ??
                        '',
                    itemsQuantityController:
                        TextEditingController(text: e.quantity.toString()),
                    itemPriceController:
                        TextEditingController(text: e.itemPrice.toString()),
                  );
                }).toList(),
              )
            ],
          ),
        if (alarmBellList.isNotEmpty) const SizedBox(height: 16),
        if (glassBreakerList.isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagePaths.breakGlass,
                      height: 22.h, width: 22.w, color: ColorSchemes.primary),
                  const SizedBox(width: 12),
                  Text(S.of(context).broken_glass,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: glassBreakerList.map((e) {
                  return buildItem(
                    (GetLanguageUseCase(injector())() == 'en'
                            ? e.itemName?.en
                            : e.itemName?.ar) ??
                        '',
                    itemsQuantityController:
                        TextEditingController(text: e.quantity.toString()),
                    itemPriceController:
                        TextEditingController(text: e.itemPrice.toString()),
                  );
                }).toList(),
              )
            ],
          ),
        if (glassBreakerList.isNotEmpty) const SizedBox(height: 16),
      ],
    );
  }

  Widget buildSecondPage() {
    return Column(
      children: [
        if (emergencyLightList.isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagePaths.lighting,
                      height: 22.h, width: 22.w, color: ColorSchemes.primary),
                  const SizedBox(width: 12),
                  Text(S.of(context).emergency_lights,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: emergencyLightList.map((e) {
                  return buildItem(
                    (GetLanguageUseCase(injector())() == 'en'
                            ? e.itemName?.en
                            : e.itemName?.ar) ??
                        '',
                    itemsQuantityController:
                        TextEditingController(text: e.quantity.toString()),
                    itemPriceController:
                        TextEditingController(text: e.itemPrice.toString()),
                  );
                }).toList(),
              )
            ],
          ),
        if (emergencyLightList.isNotEmpty) const SizedBox(height: 16),
        if (firePumpList.isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagePaths.fireHydrant,
                      height: 22.h, width: 22.w, color: ColorSchemes.primary),
                  const SizedBox(width: 12),
                  Text(S.of(context).pumps,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: firePumpList.map((e) {
                  return buildItem(
                    (GetLanguageUseCase(injector())() == 'en'
                            ? e.itemName?.en
                            : e.itemName?.ar) ??
                        '',
                    itemsQuantityController:
                        TextEditingController(text: e.quantity.toString()),
                    itemPriceController:
                        TextEditingController(text: e.itemPrice.toString()),
                  );
                }).toList(),
              )
            ],
          ),
        if (firePumpList.isNotEmpty) const SizedBox(height: 16),
        if (autoSprinklerList.isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagePaths.irrigation,
                      height: 22.h, width: 22.w, color: ColorSchemes.primary),
                  const SizedBox(width: 12),
                  Text(S.of(context).external_sprinkler,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: autoSprinklerList.map((e) {
                  return buildItem(
                    (GetLanguageUseCase(injector())() == 'en'
                            ? e.itemName?.en
                            : e.itemName?.ar) ??
                        '',
                    itemsQuantityController:
                        TextEditingController(text: e.quantity.toString()),
                    itemPriceController:
                        TextEditingController(text: e.itemPrice.toString()),
                  );
                }).toList(),
              )
            ],
          ),
        if (autoSprinklerList.isNotEmpty) const SizedBox(height: 16),
        if (fireBoxList.isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImagePaths.fireBox,
                      height: 22.h, width: 22.w, color: ColorSchemes.primary),
                  const SizedBox(width: 12),
                  Text(S.of(context).fireBoxes,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: fireBoxList.map((e) {
                  return buildItem(
                    (GetLanguageUseCase(injector())() == 'en'
                            ? e.itemName?.en
                            : e.itemName?.ar) ??
                        '',
                    itemsQuantityController:
                        TextEditingController(text: e.quantity.toString()),
                    itemPriceController:
                        TextEditingController(text: e.itemPrice.toString()),
                  );
                }).toList(),
              )
            ],
          ),
        if (fireBoxList.isNotEmpty) const SizedBox(height: 16),
      ],
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

  Widget buildItem(
    String title, {
    required TextEditingController itemsQuantityController,
    required TextEditingController itemPriceController,
  }) {
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
                    path: ImagePaths.quality,
                    controller: itemsQuantityController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInputField(
                    label: S.of(context).costRepair,
                    path: ImagePaths.technical,
                    controller: itemPriceController,
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
    required String path,
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
            Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 34.h,
          child: TextFormField(
            controller: controller,
            readOnly: true,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              fillColor: ColorSchemes.white,
              filled: true,
              errorText: null,
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
    if (emergencyLightList.isNotEmpty ||
        firePumpList.isNotEmpty ||
        autoSprinklerList.isNotEmpty ||
        fireBoxList.isNotEmpty) {
      if ((controlPanellist.isEmpty &&
              fireDetectorList.isEmpty &&
              alarmBellList.isEmpty &&
              glassBreakerList.isEmpty) ||
          _isSecond) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                color: (_isFirst && index == 0) || (_isSecond && index == 1)
                    ? ColorSchemes.primary
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        );
      }
    }

    return const SizedBox.shrink();
  }
}
