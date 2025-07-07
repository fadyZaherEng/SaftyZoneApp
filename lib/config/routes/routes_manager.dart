import 'package:flutter/material.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/domain/entities/main/requests/request.dart';
import 'package:hatif_mobile/domain/usecase/get_token_use_case.dart';
import 'package:hatif_mobile/domain/usecase/getauthenticate_use_case.dart';
import 'package:hatif_mobile/presentation/screens/complete_info/complete_info_view.dart';
import 'package:hatif_mobile/presentation/screens/employess/employees_list_screen.dart';
import 'package:hatif_mobile/presentation/screens/home/home_screen.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/installation_options_screen.dart';
import 'package:hatif_mobile/presentation/screens/language/language_screen.dart';
import 'package:hatif_mobile/presentation/screens/login/login_screen.dart';
import 'package:hatif_mobile/presentation/screens/main/main_screen.dart';
import 'package:hatif_mobile/presentation/screens/maintainance/maintainance_screen.dart';
import 'package:hatif_mobile/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:hatif_mobile/presentation/screens/register/vendor_registration_screen.dart';
import 'package:hatif_mobile/presentation/screens/requests/requests_screen.dart';
import 'package:hatif_mobile/presentation/screens/requests_details/request_details_screen.dart';
import 'package:hatif_mobile/presentation/screens/revision/revision_screen.dart';
import 'package:hatif_mobile/presentation/screens/splash/splash_screen.dart';
import 'package:hatif_mobile/presentation/screens/term_conditions/term_conditions_screen.dart';
import 'package:hatif_mobile/presentation/screens/upload_document_fawry/upload_document_fawry_Screen.dart';
import 'package:hatif_mobile/presentation/screens/verification_code/verification_code_screen.dart';
import 'package:hatif_mobile/presentation/screens/welcome/welcome_screen.dart';
import 'package:hatif_mobile/presentation/screens/whatsapp_verify/whatsapp_screen.dart';
import 'package:hatif_mobile/presentation/screens/working_progress/working_progress_screen.dart';

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
  static const String requestDetailsScreen = '/request-details-screen';
  static const String workingProgressScreen = '/working-progress-screen';
}

class RoutesManager {
  /// Check if user is authenticated
  static bool isAuthenticated() {
    final token = GetTokenUseCase(injector())();
    final isAuth = GetIsAuthenticationUseCase(injector())();
    return token.isNotEmpty && isAuth;
  }

  static Widget _requireAuth(Widget widget, BuildContext context) {
    if (!isAuthenticated()) {
      // User is not authenticated, redirect to welcome page
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.welcome,
          (route) => false,
        );
      });
      // Return a loading widget temporarily
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return widget;
  }

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
      // return MaterialPageRoute(
      //   builder: (context) => _requireAuth(
      //     const InstallationOptionsScreen(),
      //     context,
      //   ),
      // );
      case Routes.completeInfo:
        return _materialRoute(const CompleteInfoView());
        // return MaterialPageRoute(
        //   builder: (context) => _requireAuth(const CompleteInfoView(), context),
        // );

      case Routes.revisionScreen:
        return _materialRoute(const RevisionScreen());

      case Routes.homeScreen:
        return _materialRoute(const HomeScreen());

      case Routes.maintainanceScreen:
        return _materialRoute(const MaintainanceScreen());

      case Routes.requestScreen:
        return _materialRoute(const RequestsScreen());

      case Routes.main:
        return _materialRoute(const MainScreen());

      case Routes.requestDetailsScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        final request = args?['request'] as Requests;
        return _materialRoute(RequestDetailsScreen(
          request: request,
        ));

      case Routes.workingProgressScreen:
        return _materialRoute(const WorkingProgressScreen());

      case Routes.uploadDocumentFawryScreen:
        Map<String, dynamic>? args =
            routeSettings.arguments as Map<String, dynamic>?;
        final request = args?['request'] as Requests;
        return _materialRoute(UploadDocumentFawryScreen(request: request));

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
