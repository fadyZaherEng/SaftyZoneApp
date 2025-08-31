import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/presentation/screens/map_search/map_search_screen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';

class ContractsScreen extends BaseStatefulWidget {
  const ContractsScreen({super.key});

  @override
  BaseState<ContractsScreen> baseCreateState() => _ContractsScreenState();
}

class _ContractsScreenState extends BaseState<ContractsScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSchemes.primary,
        title: Text(
          s.contractsList,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              itemCount: 2,
              itemBuilder: (context, index) => ContractCard(index: index),
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}

class ContractCard extends StatelessWidget {
  final int index;

  const ContractCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Color(0xFFD9D7D7),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 70,
                  width: 70,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'شركة منطقة السلامة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "(فرع الرياضه)",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  size: 24,
                  color: ColorSchemes.secondary,
                ),
                const SizedBox(width: 4),
                Text(
                  s.locationOnMap,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Color(0xFFD9D7D7).withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ColorSchemes.white,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "address",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: CustomButtonWidget(
                      height: 42,
                      backgroundColor: ColorSchemes.red,
                      textColor: Colors.white,
                      text: s.openMap,
                      onTap: () async {
                        // Handle map navigation
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapSearchScreen(
                              initialLatitude: 24.774265,
                              initialLongitude: 46.738586,
                              onLocationSelected: (lat, lng, address) {
                                // setState(() {});
                                // _showValidationError(
                                //   S.of(context).locationSelected,
                                //   false,
                                // );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300, thickness: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const  SizedBox(width: 8),
                Text(
                  s.printContract,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Icon(
                  Icons.print,
                  color: ColorSchemes.primary,
                  size: 32,
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const  SizedBox(width: 8),
                Text(
                  s.printReport,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Icon(
                  Icons.print,
                  color: ColorSchemes.primary,
                  size: 32,
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 24),
            CustomButtonWidget(
              backgroundColor: ColorSchemes.primary,
              text: s.renewContract,
              textColor: ColorSchemes.white,
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorSchemes.white,
              ),
              height: 48,
              onTap: () {},
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(value: false, onChanged: (v) {}),
                const Spacer(),
                Text(
                  s.chooseNonRenewalReason,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
