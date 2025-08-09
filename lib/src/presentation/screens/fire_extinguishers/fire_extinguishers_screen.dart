import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_add_recieve.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_second_and_third_schedule.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_update_status_deliver.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/add_recieve_request.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/main_offer_fire_extinguisher.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/src/presentation/blocs/fire_extinguishers/fire_extinguishers_bloc.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/android_date_picker.dart';
import '../../../core/utils/ios_date_picker.dart';

class ReviewItems {
  String title;
  int numberArrived;
  int totalPrice;
  String image;

  ReviewItems({
    required this.title,
    required this.numberArrived,
    required this.totalPrice,
    required this.image,
  });

  //copy with
  ReviewItems copyWith({
    String? title,
    int? numberArrived,
    int? totalPrice,
    String? image,
  }) =>
      ReviewItems(
        title: title ?? this.title,
        numberArrived: numberArrived ?? this.numberArrived,
        totalPrice: totalPrice ?? this.totalPrice,
        image: image ?? this.image,
      );
}

class FireExtinguishersScreen extends BaseStatefulWidget {
  final ScheduleJop scheduleJop;
  final bool isFirstPage;
  final bool isSecondPage;
  final bool isThirdPage;

  const FireExtinguishersScreen({
    super.key,
    required this.scheduleJop,
    required this.isFirstPage,
    required this.isSecondPage,
    required this.isThirdPage,
  });

  @override
  BaseState<FireExtinguishersScreen> baseCreateState() =>
      _FireExtinguishersScreenState();
}

class _FireExtinguishersScreenState extends BaseState<FireExtinguishersScreen> {
  final List<TextEditingController> _firstPageControllers = [];
  final List<TextEditingController> _secondPageControllers = [];
  final List<TextEditingController> _thirdPageControllers = [];
  bool _isFirstPage = true;
  bool _isSecondPage = false;
  bool _isThirdPage = false;
  RemoteSecondAndThirdSchedule secondAndThirdSchedule =
      RemoteSecondAndThirdSchedule();
  RemoteFirstScreenSchedule firstScreenSchedule = RemoteFirstScreenSchedule();
  RemoteMainOfferFireExtinguisher mainOfferFireExtinguisher =
      RemoteMainOfferFireExtinguisher();
  RemoteUpdateStatusDeliver updateStatusDeliver = RemoteUpdateStatusDeliver();
  RemoteAddRecieve addRecieve = RemoteAddRecieve();

  FireExtinguishersBloc get _bloc =>
      BlocProvider.of<FireExtinguishersBloc>(context);
  List<GlobalKey<FormState>> firstPageFormKeys = [];
  List<GlobalKey<FormState>> secondPageFormKeys = [];
  List<Item> tempItems = [];
  List<ReviewItems> reviewItems = [];

  @override
  void initState() {
    if (widget.isFirstPage) {
      _bloc.add(GetFirstScreenScheduleEvent(id: widget.scheduleJop.Id));
    }
    super.initState();
    _isFirstPage = widget.isFirstPage;
    _isSecondPage = widget.isSecondPage;
    _isThirdPage = widget.isThirdPage;
    if (widget.isSecondPage) {
      _bloc.add(GetSecondAndThirdScreenScheduleEvent(
          id: widget.scheduleJop.receiveItem));
    } else if (widget.isThirdPage) {
      _bloc.add(GetSecondAndThirdScreenScheduleEvent(
          id: widget.scheduleJop.receiveItem));
    }
  }

