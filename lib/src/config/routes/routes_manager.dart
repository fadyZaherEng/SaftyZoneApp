import 'package:flutter/material.dart';
import 'package:safety_zone/src/domain/entities/home/schedule_jop.dart';
import 'package:safety_zone/src/domain/entities/main/requests/request.dart';
import 'package:safety_zone/src/presentation/screens/complete_info/complete_info_view.dart';
import 'package:safety_zone/src/presentation/screens/contract/contract_screen.dart';
import 'package:safety_zone/src/presentation/screens/employess/employees_list_screen.dart';
import 'package:safety_zone/src/presentation/screens/fatora/inovoice_screen.dart';
import 'package:safety_zone/src/presentation/screens/fire_extinguishers/fire_extinguishers_screen.dart';
import 'package:safety_zone/src/presentation/screens/home/home_screen.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/installation_options_screen.dart';
import 'package:safety_zone/src/presentation/screens/language/language_screen.dart';
import 'package:safety_zone/src/presentation/screens/login/login_screen.dart';
import 'package:safety_zone/src/presentation/screens/main/main_screen.dart';
import 'package:safety_zone/src/presentation/screens/maintainance_work/maintainance_work_screen.dart';
import 'package:safety_zone/src/presentation/screens/notifications/notifications_screen.dart';
import 'package:safety_zone/src/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:safety_zone/src/presentation/screens/price_offer/prices_need_escalation_screen.dart';
import 'package:safety_zone/src/presentation/screens/register/vendor_registration_screen.dart';
import 'package:safety_zone/src/presentation/screens/requests/requests_screen.dart';
import 'package:safety_zone/src/presentation/screens/requests_details_extinguishers/request_details_extinguishers_screen.dart';
import 'package:safety_zone/src/presentation/screens/requests_details_installation/request_details_installation_screen.dart';
import 'package:safety_zone/src/presentation/screens/requests_details_maintainance/request_details_maintainance_screen.dart';
import 'package:safety_zone/src/presentation/screens/revision/revision_screen.dart';
import 'package:safety_zone/src/presentation/screens/splash/splash_screen.dart';
import 'package:safety_zone/src/presentation/screens/term_conditions/term_conditions_screen.dart';
import 'package:safety_zone/src/presentation/screens/upload_document_fawry/upload_document_fawry_Screen.dart';
import 'package:safety_zone/src/presentation/screens/verification_code/verification_code_screen.dart';
import 'package:safety_zone/src/presentation/screens/wallet/wallet_screen.dart';
import 'package:safety_zone/src/presentation/screens/welcome/welcome_screen.dart';
import 'package:safety_zone/src/presentation/screens/whatsapp_verify/whatsapp_screen.dart';
import 'package:safety_zone/src/presentation/screens/working_progress/working_progress_screen.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String verification = '/verification';
  static const String languageSelection = '/language-selection';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String contactUs = '/contact-us';
  static const String whatsappVerification = '/whatsapp_verification';
  static const String verificationCode = '/verification_code';

  // Installation Fees Routes
  static const String installationFees = '/installation-fees';

  // Complete Information
  static const String completeInfo = '/complete-info';
  static const String termConditionsScreen = '/term-conditions-screen';
  static const String employeesList = '/employees-list';
  static const String revisionScreen = '/revision-screen';
  static const String uploadDocumentFawryScreen =
      '/upload-document-fawry-screen';

  //main
  static const String main = '/main';
  static const String homeScreen = '/home-screen';
  static const String maintainanceScreen = '/maintainance-screen';
  static const String requestScreen = '/request-screen';
  static const String requestDetailsInstallationScreen =
      '/request-details-installation-screen';
  static const String requestDetailsMaintainanceScreen =
      '/request-details-maintainance-screen';
  static const String requestDetailsExtinguishersScreen =
      '/request-details-extinguishers-screen';
  static const String workingProgressScreen = '/working-progress-screen';
  static const String walletScreen = '/wallet-screen';
  static const String contractScreen = '/contract-screen';
  static const String pricesNeedEscalationScreen =
      '/prices-need-escalation-screen';
  static const String notificationsScreen = '/notifications-screen';
  static const String fireExtinguishersScreen = '/fire-extinguishers-screen';
  static const String invoiceScreen = '/invoiceScreen';
}

class RoutesManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return _materialRoute(const SplashScreen());

      case Routes.languageSelection:
        return _materialRoute(const LanguageScreen());

      case Routes.onboarding:
        return _materialRoute(const OnboardingScreen());

      case Routes.welcome:
        return _materialRoute(const WelcomeScreen());

      case Routes.register:
        return _materialRoute(const VendorRegistrationScreen());
      case Routes.login:
        return _materialRoute(const LoginScreen());
      case Routes.whatsappVerification:
        return _materialRoute(const WhatsappVerificationScreen());

      case Routes.verificationCode:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        final phoneNumber = args?['phoneNumber'] as String? ?? '';
        return _materialRoute(
            VerificationCodeScreen(args: {'phoneNumber': phoneNumber}));
      case Routes.termConditionsScreen:
        return _materialRoute(const TermConditionsScreen());
      case Routes.employeesList:
        return _materialRoute(const EmployeesListScreen());

      case Routes.installationFees:
        return _materialRoute(const InstallationOptionsScreen());

      case Routes.completeInfo:
        return _materialRoute(const CompleteInfoView());

      case Routes.revisionScreen:
        return _materialRoute(const RevisionScreen());

      case Routes.homeScreen:
        return _materialRoute(const HomeScreen());

      case Routes.maintainanceScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        return _materialRoute(MaintainanceWorkScreen(
          isAppBar: args?['isAppBar'] as bool,
        ));

      case Routes.requestScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        return _materialRoute(RequestsScreen(
          isAppBar: args?['isAppBar'] as bool,
        ));

      case Routes.main:
        return _materialRoute(const MainScreen());

      case Routes.requestDetailsInstallationScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        final requestId = args?['requestId'] as String;
        return _materialRoute(RequestDetailsInstallationScreen(
          requestId: requestId,
        ));

      case Routes.workingProgressScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        return _materialRoute(WorkingProgressScreen(
          isAppBar: args?['isAppBar'] as bool,
        ));

      case Routes.uploadDocumentFawryScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        final request = args?['request'] as ScheduleJop;
        return _materialRoute(UploadDocumentFawryScreen(request: request));

      case Routes.walletScreen:
        return _materialRoute(const WalletScreen());

      case Routes.contractScreen:
        return _materialRoute(const ContractsScreen());

      case Routes.requestDetailsMaintainanceScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        final requestId = args?['requestId'] as String;
        return _materialRoute(RequestDetailsMaintainanceScreen(
          requestId: requestId,
        ));

      case Routes.requestDetailsExtinguishersScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        final requestId = args?['requestId'] as String;
        return _materialRoute(RequestDetailsExtinguishersScreen(
          requestId: requestId,
        ));

      case Routes.pricesNeedEscalationScreen:
        return _materialRoute(const PricesNeedEscalationScreen());

      case Routes.notificationsScreen:
        return _materialRoute(const NotificationsScreen());

      case Routes.fireExtinguishersScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        return _materialRoute(FireExtinguishersScreen(
          scheduleJop: args?['scheduleJop'] as ScheduleJop,
          isFirstPage: args?['isFirstPage'] as bool,
          isSecondPage: args?['isSecondPage'] as bool,
          isThirdPage: args?['isThirdPage'] as bool,
        ));

      case Routes.invoiceScreen:
        return _materialRoute(InvoiceScreen());
      default:
        return unDefinedRoute(routeSettings.name.toString());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> unDefinedRoute(String name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Not found")),
        body: Center(
          child: Text(name),
        ),
      ),
    );
  }
}
