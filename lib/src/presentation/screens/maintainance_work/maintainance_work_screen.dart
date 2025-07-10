import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/domain/entities/main/requests/request.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MaintainanceWorkScreen extends BaseStatefulWidget {
  const MaintainanceWorkScreen({super.key});

  @override
  BaseState<MaintainanceWorkScreen> baseCreateState() =>
      _MaintainanceWorkScreenState();
}

class _MaintainanceWorkScreenState extends BaseState<MaintainanceWorkScreen> {
  final List<Requests> _workingProgress = [
    Requests(
      id: 2458926,
      companyName: 'محمد قاسم',
      image: 'assets/images/user1.png',
      city: 'الرياض',
      status: 'تحت المراجعة',
      statusColor: Colors.black,
      visits: 5,
      type: RequestType.InstallationCertificate.name,
    ),
    Requests(
      id: 2458927,
      companyName: 'وائل ياسر',
      image: 'assets/images/user2.png',
      city: 'جدة',
      status: 'عقود قائمة',
      statusColor: Colors.blue,
      visits: 3,
      type: RequestType.MaintenanceContract.name,
    ),
    Requests(
      id: 2458928,
      companyName: 'علي أحمد',
      image: 'assets/images/user3.png',
      city: 'أبها',
      status: 'تفاصيل الفريق',
      statusColor: Colors.red,
      visits: 2,
      type: RequestType.FireExtinguisher.name,
    ),
  ];
  bool _isLoading = true;
  bool _isComplete = false;
  bool _isAll = true;
  bool _isProgress = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Skeletonizer(
          enabled: _isLoading,
          child: Column(
            children: [
              _buildSearchSection(context),
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  itemCount: _workingProgress.length,
                  itemBuilder: (context, index) {
                    final request = _workingProgress[index];

                    if (request.type ==
                        RequestType.InstallationCertificate.name) {
                      return _buildFawryRequestCard(
                        context,
                        request,
                        Key(request.id.toString()),
                      );
                    } else if (request.type ==
                        RequestType.MaintenanceContract.name) {
                      return _buildMaintenanceRequestCard(
                        context,
                        request,
                        Key(request.id.toString()),
                      );
                    } else {
                      return _buildRequestCard(
                        context,
                        request,
                        Key(request.id.toString()),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
            s.scheduledJobs,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.stayOnTopOfYourServiceTasksWithClearSchedulesAssignedTechniciansAndRealTimeStatusUpdates,
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
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statusTab(
                  context,
                  s.all,
                  isActive: _isAll,
                  onTap: () {
                    setState(() {
                      _isAll = true;
                      _isProgress = false;
                      _isComplete = false;
                    });
                  },
                ),
                _statusTab(
                  context,
                  s.progress,
                  isActive: _isProgress,
                  onTap: () {
                    setState(() {
                      _isAll = false;
                      _isProgress = true;
                      _isComplete = false;
                    });
                  },
                ),
                _statusTab(
                  context,
                  s.completed,
                  isActive: _isComplete,
                  onTap: () {
                    setState(() {
                      _isAll = false;
                      _isProgress = false;
                      _isComplete = true;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '#${request.id}',
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
                  backgroundColor:
                      _isLoading ? Colors.grey.shade300 : request.statusColor,
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
                  request.companyName,
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
                      request.city,
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
                  "ali mohamed",
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
    Requests request,
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
                  '#${request.id}',
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
                  backgroundColor:
                      _isLoading ? Colors.grey.shade300 : request.statusColor,
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
                  request.companyName,
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
                      request.city,
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
                  "ali mohamed",
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
      BuildContext context, Requests request, Key key) {
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
                  '#${request.id}',
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
                  backgroundColor:
                      _isLoading ? Colors.grey.shade300 : request.statusColor,
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
                  request.companyName,
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
                      request.city,
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
                  "ali mohamed",
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
                onTap: () => _uploadLicenseDoc(context, request),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _uploadLicenseDoc(BuildContext context, Requests request) {
    Navigator.pushNamed(
      context,
      Routes.uploadDocumentFawryScreen,
      arguments: {'request': request},
    );
  }

  void _goToLocation(BuildContext context, Requests request) {}
}