  @override
  Widget baseBuild(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<FireExtinguishersBloc, FireExtinguishersState>(
      listener: (context, state) {
        if (state is GetFirstScreenScheduleSuccessState) {
          firstScreenSchedule = state.remoteFirstScreenSchedule;
          _showValidationError(
              state.remoteFirstScreenSchedule.message.toString(), true);
          List<AlarmItems> fireExtinguisher =
              firstScreenSchedule.data?.consumerRequest?.fireExtinguisherItem ??
                  [];
          for (int i = 0; i < fireExtinguisher.length; i++) {
            _firstPageControllers.add(TextEditingController());
            firstPageFormKeys.add(GlobalKey<FormState>());
          }
        } else if (state is GetFirstScreenScheduleErrorState) {
          _showValidationError(state.message, false);
        } else if (state is MainOfferFireExtinguishersLoadingState) {
          showLoading();
        } else if (state is MainOfferFireExtinguishersSuccessState) {
          mainOfferFireExtinguisher = state.remoteMainOfferFireExtinguisher;
          hideLoading();
          _showValidationError(S.of(context).success, true);
          _isSecondPage = false;
          _isFirstPage = false;
          _isThirdPage = true;
          final fireExtinguishers =
              secondAndThirdSchedule.data?.fireExtinguisher ?? [];

          reviewItems = List.generate(fireExtinguishers.length, (index) {
            final extinguisher = fireExtinguishers[index];
            final item = extinguisher.itemId;

            return ReviewItems(
              title: (GetLanguageUseCase(injector())() == 'en'
                      ? item?.itemName?.en
                      : item?.itemName?.ar) ??
                  s.powder6Kg,
              numberArrived: extinguisher.receivedQuantity ?? 0,
              totalPrice: 0,
              image: item?.image ?? ImagePaths.firePng1,
            );
          });

          // تحديث الأسعار بعد الإنشاء
          reviewItems = reviewItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return item.copyWith(
              totalPrice: tempItems[index].price,
            );
          }).toList();
        } else if (state is MainOfferFireExtinguishersErrorState) {
          _showValidationError(state.message, false);
          hideLoading();
          _isSecondPage = false;
          _isFirstPage = false;
          _isThirdPage = true;
          final fireExtinguishers =
              secondAndThirdSchedule.data?.fireExtinguisher ?? [];

          reviewItems = List.generate(fireExtinguishers.length, (index) {
            final extinguisher = fireExtinguishers[index];
            final item = extinguisher.itemId;

            return ReviewItems(
              title: (GetLanguageUseCase(injector())() == 'en'
                      ? item?.itemName?.en
                      : item?.itemName?.ar) ??
                  s.powder6Kg,
              numberArrived: extinguisher.receivedQuantity ?? 0,
              totalPrice: 0,
              image: item?.image ?? ImagePaths.firePng1,
            );
          });

          // تحديث الأسعار بعد الإنشاء
          reviewItems = reviewItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return item.copyWith(
              totalPrice: tempItems[index].price,
            );
          }).toList();
        } else if (state is GetSecondAndThirdScreenScheduleErrorState) {
          _showValidationError(state.message, false);
          hideLoading();
        } else if (state is GetSecondAndThirdScreenScheduleSuccessState) {
          secondAndThirdSchedule = state.remoteSecondAndThirdSchedule;
          hideLoading();
          _showValidationError(
              state.remoteSecondAndThirdSchedule.message.toString(), true);

          final secondPageLength =
              secondAndThirdSchedule.data?.fireExtinguisher?.length ?? 0;
          for (int i = 0; i < secondPageLength; i++) {
            _secondPageControllers.add(TextEditingController());
            secondPageFormKeys.add(GlobalKey<FormState>());
          }
        } else if (state is UpdateStatusToReceiveLoadingState) {
          showLoading();
        } else if (state is UpdateStatusToReceiveErrorState) {
          _showValidationError(state.message, false);
          hideLoading();
          Navigator.pop(context);
        } else if (state is UpdateStatusToReceiveSuccessState) {
          _showValidationError(
              state.remoteUpdateStatusDeliver.message.toString(), true);
          hideLoading();
          updateStatusDeliver = state.remoteUpdateStatusDeliver;
          Navigator.pop(context);
        } else if (state is AddReceiveToDeliverLoadingState) {
          showLoading();
        } else if (state is AddReceiveToDeliverErrorState) {
          _showValidationError(state.message, false);
          hideLoading();
        } else if (state is AddReceiveToDeliverSuccessState) {
          hideLoading();
          _showValidationError(state.remoteAddRecieve.message.toString(), true);
          addRecieve = state.remoteAddRecieve;
          _isSecondPage = true;
          _isFirstPage = false;
          _isThirdPage = false;
          _bloc.add(GetSecondAndThirdScreenScheduleEvent(
              id: addRecieve.data?.Id ?? ""));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
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
              enabled: state is GetSecondAndThirdScreenScheduleLoadingState ||
                  state is GetFirstScreenScheduleLoadingState,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCardHeader(s),

                    /// first page of fire extinguishers
                    if (_isFirstPage &&
                        firstScreenSchedule.data != null &&
                        firstScreenSchedule.data!.consumerRequest != null &&
                        firstScreenSchedule
                                .data!.consumerRequest!.fireExtinguisherItem !=
                            null &&
                        firstScreenSchedule.data!.consumerRequest!
                            .fireExtinguisherItem!.isNotEmpty)
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        children: firstScreenSchedule
                                .data?.consumerRequest?.fireExtinguisherItem
                                ?.asMap()
                                .entries
                                .map(
                                  (e) => _buildItem(
                                    context,
                                    imagePath: e.value.itemId?.image ??
                                        ImagePaths.firePng1,
                                    title: (GetLanguageUseCase(injector())() ==
                                                'en'
                                            ? e.value.itemId?.itemName?.en
                                            : e.value.itemId?.itemName?.ar) ??
                                        s.powder6Kg,
                                    receivedCount: 0,
                                    clientCount: e.value.quantity ?? 0,
                                    controller: _firstPageControllers[e.key],
                                    formKey: firstPageFormKeys[e.key],
                                  ),
                                )
                                .toList() ??
                            [],
                      ),

                    if (_isFirstPage) const SizedBox(height: 32),
                    if (_isFirstPage) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButtonWidget(
                          text: S.of(context).save,
                          backgroundColor: ColorSchemes.primary,
                          textColor: Colors.white,
                          onTap: () {
                            bool isValid = true;
                            for (var element in firstPageFormKeys) {
                              if (!element.currentState!.validate()) {
                                isValid = false;
                              }
                            }
                            if (isValid) {
                              _bloc.add(
                                AddReceiveToDeliverEvent(
                                  request: AddRecieveRequest(
                                    consumerRequest: firstScreenSchedule
                                            .data?.consumerRequest?.Id ??
                                        "",
                                    branch:
                                        firstScreenSchedule.data?.branch?.Id ??
                                            "",
                                    consumer: firstScreenSchedule
                                            .data?.consumerRequest?.Id ??
                                        "",
                                    scheduleJob: widget.scheduleJop.Id,
                                    fireExtinguisher: firstScreenSchedule
                                            .data
                                            ?.consumerRequest
                                            ?.fireExtinguisherItem
                                            ?.asMap()
                                            .entries
                                            .map((e) => RequestFireExtinguisher(
                                                item_id:
                                                    e.value.itemId?.Id ?? "",
                                                receivedQuantity: int.parse(
                                                    _firstPageControllers[e.key]
                                                        .text)))
                                            .toList() ??
                                        [],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],

                    /// second page of fire extinguishers
                    if (_isSecondPage &&
                        secondAndThirdSchedule.data != null &&
                        secondAndThirdSchedule.data!.fireExtinguisher != null &&
                        secondAndThirdSchedule
                            .data!.fireExtinguisher!.isNotEmpty)
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        children: secondAndThirdSchedule.data?.fireExtinguisher
                                ?.asMap()
                                .entries
                                .map((e) {
                              return _buildItem(
                                context,
                                imagePath: e.value.itemId?.image ??
                                    ImagePaths.firePng2,
                                title: (GetLanguageUseCase(injector())() == 'en'
                                        ? e.value?.itemId?.itemName?.en
                                        : e.value?.itemId?.itemName?.ar) ??
                                    s.powder6Kg,
                                receivedCount: 0,
                                clientCount: e.value.receivedQuantity ?? 0,
                                controller: _secondPageControllers[e.key],
                                formKey: secondPageFormKeys[e.key],
                              );
                            }).toList() ??
                            [],
                      ),
                    if (_isSecondPage) const SizedBox(height: 32),
                    if (_isSecondPage) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButtonWidget(
                          text: S.of(context).sendPriceOffer,
                          backgroundColor: ColorSchemes.primary,
                          textColor: Colors.white,
                          onTap: () {
                            final List<Item> items = [];
                            int total = 0;
                            int lengthFire = secondAndThirdSchedule
                                    .data?.fireExtinguisher?.length ??
                                0;
                            for (int i = 0; i < lengthFire; i++) {
                              AlarmItems element = firstScreenSchedule
                                      .data
                                      ?.consumerRequest
                                      ?.fireExtinguisherItem?[i] ??
                                  AlarmItems();
                              final entrePrice = _secondPageControllers[i]
                                      .text
                                      .isNotEmpty
                                  ? int.parse(_secondPageControllers[i].text)
                                  : 0;
                              total += entrePrice;
                              items.add(Item(
                                price: entrePrice,
                                quantity: element.quantity ?? 0,
                                ItemId: element.itemId?.Id ?? "",
                              ));
                            }
                            tempItems = List.from(items);
                            _bloc.add(
                              MainOfferFireExtinguishersEvent(
                                mainOfferFireExtinguisher:
                                    MainOfferFireExtinguisher(
                                  consumerRequest:
                                      widget.scheduleJop.consumerRequest,
                                  scheduleJob: widget.scheduleJop.Id,
                                  responsibleEmployee:
                                      widget.scheduleJop.responseEmployee.Id,
                                  items: items,
                                  price: total,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    /// third page of fire extinguishers
                    if (_isThirdPage)
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        children: reviewItems
                            .map(
                              (e) => _buildItem(
                                context,
                                imagePath: e.image,
                                title: e.title,
                                receivedCount: e.totalPrice,
                                clientCount: e.numberArrived,
                                controller: TextEditingController(),
                                formKey: GlobalKey<FormState>(),
                              ),
                            )
                            .toList(),
                      ),
                    if (_isThirdPage) ...[
                      Column(
                        children: [
                          const SizedBox(height: 32),
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
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomButtonWidget(
                              text: S.of(context).fireExtinguishersDelivery,
                              backgroundColor: ColorSchemes.primary,
                              textColor: Colors.white,
                              onTap: () {
                                _bloc.add(
                                  UpdateStatusToDeliverEvent(
                                    scheduleJopId: widget.scheduleJop.Id,
                                    receiverId: addRecieve.data?.Id ?? "",
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String imagePath,
    required String title,
    required int clientCount,
    required int receivedCount,
    required TextEditingController controller,
    required GlobalKey<FormState> formKey,
  }) {
    final s = S.of(context);
    final TextEditingController clientCountController =
        TextEditingController(text: clientCount.toString());
    final TextEditingController receivedCountController =
        TextEditingController(text: receivedCount.toString());
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
                    fontSize: 15.sp,
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
                        label: _isSecondPage || _isThirdPage
                            ? s.receivedCount
                            : s.availableAtClient,
                        value: clientCount,
                        path: ImagePaths.quality,
                        isReadOnly: true,
                        controller: clientCountController,
                      ),
                      const SizedBox(height: 8),
                      _isFirstPage
                          ? _buildFirstInputField(
                              label: _isThirdPage
                                  ? s.numberArrivedForClient
                                  : _isSecondPage
                                      ? s.totalPrice
                                      : s.receivedCount,
                              value: receivedCount,
                              isReadOnly: false,
                              path: ImagePaths.technical,
                              controller: controller,
                              clientCount: clientCount,
                              formKey: formKey,
                            )
                          : _isSecondPage
                              ? _buildInputField(
                                  label: _isThirdPage
                                      ? s.numberArrivedForClient
                                      : _isSecondPage
                                          ? s.totalPrice
                                          : s.receivedCount,
                                  value: receivedCount,
                                  isReadOnly: false,
                                  path: ImagePaths.technical,
                                  controller: controller,
                                )
                              : _buildInputField(
                                  label: s.totalPrice,
                                  value: receivedCount,
                                  isReadOnly: false,
                                  path: ImagePaths.technical,
                                  controller: receivedCountController,
                                ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Image.network(
                  imagePath,
                  height: 100.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstInputField({
    required String label,
    required int value,
    required String path,
    required bool isReadOnly,
    required TextEditingController controller,
    required int clientCount,
    required GlobalKey<FormState> formKey,
  }) {
    return Form(
      key: formKey,
      child: Column(
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
            height: formKey.currentState?.validate() == true ? 34.h : 70.h,
            child: TextFormField(
              controller: controller,
              readOnly: isReadOnly,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                } else if (int.parse(value) > clientCount) {
                  return '${S.of(context).pleaseEnterANumberLessThanOrEqualTo} $clientCount';
                }
                return null;
              },
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
        const SizedBox(height: 4),
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

  Widget _buildCardHeader(S s) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        _getStatus(widget.scheduleJop.status),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: ColorSchemes.black,
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
        ),
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
      ],
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

  String _getStatus(String status) {
    if (status.toLowerCase() == "pending") {
      return S.of(context).pending;
    } else if (status.toLowerCase() == "accepted") {
      return S.of(context).accepted;
    } else if (status.toLowerCase() == "rejected") {
      return S.of(context).rejected;
    } else if (status.toLowerCase() == "cancelled") {
      return S.of(context).cancelled;
    } else if (status.toLowerCase() == "active") {
      return S.of(context).active;
    } else if (status.toLowerCase() == "inProgress") {
      return S.of(context).inProgress;
    } else {
      return S.of(context).rejected;
    }
  }
}
