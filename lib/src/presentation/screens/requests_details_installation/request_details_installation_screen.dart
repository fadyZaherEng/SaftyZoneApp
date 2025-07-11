import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/create_employee.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/presentation/blocs/requests/requests_bloc.dart';
import 'package:safety_zone/src/presentation/screens/map_search/map_search_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RequestDetailsInstallationScreen extends StatefulWidget {
  final String requestId;

  const RequestDetailsInstallationScreen({
    super.key,
    required this.requestId,
  });

  @override
  State<RequestDetailsInstallationScreen> createState() =>
      _RequestDetailsInstallationScreenState();
}

class _RequestDetailsInstallationScreenState
    extends State<RequestDetailsInstallationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _priceController = TextEditingController();
  int _currentIndex = 0;
  RequestDetails model = RequestDetails();
  bool _isPriceSending = false;
  bool _isLoading = true;

  RequestsBloc get _bloc => BlocProvider.of<RequestsBloc>(context);
  final List<Items> _itemsAlarm = [];
  final List<Items> _itemsFire = [];
  List<Employee> _employees = [];
  Employee? _selectedEmployee = Employee();

  @override
  void initState() {
    _bloc.add(GetConsumerRequestsDetailsEvent(requestId: widget.requestId));
    _bloc.add(GetEmployeesEvent());
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<RequestsBloc, RequestsState>(
        listener: (context, state) {
      if (state is GetConsumerRequestDetailsLoadingState) {
        _isLoading = true;
      } else if (state is GetConsumerRequestDetailsSuccessState) {
        setState(() {
          model = state.requestDetails;
        });
        _isLoading = false;
        _filterItems(model.result.items);
      } else if (state is GetConsumerRequestDetailsErrorState) {
        _showValidationError(state.message, false);
        _isLoading = false;
      } else if (state is GetEmployeesSuccessState) {
        _employees = List.from(state.employees);
        _selectedEmployee = _employees.first;
      } else if (state is GetEmployeesErrorState) {
        _showValidationError(state.message, false);
      } else if (state is SendPriceOfferSuccessState) {
        _showValidationError(S.of(context).sendPriceOfferSuccess, false);
        Navigator.pop(context);
      } else if (state is SendPriceOfferErrorState) {
        _showValidationError(state.message, false);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorSchemes.primary,
          elevation: 0,
          centerTitle: true,
          title: Text(s.requests, style: const TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Skeletonizer(
            enabled: _isLoading,
            child: _isPriceSending
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCardHeader(s),
                        const SizedBox(height: 12),
                        if (!_isPriceSending) _buildTabBar(s),
                        if (!_isPriceSending) const SizedBox(height: 16),
                        if (!_isPriceSending)
                          Expanded(child: _buildTabContent(s)),
                        if (_isPriceSending) _buildPriceSending(s),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCardHeader(s),
                      const SizedBox(height: 12),
                      if (!_isPriceSending) _buildTabBar(s),
                      if (!_isPriceSending) const SizedBox(height: 16),
                      if (!_isPriceSending)
                        Expanded(child: _buildTabContent(s)),
                      if (_isPriceSending) _buildPriceSending(s),
                    ],
                  ),
          ),
        ),
      );
    });
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
                    model.result.requestType,
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
                  model.result.requestNumber,
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
                    model.result.branch.branchName,
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
                      model.result.branch.address.split(",").last,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _isLoading
                        ? Container(
                            width: 16.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          )
                        : SvgPicture.asset(
                            ImagePaths.activity,
                            width: 16,
                            height: 16,
                            color: Colors.grey[700],
                          ),
                    const SizedBox(width: 4),
                    Text(
                      S.of(context).typeOfActivity,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: _isLoading
                        ? Colors.grey.shade300
                        : ColorSchemes.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    model.result.systemType,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              s.locationOnMap,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 15.sp,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ColorSchemes.white,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButtonWidget(
                      height: 42,
                      backgroundColor: ColorSchemes.red,
                      textColor: Colors.white,
                      text: s.openMap,
                      onTap: () async {
                        // Handle map navigation
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapSearchScreen(
                              initialLatitude: model
                                  .result.branch.location.coordinates.first,
                              initialLongitude:
                                  model.result.branch.location.coordinates.last,
                              onLocationSelected: (lat, lng, address) {
                                setState(() {});
                                _showValidationError(
                                  S.of(context).locationSelected,
                                  false,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: Text(
                      model.result.branch.address,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(S s) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TabBar(
        controller: _tabController,
        labelColor: ColorSchemes.secondary,
        unselectedLabelColor: Colors.grey,
        indicatorColor: ColorSchemes.red,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 0),
        labelStyle: TextStyle(
          fontWeight: GetLanguageUseCase(injector())() == 'en'
              ? FontWeight.normal
              : FontWeight.bold,
          fontSize: GetLanguageUseCase(injector())() == 'en' ? 12.sp : 14.sp,
        ),
        tabs: [
          Tab(text: s.siteInfo),
          Tab(text: s.quantitiesTable),
          Tab(text: s.termsAndConditions),
        ],
      ),
    );
  }

  Widget _buildTabContent(S s) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildSiteInfoTab(s),
        _buildQuantitiesTab(),
        _buildTermsTab(),
      ],
    );
  }

  Widget _buildSiteInfoTab(S s) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Row(
                children: [
                  _isLoading
                      ? Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )
                      : SvgPicture.asset(
                          ImagePaths.priceTag,
                          color: ColorSchemes.secondary,
                          width: 16,
                          height: 16,
                        ),
                  const SizedBox(width: 8),
                  Text(
                    '${s.systemType}:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                model.result.systemType,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Row(
                children: [
                  _isLoading
                      ? Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )
                      : SvgPicture.asset(
                          ImagePaths.area,
                          color: ColorSchemes.secondary,
                          width: 16,
                          height: 16,
                        ),
                  const SizedBox(width: 8),
                  Text(
                    '${s.area}:',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                model.result.space.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 64),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorSchemes.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                debugPrint('Saved Model: $model');
                if (_currentIndex < 3 && _currentIndex >= 0) {
                  if (_currentIndex == 2) {
                    _currentIndex = 0;
                  } else {
                    _currentIndex++;
                  }
                  _tabController.animateTo(_currentIndex);
                }
              },
              child: Text(s.next),
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  Widget _buildQuantitiesTab() {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildQuantitySection(
              title: s.alarmItems,
              items: _itemsAlarm,
            ),
            const SizedBox(height: 16),
            _buildQuantitySection(
                title: s.extinguishingItems, items: _itemsFire),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorSchemes.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  debugPrint('Saved Model: $model');
                  if (_currentIndex < 3 && _currentIndex >= 0) {
                    if (_currentIndex == 2) {
                      _currentIndex = 0;
                    } else {
                      _currentIndex++;
                    }
                    _tabController.animateTo(_currentIndex);
                  }
                },
                child: Text(s.next),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySection({
    required String title,
    required List<Items> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              ImagePaths.priceTag,
              color: ColorSchemes.secondary,
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              S.of(context).quantity,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...items.asMap().entries.map(
              (item) => _buildQuantityRow(
                item.value.itemId.itemName,
                item.value.quantity.toString(),
                item.key == items.length - 1,
              ),
            ),
      ],
    );
  }

  Widget _buildQuantityRow(String name, String count, bool isLast) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontSize: 14)),
              Text(count, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          if (!isLast) const Divider(),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildTermsTab() {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                ImagePaths.person,
                color: ColorSchemes.secondary,
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "${s.authorizedSignature} : ",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                model.termsAndConditions.employee.fullName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SvgPicture.asset(
                ImagePaths.technical,
                color: ColorSchemes.secondary,
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "${S.of(context).technicianResponsibleForInstallingTheEquipment} : ",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<Employee>(
                value: _selectedEmployee,
                onChanged: (value) {
                  setState(() {
                    _selectedEmployee = value;
                  });
                },
                items: _employees.map((emp) {
                  return DropdownMenuItem(
                    value: emp,
                    child: Text(
                      emp.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: ColorSchemes.black,
                      ),
                    ),
                  );
                }).toList(),
                underline: const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 64),
          CustomButtonWidget(
            backgroundColor: ColorSchemes.primary,
            textColor: Colors.white,
            text: S.of(context).sendPriceOffer,
            onTap: () {
              debugPrint('Saved Model: $model');
              setState(() {
                _isPriceSending = true;
              });
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPriceSending(S s) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                ImagePaths.priceSending,
                width: 24.w,
                height: 24.w,
                color: ColorSchemes.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  S.of(context).submitAPriceOfferForInstantPermitIssuance,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              SvgPicture.asset(
                ImagePaths.priceTag,
                width: 24.w,
                height: 24.w,
                color: ColorSchemes.black,
              ),
              SizedBox(width: 16.h),
              Expanded(
                child: Text(
                  S.of(context).instantPermitIssuanceFee,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 38.h,
            child: TextField(
              controller: _priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'ex. 50 R.S',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFFCCCCCC),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFF8B0000)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          SizedBox(height: 32.h),
          CustomButtonWidget(
            backgroundColor: ColorSchemes.primary,
            textColor: Colors.white,
            text: S.of(context).send,
            onTap: () {
              debugPrint('Saved Model: $model');
              _bloc.add(
                SendPriceOfferEvent(
                  request: SendPriceRequest(
                    consumerRequest: model.result.consumer,
                    responsibleEmployee: model.termsAndConditions.employee.Id,
                    price: int.parse(_priceController.text),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
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

  void _filterItems(List<Items> items) {
    _itemsAlarm.clear();
    _itemsFire.clear();
    for (var item in items) {
      if (SystemType.isAlarmType(item.itemId.type)) {
        _itemsAlarm.add(item);
      } else if (SystemType.isFireType(item.itemId.type)) {
        _itemsFire.add(item);
      }
    }
    setState(() {});
  }
}
