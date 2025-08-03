import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/send_price_request.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/create_employee.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/domain/usecase/home/go_to_location_use_case.dart';
import 'package:safety_zone/src/presentation/blocs/requests/requests_bloc.dart';
import 'package:safety_zone/src/presentation/screens/map_search/map_search_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RequestDetailsExtinguishersScreen extends BaseStatefulWidget {
  final String requestId;

  const RequestDetailsExtinguishersScreen({
    super.key,
    required this.requestId,
  });

  @override
  BaseState<RequestDetailsExtinguishersScreen> baseCreateState() =>
      _RequestDetailsExtinguishersScreenState();
}

class _RequestDetailsExtinguishersScreenState
    extends BaseState<RequestDetailsExtinguishersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _priceController = TextEditingController();
  int _currentIndex = 0;
  RequestDetails model = RequestDetails();
  bool _isPriceSending = false;
  bool _isLoading = false;

  final List<TextEditingController> _priceKiloController = [];

  RequestsBloc get _bloc => BlocProvider.of<RequestsBloc>(context);
  List<Employee> _employees = [];
  Employee _selectedEmployee = Employee();

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
  Widget baseBuild(BuildContext context) {
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
        for (var element in model.result.fireExtinguisherItem) {
          _priceKiloController.add(TextEditingController());
        }
      } else if (state is GetConsumerRequestDetailsErrorState) {
        _showValidationError(state.message, false);
        _isLoading = false;
      } else if (state is GetEmployeesSuccessState) {
        _employees = List.from(state.employees);
        _selectedEmployee = _employees.first;
      } else if (state is GetEmployeesErrorState) {
        _showValidationError(state.message, false);
      } else if (state is SendPriceOfferSuccessState) {
        _showValidationError(S.of(context).sendPriceOfferSuccess, true);
        hideLoading();
        Navigator.pop(context);
      } else if (state is SendPriceOfferErrorState) {
        _showValidationError(state.message, false);
        hideLoading();
      } else if (state is SendPriceOfferLoadingState) {
        showLoading();
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorSchemes.red,
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
                    S.of(context).fireSystems,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor:
                      _isLoading ? Colors.grey.shade300 : ColorSchemes.primary,
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
                      model.result.branch.address.split(" ").last,
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
                    _systemType(model.result.systemType),
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
                        await GoToLocationUseCase(injector())(
                            id: model.result.Id);

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
                _systemType(model.result.systemType),
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
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
              title: s.fireExtinguishers,
              items: model.result.fireExtinguisherItem,
            ),
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
                GetLanguageUseCase(injector())() == 'en'
                    ? item.value.itemId.itemName.en
                    : item.value.itemId.itemName.ar,
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
                height: 24.h,
                width: 24.w,
                color: ColorSchemes.primary,
              ),
              const SizedBox(width: 12),
              Text(
                S.of(context).submitOfferTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: ColorSchemes.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < model.result.fireExtinguisherItem.length; i++)
            Column(
              children: [
                _buildFireItem(
                  title: GetLanguageUseCase(injector())() == 'en'
                      ? model.result.fireExtinguisherItem[i].itemId.itemName.en
                      : model.result.fireExtinguisherItem[i].itemId.itemName.ar,
                  hint: S.of(context).example3,
                  controller: _priceKiloController[i],
                  iconDescription: ImagePaths.price,
                  color: ColorSchemes.black,
                  iconTitle: ImagePaths.fire,
                ),
                const SizedBox(height: 12),
              ],
            ),
          SizedBox(height: 32.h),
          CustomButtonWidget(
            backgroundColor: ColorSchemes.primary,
            textColor: Colors.white,
            text: S.of(context).send,
            onTap: () {
              debugPrint('Saved Model: $model');
              List<Item> items = [];
              int totalPrice = 0;
              for (int i = 0;
                  i < model.result.fireExtinguisherItem.length;
                  i++) {
                items.add(Item(
                  ItemId: model.result.fireExtinguisherItem[i].itemId.Id,
                  quantity: 1,
                  price: int.parse(_priceKiloController[i].text),
                ));
                totalPrice += int.parse(_priceKiloController[i].text) * 1;
              }
              _bloc.add(
                SendPriceOfferEvent(
                  request: SendPriceRequest(
                    consumerRequest: model.result.Id,
                    responsibleEmployee: _selectedEmployee.Id,
                    price: totalPrice,
                    is_Primary: true,
                    item: items,
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

  Widget _buildFireItem({
    required String title,
    required String hint,
    required String iconTitle,
    required String iconDescription,
    required TextEditingController controller,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                iconTitle,
                width: 24,
                height: 24,
                color: color ?? ColorSchemes.black,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                iconDescription,
                width: 24,
                height: 24,
                color: color ?? ColorSchemes.black,
              ),
              const SizedBox(width: 8),
              Text(
                S.of(context).maintenancePricePerKilo,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 14,
              color: ColorSchemes.black,
              fontWeight: FontWeight.normal,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              hintText: hint,
              fillColor: Colors.white,
              filled: true,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.r),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.r),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.r),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.r),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.r),
                borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _systemType(String systemType) {
    if (systemType.toLowerCase() == "zone") {
      return S.of(context).zone;
    } else if (systemType.toLowerCase() == "loop") {
      return S.of(context).loop;
    } else {
      return S.of(context).loop;
    }
  }
}
