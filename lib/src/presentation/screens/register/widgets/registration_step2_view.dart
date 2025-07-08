import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/helpers/helper_functions.dart';
import 'package:safety_zone/src/core/utils/permission_service_handler.dart';
import 'package:safety_zone/src/core/utils/show_action_dialog_widget.dart';
import 'package:safety_zone/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/core/utils/upload_image_to_server.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/entity/remote_generate_url.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/vendor_registration_model.dart';
import 'package:safety_zone/src/domain/usecase/auth/generate_image_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';
import 'registration_step3_view.dart';

enum DocumentType { commercial, civilDefense }

class RegistrationStep2View extends StatefulWidget {
  final VendorRegistrationModel vendorData;

  const RegistrationStep2View({
    super.key,
    required this.vendorData,
  });

  @override
  State<RegistrationStep2View> createState() => _RegistrationStep2ViewState();
}

class _RegistrationStep2ViewState extends State<RegistrationStep2View> {
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('dd/MM/yyyy');

  DateTime? _commercialRegistrationExpiryDate;
  DateTime? _civilDefensePermitExpiryDate;
  bool _hasCommercialDoc = false;
  bool _hasCivilDefenseDoc = false;

  final ImagePicker _picker = ImagePicker();
  File? _commercialRegDoc;
  File? _civilDefenseDoc;

  @override
  void initState() {
    super.initState();
    _commercialRegistrationExpiryDate =
        widget.vendorData.commercialRegistrationExpiryDate;
    _civilDefensePermitExpiryDate =
        widget.vendorData.civilDefensePermitExpiryDate;
    _hasCommercialDoc =
        widget.vendorData.commercialRegistrationDocumentPath != null;
    _hasCivilDefenseDoc =
        widget.vendorData.civilDefensePermitDocumentPath != null;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? ColorSchemes.dark : ColorSchemes.light,
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        foregroundColor: Colors.white,
        title: Text(
          S.of(context).signup,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Title with service provider in blue
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              color: dark ? ColorSchemes.darkContainer : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: dark
                            ? ColorSchemes.textLight
                            : ColorSchemes.textDark,
                      ),
                      children: [
                        TextSpan(
                          text: "${S.of(context).newRegistrationAs} ",
                        ),
                        TextSpan(
                          text: S.of(context).serviceProvider,
                          style: TextStyle(
                            color: ColorSchemes.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Progress indicator - 50%
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: 0.50,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ColorSchemes.primary,
                            ),
                            minHeight: 4.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "50%",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorSchemes.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Commercial Registration Expiry Date Section
                      _buildDocumentSection(
                        context: context,
                        title: S.of(context).crExpiryDateLabel,
                        date: _commercialRegistrationExpiryDate,
                        onDateSelected: (date) {
                          setState(() {
                            _commercialRegistrationExpiryDate = date;
                          });
                        },
                        hasDoc: _hasCommercialDoc,
                        onDocumentUploaded: () {
                          // Simulate document upload
                          setState(() {
                            _hasCommercialDoc = true;
                            widget.vendorData
                                    .commercialRegistrationDocumentPath =
                                'path/to/document';
                          });
                        },
                        documentType: DocumentType.commercial,
                      ),

                      SizedBox(height: 32.h),

                      // Civil Defense Permit Expiry Date Section
                      _buildDocumentSection(
                        context: context,
                        title: S.of(context).civilDefenseExpiryDateLabel,
                        date: _civilDefensePermitExpiryDate,
                        onDateSelected: (date) {
                          setState(() {
                            _civilDefensePermitExpiryDate = date;
                          });
                        },
                        hasDoc: _hasCivilDefenseDoc,
                        onDocumentUploaded: () {
                          // Simulate document upload
                          setState(() {
                            _hasCivilDefenseDoc = true;
                            widget.vendorData.civilDefensePermitDocumentPath =
                                'path/to/document';
                          });
                        },
                        documentType: DocumentType.civilDefense,
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom section with continue button
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: dark ? ColorSchemes.darkContainer : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAndContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorSchemes.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    S.of(context).continues,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentSection({
    required BuildContext context,
    required String title,
    required DateTime? date,
    required Function(DateTime) onDateSelected,
    required bool hasDoc,
    required VoidCallback onDocumentUploaded,
    required DocumentType documentType,
  }) {
    THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: ColorSchemes.textDark,
          ),
        ),
        SizedBox(height: 12.h),

        // Date picker field
        InkWell(
          onTap: () => _selectDate(context, date, onDateSelected),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null
                      ? dateFormat.format(date)
                      : S.of(context).selectDate,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: date != null ? ColorSchemes.textDark : Colors.grey,
                  ),
                ),
                Icon(Icons.calendar_today, color: ColorSchemes.primary),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Document upload button - Redesigned
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                hasDoc
                    ? S.of(context).documentUploaded
                    : S.of(context).uploadDocumentHint,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: hasDoc ? ColorSchemes.success : ColorSchemes.textGrey,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              width: 155.w,
              height: 44.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: hasDoc
                    ? ColorSchemes.success.withOpacity(0.1)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                  BoxShadow(
                    color: Color(0x29676E76),
                    blurRadius: 0,
                    offset: Offset(0, 0),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Color(0x14676E76),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () =>
                      _onOpenMediaBottomSheetState(documentType: documentType),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 10.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            hasDoc
                                ? S.of(context).changeDocument
                                : S.of(context).uploadDocument,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: hasDoc
                                  ? ColorSchemes.success
                                  : ColorSchemes.secondary,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          hasDoc ? Icons.check_circle : Icons.upload_file,
                          size: 20.sp,
                          color: hasDoc
                              ? ColorSchemes.success
                              : ColorSchemes.secondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // Show image preview if uploaded
        if (hasDoc) ...[
          SizedBox(height: 16.h),
          _buildDocumentPreview(
            documentType == DocumentType.commercial
                ? _commercialRegDoc
                : _civilDefenseDoc,
            documentType == DocumentType.commercial
                ? widget.vendorData.commercialRegistrationDocumentPath
                : widget.vendorData.civilDefensePermitDocumentPath,
          ),
        ],
      ],
    );
  }

