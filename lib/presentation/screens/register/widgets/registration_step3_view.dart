import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/data_state.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/core/utils/helpers/helper_functions.dart';
import 'package:hatif_mobile/core/utils/show_snack_bar.dart';
import 'package:hatif_mobile/data/sources/remote/safty_zone/auth/request/request_register.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/entities/auth/register.dart';
import 'package:hatif_mobile/domain/usecase/auth/register_use_case.dart';
import 'package:hatif_mobile/domain/usecase/set_token_use_case.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/screens/map_search/map_search_screen.dart';
import 'package:hatif_mobile/presentation/widgets/custom_textfield.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../domain/entities/vendor_registration_model.dart';
import 'registration_success_view.dart';

class RegistrationStep3View extends StatefulWidget {
  final VendorRegistrationModel vendorData;

  const RegistrationStep3View({super.key, required this.vendorData});

  @override
  State<RegistrationStep3View> createState() => _RegistrationStep3ViewState();
}

class _RegistrationStep3ViewState extends State<RegistrationStep3View> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _bankAccountNameController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();

  bool _confirmationChecked = false;
  bool _termsChecked = false;

  static const Color darkRed = Color(0xFF8B0000);
  static const Color darkBlue = Color(0xFF003366);

  @override
  void initState() {
    super.initState();
    _locationController.text = widget.vendorData.address ?? '';
    _bankAccountNameController.text = widget.vendorData.bankName ?? '';
    _bankAccountNumberController.text =
        widget.vendorData.bankAccountNumber ?? '';
    _confirmationChecked = widget.vendorData.confirmationChecked ?? false;
    _termsChecked = widget.vendorData.termsChecked ?? false;
  }

  @override
  void dispose() {
    _locationController.dispose();
    _bankAccountNameController.dispose();
    _bankAccountNumberController.dispose();
    super.dispose();
  }

  Future<void> _openMapPicker() async {
    if (!await _handleLocationPermission()) return;

    try {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MapSearchScreen(
            initialLatitude: widget.vendorData.latitude ?? 24.774265,
            initialLongitude: widget.vendorData.longitude ?? 46.738586,
            onLocationSelected: (lat, lng, address) {
              setState(() {
                widget.vendorData.latitude = lat;
                widget.vendorData.longitude = lng;
                if (address.isNotEmpty) {
                  _locationController.text = address;
                  widget.vendorData.address = address;
                }
              });
              _showValidationError(S.of(context).locationSelected, false);
            },
          ),
        ),
      );
    } catch (e) {
      _showValidationError('Error loading map: $e', true);
    }
  }

  Future<bool> _handleLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _showPermissionError(S.of(context).locationServicesDisabled);
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showValidationError(S.of(context).locationPermissionDenied, false);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionError(S.of(context).locationPermissionPermanentlyDenied);
      return false;
    }

    return true;
  }

  void _showPermissionError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Settings',
          textColor: Colors.white,
          onPressed: openAppSettings,
        ),
      ),
    );
  }

  void _showValidationError(String message, bool isError) {
    showSnackBar(
      context: context,
      message: message,
      color: isError ? ColorSchemes.warning : ColorSchemes.success,
      icon: isError ? ImagePaths.error : ImagePaths.success,
    );
  }

  bool _isFormValid() {
    return _formKey.currentState?.validate() == true &&
        _confirmationChecked &&
        _termsChecked &&
        _locationController.text.isNotEmpty &&
        _bankAccountNameController.text.isNotEmpty &&
        _bankAccountNumberController.text.isNotEmpty;
  }

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          S.of(context).termsAndConditions,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            S.of(context).termsAndConditionsText,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              S.of(context).close,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final titleStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF333333),
    );

    return Scaffold(
      backgroundColor: dark ? ColorSchemes.dark : const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: darkRed,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          S.of(context).signup,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              color: dark ? ColorSchemes.darkContainer : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: dark
                              ? ColorSchemes.textLight
                              : const Color(0xFF333333)),
                      children: [
                        TextSpan(text: "${S.of(context).newRegistrationAs} "),
                        TextSpan(
                          text: S.of(context).serviceProvider,
                          style: TextStyle(
                            color: darkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: 0.75,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation(darkBlue),
                            minHeight: 4.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "75%",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
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
                      _buildSectionHeader(
                        S.of(context).locationLabel,
                        S.of(context).pinOnMap,
                        _openMapPicker,
                      ),
                      CustomTextField(
                        controller: _locationController,
                        hintText: S.of(context).locationPlaceholder,
                        keyboardType: TextInputType.text,
                        maxLines: 2,
                        validator: (value) => (value == null || value.isEmpty)
                            ? S.of(context).locationRequired
                            : null,
                      ),
                      SizedBox(height: 20.h),
                      Text(S.of(context).bankAccountNameLabel,
                          style: titleStyle),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _bankAccountNameController,
                        hintText: S.of(context).bankAccountNamePlaceholder,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).bankAccountNameRequired;
                          }
                          if (RegExp(r'[0-9]').hasMatch(value)) {
                            return S.of(context).bankAccountNameAlphabetical;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(S.of(context).bankAccountNumberLabel,
                          style: titleStyle),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _bankAccountNumberController,
                        hintText: S.of(context).bankAccountNumberPlaceholder,
                        keyboardType: TextInputType.number,
                        validator: (value) => (value == null || value.isEmpty)
                            ? S.of(context).bankAccountNumberRequired
                            : null,
                      ),
                      SizedBox(height: 32.h),
                      _buildCheckbox(
                          S.of(context).confirmInformation,
                          _confirmationChecked,
                          (val) => setState(
                              () => _confirmationChecked = val ?? false)),
                      _buildCheckboxWithTerms(),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, String actionLabel, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
          ),
        ),
        TextButton.icon(
          onPressed: onTap,
          icon: Icon(Icons.add_location, color: darkRed),
          label: Text(actionLabel,
              style: TextStyle(color: darkRed, fontWeight: FontWeight.w500)),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.grey[400]),
      child: CheckboxListTile(
        title: Text(title,
            style: TextStyle(fontSize: 16.sp, color: const Color(0xFF333333))),
        value: value,
        activeColor: darkRed,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildCheckboxWithTerms() {
    final dark = THelperFunctions.isDarkMode(context);
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.grey[400]),
      child: CheckboxListTile(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.of(context).iAgreeToThe,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: dark ? Colors.white : const Color(0xFF333333),
                ),
              ),
              TextSpan(
                text: ' ${S.of(context).termsAndConditions}',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: darkRed,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _showTermsAndConditions(context),
              ),
            ],
          ),
        ),
        value: _termsChecked,
        activeColor: darkRed,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        onChanged: (val) => setState(() => _termsChecked = val ?? false),
      ),
    );
  }

  Widget _buildBottomConfirmButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: THelperFunctions.isDarkMode(context)
            ? ColorSchemes.darkContainer
            : Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isFormValid() ? _confirmRegistration : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: darkRed,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[400],
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            S.of(context).confirm,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _confirmRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_confirmationChecked || !_termsChecked) {
      showSnackBar(
        context: context,
        message: _confirmationChecked
            ? S.of(context).pleaseAgreeToTerms
            : S.of(context).pleaseConfirmInformation,
        color: ColorSchemes.warning,
        icon: ImagePaths.warning,
      );

      return;
    }

    widget.vendorData
      ..address = _locationController.text
      ..bankName = _bankAccountNameController.text
      ..bankAccountNumber = _bankAccountNumberController.text
      ..confirmationChecked = _confirmationChecked
      ..termsChecked = _termsChecked
      ..latitude ??= 24.774265
      ..longitude ??= 46.738586;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(darkRed),
        ),
      ),
    );

    try {
      DataState<Register> response = await RegisterUseCase(injector())(
        request: RequestRegister(
          email: widget.vendorData.email ?? 'null',
          address:
              widget.vendorData.address ?? widget.vendorData.location ?? 'null',
          bankName: widget.vendorData.bankName ??
              widget.vendorData.bankAccountName ??
              'null',
          bankAccountNumber: widget.vendorData.bankAccountNumber ?? 'null',
          commercialRegistrationNumber:
              widget.vendorData.commercialRegistrationNo ?? 'null',
          phoneNumber: widget.vendorData.whatsappNumber ?? 'null',
          companyName: widget.vendorData.companyName ?? 'null',
          location: Location(type: 'Point', coordinates: [
            widget.vendorData.longitude ?? 30.123456,
            widget.vendorData.latitude ?? -97.654321
          ]),
          civilDefensePermit: CivilDefensePermit(
            filePath: widget.vendorData.civilDefensePermitDocumentPath,
            expiryDate: widget.vendorData.civilDefensePermitExpiryDate
                ?.millisecondsSinceEpoch,
          ),
          commercialRegistration: CommercialRegistration(
            filePath: widget.vendorData.commercialRegistrationDocumentPath,
            expiryDate: widget.vendorData.commercialRegistrationExpiryDate
                ?.millisecondsSinceEpoch,
          ),
        ),
      );
      print("rrrrrrrrrrrrrrrrrr$response");
      if (response is DataSuccess) {
        SetTokenUseCase(injector())(response.data?.token ?? '');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RegistrationSuccessView(vendorData: widget.vendorData),
          ),
          (route) => false, // Remove all previous routes
        );
      } else {
        _showValidationError(response.message ?? 'Registration failed', true);
      }
    } catch (e) {
      Navigator.pop(context);
      _showValidationError('Registration failed: $e', true);
    }
  }
}
