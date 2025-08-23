import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/core/utils/permission_service_handler.dart';
import 'package:safety_zone/src/core/utils/show_action_dialog_widget.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/entity/remote_first_screen_schedule.dart';

import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/request_certificate_installation.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/blocs/upload_doc/upload_doc_bloc.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';

import 'package:safety_zone/src/domain/entities/auth/create_employee.dart'
    as employee;

class UploadDocumentFawryScreen extends BaseStatefulWidget {
  final ScheduleJop request;

  const UploadDocumentFawryScreen({super.key, required this.request});

  @override
  BaseState<UploadDocumentFawryScreen> baseCreateState() =>
      _UploadDocumentFawryScreenState();
}

class _UploadDocumentFawryScreenState
    extends BaseState<UploadDocumentFawryScreen>
    with SingleTickerProviderStateMixin {
  bool _dotsOpen = false;
  bool _isExpandedUpload = false;
  String? imageFile;
  String? finalPath;
  String? fileSize;
  int _currentIndex = 0;
  List<employee.Employee> _employees = [];
  employee.Employee _selectedEmployee = employee.Employee();
  RemoteFirstScreenSchedule model = RemoteFirstScreenSchedule();

  late TabController _tabController;

  UploadDocBloc get uploadDocBloc => BlocProvider.of<UploadDocBloc>(context);
  bool _isLoading = true;

  @override
  void initState() {
    uploadDocBloc.add(GetScheduleJopDetailsEvent(requestId: widget.request.Id));
    uploadDocBloc.add(GetEmployeesEvent());
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<UploadDocBloc, UploadDocState>(
      listener: (context, state) {
        if (state is UploadDocSuccessState) {
          hideLoading();
          _isExpandedUpload = true;
          imageFile = state.url;
          finalPath = state.url;
          showSnackBar(
            context: context,
            message: state.url,
            color: ColorSchemes.success,
            icon: ImagePaths.success,
          );
        } else if (state is UploadDocErrorState) {
          hideLoading();
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.warning,
            icon: ImagePaths.error,
          );
        } else if (state is UploadDocDeleteSuccessState) {
          hideLoading();
          imageFile = null;
          _isExpandedUpload = false;
          _dotsOpen = false;
          showSnackBar(
            context: context,
            message: S.of(context).deletedSuccessfully,
            color: ColorSchemes.success,
            icon: ImagePaths.success,
          );
        } else if (state is UploadDocDeleteErrorState) {
          hideLoading();
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.warning,
            icon: ImagePaths.error,
          );
        } else if (state is UploadDocApiSuccessState) {
          hideLoading();
          showSnackBar(
            context: context,
            message: S.of(context).uploadDocumentSuccess,
            color: ColorSchemes.success,
            icon: ImagePaths.success,
          );
          Navigator.pop(context);
        } else if (state is GetScheduleJopDetailsLoadingState) {
          _isLoading = true;
        } else if (state is GetScheduleJopDetailsSuccessState) {
          model = state.request;
          print(
              "Consumer Request Details: ${model.data?.consumerRequest?.alarmItems?.length}");
          _isLoading = false;
        } else if (state is GetScheduleJopDetailsErrorState) {
          _showValidationError(state.message, false);
          _isLoading = false;
        } else if (state is GetEmployeesSuccessState) {
          _employees = List.from(state.employees);
          _selectedEmployee = _employees.first;
        } else if (state is GetEmployeesErrorState) {
          _showValidationError(state.message, false);
        }
      },
      builder: (context, state) {
        final s = S.of(context);

        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            _dotsOpen = false;
            setState(() {});
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              centerTitle: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: ColorSchemes.primary,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              backgroundColor: ColorSchemes.primary,
              title: Text(
                S.of(context).workingInProgress,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorSchemes.white,
                ),
              ),
              leading: IconButton(
                icon: SvgPicture.asset(
                  ImagePaths.backArrow,
                  color: ColorSchemes.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildRequestCard(context, widget.request),
                    ),
                    const SizedBox(height: 12),
                    if (_isLoading)
                      Center(
                        child: SpinKitDoubleBounce(
                          color: ColorSchemes.primary,
                        ),
                      )
                    else
                      _buildTabBar(s),
                    const SizedBox(height: 16),
                    if (_isLoading)
                      SizedBox(
                        height: 250.h,
                        child: Center(
                          child: SpinKitDoubleBounce(
                            color: ColorSchemes.primary,
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        height: 250.h,
                        child: _buildTabContent(s),
                      ),
                    SizedBox(height: 16.h),
                    if (_isExpandedUpload)
                      Text(
                        widget.request.type ==
                                RequestType.InstallationCertificate.name
                            ? S.of(context).instantLicense
                            : S.of(context).engineeringReport,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (_isExpandedUpload) const SizedBox(height: 8),
                    if (_isExpandedUpload) _buildDoc(context),
                    const SizedBox(height: 16),
                    // const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 44.h,
                      child: CustomButtonWidget(
                        backgroundColor: ColorSchemes.primary,
                        borderColor: ColorSchemes.primary,
                        text: finalPath == null
                            ? S.of(context).uploadLicenseDoc
                            : S.of(context).submit,
                        textColor: ColorSchemes.white,
                        onTap: () => finalPath != null
                            ? _uploadApiDoc(context, widget.request)
                            : _uploadLicenseDoc(context, widget.request),
                      ),
                    ),
                    SizedBox(height: 88.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
                _systemType(model.data?.type?.toLowerCase() ?? ''),
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
                model.data?.consumerRequest?.space?.toString() ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 64),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: ColorSchemes.red,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       padding: const EdgeInsets.symmetric(vertical: 14),
          //     ),
          //     onPressed: () {
          //       debugPrint('Saved Model: $model');
          //       if (_currentIndex < 3 && _currentIndex >= 0) {
          //         if (_currentIndex == 2) {
          //           _currentIndex = 0;
          //         } else {
          //           _currentIndex++;
          //         }
          //         _tabController.animateTo(_currentIndex);
          //       }
          //     },
          //     child: Text(s.next),
          //   ),
          // ),
          // const SizedBox(height: 64),
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

  String _systemType(String systemType) {
    if (systemType.toLowerCase() == "zone") {
      return S.of(context).zone;
    } else if (systemType.toLowerCase() == "loop") {
      return S.of(context).loop;
    } else {
      return S.of(context).loop;
    }
  }

  Widget _buildQuantitiesTab() {
    final s = S.of(context);
    print(
        "Consumer Request: ${model.data?.consumerRequest?.alarmItems?.length}");
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildQuantitySection(
              title: s.alarmItems,
              items: model.data?.consumerRequest?.alarmItems ?? [],
            ),
            const SizedBox(height: 16),
            _buildQuantitySection(
              title: s.fireSystems,
              items: model.data?.consumerRequest?.fireExtinguisherItem ?? [],
            ),
            const SizedBox(height: 16),
            _buildQuantitySection(
              title: s.extinguishingItems,
              items: model.data?.consumerRequest?.fireSystemItem ?? [],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySection({
    required String title,
    required List<AlarmItems> items,
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
                    ? item.value.itemId?.itemName?.en.toString() ?? ''
                    : item.value.itemId?.itemName?.ar.toString() ?? '',
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  "${S.of(context).theEmployeeResponsibleForExecutingTheRequest} : ",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<employee.Employee>(
                value: _selectedEmployee,
                onChanged: (employee.Employee? value) {
                  debugPrint('Selected Employee: ${value?.Id}');
                  setState(() {
                    _selectedEmployee = value ?? _selectedEmployee;
                  });
                },
                items: _employees.map((emp) {
                  return DropdownMenuItem(
                    value: emp,
                    child: Text(
                      emp.fullName ?? '',
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
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, ScheduleJop request) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- رقم الطلب + الحالة ---
            Row(
              children: [
                Text(
                  request.requestNumber, // 👈 بدل Id
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    _getStatus(request.status),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  backgroundColor: ColorSchemes.secondary,
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// --- الفرع + العنوان ---
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
                      request.branch.address.split(",").last,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Divider(),

            /// --- النوع + الخطوة الحالية ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: ColorSchemes.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getTitle(request.type),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// --- تاريخ الزيارة + عدد الزيارات ---
            if (request.numberOfVisits >
                0) // Show only if number of visits is greater than 0
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "${S.of(context).visitDate}: ${DateFormat('dd/MM/yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(request.visitDate),
                    )}",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${S.of(context).numberOfVisits}: ${request.numberOfVisits}",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 12),

            /// --- الموظف المسؤول عن الرد ---
            Row(
              children: [
                SvgPicture.asset(ImagePaths.technical,
                    height: 16.h, width: 16.w),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    S.of(context).responsibleEmployee,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Text(
                  request.responseEmployee.fullName,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// --- موظف الفرع ---
            Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    S.of(context).branchEmployee,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Text(
                  request.branch.employee.fullName,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// --- تاريخ الإنشاء ---
            Text(
              "${S.of(context).createdAt}: ${DateFormat('dd/MM/yyyy HH:mm').format(
                DateTime.fromMillisecondsSinceEpoch(request.createdAt),
              )}",
              style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadLicenseDoc(BuildContext context, request) {
    _pickPDFFile();
  }

  Future<void> _pickPDFFile() async {
    showLoading();
    if (await PermissionServiceHandler().handleServicePermission(
        setting: PermissionServiceHandler.getStorageFilesPermission(
      androidDeviceInfo:
          Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null,
    ))) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        final String filePath = result.files.single.path!;
        XFile imageFile = XFile(filePath);
        //ToDO: Save File
        fileSize = "${(await getFileSize(imageFile)).toStringAsFixed(2)} mb";
        // ToDO: Upload File in Server
        uploadDocBloc.add(UploadDocumentEvent(docPath: imageFile.path));
      }
    } else {
      hideLoading();
      _dialogMessage(
        icon: ImagePaths.warning,
        message: S.of(context).storagePermissionIsRequiredToProceed,
        primaryAction: () async {
          Navigator.pop(context);
          openAppSettings().then((value) async {});
        },
      );
    }
  }

  void _dialogMessage({
    required String message,
    required String icon,
    required Function() primaryAction,
    Function()? secondaryAction,
  }) {
    showActionDialogWidget(
      context: context,
      text: message,
      icon: icon,
      primaryText: S.of(context).ok,
      secondaryText: S.of(context).cancel,
      primaryAction: primaryAction,
      secondaryAction: () => secondaryAction ?? Navigator.pop(context),
    );
  }

  Future<double> getFileSize(XFile? imageFile) async {
    if (imageFile != null) {
      File file = File(imageFile.path);
      return await file.length() / 1024;
    }
    return 0;
  }

  _uploadApiDoc(BuildContext context, ScheduleJop request) {
    showLoading();
    uploadDocBloc.add(
      UploadDocumentAPiEvent(
        request: RequestCertificateInstallation(
          branch: widget.request.branch.Id,
          consumer: widget.request.consumer.id,
          scheduleJob: widget.request.Id,
          file: finalPath,
        ),
      ),
    );
  }

  String _getTitle(String requestType) {
    if (RequestType.FireExtinguisher.name == requestType) {
      return S.of(context).fireSystems;
    } else if (RequestType.MaintenanceContract.name == requestType) {
      return S.of(context).maintenanceContracts;
    } else {
      return S.of(context).instantLicense;
    }
  }

  String _getStatus(String status) {
    if (status == "pending") {
      return S.of(context).pending;
    } else if (status == "accepted") {
      return S.of(context).accepted;
    } else if (status == "rejected") {
      return S.of(context).rejected;
    } else if (status == "cancelled") {
      return S.of(context).cancelled;
    } else if (status == "active") {
      return S.of(context).active;
    } else if (status == "inProgress") {
      return S.of(context).inProgress;
    } else {
      return S.of(context).rejected;
    }
  }

  _buildDoc(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: double.infinity,
            height: 80.h,
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      ImagePaths.pdf,
                      width: 32.w,
                      height: 32.h,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.request.type ==
                                  RequestType.InstallationCertificate.name
                              ? S.of(context).instantLicenseForCompany
                              : S.of(context).engineeringReportForCompany,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fileSize ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _dotsOpen = !_dotsOpen;
                        });
                      },
                      icon: SvgPicture.asset(
                        ImagePaths.dots,
                        width: 24.w,
                        height: 24.h,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (_dotsOpen)
            Positioned(
              left: GetLanguageUseCase(injector())() == 'ar' ? 50.w : null,
              right: GetLanguageUseCase(injector())() == 'en' ? 50.w : null,
              top: 40.h,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorSchemes.white,
                    border: Border.all(color: ColorSchemes.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const SizedBox(width: 4),
                          SizedBox(
                            height: 48.h,
                            child: IconButton(
                              onPressed: _pickPDFFile,
                              icon: SvgPicture.asset(
                                ImagePaths.edit,
                                width: 24.w,
                                height: 24.h,
                                color: ColorSchemes.secondary,
                                semanticsLabel: S.of(context).edit,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            S.of(context).edit,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              color: ColorSchemes.secondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 48.h,
                        child: InkWell(
                          onTap: () {
                            uploadDocBloc
                                .add(DeleteDocEvent(docPath: imageFile ?? ''));
                            setState(() {
                              _dotsOpen = false;
                              _isExpandedUpload = false;
                              imageFile = null;
                            });
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 4),
                              Container(
                                width: 48.w,
                                height: 48.h,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  ImagePaths.delete,
                                  width: 24.w,
                                  height: 24.h,
                                  color: ColorSchemes.red,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                S.of(context).delete,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorSchemes.red,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
