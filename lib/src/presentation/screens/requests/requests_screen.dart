import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/domain/entities/main/requests/request.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RequestsScreen extends BaseStatefulWidget {
  const RequestsScreen({super.key});

  @override
  BaseState<RequestsScreen> baseCreateState() => _RequestsScreenState();
}

class _RequestsScreenState extends BaseState<RequestsScreen> {
  final List<Requests> _requestsRecent = [
    Requests(
      id: 2458926,
      companyName: 'محمد قاسم',
      image: 'assets/images/user1.png',
      city: 'الرياض',
      status: 'تحت المراجعة',
      statusColor: Colors.black,
      visits: 5,
    ),
    Requests(
      id: 2458927,
      companyName: 'وائل ياسر',
      image: 'assets/images/user2.png',
      city: 'جدة',
      status: 'عقود قائمة',
      statusColor: Colors.blue,
      visits: 3,
    ),
    Requests(
      id: 2458928,
      companyName: 'علي أحمد',
      image: 'assets/images/user3.png',
      city: 'أبها',
      status: 'تفاصيل الفريق',
      statusColor: Colors.red,
      visits: 2,
    ),
  ];

  final List<Requests> _requestsOld = [
    Requests(
      id: 2458926,
      companyName: 'محمد قاسم',
      image: 'assets/images/user1.png',
      city: 'الرياض',
      status: 'تحت المراجعة',
      statusColor: Colors.black,
      visits: 5,
    ),
    Requests(
      id: 2458927,
      companyName: 'وائل ياسر',
      image: 'assets/images/user2.png',
      city: 'جدة',
      status: 'عقود قائمة',
      statusColor: Colors.blue,
      visits: 3,
    ),
    Requests(
      id: 2458928,
      companyName: 'علي أحمد',
      image: 'assets/images/user3.png',
      city: 'أبها',
      status: 'تفاصيل الفريق',
      statusColor: Colors.red,
      visits: 2,
    ),
  ];
  bool _isOld = false;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 2), () {
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
                  itemCount:
                      _isOld ? _requestsOld.length : _requestsRecent.length,
                  itemBuilder: (context, index) {
                    final request =
                        _isOld ? _requestsOld[index] : _requestsRecent[index];
                    return _buildRequestCard(
                      context,
                      request,
                      Key(request.id.toString()),
                    );
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
                    request.status,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor:_isLoading ? Colors.grey.shade300 : request.statusColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                const Spacer(),
                Text(
                  '#${request.id}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(50),
                //   child: SizedBox(
                //     width: 32.w,
                //     height: 32.h,
                //     child: Image.network(
                //       request.image,
                //       width: 32.w,
                //       height: 32.h,
                //       fit: BoxFit.cover,
                //       errorBuilder: (context, error, stackTrace) => Center(
                //         child: CircularProgressIndicator(
                //           color: ColorSchemes.primary,
                //         ),
                //       ),
                //       loadingBuilder: (context, child, loadingProgress) =>
                //           loadingProgress == null
                //               ? child
                //               : Center(
                //                   child: CircularProgressIndicator(
                //                     color: ColorSchemes.primary,
                //                   ),
                //                 ),
                //     ),
                //   ),
                // ),
                // const SizedBox(width: 8),
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
                    SvgPicture.asset(
                      ImagePaths.visit,
                      color: ColorSchemes.grey,
                      width: 24.w,
                      height: 24.h,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Visit:${request.visits} ",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color:_isLoading ? Colors.grey.shade300 : ColorSchemes.secondary,
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
    Navigator.pushNamed(
      context,
      Routes.requestDetailsScreen,
      arguments: {'request': request},
    );
  }
}
