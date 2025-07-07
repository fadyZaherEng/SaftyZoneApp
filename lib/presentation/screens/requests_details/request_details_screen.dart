import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/core/utils/show_snack_bar.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/entities/main/requests/request.dart';
import 'package:hatif_mobile/domain/usecase/get_language_use_case.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/presentation/screens/map_search/map_search_screen.dart';
import 'package:hatif_mobile/presentation/widgets/custom_button_widget.dart';

class _QuantityItem {
  final String name;
  final String count;

  _QuantityItem(this.name, this.count);
}

class RequestDetailsScreen extends StatefulWidget {
  final Requests request;

  const RequestDetailsScreen({
    super.key,
    required this.request,
  });

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _priceController = TextEditingController();
  int _currentIndex = 0;
  RequestDetailsModel model = RequestDetailsModel();
  bool _isPriceSending = false;

  @override
  void initState() {
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSchemes.red,
        elevation: 0,
        centerTitle: true,
        title: Text(s.requests, style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardHeader(s),
            const SizedBox(height: 12),
            if (!_isPriceSending) _buildTabBar(s),
            if (!_isPriceSending) const SizedBox(height: 16),
            if (!_isPriceSending) Expanded(child: _buildTabContent(s)),
            if (_isPriceSending) _buildPriceSending(s),
          ],
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
                    widget.request.status,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: widget.request.statusColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                const Spacer(),
                Text(
                  '#${widget.request.id}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  widget.request.companyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.location_pin, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      widget.request.city,
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
                    SvgPicture.asset(
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
                    color: ColorSchemes.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.request.status,
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
              padding: const EdgeInsets.all(8),
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
                              initialLatitude: 24.774265,
                              initialLongitude: 46.738586,
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
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'فرع طريق الحلقة الشمالية، العقيق، الرياض 13511، المملكة العربية السعودية',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
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
                  SvgPicture.asset(
                    ImagePaths.priceTag,
                    color: ColorSchemes.secondary,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${s.systemType}:',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                widget.request.status,
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
              Row(
                children: [
                  SvgPicture.asset(
                    ImagePaths.area,
                    color: ColorSchemes.secondary,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${s.area}:',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "100",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
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
              items: [
                _QuantityItem(s.controlPanel, '1'),
                _QuantityItem(s.fireDetector, '5'),
                _QuantityItem(s.glassBreaker, '3'),
                _QuantityItem(s.alarmBell, '3'),
                _QuantityItem(s.backupLighting, '3'),
              ],
            ),
            const SizedBox(height: 16),
            _buildQuantitySection(
              title: s.extinguishingItems,
              items: [
                _QuantityItem(s.autoSprinkler, '1'),
                _QuantityItem(s.autoSprinkler, '200'),
                _QuantityItem(s.fireBox, '1'),
              ],
            ),
            // const SizedBox(height: 16),
            // _buildQuantitySection(
            //   title: s.fireExtinguishers,
            //   items: [
            //     _QuantityItem(s.extinguisher6KgPowder, '1'),
            //     _QuantityItem(s.extinguisher12KgPowder, '5'),
            //     _QuantityItem(s.extinguisherCO2, '3'),
            //   ],
            // ),
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
    required List<_QuantityItem> items,
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
                item.value.name,
                item.value.count,
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
                "ali hassan",
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
                  "${s.technicianResponsibleForInstallingTheEquipment} : ",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "ali hassan",
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
}
