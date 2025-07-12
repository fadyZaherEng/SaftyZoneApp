import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:safety_zone/src/presentation/blocs/home/home_bloc.dart';
import 'package:safety_zone/src/presentation/screens/home/widgets/greeting_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardItem {
  final String value;
  final String label;
  final String icon;

  DashboardItem(this.value, this.label, this.icon);
}

class HomeScreen extends BaseStatefulWidget {
  const HomeScreen({super.key});

  @override
  BaseState<HomeScreen> baseCreateState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  CheckAuth _checkAuth = const CheckAuth();
  bool _isLoading = true;
  List<DashboardItem> _dashboardItems = [];

  HomeBloc get _bloc => BlocProvider.of<HomeBloc>(context);

  @override
  void initState() {
    _bloc.add(GetHomeDashboardEvent());
    super.initState();
    _dashboardItems = [
      DashboardItem('30', S.current.newRequests, ImagePaths.news),
      DashboardItem('5', S.current.maintenanceReports, ImagePaths.technical),
      DashboardItem('10', S.current.pendingRequests, ImagePaths.requests),
      DashboardItem('8', S.current.priceOffers, ImagePaths.work),
      DashboardItem('12', S.current.todayTasks, ImagePaths.groups),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    DataState<CheckAuth> dataState = await CheckAuthUseCase(injector())();
    if (dataState is DataSuccess) {
      setState(() {
        _checkAuth = dataState.data ?? const CheckAuth();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget baseBuild(BuildContext context) {
    final s = S.of(context);

    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state is GetHomeDashboardLoadingState) {
        _isLoading = true;
      } else if (state is GetHomeDashboardSuccessState) {
        _dashboardItems = state.dashboardItems;
        _isLoading = false;
      } else if (state is GetHomeDashboardErrorState) {
        _isLoading = false;
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Skeletonizer(
            enabled: _isLoading || state is GetHomeDashboardLoadingState,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GreetingSection(
                      s: s,
                      isLoading: _isLoading,
                      fullName: _checkAuth.employeeDetails.fullName,
                    ),
                    const SizedBox(height: 16),
                    _buildSearchSection(context),
                    const SizedBox(height: 16),
                    _buildGridDashboard(context, s),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSearchSection(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 42.h,
          child: TextField(
            decoration: InputDecoration(
              hintText: s.searchHint,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: _isLoading
                    ? Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )
                    : SvgPicture.asset(
                        ImagePaths.search,
                        color: Colors.grey,
                        width: 16.w,
                        height: 16.h,
                      ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: _isLoading
                      ? Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )
                      : SvgPicture.asset(
                          ImagePaths.filter,
                          color: ColorSchemes.primary,
                          width: 16.w,
                          height: 16.h,
                        ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildGridDashboard(BuildContext context, S s) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 170.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: _buildDashboardCard(
                  context,
                  _dashboardItems[0],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.requestScreen,
                      arguments: {"isAppBar": true},
                    );
                  },
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildDashboardCard(
                  context,
                  _dashboardItems[1],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.maintainanceScreen,
                      arguments: {"isAppBar": true},
                    );
                  },
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildDashboardCard(
                  context,
                  _dashboardItems[2],
                  isColor: true,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.workingProgressScreen,
                      arguments: {"isAppBar": true},
                    );
                  },
                )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: SizedBox(
            height: 170.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: _buildDashboardCard(
                  context,
                  _dashboardItems[3],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.pricesNeedEscalationScreen,
                    );
                  },
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildDashboardCard(
                  context,
                  _dashboardItems[4],
                  onTap: () {},
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardCard(
    BuildContext context,
    DashboardItem item, {
    bool isColor = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _isLoading
                  ? Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    )
                  : SvgPicture.asset(
                      item.icon,
                      width: 32.w,
                      height: 32.h,
                      color: isColor ? Color(0XFF133769) : null,
                    ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorSchemes.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  item.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
