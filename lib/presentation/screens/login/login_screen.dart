import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatif_mobile/config/routes/routes_manager.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/data_state.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/core/utils/show_snack_bar.dart';
import 'package:hatif_mobile/data/sources/remote/safty_zone/auth/request/request_send_otp.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/entities/country.dart';
import 'package:hatif_mobile/domain/usecase/auth/send_otp_use_case.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isValidPhone = false;

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

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _validatePhone(String value) {
    final pattern = switch (_selectedCountry.code) {
      'SA' => RegExp(r'^[0-9]{9}$'),
      'EG' => RegExp(r'^[0-9]{10}$'),
      'AE' => RegExp(r'^[0-9]{9}$'),
      _ => RegExp(r'^[0-9]{9}$'),
    };

    setState(() => _isValidPhone = pattern.hasMatch(value));
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
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        elevation: 0,
        title: Text(
          S.of(context).loginTitle,
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: dark ? ColorSchemes.darkContainer : ColorSchemes.lightContainer,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.h),

                  /// Welcome Text
                  Text(
                    S.of(context).welcomeBack,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: dark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Subtitle and create account
                  Row(
                    children: [
                      Text(
                        S.of(context).loginBelow,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          Routes.register,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Text(
                            "  ${S.of(context).createAccount}",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  /// Phone Label
                  Text(
                    S.of(context).phoneNumber,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: dark ? Colors.white : Colors.black87,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Phone Input
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: _validatePhone,
                    style: TextStyle(fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: _getHintText(),
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
                      if (value == null || value.isEmpty || !_isValidPhone) {
                        return S.of(context).invalidPhoneNumber;
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 8.h),

                  /// Country Info
                  Row(
                    children: [
                      Text(
                        '${S.of(context).selectedCountry}: ',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      Text(
                        '${_selectedCountry.name} (${_selectedCountry.dialCode})',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorSchemes.primary,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// Login Button
                  SizedBox(
                    width: 1.sw,
                    child: ElevatedButton(
                      onPressed: _isValidPhone ? _submit : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorSchemes.primary,
                        disabledBackgroundColor:
                            ColorSchemes.primary.withOpacity(0.5),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        S.of(context).loginTitle,
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

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final fullNumber = '${_selectedCountry.dialCode}${_phoneController.text}';

      DataState<String> response = await SendOtpUseCase(injector())(
          request: RequestSendOtp(phoneNumber: fullNumber));

      if (response is DataSuccess) {
        Navigator.pushNamed(
          context,
          Routes.verificationCode,
          arguments: {
            'phoneNumber': _phoneController.text,
            'countryCode': _selectedCountry.dialCode,
          },
        );
      } else {
        _showError(response.message ?? '', true);
      }
    }
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
