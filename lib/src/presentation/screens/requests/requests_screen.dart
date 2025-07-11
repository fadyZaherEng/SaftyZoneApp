import 'package:flutter/material.dart';
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
                            child: CustomEmptyListWidget(
                              text: S.of(context).noRequestsFound,
                              isRefreshable: true,
                              onRefresh: () =>
                                  _bloc.add(GetConsumerRequestsEvent()),
                              imagePath: ImagePaths.emptyProject,
                            )),
                      ),
                    if (_isOld && _requestsOld.isNotEmpty ||
                        !_isOld && _requestsRecent.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          itemCount: _isOld
                              ? _requestsOld.length
                              : _requestsRecent.length,
                          itemBuilder: (context, index) {
                            final request = _isOld
                                ? _requestsOld[index]
                                : _requestsRecent[index];
                            // final request = _requestsRecent[index];
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
    if (request.requestType == RequestType.InstallationCertificate.name) {
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
    } else if (request.requestType == RequestType.EngineeringInspection.name) {
      //TODO: navigate to Engineering Inspection
      Navigator.pushNamed(
        context,
        Routes.fireExtinguishersScreen,
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
    // Handle map navigation
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
}