  Widget _buildDocumentPreview(File? file, String? path) {
    void showZoomDialog(ImageProvider imageProvider) {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Colors.black,
          insetPadding: EdgeInsets.all(16),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: PhotoView(
                  imageProvider: imageProvider,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.black),
                  loadingBuilder: (context, event) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget buildImageView(ImageProvider imageProvider) {
      return GestureDetector(
        onTap: () => showZoomDialog(imageProvider),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            height: 120.h,
            decoration: BoxDecoration(
              border: Border.all(color: ColorSchemes.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Image(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    if (file != null) {
      return buildImageView(FileImage(file));
    } else if (path != null &&
        path.isNotEmpty &&
        Uri.tryParse(path)?.isAbsolute == true) {
      return buildImageView(NetworkImage(path));
    }

    return const SizedBox.shrink();
  }

  void _onOpenMediaBottomSheetState({
    required DocumentType documentType,
  }) async {
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        Navigator.pop(context);
        if (await PermissionServiceHandler().handleServicePermission(
          setting: PermissionServiceHandler.getCameraPermission(),
        )) {
          _pickDocument(ImageSource.camera, documentType);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              Navigator.pop(context);
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                    setting: PermissionServiceHandler.getCameraPermission())) {}
              });
            },
            onSecondaryAction: () {
              Navigator.pop(context);
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveCameraPermission,
          );
        }
      },
      onTapGallery: () async {
        Navigator.pop(context);
        if (await PermissionServiceHandler().handleServicePermission(
          setting: PermissionServiceHandler.getSingleImageGalleryPermission(),
        )) {
          _pickDocument(ImageSource.gallery, documentType);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              Navigator.pop(context);
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                  setting: PermissionServiceHandler
                      .getSingleImageGalleryPermission(),
                )) {}
              });
            },
            onSecondaryAction: () {
              Navigator.pop(context);
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveCameraPermission,
          );
        }
      },
    );
  }

  Future<void> _pickDocument(
    ImageSource? result,
    DocumentType documentType,
  ) async {
    try {
      if (result != null) {
        final XFile? image = await _picker.pickImage(
          source: result,
          maxWidth: 1200,
          maxHeight: 1200,
          imageQuality: 85,
        );

        if (image != null) {
          final file = File(image.path);

          if (documentType == DocumentType.commercial) {
            _uploadCommercialRegDoc(file);
          } else {
            _uploadCivilDefenseDoc(file);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(
          context: context,
          message: S.of(context).imagePickError,
          color: ColorSchemes.warning,
          icon: ImagePaths.error,
        );
      }
    }
  }

  Future<void> _uploadCommercialRegDoc(File file) async {
    DataState<List<RemoteGenerateUrl>> result =
        await GenerateImageUrlUseCase(injector())();
    bool isSuccess = await uploadImageToServer(
      file,
      result.data?.first.presignedURL ?? '',
    );
    if (isSuccess) {
      setState(() {
        _commercialRegDoc = file;
        _hasCommercialDoc = true;
        widget.vendorData.commercialRegistrationDocumentPath =
            result.data?.first.mediaUrl ?? file.path;
      });
    } else {
      showSnackBar(
        context: context,
        message: S.of(context).imageUploadError,
        color: ColorSchemes.warning,
        icon: ImagePaths.error,
      );
    }
  }

  Future<void> _uploadCivilDefenseDoc(File file) async {
    DataState<List<RemoteGenerateUrl>> result =
        await GenerateImageUrlUseCase(injector())();
    bool isSuccess = await uploadImageToServer(
      file,
      result.data?.first.presignedURL ?? '',
    );
    if (isSuccess) {
      setState(() {
        _civilDefenseDoc = file;
        _hasCivilDefenseDoc = true;
        widget.vendorData.civilDefensePermitDocumentPath =
            result.data?.first.mediaUrl ?? file.path;
      });
    } else {
      showSnackBar(
        context: context,
        message: S.of(context).imageUploadError,
        color: ColorSchemes.warning,
        icon: ImagePaths.error,
      );
    }
  }

  Future<void> _selectDate(BuildContext context, DateTime? initialDate,
      Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: ColorSchemes.primary,
              ),
        ),
        child: child!,
      ),
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );

    if (picked != null && picked != initialDate) {
      onDateSelected(picked);
    }
  }

  void _validateAndContinue() {
    // Check if dates are selected and documents are uploaded
    if (_commercialRegistrationExpiryDate == null) {
      _showValidationError(context, S.of(context).crExpiryDateRequired);
      return;
    }

    if (!_hasCommercialDoc) {
      _showValidationError(context, S.of(context).crDocumentRequired);
      return;
    }

    if (_civilDefensePermitExpiryDate == null) {
      _showValidationError(
          context, S.of(context).civilDefenseExpiryDateRequired);
      return;
    }

    if (!_hasCivilDefenseDoc) {
      _showValidationError(context, S.of(context).civilDefenseDocumentRequired);
      return;
    }

    // Save data to model
    widget.vendorData.commercialRegistrationExpiryDate =
        _commercialRegistrationExpiryDate;
    widget.vendorData.civilDefensePermitExpiryDate =
        _civilDefensePermitExpiryDate;

    // Ensure paths are saved correctly
    if (_commercialRegDoc != null) {
      widget.vendorData.commercialRegistrationDocumentPath =
          _commercialRegDoc!.path;
    }

    if (_civilDefenseDoc != null) {
      widget.vendorData.civilDefensePermitDocumentPath = _civilDefenseDoc!.path;
    }
    // Navigate to step 3
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationStep3View(
          vendorData: widget.vendorData,
        ),
      ),
    );
  }

  void _showValidationError(BuildContext context, String message) {
    showSnackBar(
      context: context,
      message: message,
      color: ColorSchemes.warning,
      icon: ImagePaths.error,
    );
  }

  void _showActionDialog({
    required String icon,
    required Null Function() onPrimaryAction,
    required Null Function() onSecondaryAction,
    required primaryText,
    required String secondaryText,
    required text,
  }) {
    showActionDialogWidget(
      context: context,
      text: text,
      icon: icon,
      primaryText: primaryText,
      secondaryText: secondaryText,
      primaryAction: onPrimaryAction,
      secondaryAction: onSecondaryAction,
    );
  }
}
