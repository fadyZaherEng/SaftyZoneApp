import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_send_otp.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/country.dart';
import 'package:safety_zone/src/domain/usecase/auth/send_otp_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/core/utils/helpers/helper_functions.dart';

class WhatsappVerificationScreen extends StatefulWidget {
  const WhatsappVerificationScreen({super.key});

  @override
  State<WhatsappVerificationScreen> createState() =>
      _WhatsappVerificationScreenState();
}

class _WhatsappVerificationScreenState
    extends State<WhatsappVerificationScreen> {
  final TextEditingController _whatsappController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isValidPhone = false;
  bool _isLoading = false;

  final List<Country> _countries = [
    Country(code: 'SA', dialCode: '+966', name: 'saudiArabia', flag: '🇸🇦'),
    Country(code: 'EG', dialCode: '+20', name: 'egypt', flag: '🇪🇬'),
    Country(code: 'AE', dialCode: '+971', name: 'uae', flag: '🇦🇪'),
  ];

  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries[0];
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        elevation: 0,
        title: Text(
          S.of(context).enterWhatsappNumber,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          decoration: BoxDecoration(
            color:
                dark ? ColorSchemes.darkContainer : ColorSchemes.lightContainer,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    Text(
                      S.of(context).enterWhatsappNumber,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: dark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      S.of(context).whatsappNumber,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: dark ? Colors.white : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _whatsappController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 16.sp),
                      onChanged: _validatePhone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        prefixIcon: DropdownButtonHideUnderline(
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
                                        : dark
                                            ? Colors.white
                                            : Colors.black87,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        hintText: _getHintText(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !_isValidPhone) {
                          return S.of(context).invalidPhoneNumber;
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Row(
                        children: [
                          Text(
                            '${S.of(context).selectedCountry}: ',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.grey),
                          ),
                          Text(
                            '${_selectedCountry.name} (${_selectedCountry.dialCode})',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorSchemes.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 1.sw,
                      child: ElevatedButton(
                        onPressed:
                            _isValidPhone && !_isLoading ? _sendOTP : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorSchemes.primary,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          disabledBackgroundColor:
                              ColorSchemes.primary.withOpacity(0.5),
                        ),
                        child: _isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                S.of(context).next,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validatePhone(String value) {
    final patterns = {
      'SA': r'^[0-9]{9}$',
      'EG': r'^[0-9]{10}$',
      'AE': r'^[0-9]{9}$',
    };
    final pattern = patterns[_selectedCountry.code] ?? r'^[0-9]{9}$';
    setState(() => _isValidPhone = RegExp(pattern).hasMatch(value));
  }

  String _getHintText() {
    switch (_selectedCountry.code) {
      case 'SA':
      case 'AE':
        return '5XXXXXXXX';
      case 'EG':
        return '10XXXXXXXX';
      default:
        return '5XXXXXXXX';
    }
  }

  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final fullPhoneNumber =
        _selectedCountry.dialCode + _whatsappController.text.trim();

    try {
      final response = await SendOtpUseCase(injector())(
        request: RequestSendOtp(phoneNumber: fullPhoneNumber),
      );

      if (response is DataSuccess && mounted) {
        Navigator.pushNamed(
          context,
          Routes.verificationCode,
          arguments: {
            'phoneNumber': fullPhoneNumber,
            'countryCode': _selectedCountry.dialCode,
          },
        );
      } else if (mounted) {
        _showError(response.message ?? S.of(context).error, true);
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString(), true);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _whatsappController.dispose();
    super.dispose();
  }

  void _showError(String message, bool isError) {
    showSnackBar(
      context: context,
      message: message,
      color: isError ? ColorSchemes.warning : ColorSchemes.success,
      icon: isError ? ImagePaths.error : ImagePaths.success,
    );
  }
}
