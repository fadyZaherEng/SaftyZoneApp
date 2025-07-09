import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/presentation/screens/contract/contract_screen.dart';
import 'package:safety_zone/src/presentation/screens/wallet/widgets/submit_widget.dart';

class WalletScreen extends BaseStatefulWidget {
  const WalletScreen({super.key});

  @override
  BaseState<WalletScreen> baseCreateState() => _WalletScreenState();
}

class _WalletScreenState extends BaseState<WalletScreen> {
  bool _uploadWallet = false;

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          S.of(context).wallet,
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF880000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).wallet_summary,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                decoration: BoxDecoration(
                  color: const Color(0xFF880000),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: SvgPicture.asset(
                        ImagePaths.moneys,
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '5000 ر.س',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              S.of(context).current_wallet_amount,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Image.asset(ImagePaths.wallets),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _uploadWallet
                  ? SubmitInvoiceSection()
                  : _buildUploadWalletWidget(),
              _buildTableWidget(),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  _buildTableWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          S.of(context).amount_received,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: ColorSchemes.black,
          ),
        ),
        const SizedBox(height: 8),
        Table(
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    S.of(context).orderDate,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorSchemes.black,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    S.of(context).price,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorSchemes.black,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    S.of(context).order_status,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorSchemes.black,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    S.of(context).print_report,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorSchemes.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Divider(),
        const SizedBox(height: 8),
        for (int i = 0; i < 10; i++)
          Table(
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '01/01/2023',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: ColorSchemes.grey,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '200 ر.س',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: ColorSchemes.grey,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorSchemes.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "paid",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: ColorSchemes.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SvgPicture.asset(
                        ImagePaths.printer,
                        width: 32,
                        height: 32,
                        color: ColorSchemes.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
      ],
    );
  }

  Widget _buildUploadWalletWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                ImagePaths.price,
                width: 32,
                height: 32,
                color: ColorSchemes.primary,
              ),
              const SizedBox(width: 4),
              Text(
                '200 ر.س',
                style: TextStyle(
                  color: ColorSchemes.primary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).priceClosed,
                      style: TextStyle(
                        color: ColorSchemes.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "(${S.of(context).untilTheMaintenanceVisitsAreCompleted.trim()})",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorSchemes.grey,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _uploadWallet = true;
            });
          },
          icon: SvgPicture.asset(
            ImagePaths.addProgress,
            width: 24,
            height: 24,
            color: ColorSchemes.primary,
          ),
          label: Text(
            S.of(context).submit_invoice,
            style: TextStyle(
              color: ColorSchemes.primary,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorSchemes.white,
            minimumSize: const Size.fromHeight(38),
          ),
        ),
      ],
    );
  }
}
