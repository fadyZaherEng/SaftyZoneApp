import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/helpers/helper_functions.dart';
import 'package:safety_zone/src/core/utils/permission_service_handler.dart';
import 'package:safety_zone/src/core/utils/show_action_dialog_widget.dart';
import 'package:safety_zone/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/domain/entities/country.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import '../cubit/add_employee_cubit.dart';

class AddEmployeeBasicInfo extends StatefulWidget {
  const AddEmployeeBasicInfo({super.key});

  @override
  State<AddEmployeeBasicInfo> createState() => _AddEmployeeBasicInfoState();
}

class _AddEmployeeBasicInfoState extends State<AddEmployeeBasicInfo> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _errorMessageFullName;
  String? _errorMessageJobTitle;
  String? _errorMessagePhone;
  String? _photoPath;

  @override
  void dispose() {
    _fullNameController.dispose();
    _jobTitleController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  final List<Country> _countries = [
    Country(
      code: 'SA',
      dialCode: '+966',
      name: 'saudiArabia',
      flag: '🇸🇦',
    ),
  ];

  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries[0];
  }

  void _validatePhone(String value) {
    final pattern = switch (_selectedCountry.code) {
      'SA' => RegExp(r'^[0-9]{9}$'),
      'EG' => RegExp(r'^[0-9]{10}$'),
      'AE' => RegExp(r'^[0-9]{9}$'),
      _ => RegExp(r'^[0-9]{9}$'),
    };

    setState(() => _errorMessagePhone =
        pattern.hasMatch(value) ? null : S.of(context).invalidPhoneNumber);
  }

  String _getHintText() => switch (_selectedCountry.code) {
        'SA' => '5XXXXXXXX',
        'EG' => '10XXXXXXXX',
        'AE' => '5XXXXXXXX',
        _ => '5XXXXXXXX',
      };

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEmployeeCubit>();
    final state = context.watch<AddEmployeeCubit>().state;
    final dark = THelperFunctions.isDarkMode(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).fullName,
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildInput(
                          errorMessage: _errorMessageFullName,
                          label: S.of(context).enterFullName,
                          controller: _fullNameController,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                          onChanged: (value) {
                            setState(() {
                              _errorMessageFullName =
                                  value == null || value.isEmpty
                                      ? S.of(context).thisFieldIsRequired
                                      : null;
                            });
                            _onChanged(cubit);
                          }),
                      SizedBox(height: 16.h),
                      Text(
                        S.of(context).jopTitle,
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildInput(
                          errorMessage: _errorMessageJobTitle,
                          label: S.of(context).enterJopTitle,
                          controller: _jobTitleController,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                          onChanged: (value) {
                            setState(() {
                              _errorMessageJobTitle =
                                  value == null || value.isEmpty
                                      ? S.of(context).thisFieldIsRequired
                                      : null;
                            });
                            _onChanged(cubit);
                          }),
                      SizedBox(height: 16.h),
                      Text(
                        S.of(context).phoneNumber,
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      SizedBox(height: 8.h),

                      /// Phone Input
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          setState(() {
                            _errorMessagePhone =
                                value == null || value.length < 8
                                    ? S.of(context).invalidPhoneNumber
                                    : null;
                          });
                          _onChanged(cubit);
                        },
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                          hintText: _getHintText(),
                          errorText: _errorMessagePhone,
                          labelText: S.of(context).enterPhoneNumber,
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            fontFamily: 'SF Pro',
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w,
                          ),
                          prefixIcon: _buildCountryDropdown(dark),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).invalidPhoneNumber;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),
                      Text(
                        S.of(context).uploadPhoto,
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        S
                            .of(context)
                            .pleaseUploadAClearPhotoOfTheEmployeeASJPGPNGMax2MB,
                        style: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: 12.sp,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildUploadPhoto(context, cubit),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              label: S.of(context).previous,
                              enabled: false,
                              color: const Color(0xFFCCCCCC),
                              textColor: Colors.white,
                              onTap: null,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: _buildButton(
                              label: S.of(context).next,
                              enabled: state.canGoNext,
                              color: const Color(0xFFA50000),
                              textColor: Colors.white,
                              onTap: state.canGoNext
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.nextStep();
                                      }
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Center(
            child: TextButton.icon(
              onPressed: () {
                cubit.reset();
                _fullNameController.clear();
                _jobTitleController.clear();
                _phoneController.clear();
                setState(() => _photoPath = null);
              },
              icon: Icon(Icons.add_circle, color: Color(0xFF1C3D80)),
              label: Text(
                S.of(context).addAnotherEmployee,
                style: TextStyle(
                  color: Color(0xFF1C3D80),
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  fontFamily: 'SF Pro',
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF1C3D80),
                textStyle: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildCountryDropdown(bool dark) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Country>(
          value: _selectedCountry,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: (Country? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedCountry = newValue;
                _validatePhone(_phoneController.text);
              });
            }
          },
          items: _countries.map((country) {
            return DropdownMenuItem(
              value: country,
              child: Text(
                country.flag,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: country.code == _selectedCountry.code
                      ? ColorSchemes.primary
                      : (dark ? Colors.white : Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
    String? errorMessage,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(
        color: const Color(0xFF333333),
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        fontFamily: 'SF Pro',
      ),
      decoration: InputDecoration(
        errorText: errorMessage,
        hintText: label,
        hintStyle: TextStyle(
          color: const Color(0xFF999999),
          fontSize: 14.sp,
          fontFamily: 'SF Pro',
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFA50000)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFA50000)),
        ),
      ),
    );
  }

  void _onOpenMediaBottomSheetState(cubit) async {
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        Navigator.pop(context);
        if (await PermissionServiceHandler().handleServicePermission(
          setting: PermissionServiceHandler.getCameraPermission(),
        )) {
          _pickDocument(ImageSource.camera, cubit);
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
          _pickDocument(ImageSource.gallery, cubit);
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

  Future<void> _pickDocument(
    ImageSource? result,
    AddEmployeeCubit cubit,
  ) async {
    ImagePicker picker = ImagePicker();
    try {
      if (result != null) {
        final XFile? image = await picker.pickImage(
          source: result,
          maxWidth: 1200,
          maxHeight: 1200,
          imageQuality: 85,
        );

        if (image != null) {
          // TODO: Implement file picker/camera
          // For now, just simulate
          setState(() => _photoPath = image.path);
          // TODO: Update photo
          debugPrint("Photo path: ${image.path}");
          cubit.updatePhoto(image.path);
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

  Widget _buildUploadPhoto(BuildContext context, AddEmployeeCubit cubit) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => _onOpenMediaBottomSheetState(cubit),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Icon(Icons.upload, color: const Color(0xFFA50000)),
            ),
          ),
          Text(
            S.of(context).upload,
            style: TextStyle(
              color: const Color(0xFFA50000),
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              fontFamily: 'SF Pro',
            ),
          ),
          const Spacer(),
          if (_photoPath != null)
            GestureDetector(
              onTap: () {
                _buildDocumentPreview(File(_photoPath!), null);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: FileImage(File(_photoPath!)),
                ),
              ),
            ),
        ],
      ),
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
      print(file.path);
      return buildImageView(FileImage(file));
    } else if (path != null &&
        path.isNotEmpty &&
        Uri.tryParse(path)?.isAbsolute == true) {
      return buildImageView(NetworkImage(path));
    }

    return const SizedBox.shrink();
  }

  Widget _buildButton({
    required String label,
    required bool enabled,
    required Color color,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: 150.w,
      height: 48.h,
      child: CustomButtonWidget(
        textColor: textColor,
        onTap: onTap ?? () {},
        backgroundColor: color,
        text: label,
      ),
    );
  }

  void _onChanged(AddEmployeeCubit cubit) {
    cubit.updateBasicInfo(
      fullName: _fullNameController.text,
      jobTitle: _jobTitleController.text,
      phoneNumber: _phoneController.text,
      photoPath: _photoPath,
    );
  }
}
