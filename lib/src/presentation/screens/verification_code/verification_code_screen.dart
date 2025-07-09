import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/enums.dart';
import 'package:safety_zone/src/core/utils/helpers/helper_functions.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_send_otp.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_verify_otp.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/entities/auth/verify_otp.dart';
import 'package:safety_zone/src/domain/usecase/auth/check_auth_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/re_send_otp_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/verify_send_otp_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_authenticate_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_token_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_user_verification_data_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeScreen extends StatefulWidget {
  final Map<String, dynamic> args;

  const VerificationCodeScreen({super.key, required this.args});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;
  bool _canResend = false;
  int _secondsRemaining = 60;
  Timer? _timer;
  bool _isRememberMe = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final phoneNumber = widget.args['phoneNumber'] as String;
    final maskedPhone = phoneNumber.length > 4
        ? '****${phoneNumber.substring(phoneNumber.length - 4)}'
        : phoneNumber;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        elevation: 0,
        title: Text(
          S.of(context).verifyCode,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: dark ? ColorSchemes.darkContainer : ColorSchemes.lightContainer,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                Text(
                  S.of(context).enterVerificationCode,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: dark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  '${S.of(context).codeSentTo} $maskedPhone',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 40.h),
                Center(
                  child: SizedBox(
                    height: 48.h,
                    width: 216.w,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        controller: _codeController,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 48,
                          fieldWidth: 48,
                          activeFillColor:
                              dark ? ColorSchemes.dark : Colors.white,
                          inactiveFillColor:
                              dark ? ColorSchemes.dark : Colors.white,
                          selectedFillColor:
                              dark ? ColorSchemes.dark : Colors.white,
                          activeColor: ColorSchemes.primary,
                          inactiveColor: Colors.grey,
                          selectedColor: ColorSchemes.primary,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        onChanged: (_) {},
                        beforeTextPaste: (_) => true,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 48.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Center(
                            child: _canResend
                                ? TextButton(
                                    onPressed: _resendOTP,
                                    child: Text(
                                      S.of(context).resendCode,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: ColorSchemes.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).resendCodeIn,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        _formatTimeRemaining(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: ColorSchemes.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          const SizedBox(width: 8),
                          //remember me
                          if (_canResend)
                            Row(
                              children: [
                                Checkbox(
                                  value: _isRememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _isRememberMe = value ?? false;
                                    });
                                  },
                                ),
                                Text(
                                  S.of(context).rememberMe,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 1.sw,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSchemes.primary,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      disabledBackgroundColor:
                          ColorSchemes.primary.withOpacity(0.5),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            S.of(context).verify,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 64.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startResendTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  String _formatTimeRemaining() {
    final minutes = (_secondsRemaining / 60).floor();
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _verifyOTP() async {
    if (!mounted || _codeController.text.length != 4) {
      _showError(S.of(context).invalidCode, true);
      return;
    }

    setState(() => _isLoading = true);

    final phoneNumber = widget.args['phoneNumber'] as String;
    final code = _codeController.text;

    try {
      final response = await VerifySendOtpUseCase(injector())(
        request: RequestVerifyOtp(phoneNumber: "+966$phoneNumber", code: code),
      );

      if (response is DataSuccess) {
        await SetTokenUseCase(injector())(response.data?.token ?? '');
        await SetRememberMeUseCase(injector())(_isRememberMe);
        await SetAuthenticateUseCase(injector())(true);
        DataState<CheckAuth> authResponse =
        await CheckAuthUseCase(injector())();
        await SetUserVerificationDataUseCase(injector())(
            response.data ?? const VerifyOtp());
        _showError(S.of(context).verificationSuccessful, false);
        if (authResponse.data?.status == RegisterStatus.Home_Page.name) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.main,
            (route) => false,
          );
        } else if (authResponse.data?.status == RegisterStatus.Pending.name) {
          Navigator.pushNamed(context, Routes.revisionScreen);
        } else {
          Navigator.pushNamed(
            context,
            Routes.completeInfo,
          );
        }
      } else {
        _showError(response.message ?? '', true);
      }
    } catch (e) {
      _showError(e.toString(), true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _resendOTP() async {
    if (!_canResend || !mounted) return;

    setState(() => _isLoading = true);

    try {
      final phoneNumber = widget.args['phoneNumber'] as String;
      final response = await ReSendOtpUseCase(injector())(
        request: RequestSendOtp(phoneNumber: phoneNumber),
      );

      _showError(response.message ?? S.of(context).otpResent, false);
      _startResendTimer();
    } catch (e) {
      _showError(e.toString(), true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
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

  @override
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
    super.dispose();
  }
}
