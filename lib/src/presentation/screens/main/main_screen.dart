import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/src/domain/usecase/auth/check_auth_use_case.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/screens/home/home_screen.dart';
import 'package:safety_zone/src/presentation/screens/main/widgets/drawer_widget.dart';
import 'package:safety_zone/src/presentation/screens/maintainance_work/maintainance_work_screen.dart';
import 'package:safety_zone/src/presentation/screens/requests/requests_screen.dart';
import 'package:safety_zone/src/presentation/screens/working_progress/working_progress_screen.dart';

class MainScreen extends BaseStatefulWidget {
  const MainScreen({super.key});

  @override
  BaseState<MainScreen> baseCreateState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const HomeScreen(),
    const RequestsScreen(),
    const MaintainanceWorkScreen(),
    const WorkingProgressScreen(),
  ];
  List<String> _widgetTitles = [];
  CheckAuth _checkAuth = const CheckAuth();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _widgetTitles = [
      S.of(context).home,
      S.of(context).requests,
      S.of(context).table,
      S.of(context).workingInProgress,
    ];
    DataState<CheckAuth> dataState = await CheckAuthUseCase(injector())();
    if (dataState is DataSuccess) {
      _checkAuth = dataState.data ?? const CheckAuth();
      setState(() {});
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget baseBuild(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: ColorSchemes.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorSchemes.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          backgroundColor: ColorSchemes.primary,
          title: Text(
            _widgetTitles[_selectedIndex],
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorSchemes.white,
            ),
          ),
          leading: _selectedIndex != 0
              ? null
              : IconButton(
                  icon: SvgPicture.asset(
                    ImagePaths.list,
                    width: 20,
                    height: 20,
                    color: ColorSchemes.white,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
          actions: _selectedIndex != 0
              ? null
              : [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.notificationsScreen);
                    },
                    child: SvgPicture.asset(
                      ImagePaths.ringing,
                      width: 20,
                      height: 20,
                      color: ColorSchemes.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
        ),
        drawer: CustomDrawer(
          employeeDetails: _checkAuth.employeeDetails,
        ),
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorSchemes.white,
          elevation: 100,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          unselectedLabelStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: ColorSchemes.gray,
          ),
          selectedItemColor: ColorSchemes.secondary,
          unselectedItemColor: ColorSchemes.gray,
          selectedLabelStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: ColorSchemes.blue,
          ),
          onTap: _onItemTapped,
          items: [
            _buildNavItem(ImagePaths.homeHouse, S.of(context).home),
            _buildNavItem(ImagePaths.requests, S.of(context).requests),
            _buildNavItem(ImagePaths.maintainance, S.of(context).maintainance),
            _buildNavItem(ImagePaths.progress, S.of(context).progress),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavItem(String asset, String label) {
    return BottomNavigationBarItem(
      tooltip: label,
      icon: SvgPicture.asset(
        asset,
        width: 24,
        height: 24,
        color: ColorSchemes.gray,
      ),
      activeIcon: SvgPicture.asset(
        asset,
        width: 24,
        height: 24,
        color: ColorSchemes.primary,
      ),
      label: label,
    );
  }
}
