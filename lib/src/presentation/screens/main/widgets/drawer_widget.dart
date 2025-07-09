import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/routes/routes_manager.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/domain/entities/auth/check_auth.dart';
import 'package:safety_zone/generated/l10n.dart';

class CustomDrawer extends StatelessWidget {
  final EmployeeDetails employeeDetails;

  const CustomDrawer({
    super.key,
    required this.employeeDetails,
  });

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
                employeeDetails.image,
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
              employeeDetails.fullName,
              style: Theme.of(context).textTheme.titleMedium,
              textDirection: TextDirection.rtl,
            ),
            subtitle: Text(
              employeeDetails.jobTitle,
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
            onTap: () {
              Navigator.pushNamed(context, Routes.walletScreen);
            },
          ),
          _drawerItem(
            context,
            ImagePaths.contract,
            s.contractList,
            onTap: () {
              Navigator.pushNamed(context, Routes.contractScreen);
            },
          ),
          _drawerItem(
            context,
            "assets/images/price-down.svg",
            s.pricesNeedEscalation,
            isColor: true,
            onTap: () {},
          ),
          _drawerItem(
            context,
            ImagePaths.request,
            s.installationTasks,
            onTap: () {},
          ),
          _drawerItem(
            context,
            ImagePaths.employees,
            s.employees,
            onTap: () {},
          ),
          _drawerItem(
            context,
            ImagePaths.termsAndConditions,
            s.termsAndConditions,
            isColor: true,
            onTap: () {},
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
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            leading: SvgPicture.asset(
              ImagePaths.logouts,
              color: Colors.red,
              width: 24,
              height: 24,
            ),
            title: Text(
              s.logout,
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Handle logout
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
