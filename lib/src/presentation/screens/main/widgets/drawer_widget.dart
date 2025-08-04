import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/domain/usecase/clear_local_data_use_case.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_language_use_case.dart';
import 'package:safety_zone/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:safety_zone/src/presentation/screens/reports/reports_screen.dart';
import 'package:safety_zone/src/presentation/widgets/restart_widget.dart';

class CustomDrawer extends StatefulWidget {
  final EmployeeDetails employeeDetails;

  const CustomDrawer({
    super.key,
    required this.employeeDetails,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isEnglish = false;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 50),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                widget.employeeDetails.image,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.person,
                  size: 50,
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            title: Text(
              widget.employeeDetails.fullName,
              style: Theme.of(context).textTheme.titleMedium,
              textDirection: TextDirection.rtl,
            ),
            subtitle: Text(
              widget.employeeDetails.jobTitle,
              textDirection: TextDirection.rtl,
            ),
          ),
          const Divider(),
          _drawerItem(
            context,
            ImagePaths.information,
            s.basicInformation,
            onTap: () {},
          ),
          _drawerItem(
            context,
            ImagePaths.wallet,
            s.wallet,
            onTap: () async {
              await Navigator.pushNamed(context, Routes.walletScreen);
            },
          ),
          _drawerItem(
            context,
            ImagePaths.contract,
            s.contractList,
            onTap: () async {
              await Navigator.pushNamed(context, Routes.contractScreen);
            },
          ),
          _drawerItem(
            context,
            "assets/images/price-down.svg",
            s.pricesNeedEscalation,
            isColor: true,
            onTap: () async {
              await Navigator.pushNamed(
                context,
                Routes.pricesNeedEscalationScreen,
              );
            },
          ),
          _drawerItem(
            context,
            ImagePaths.request,
            s.installationTasks,
            onTap: () async {
              await Navigator.pushNamed(
                context,
                Routes.installationFees,
              ).then((value) {});
            },
          ),
          _drawerItem(
            context,
            ImagePaths.employees,
            s.employees,
            onTap: () async {
              await Navigator.pushNamed(
                context,
                Routes.employeesList,
              );
            },
          ),
          _drawerItem(
            context,
            ImagePaths.termsAndConditions,
            s.termsAndConditions,
            isColor: true,
            onTap: () async {
              await Navigator.pushNamed(
                context,
                Routes.termConditionsScreen,
              ).then((value) {});
            },
          ),
          _drawerItem(
            context,
            ImagePaths.chat,
            s.messages,
            onTap: () {},
          ),
          _drawerItem(
            context,
            ImagePaths.businessReport,
            s.reports,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReportsScreen(),
                ),
              );
            },
          ),
          //change language
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  s.changeLanguage,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Checkbox(
                  value: GetLanguageUseCase(injector())() == 'en',
                  onChanged: (value) {
                    setState(() => _isEnglish = value!);
                    SetLanguageUseCase(injector())(_isEnglish ? 'en' : 'ar');
                    RestartWidget.restartApp(context);
                  },
                ),
                Text(
                  s.english,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          ListTile(
            leading: SvgPicture.asset(
              ImagePaths.logouts,
              color: ColorSchemes.red,
              width: 24,
              height: 24,
            ),
            title: Text(
              s.logout,
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () async {
              // Handle logout
              await ClearLocalDataUseCase(injector())();
              await SetRememberMeUseCase(injector())(false);
              await Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.languageSelection,
                (route) => false,
              );
            },
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    String icon,
    String title, {
    bool isColor = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        color: isColor ? Colors.grey : null,
      ),
      title: Text(title, textDirection: TextDirection.rtl),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
