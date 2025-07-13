import 'package:safety_zone/src/di/injector.dart';
import 'package:safety_zone/src/domain/usecase/auth/check_auth_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/first_emp_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/generate_file_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/generate_image_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/get_installation_status_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/get_sub_category_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/get_term_conditions_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/re_send_otp_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/register_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/send_otp_use_case.dart';
import 'package:safety_zone/src/domain/usecase/auth/verify_send_otp_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_firebase_notification_token_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_isboarding_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_remember_me_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_theme_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_user_login_data_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_user_verification_data_use_case.dart';
import 'package:safety_zone/src/domain/usecase/getauthenticate_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/get_consumer_requests_details_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/get_consumer_requests_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/schedule_all_jop_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/schedule_jop_use_case.dart';
import 'package:safety_zone/src/domain/usecase/home/send_offer_price_use_case.dart';
import 'package:safety_zone/src/domain/usecase/remove_remember_me_use_case.dart';
import 'package:safety_zone/src/domain/usecase/save_firebase_notification_token_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_authenticate_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_isboarding_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_language_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_theme_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_user_login_data_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_user_verification_data_use_case.dart';

Future<void> initializeUseCaseDependencies() async {
  injector.registerFactory<SetLanguageUseCase>(
      () => SetLanguageUseCase(injector()));
  injector.registerFactory<GetLanguageUseCase>(
      () => GetLanguageUseCase(injector()));
  injector.registerFactory<GetRememberMeUseCase>(
      () => GetRememberMeUseCase(injector()));
  injector.registerFactory<RemoveRememberMeUseCase>(
      () => RemoveRememberMeUseCase(injector()));
  injector.registerFactory<SetRememberMeUseCase>(
      () => SetRememberMeUseCase(injector()));
  injector.registerFactory<GetIsAuthenticationUseCase>(
      () => GetIsAuthenticationUseCase(injector()));
  injector.registerFactory<SetAuthenticateUseCase>(
      () => SetAuthenticateUseCase(injector()));
  injector.registerFactory<GetIsBoardingUseCase>(
      () => GetIsBoardingUseCase(injector()));
  injector.registerFactory<SetIsBoardingUseCase>(
      () => SetIsBoardingUseCase(injector()));
  injector.registerFactory<SetThemeUseCase>(() => SetThemeUseCase(injector()));
  injector.registerFactory<GetThemeUseCase>(() => GetThemeUseCase(injector()));

  injector
      .registerFactory<CheckAuthUseCase>(() => CheckAuthUseCase(injector()));
  injector.registerFactory<GetFirstEmployeeUseCase>(
      () => GetFirstEmployeeUseCase(injector()));
  injector.registerFactory<GetInstallationsStatusUseCase>(
      () => GetInstallationsStatusUseCase(injector()));
  injector.registerFactory<GetBySubCategoryUseCase>(
      () => GetBySubCategoryUseCase(injector()));
  injector.registerFactory<GetTermConditionsUseCase>(
      () => GetTermConditionsUseCase(injector()));
  injector
      .registerFactory<ReSendOtpUseCase>(() => ReSendOtpUseCase(injector()));
  injector.registerFactory<RegisterUseCase>(() => RegisterUseCase(injector()));
  injector.registerFactory<SendOtpUseCase>(() => SendOtpUseCase(injector()));
  injector.registerFactory<VerifySendOtpUseCase>(
      () => VerifySendOtpUseCase(injector()));
  injector.registerFactory<GetUserVerificationDataUseCase>(
      () => GetUserVerificationDataUseCase(injector()));
  injector.registerFactory<SetUserVerificationDataUseCase>(
      () => SetUserVerificationDataUseCase(injector()));
  injector.registerFactory<SveFirebaseNotificationTokenUseCase>(
      () => SveFirebaseNotificationTokenUseCase(injector()));
  injector.registerFactory<GetFirebaseNotificationTokenUseCase>(
      () => GetFirebaseNotificationTokenUseCase(injector()));
  injector.registerFactory<GenerateImageUrlUseCase>(
      () => GenerateImageUrlUseCase(injector()));
  injector.registerFactory<GenerateFileUrlUseCase>(
      () => GenerateFileUrlUseCase(injector()));
  injector.registerFactory<GetConsumerRequestDetailsUseCase>(
      () => GetConsumerRequestDetailsUseCase(injector()));
  injector.registerFactory<GetConsumerRequestsUseCase>(
      () => GetConsumerRequestsUseCase(injector()));
  injector.registerFactory<SendOfferPriceUseCase>(
      () => SendOfferPriceUseCase(injector()));
  injector.registerFactory<ScheduleJopUseCase>(
      () => ScheduleJopUseCase(injector()));
  injector.registerFactory<GetUserLoginDataUseCase>(
      () => GetUserLoginDataUseCase(injector()));
  injector.registerFactory<SetUserLoginDataUseCase>(
      () => SetUserLoginDataUseCase(injector()));
  injector.registerFactory<ScheduleJobAllUseCase>(
      () => ScheduleJobAllUseCase(injector()));
}
