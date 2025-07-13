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
import 'package:safety_zone/src/domain/entities/home/requests.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/blocs/requests/requests_bloc.dart';
import 'package:safety_zone/src/presentation/screens/map_search/map_search_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:safety_zone/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WorkingProgressScreen extends BaseStatefulWidget {
  final bool isAppBar;

  const WorkingProgressScreen({
    super.key,
    this.isAppBar = false,
  });

  @override
  BaseState<WorkingProgressScreen> baseCreateState() =>
      _WorkingProgressScreenState();
}

class _WorkingProgressScreenState extends BaseState<WorkingProgressScreen> {
  RequestsBloc get _bloc => BlocProvider.of<RequestsBloc>(context);

  List<ScheduleJop> _workingProgress = [];

  @override
  void initState() {
    _bloc.add(GetScheduleJobInProgressEvent(
        status: ScheduleJobStatusEnum.inProgress.name));
    super.initState();
  }

  bool _isLoading = true;

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<RequestsBloc, RequestsState>(
      listener: (context, state) {
        if (state is ScheduleJobInProgressLoadingState) {
          _isLoading = true;
        } else if (state is ScheduleJobInProgressSuccessState) {
          _workingProgress = List.from(state.scheduleJob);
          _isLoading = false;
        } else if (state is ScheduleJobInProgressErrorState) {
          _isLoading = false;
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.warning,
            icon: ImagePaths.error,
          );
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _bloc.add(
              GetScheduleJobInProgressEvent(
                status: ScheduleJobStatusEnum.inProgress.name,
              ),
            );
          },
          child: Scaffold(
            appBar: widget.isAppBar
                ? AppBar(
                    backgroundColor: ColorSchemes.primary,
                    title: Text(
                      S.of(context).workingInProgress,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                : null,
            body: SafeArea(
              child: Skeletonizer(
                enabled: _isLoading,
                child: Column(
                  children: [
                    _buildSearchSection(context),
                    if (_workingProgress.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: _isLoading
                              ? Container(
                                  height: 200.h,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                )
                              : CustomEmptyListWidget(
                                  text: S.of(context).noRequestsFound,
                                  isRefreshable: true,
                                  onRefresh: () => _bloc.add(
                                    GetScheduleJobInProgressEvent(
                                      status:
                                          ScheduleJobStatusEnum.inProgress.name,
                                    ),
                                  ),
                                  imagePath: ImagePaths.emptyProject,
                                ),
                        ),
                      ),
                    if (_workingProgress.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          itemCount: _workingProgress.length,
                          itemBuilder: (context, index) {
                            final request = _workingProgress[index];
                            if (request.type ==
                                    RequestType.InstallationCertificate.name ||
                                request.type ==
                                    RequestType.EngineeringInspection.name) {
                              return _buildFawryRequestCard(
                                context,
                                request,
                                Key(request.Id.toString()),
                              );
                            } else if (request.type ==
                                RequestType.MaintenanceContract.name) {
                              return _buildMaintenanceRequestCard(
                                context,
                                request,
                                Key(request.Id.toString()),
                              );
                            } else if (request.type ==
                                RequestType.FireExtinguisher.name) {
                              return _buildFireExtinguisherRequestCard(
                                context,
                                request,
                                Key(request.Id.toString()),
                              );
                            } else {
                              return _buildRequestCard(
                                context,
                                request,
                                Key(request.Id.toString()),
                              );
                            }
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
            s.maintenanceInProgress,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.stayInformed,
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
                  child: _isLoading
                      ? Container(
                          width: 16.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )
                      : SvgPicture.asset(
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
                            width: 16.w,
                            height: 16.h,
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
        ],
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, ScheduleJop request, Key key) {
    return Card(
      key: key,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  request.requestNumber,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    request.status,
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
                Row(
                  children: [
                    const Icon(Icons.location_pin, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      request.branch.address.split(',').last,
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
              S.of(context).fireTitle,
              style: TextStyle(
                color: ColorSchemes.red,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (SystemType.isExtinguisherType(request.type))
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
                          : const Icon(
                              Icons.calendar_month_outlined,
                              size: 16,
                            ),
                      const SizedBox(width: 4),
                      Text(
                        "${S.of(context).visitDate}:\n${"12/12/2022"}",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
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
                    request.status,
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
                        ImagePaths.technical,
                        height: 16.h,
                        width: 16.w,
                      ),
                const SizedBox(width: 4),
                Text(
                  S.of(context).responsibleEmployee,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  request.responseEmployee.fullName,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.primary,
                borderColor: ColorSchemes.primary,
                text: S.of(context).goToLocation,
                textColor: Colors.white,
                onTap: () => _uploadLicenseDoc(context, request),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.white,
                borderColor: ColorSchemes.grey,
                text: S.of(context).receiveExtinguishers,
                textColor: ColorSchemes.primary,
                onTap: () => _goToLocation(context, request),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.white,
                borderColor: ColorSchemes.grey,
                text: S.of(context).submitQuotation,
                textColor: ColorSchemes.primary,
                textStyle: TextStyle(
                  color: ColorSchemes.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                onTap: () => _goToLocation(context, request),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.white,
                borderColor: ColorSchemes.grey,
                text: S.of(context).deliverExtinguishers,
                textColor: ColorSchemes.primary,
                textStyle: TextStyle(
                  color: ColorSchemes.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                onTap: () => _goToLocation(context, request),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildFawryRequestCard(
    BuildContext context,
    ScheduleJop request,
    Key key,
  ) {
    return Card(
      key: key,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  request.requestNumber,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    request.status,
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
                        : const Icon(Icons.location_pin, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      request.branch.address.split(",").first,
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
                color: ColorSchemes.red,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (SystemType.isExtinguisherType(request.type))
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
                          : const Icon(
                              Icons.calendar_month_outlined,
                              size: 16,
                            ),
                      const SizedBox(width: 4),
                      Text(
                        "${S.of(context).visitDate}:\n${"12/12/2022"}",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
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
                    request.status,
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
                        ImagePaths.technical,
                        height: 16.h,
                        width: 16.w,
                      ),
                const SizedBox(width: 4),
                Text(
                  S.of(context).responsibleEmployee,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  request.responseEmployee.fullName,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.primary,
                borderColor: ColorSchemes.primary,
                text: S.of(context).uploadLicenseDoc,
                textColor: Colors.white,
                textStyle: TextStyle(
                  color: ColorSchemes.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                onTap: () => _uploadLicenseDoc(context, request),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.white,
                borderColor: ColorSchemes.grey,
                text: S.of(context).goToLocation,
                textColor: ColorSchemes.primary,
                textStyle: TextStyle(
                  color: ColorSchemes.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                onTap: () => _goToLocation(context, request),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceRequestCard(
      BuildContext context, ScheduleJop request, Key key) {
    return Card(
      key: key,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  request.requestNumber,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    request.status,
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
                Row(
                  children: [
                    const Icon(Icons.location_pin, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      request.branch.address.split(',').first,
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
              S.of(context).maintainanceTitle,
              style: TextStyle(
                color: ColorSchemes.red,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (SystemType.isExtinguisherType(request.type))
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${S.of(context).visitDate}:\n${"12/12/2022"}",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
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
                    request.status,
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
                        ImagePaths.technical,
                        height: 16.h,
                        width: 16.w,
                      ),
                const SizedBox(width: 4),
                Text(
                  S.of(context).responsibleEmployee,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  request.responseEmployee.fullName,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.primary,
                borderColor: ColorSchemes.primary,
                text: S.of(context).goToLocation,
                textColor: ColorSchemes.white,
                textStyle: TextStyle(
                  color: ColorSchemes.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                onTap: () => _goToLocation(context, request),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.white,
                borderColor: ColorSchemes.grey,
                text: S.of(context).generateReport,
                textColor: ColorSchemes.primary,
                textStyle: TextStyle(
                  color: ColorSchemes.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                onTap: () => _uploadLicenseDoc(context, request),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _uploadLicenseDoc(BuildContext context, ScheduleJop request) {
    Navigator.pushNamed(
      context,
      Routes.uploadDocumentFawryScreen,
      arguments: {'request': request},
    );
  }

  void _goToLocation(BuildContext context, ScheduleJop request) async {
    // Handle map navigation
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapSearchScreen(
          initialLatitude: request.branch.location.coordinates.first,
          initialLongitude: request.branch.location.coordinates.last,
          onLocationSelected: (lat, lng, address) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildFireExtinguisherRequestCard(
    BuildContext context,
    ScheduleJop request,
    Key key,
  ) {
    return Card(
      key: key,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.requestNumber,
              style: TextStyle(color: Colors.grey[700]),
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
                        : const Icon(Icons.location_pin, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      request.branch.address.split(",").first,
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
                color: ColorSchemes.red,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            Divider(),
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
                        : const Icon(
                            Icons.calendar_month_outlined,
                            size: 16,
                          ),
                    const SizedBox(width: 4),
                    Text(
                      "${S.of(context).visitDate}:\n${"12/12/2022"}",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
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
                    request.type,
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
                        ImagePaths.technical,
                        height: 16.h,
                        width: 16.w,
                      ),
                const SizedBox(width: 4),
                Text(
                  S.of(context).responsibleEmployee,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  request.responseEmployee.fullName,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.white,
                borderColor: ColorSchemes.grey,
                text: S.of(context).goToLocation,
                textColor: ColorSchemes.primary,
                textStyle: TextStyle(
                  color: ColorSchemes.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                onTap: () => _goToLocation(context, request),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.primary,
                borderColor: ColorSchemes.primary,
                text: S.of(context).startMission,
                textColor: Colors.white,
                textStyle: TextStyle(
                  color: ColorSchemes.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                onTap: () => showStartTaskDialog(context, request),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void showStartTaskDialog(BuildContext context, ScheduleJop request) {
    final s = S.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              s.startTaskTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: ColorSchemes.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              s.startTaskSubtitle,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Divider(height: 1),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                // Handle start now logic
                _startMission(context, request);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    s.startNow,
                    style: const TextStyle(
                        color: ColorSchemes.primary, fontSize: 16),
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    s.notYet,
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startMission(BuildContext context, ScheduleJop request) {
    Navigator.pushNamed(
      context,
      Routes.fireExtinguishersScreen,
      arguments: {'scheduleJop': request},
    );
  }
}
