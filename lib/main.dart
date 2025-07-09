import 'dart:io';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/app_theme.dart';
import 'package:safety_zone/src/core/utils/bloc_observer.dart';
import 'package:safety_zone/src/core/utils/network_connectivity.dart';
import 'package:safety_zone/src/core/utils/notifications/firebase_notification_services.dart';
import 'package:safety_zone/src/core/utils/show_no_internet_dialog_widget.dart';
import 'package:safety_zone/src/di/injector.dart';
import 'package:safety_zone/src/domain/usecase/get_firebase_notification_token_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/blocs/main/main_cubit.dart';
import 'package:safety_zone/src/presentation/blocs/requests/requests_bloc.dart';
import 'package:safety_zone/src/presentation/blocs/term_conditions/term_conditions_bloc.dart';
import 'package:safety_zone/src/presentation/blocs/theme/theme_cubit.dart';
import 'package:safety_zone/src/presentation/blocs/upload_doc/upload_doc_bloc.dart';
import 'package:safety_zone/src/presentation/blocs/working_progress/working_progress_bloc.dart';
import 'package:safety_zone/src/presentation/screens/splash/splash_screen.dart';
import 'package:safety_zone/src/presentation/screens/main/main_screen.dart';
import 'package:safety_zone/src/presentation/widgets/restart_widget.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';

void main() async {
  ChuckerFlutter.showOnRelease = true;
  ChuckerFlutter.showNotification = true;
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await initFirebaseService();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(RestartWidget(MyApp()));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      NetworkConnectivity.instance.initializeInternetConnectivityStream();
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (GetFirebaseNotificationTokenUseCase(injector())() == null ||
        GetFirebaseNotificationTokenUseCase(injector())() == "") {
      await initFirebaseService();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: BlocBuilder<MainCubit, Locale>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (context, locale) {
          return StreamBuilder(
            stream: NetworkConnectivity.instance.myStream,
            builder: (mContext, snapshot) {
              if (snapshot.hasData && !kIsWeb) {
                _connectToInternet(snapshot);
              }
              return BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeState) {
                  return ScreenUtilInit(
                    designSize: const Size(375, 812),
                    child: MaterialApp(
                      navigatorKey: navigatorKey,
                      navigatorObservers: [
                        ChuckerFlutter.navigatorObserver,
                        routeObserver,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      onGenerateRoute: RoutesManager.getRoute,
                      initialRoute: Routes.splash,
                      localizationsDelegates: const [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      debugShowCheckedModeBanner: false,
                      title: "Safety Zone",
                      darkTheme: AppTheme(locale.languageCode).dark,
                      theme: AppTheme(locale.languageCode).light,
                      themeMode: themeState,
                      locale: locale,
                      // Pass versionCode when navigating to the splash screen
                      builder: (context, child) {
                        return _buildInitialScreen(context, child);
                      },
                      // home: MainScreen(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInitialScreen(BuildContext context, Widget? child) {
    return Navigator(
      observers: [ChuckerFlutter.navigatorObserver, routeObserver],
      key: navigatorKey,
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => SplashScreen());
      },
      initialRoute: Routes.splash,
      onGenerateInitialRoutes: (navigator, initialRoute) {
        return [MaterialPageRoute(builder: (_) => SplashScreen())];
      },
      onGenerateRoute: RoutesManager.getRoute,
    );
  }

  void _connectToInternet(snapshot) {
    ConnectivityResult connectivityResult = snapshot.data;
    if (connectivityResult == ConnectivityResult.none) {
      if (!NetworkConnectivity.instance.isShowNoInternetDialog) {
        showNoInternetDialogWidget(
          context: navigatorKey.currentContext ?? context,
          onTapTryAgain: () {},
        );
      }
      NetworkConnectivity.instance.isShowNoInternetDialog = true;
    } else {
      if (NetworkConnectivity.instance.isShowNoInternetDialog &&
          Navigator.canPop(navigatorKey.currentContext ?? context)) {
        Navigator.of(navigatorKey.currentContext ?? context).pop();
        NetworkConnectivity.instance.isShowNoInternetDialog = false;
      }
    }
  }

  List<BlocProvider> _getProviders() {
    return [
      BlocProvider<MainCubit>(create: (context) => injector()),
      BlocProvider<ThemeCubit>(create: (context) => injector()),
      BlocProvider<TermConditionsBloc>(create: (context) => injector()),
      BlocProvider<WorkingProgressBloc>(create: (context) => injector()),
      BlocProvider<UploadDocBloc>(create: (context) => injector()),
      BlocProvider<RequestsBloc>(create: (context) => injector()),
    ];
  }
}

Future<void> initFirebaseService() async {
  if (!kIsWeb) {
    try {
      if (Platform.isIOS) {
        await _initializeFirebaseServices();
      } else {
        final int resultCode =
            await HmsApiAvailability().isHMSAvailableWithApkVersion(28);
        if (resultCode == 1) {
          await _initializeFirebaseServices();
        } else {
          await _initializeHuaweiServices();
        }
      }
    } catch (e) {}
  }
}

Future<void> _initializeFirebaseServices() async {
  try {
    //TODO :WHEN ADD FIREBASE
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    await FirebaseNotificationService().initializeNotificationService();
    Bloc.observer = AppBlocObserver();
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (e) {}
}

Future<void> _initializeHuaweiServices() async {
  // await HMSNotificationServices().initializeNotificationService();
}
