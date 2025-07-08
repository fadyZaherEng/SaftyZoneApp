import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/utils/helpers/helper_functions.dart';
import 'package:safety_zone/src/domain/entities/country.dart';
import 'package:safety_zone/src/domain/entities/vendor_registration_model.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/widgets/custom_textfield.dart';

import 'registration_step2_view.dart';

class RegistrationStep1View extends StatefulWidget {
  final VendorRegistrationModel vendorData;

  const RegistrationStep1View({
    super.key,
    required this.vendorData,
  });

  @override
  State<RegistrationStep1View> createState() => _RegistrationStep1ViewState();
}

class _RegistrationStep1ViewState extends State<RegistrationStep1View> {
  final _formKey = GlobalKey<FormState>();

  final _companyNameController = TextEditingController();
  final _crNumberController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _emailController = TextEditingController();
  String? _companyNameErrorMessage;

  String? _crNumberErrorMessage;

  String? _whatsappErrorMessage;

  String? _emailErrorMessage;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries[0];

    // Initialize controllers with existing data if available
    _companyNameController.text = widget.vendorData.companyName ?? '';
    _crNumberController.text = widget.vendorData.commercialRegistrationNo ?? '';
    _whatsappController.text = widget.vendorData.whatsappNumber ?? '';
    _emailController.text = widget.vendorData.email ?? '';
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _crNumberController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
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

  void _validatePhone(String value) {
    final pattern = switch (_selectedCountry.code) {
      'SA' => RegExp(r'^[0-9]{9}$'),
      'EG' => RegExp(r'^[0-9]{10}$'),
      'AE' => RegExp(r'^[0-9]{9}$'),
      _ => RegExp(r'^[0-9]{9}$'),
    };

    setState(() => _whatsappErrorMessage =
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
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? ColorSchemes.dark : ColorSchemes.light,
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        foregroundColor: Colors.white,
        title: Text(
          S.of(context).signup,
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
            color: ColorSchemes.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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

                  // Progress indicator - 25%
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: 0.25,
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
                        "25%",
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
                      // Company Name Field
                      Text(
                        S.of(context).companyNameLabel,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorSchemes.textDark,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _companyNameController,
                        hintText: S.of(context).companyNamePlaceholder,
                        keyboardType: TextInputType.text,
                        errorMessage: _companyNameErrorMessage,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).companyNameRequired;
                          }
                          return null;
                        },
                        onChanged: (value){
                          if(value.isEmpty){
                            setState(() {
                              _companyNameErrorMessage=S.of(context).thisFieldIsRequired;
                            });
                          }else{
                            setState(() {
                              _companyNameErrorMessage=null;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      // Commercial Registration No Field
                      Text(
                        S.of(context).crNumberLabel,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorSchemes.textDark,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _crNumberController,
                        hintText: S.of(context).crNumberPlaceholder,
                        keyboardType: TextInputType.text,
                        errorMessage: _crNumberErrorMessage,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).crNumberRequired;
                          }
                          return null;
                        },
                        onChanged: (value){
                          if(value.isEmpty){
                            setState(() {
                              _crNumberErrorMessage=S.of(context).thisFieldIsRequired;
                            });
                          }else{
                            setState(() {
                              _crNumberErrorMessage=null;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20.h),

                      // WhatsApp Number Field
                      Text(
                        S.of(context).whatsappNumberLabel,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorSchemes.textDark,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _whatsappController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).whatsappNumberRequired;
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                          hintText: _getHintText(),
                          errorText: _whatsappErrorMessage,
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
                        onChanged: (value) {
                          if (value.length < 8) {
                            setState(() {
                              _whatsappErrorMessage = S.of(context).thisFieldIsRequired;
                            });
                          } else {
                            setState(() {
                              _whatsappErrorMessage = null;
                            });
                          }
                        },
                      ),

                      SizedBox(height: 20.h),

                      // Email Field
                      Text(
                        S.of(context).emailLabel,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorSchemes.textDark,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _emailController,
                        errorMessage: _emailErrorMessage,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              _emailErrorMessage = S.of(context).emailRequired;
                            });
                          } else {
                            setState(() {
                              _emailErrorMessage = null;
                            });
                          }
                        },
                        hintText: S.of(context).emailPlaceholder,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.email_outlined),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).emailRequired;
                          } else if (!_isValidEmail(value)) {
                            return S.of(context).emailInvalid;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom section with continue button only
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
                  onPressed: _saveAndContinue,
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
                _validatePhone(_whatsappController.text);
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

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      // Save data to model
      widget.vendorData.companyName = _companyNameController.text;
      widget.vendorData.commercialRegistrationNo = _crNumberController.text;
      widget.vendorData.whatsappNumber =
          "+${_selectedCountry.dialCode}${_whatsappController.text}";
      widget.vendorData.email = _emailController.text;

      // For debugging
      debugPrint('Step 1 data saved:');
      debugPrint('Company name: ${widget.vendorData.companyName}');
      debugPrint('CR number: ${widget.vendorData.commercialRegistrationNo}');
      debugPrint('WhatsApp: ${widget.vendorData.whatsappNumber}');
      debugPrint('Email: ${widget.vendorData.email}');

      // Navigate to step 2
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RegistrationStep2View(vendorData: widget.vendorData),
        ),
      );
    }
  }
}
