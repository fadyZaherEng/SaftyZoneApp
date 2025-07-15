import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/core/utils/permission_service_handler.dart';
import 'package:safety_zone/src/core/utils/show_action_dialog_widget.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/blocs/upload_doc/upload_doc_bloc.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class UploadDocumentFawryScreen extends BaseStatefulWidget {
  final ScheduleJop request;

  const UploadDocumentFawryScreen({super.key, required this.request});

  @override
  BaseState<UploadDocumentFawryScreen> baseCreateState() =>
      _UploadDocumentFawryScreenState();
}

class _UploadDocumentFawryScreenState
    extends BaseState<UploadDocumentFawryScreen> {
  bool _dotsOpen = false;
  bool _isExpandedUpload = false;
  String? imageFile;
  String? fileSize;

  UploadDocBloc get uploadDocBloc => BlocProvider.of<UploadDocBloc>(context);

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<UploadDocBloc, UploadDocState>(
      listener: (context, state) {
        if (state is UploadDocSuccessState) {
          _isExpandedUpload = true;
          imageFile = state.url;
          showSnackBar(
            context: context,
            message: state.url,
            color: ColorSchemes.success,
            icon: ImagePaths.success,
          );
        } else if (state is UploadDocErrorState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.warning,
            icon: ImagePaths.error,
          );
        } else if (state is UploadDocDeleteSuccessState) {
          imageFile = null;
          _isExpandedUpload = false;
          _dotsOpen = false;
          showSnackBar(
            context: context,
            message: S.of(context).deletedSuccessfully,
            color: ColorSchemes.success,
            icon: ImagePaths.success,
          );
        }
      },
      builder: (context, state) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildRequestCard(context, widget.request),
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
                  if (_isExpandedUpload)
                    SizedBox(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S
                                              .of(context)
                                              .instantLicenseForCompany,
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
                              left: GetLanguageUseCase(injector())() == 'ar'
                                  ? 50.w
                                  : null,
                              right: GetLanguageUseCase(injector())() == 'en'
                                  ? 50.w
                                  : null,
                              top: 40.h,
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorSchemes.white,
                                    border:
                                        Border.all(color: ColorSchemes.white),
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
                                                semanticsLabel:
                                                    S.of(context).edit,
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
                                            uploadDocBloc.add(
                                              DeleteDocEvent(
                                                docPath: imageFile ?? '',
                                              ),
                                            );
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
                    ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 44.h,
                    child: CustomButtonWidget(
                      backgroundColor: ColorSchemes.primary,
                      borderColor: ColorSchemes.primary,
                      text: S.of(context).uploadLicenseDoc,
                      textColor: ColorSchemes.white,
                      onTap: () => _uploadLicenseDoc(context, widget.request),
                    ),
                  ),
                  SizedBox(height: 88.h),
                ],
              ),
            ),
          ),
        );
      },
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
            Row(
              children: [
                Text(
                  request.Id,
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
                  backgroundColor: ColorSchemes.secondary,
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
                      request.branch.address.split(",").last,
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
                if (!SystemType.isExtinguisherType(request.type)) Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: ColorSchemes.secondary,
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
            const SizedBox(height: 16),
            Row(
              children: [
                SvgPicture.asset(
                  ImagePaths.technical,
                  height: 16.h,
                  width: 16.w,
                ),
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
                const SizedBox(width: 4),
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
      hideLoading();
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
}
