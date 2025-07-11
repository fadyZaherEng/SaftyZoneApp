import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/domain/entities/home/request_details.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/presentation/screens/map_search/map_search_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FireExtinguishersScreen extends BaseStatefulWidget {
  final String requestId;

  const FireExtinguishersScreen({
    super.key,
    required this.requestId,
  });

  @override
  BaseState<FireExtinguishersScreen> baseCreateState() =>
      _FireExtinguishersScreenState();
}

class _FireExtinguishersScreenState extends BaseState<FireExtinguishersScreen> {
  bool _isLoading = true;
  RequestDetails model = RequestDetails(
    result: Result(
      status: "Active",
      requestType: "Fire Extinguisher",
      createdAt: 5,
      Id: "1",
      requestNumber: "1",
      consumer: "Sayed",
      branch: Branch(
        employee: Employee(
          fullName: "Sayed",
          phoneNumber: "0111011011",
          Id: "1",
          employeeType: "Admin",
        ),
        location: Location(),
        address: "Cairo",
        branchName: "Branch 1",
        Id: "1",
      ),
      items: [
        Items(
          itemId: ItemId(
            type: "Fire Extinguisher",
            Id: "1",
            itemName: "Fire Extinguisher",
          ),
          Id: "1",
          quantity: 1,
        ),
      ],
      space: 5,
      systemType: "Fire Extinguisher",
    ),
  );
  TextEditingController _price6KiloController = TextEditingController();
  TextEditingController _price12KiloController = TextEditingController();
  TextEditingController _priceCo2Controller = TextEditingController();

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
        title: Text(s.requests, style: const TextStyle(color: Colors.white)),
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                      _buildFireItem(
                        title: S.of(context).fireExtinguisher6kg,
                        hint: S.of(context).example3,
                        controller: _price6KiloController,
                        iconDescription: ImagePaths.price,
                        color: ColorSchemes.black,
                        iconTitle: ImagePaths.fire,
                      ),
                      const SizedBox(height: 12),
                      Divider(),
                      const SizedBox(height: 12),
                      _buildFireItem(
                        title: S.of(context).fireExtinguisher12kg,
                        hint: S.of(context).example350,
                        controller: _price12KiloController,
                        iconDescription: ImagePaths.price,
                        color: ColorSchemes.black,
                        iconTitle: ImagePaths.fire,
                      ),
                      const SizedBox(height: 12),
                      Divider(),
                      const SizedBox(height: 12),
                      _buildFireItem(
                        title: S.of(context).fireExtinguisherCO2,
                        hint: S.of(context).example350,
                        controller: _priceCo2Controller,
                        iconDescription: ImagePaths.price,
                        color: ColorSchemes.black,
                        iconTitle: ImagePaths.fire,
                      ),
                      const SizedBox(height: 12),
                      Divider(),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          S.of(context).noteText,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ),
                      Text(
                        S.of(context).finalPrice,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: ColorSchemes.black,
                        ),
                      ),
                      const SizedBox(height: 8),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButtonWidget(
                    text: S.of(context).sendPriceOffer,
                    backgroundColor: ColorSchemes.primary,
                    textColor: Colors.white,
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
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
                    model.termsAndConditions.company,
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
                    child: Center(
                      child: Text(
                        model.result.branch.address,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
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

  void _showValidationError(String locationSelected, bool bool) {
    showSnackBar(
      context: context,
      message: locationSelected,
      color: !bool ? ColorSchemes.warning : ColorSchemes.success,
      icon: !bool ? ImagePaths.error : ImagePaths.success,
    );
  }
}
