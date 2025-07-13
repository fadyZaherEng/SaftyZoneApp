import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/presentation/blocs/requests/requests_bloc.dart';
import 'package:safety_zone/src/presentation/screens/map_search/map_search_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:safety_zone/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RequestsScreen extends BaseStatefulWidget {
  final bool isAppBar;

  const RequestsScreen({
    super.key,
    this.isAppBar = false,
  });

  @override
  BaseState<RequestsScreen> baseCreateState() => _RequestsScreenState();
}

class _RequestsScreenState extends BaseState<RequestsScreen> {
  List<Requests> _requestsRecent = [];

  List<Requests> _requestsOld = [];
  bool _isOld = false;
  bool _isLoading = true;

  RequestsBloc get _bloc => BlocProvider.of<RequestsBloc>(context);
  TextEditingController _price6KiloController = TextEditingController();
  TextEditingController _price12KiloController = TextEditingController();
  TextEditingController _priceCo2Controller = TextEditingController();

  @override
  void initState() {
    _bloc.add(GetConsumerRequestsEvent());
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<RequestsBloc, RequestsState>(
      listener: (context, state) {
        if (state is GetConsumerRequestsLoadingState) {
          _isLoading = true;
        } else if (state is GetConsumerRequestsSuccessState) {
          _requestsRecent = List.from(state.requestsRecent);
          _requestsOld = List.from(state.requestsOld);
          _isLoading = false;
        } else if (state is GetConsumerRequestsErrorState) {
          _showError(state.message);
          _isLoading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: widget.isAppBar
              ? AppBar(
                  backgroundColor: ColorSchemes.primary,
                  title: Text(
                    S.of(context).requests,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
          body: RefreshIndicator(
            onRefresh: () async {
              _bloc.add(GetConsumerRequestsEvent());
            },
            child: SafeArea(
              child: Skeletonizer(
                enabled: _isLoading,
                child: Column(
                  children: [
                    _buildSearchSection(context),
                    if (_isOld && _requestsOld.isEmpty)
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: CustomEmptyListWidget(
                              text: S.of(context).noRequestsFound,
                              isRefreshable: true,
                              onRefresh: () =>
                                  _bloc.add(GetConsumerRequestsEvent()),
                              imagePath: ImagePaths.emptyProject,
                            )),
                      ),
                    if (!_isOld && _requestsRecent.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: _isLoading
                              ? Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: ColorSchemes.border,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )
                              : CustomEmptyListWidget(
                                  text: S.of(context).noRequestsFound,
                                  isRefreshable: true,
                                  onRefresh: () =>
                                      _bloc.add(GetConsumerRequestsEvent()),
                                  imagePath: ImagePaths.emptyProject,
                                ),
                        ),
                      ),
                    if (_isOld && _requestsOld.isNotEmpty ||
                        !_isOld && _requestsRecent.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          itemCount: _isOld
                              ? _requestsOld.length
                              : _requestsRecent.length,
                          itemBuilder: (context, index) {
                            final request = _isOld
                                ? _requestsOld[index]
                                : _requestsRecent[index];
                            if (SystemType.isExtinguisherType(
                                request.requestType)) {
                              return _buildFireExtinguisherCard(
                                  context,
                                  request,
                                  Key(request.requestNumber.toString()));
                            }
                            return _buildRequestCard(
                              context,
                              request,
                              Key(request.requestNumber.toString()),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showError(String message) {
    showSnackBar(
      context: context,
      message: message,
      color: ColorSchemes.warning,
      icon: ImagePaths.error,
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            s.requestServiceTitle.trim(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.requestServiceSubtitle.trim(),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 42.h,
            child: TextField(
              decoration: InputDecoration(
                hintText: s.searchHint,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    ImagePaths.search,
                    color: Colors.grey,
                    width: 16.w,
                    height: 16.h,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: _isLoading
                        ? Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          )
                        : SvgPicture.asset(
                            ImagePaths.filter,
                            color: ColorSchemes.primary,
                            width: 16.w,
                            height: 16.h,
                          ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statusTab(
                  context,
                  s.recently,
                  isActive: !_isOld,
                  onTap: () => setState(() => _isOld = false),
                ),
                _statusTab(
                  context,
                  s.pendingApproval,
                  isActive: _isOld,
                  onTap: () => setState(() => _isOld = true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTab(
    BuildContext context,
    String label, {
    bool isActive = false,
    required void Function() onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            color: isActive ? ColorSchemes.white : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? ColorSchemes.primary : Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, Requests request, Key key) {
    return Card(
      key: key,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Chip(
                  label: Text(
                    request.requestType,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: _isLoading
                      ? Colors.grey.shade300
                      : ColorSchemes.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                const Spacer(),
                Text(
                  request.requestNumber,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  request.branch.branchName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                if (request.requestType == RequestType.MaintenanceContract.name)
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImagePaths.visit,
                        color: ColorSchemes.grey,
                        width: 24.w,
                        height: 24.h,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Visit:8 ",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _openMap(
                        request.branch.location.coordinates.first,
                        request.branch.location.coordinates.last),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_pin, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            request.branch.address,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(width: 8),
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
                    request.providers.first.status.toUpperCase(),
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
            SizedBox(
              width: double.infinity,
              height: 42.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.primary,
                borderColor: ColorSchemes.primary,
                text: S.of(context).sendPriceOffer,
                textColor: Colors.white,
                onTap: () => _acceptRequest(context, request),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _acceptRequest(BuildContext context, Requests request) {
    if (request.requestType == RequestType.InstallationCertificate.name ||
        request.requestType == RequestType.EngineeringInspection.name) {
      Navigator.pushNamed(
        context,
        Routes.requestDetailsInstallationScreen,
        arguments: {'requestId': request.Id},
      );
    } else if (request.requestType == RequestType.MaintenanceContract.name) {
      Navigator.pushNamed(
        context,
        Routes.requestDetailsMaintainanceScreen,
        arguments: {'requestId': request.Id},
      );
    } else if (request.requestType == RequestType.FireExtinguisher.name) {
      Navigator.pushNamed(
        context,
        Routes.requestDetailsExtinguishersScreen,
        arguments: {'requestId': request.Id},
      );
    }
  }

  void _openMap(double first, double last) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapSearchScreen(
          initialLatitude: first,
          initialLongitude: last,
          onLocationSelected: (lat, lng, address) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildFireExtinguisherCard(
      BuildContext context, Requests request, Key key) {
    final s = S.of(context);
    return Card(
      key: key,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(s, request),
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
          const SizedBox(height: 16),
        ],
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

  Widget _buildCardHeader(S s, Requests model) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Chip(
                label: Text(
                  model.requestType,
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
                model.requestNumber,
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
                  model.branch.branchName,
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
                    model.branch.address.split(" ").last,
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
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: _isLoading
                      ? Colors.grey.shade300
                      : ColorSchemes.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  model.branch.location.type,
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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
                            initialLatitude:
                                model.branch.location.coordinates.first,
                            initialLongitude:
                                model.branch.location.coordinates.last,
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
                      model.branch.address,
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
